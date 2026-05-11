import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/academy_model.dart';
import '../data/repositories/academies_repository.dart';

/// State for academies
class AcademiesState {
  final List<AcademyModel> academies;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String? selectedCountry;
  final String? selectedConfederation;
  final String? selectedCategory;
  final int start;
  final bool hasMore;

  AcademiesState({
    List<AcademyModel>? academies,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.selectedCountry,
    this.selectedConfederation,
    this.selectedCategory,
    this.start = 0,
    this.hasMore = true,
  }) : academies = academies ?? [];

  AcademiesState copyWith({
    List<AcademyModel>? academies,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? selectedCountry,
    String? selectedConfederation,
    String? selectedCategory,
    int? start,
    bool? hasMore,
  }) {
    return AcademiesState(
      academies: academies ?? this.academies,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedConfederation: selectedConfederation ?? this.selectedConfederation,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      start: start ?? this.start,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// Notifier for academies
class AcademiesNotifier extends StateNotifier<AcademiesState> {
  final AcademiesRepository _repository;

  AcademiesNotifier(this._repository) : super(AcademiesState());

  /// Set country filter
  void setCountry(String? country, String? confederation) {
    state = state.copyWith(
      selectedCountry: country,
      selectedConfederation: confederation,
    );
  }

  /// Set category filter
  void setCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  /// Search academies with current filters
  Future<void> search() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      start: 0,
      hasMore: true,
      academies: [],
    );

    await _loadAcademies();
  }

  /// Load more academies (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);
    await _loadAcademies();
  }

  /// Internal method to load academies
  Future<void> _loadAcademies() async {
    try {
      final userId = StorageService.userId;
      if (userId == null || userId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: 'User not logged in',
        );
        return;
      }

      final newAcademies = await _repository.getAcademyList(
        userId: userId,
        country: state.selectedCountry,
        confed: state.selectedConfederation,
        category: state.selectedCategory,
        start: state.start,
        limit: 10,
      );

      final updatedAcademies = [...state.academies, ...newAcademies];
      final hasMore = newAcademies.length >= 10;

      state = state.copyWith(
        academies: updatedAcademies,
        isLoading: false,
        isLoadingMore: false,
        start: state.start + 10,
        hasMore: hasMore,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// Reset filters and search
  void reset() {
    state = AcademiesState();
  }
}

/// Provider for academies repository
final academiesRepositoryProvider = Provider<AcademiesRepository>((ref) {
  return AcademiesRepository();
});

/// Provider for academies
final academiesProvider =
    StateNotifierProvider<AcademiesNotifier, AcademiesState>((ref) {
  final repository = ref.watch(academiesRepositoryProvider);
  return AcademiesNotifier(repository);
});
