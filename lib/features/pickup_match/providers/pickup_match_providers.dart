import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/storage/storage_service.dart';

import '../data/models/pickup_match_model.dart';
import '../data/repositories/pickup_match_repository.dart';

/// State for pickup matches pagination with loading status
class PickupMatchesState {
  final List<PickupMatchModel> matches;
  final bool isLoadingMore;
  final bool hasMore;

  const PickupMatchesState({
    required this.matches,
    required this.isLoadingMore,
    required this.hasMore,
  });

  PickupMatchesState copyWith({
    List<PickupMatchModel>? matches,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return PickupMatchesState(
      matches: matches ?? this.matches,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// State provider for pickup matches pagination
final pickupMatchesPaginationProvider = StateNotifierProvider<
    PickupMatchesPagination, AsyncValue<PickupMatchesState>>(
  (ref) => PickupMatchesPagination(ref),
);

/// Pagination state notifier for pickup matches
class PickupMatchesPagination
    extends StateNotifier<AsyncValue<PickupMatchesState>> {
  final Ref ref;
  int _start = 0;
  final int _limit = 10;

  PickupMatchesPagination(this.ref)
      : super(const AsyncValue.data(PickupMatchesState(
            matches: [], isLoadingMore: false, hasMore: true))) {
    loadMore();
  }

  Future<void> loadMore() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    if (!currentState.hasMore || currentState.isLoadingMore) return;

    final userId = StorageService.userId;
    final country = StorageService.currentUser?['country'] as String? ?? '';

    if (userId == null || userId.isEmpty) {
      state = const AsyncValue.data(PickupMatchesState(
          matches: [], isLoadingMore: false, hasMore: false));
      return;
    }

    // Set loading state
    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final repository = ref.read(pickupMatchRepositoryProvider);
      final newMatches = await repository.getPickupMatches(
        userId: userId,
        country: country,
        start: _start,
        limit: _limit,
      );

      final hasMore = newMatches.length >= _limit;
      _start += newMatches.length;

      state = AsyncValue.data(PickupMatchesState(
        matches: [...currentState.matches, ...newMatches],
        isLoadingMore: false,
        hasMore: hasMore,
      ));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    _start = 0;
    state = const AsyncValue.loading();

    final userId = StorageService.userId;
    final country = StorageService.currentUser?['country'] as String? ?? '';

    if (userId == null || userId.isEmpty) {
      state = const AsyncValue.data(PickupMatchesState(
          matches: [], isLoadingMore: false, hasMore: false));
      return;
    }

    try {
      final repository = ref.read(pickupMatchRepositoryProvider);
      final newMatches = await repository.getPickupMatches(
        userId: userId,
        country: country,
        start: 0,
        limit: _limit,
      );

      final hasMore = newMatches.length >= _limit;
      _start = newMatches.length;

      state = AsyncValue.data(PickupMatchesState(
        matches: newMatches,
        isLoadingMore: false,
        hasMore: hasMore,
      ));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
