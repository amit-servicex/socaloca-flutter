import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/storage/storage_service.dart';

import '../data/pickup_match_data.dart';
import '../data/repositories/pickup_matches_repository.dart';

/// Preview list (first page) for the Pick-Up tab.
final pickupMatchesPreviewProvider =
    FutureProvider<List<PickupMatchData>>((ref) async {
  final userId = StorageService.userId;
  final country = StorageService.currentUser?['country'] as String? ?? '';

  if (userId == null || userId.isEmpty) return [];

  final repo = ref.watch(pickupMatchesRepositoryProvider);
  return repo.getPickupMatches(
    userId: userId,
    country: country,
    start: 0,
    limit: 10,
  );
});

/// Full paginated list for a "View All" screen.
final pickupMatchesPaginationProvider = StateNotifierProvider<
    PickupMatchesPagination, AsyncValue<List<PickupMatchData>>>(
  (ref) => PickupMatchesPagination(ref),
);

class PickupMatchesPagination
    extends StateNotifier<AsyncValue<List<PickupMatchData>>> {
  final Ref ref;
  int _start = 0;
  final int _limit = 10;
  bool _hasMore = true;

  PickupMatchesPagination(this.ref) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    final userId = StorageService.userId;
    final country = StorageService.currentUser?['country'] as String? ?? '';
    if (userId == null || userId.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      final repo = ref.read(pickupMatchesRepositoryProvider);
      final fresh = await repo.getPickupMatches(
        userId: userId,
        country: country,
        start: _start,
        limit: _limit,
      );

      if (fresh.length < _limit) _hasMore = false;
      _start += fresh.length;
      state = state.whenData((current) => [...current, ...fresh]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    _start = 0;
    _hasMore = true;
    state = const AsyncValue.loading();
    await loadMore();
  }

  bool get hasMore => _hasMore;
}
