import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/club_model.dart';
import '../data/repositories/club_repository.dart';

/// State for clubs list with filters and pagination
class ClubsState {
  final List<ClubModel> clubs;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final String country;
  final String partnership;

  const ClubsState({
    this.clubs = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.country = '',
    this.partnership = '',
  });

  ClubsState copyWith({
    List<ClubModel>? clubs,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    String? country,
    String? partnership,
  }) {
    return ClubsState(
      clubs: clubs ?? this.clubs,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      country: country ?? this.country,
      partnership: partnership ?? this.partnership,
    );
  }
}

/// Notifier for clubs list with pagination and filters
class ClubsNotifier extends StateNotifier<ClubsState> {
  ClubsNotifier(this._ref) : super(const ClubsState());

  final Ref _ref;
  static const int _pageSize =
      100; // Match Android pagination size (changed from 10)

  /// Load initial clubs list
  Future<void> load() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final userId = StorageService.userId ?? '';

      if (userId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not logged in. Please log in to view clubs.',
        );
        return;
      }

      final clubs = await _ref.read(clubRepositoryProvider).getClubs(
            userId: userId,
            country: state.country,
            partnerShip: state.partnership,
            start: 0,
            limit: _pageSize,
          );

      state = state.copyWith(
        clubs: clubs,
        isLoading: false,
        hasMore: clubs.length >= _pageSize,
      );
    } catch (e, stackTrace) {
      print('❌ Error in ClubsNotifier.load(): $e');
      print('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load more clubs (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final userId = StorageService.userId ?? '';
      final newClubs = await _ref.read(clubRepositoryProvider).getClubs(
            userId: userId,
            country: state.country,
            partnerShip: state.partnership,
            start: state.clubs.length,
            limit: _pageSize,
          );

      state = state.copyWith(
        clubs: [...state.clubs, ...newClubs],
        isLoadingMore: false,
        hasMore: newClubs.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// Set country filter and reload
  void setCountry(String country) {
    if (state.country == country) return;
    state = state.copyWith(
      country: country,
      clubs: [],
      hasMore: true,
    );
    load();
  }

  /// Set partnership filter and reload
  void setPartnership(String partnership) {
    if (state.partnership == partnership) return;
    state = state.copyWith(
      partnership: partnership,
      clubs: [],
      hasMore: true,
    );
    load();
  }

  /// Refresh clubs list
  Future<void> refresh() async {
    state = state.copyWith(clubs: [], hasMore: true);
    await load();
  }
}

/// Provider for clubs list
final clubsProvider = StateNotifierProvider<ClubsNotifier, ClubsState>((ref) {
  return ClubsNotifier(ref);
});
