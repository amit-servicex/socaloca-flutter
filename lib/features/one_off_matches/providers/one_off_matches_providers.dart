import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/storage/storage_service.dart';

import '../../tournaments/data/tournament_models.dart';
import '../data/repositories/one_off_matches_repository.dart';

/// Get current date in plain format (YYYY-MM-DD)
String _getCurrentDate() {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
}

/// Provider for today's featured match
final todaysMatchProvider = FutureProvider<TournamentMatchModel?>((ref) async {
  final userId = StorageService.userId;
  final country = StorageService.currentUser?['country'] as String? ?? '';

  print(
      '🔍 [OneOff] Loading today\'s match - userId: $userId, country: $country');

  if (userId == null || userId.isEmpty) {
    print('❌ [OneOff] No userId found');
    return null;
  }

  final repository = ref.watch(oneOffMatchesRepositoryProvider);
  final match = await repository.getTodaysMatch(
    userId: userId,
    country: country,
    dateToday: _getCurrentDate(),
  );

  print('✅ [OneOff] Today\'s match loaded: ${match?.matchId ?? "null"}');
  return match;
});

/// Provider for upcoming matches (preview - 3 matches)
final upcomingMatchesPreviewProvider =
    FutureProvider<List<TournamentMatchModel>>((ref) async {
  final userId = StorageService.userId;
  final country = StorageService.currentUser?['country'] as String? ?? '';

  print(
      '🔍 [OneOff] Loading upcoming matches - userId: $userId, country: $country');

  if (userId == null || userId.isEmpty) {
    print('❌ [OneOff] No userId found for upcoming');
    return [];
  }

  final repository = ref.watch(oneOffMatchesRepositoryProvider);
  final matches = await repository.getUpcomingMatches(
    userId: userId,
    country: country,
    limit: 3,
  );

  print('✅ [OneOff] Upcoming matches loaded: ${matches.length} matches');
  return matches;
});

/// Provider for recent matches (preview - 3 matches)
final recentMatchesPreviewProvider =
    FutureProvider<List<TournamentMatchModel>>((ref) async {
  final userId = StorageService.userId;
  final country = StorageService.currentUser?['country'] as String? ?? '';

  print(
      '🔍 [OneOff] Loading recent matches - userId: $userId, country: $country');

  if (userId == null || userId.isEmpty) {
    print('❌ [OneOff] No userId found for recent');
    return [];
  }

  final repository = ref.watch(oneOffMatchesRepositoryProvider);
  final matches = await repository.getPlayedMatches(
    userId: userId,
    country: country,
    limit: 3,
  );

  print('✅ [OneOff] Recent matches loaded: ${matches.length} matches');
  return matches;
});

/// State provider for upcoming matches pagination
final upcomingMatchesPaginationProvider = StateNotifierProvider<
    UpcomingMatchesPagination, AsyncValue<List<TournamentMatchModel>>>(
  (ref) => UpcomingMatchesPagination(ref),
);

/// State provider for recent matches pagination
final recentMatchesPaginationProvider = StateNotifierProvider<
    RecentMatchesPagination, AsyncValue<List<TournamentMatchModel>>>(
  (ref) => RecentMatchesPagination(ref),
);

/// Pagination state notifier for upcoming matches
class UpcomingMatchesPagination
    extends StateNotifier<AsyncValue<List<TournamentMatchModel>>> {
  final Ref ref;
  int _start = 0;
  final int _limit = 20;
  bool _hasMore = true;

  UpcomingMatchesPagination(this.ref) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final userId = StorageService.userId;
    final country = StorageService.currentUser?['country'] as String? ?? '';

    if (userId == null || userId.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      final repository = ref.read(oneOffMatchesRepositoryProvider);
      final newMatches = await repository.getUpcomingMatches(
        userId: userId,
        country: country,
        start: _start,
        limit: _limit,
      );

      if (newMatches.length < _limit) {
        _hasMore = false;
      }

      _start += newMatches.length;

      state = state.whenData((current) => [...current, ...newMatches]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    _start = 0;
    _hasMore = true;
    state = const AsyncValue.loading();
    await loadMore();
  }
}

/// Pagination state notifier for recent matches
class RecentMatchesPagination
    extends StateNotifier<AsyncValue<List<TournamentMatchModel>>> {
  final Ref ref;
  int _start = 0;
  final int _limit = 20;
  bool _hasMore = true;

  RecentMatchesPagination(this.ref) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    final userId = StorageService.userId;
    final country = StorageService.currentUser?['country'] as String? ?? '';

    if (userId == null || userId.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      final repository = ref.read(oneOffMatchesRepositoryProvider);
      final newMatches = await repository.getPlayedMatches(
        userId: userId,
        country: country,
        start: _start,
        limit: _limit,
      );

      if (newMatches.length < _limit) {
        _hasMore = false;
      }

      _start += newMatches.length;

      state = state.whenData((current) => [...current, ...newMatches]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    _start = 0;
    _hasMore = true;
    state = const AsyncValue.loading();
    await loadMore();
  }
}
