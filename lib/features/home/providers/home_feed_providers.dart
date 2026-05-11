import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/auth_provider.dart';
import '../data/models/endorsed_player_model.dart';
import '../data/models/feed_new_team_model.dart';
import '../data/models/feed_rec_user_model.dart';
import '../data/models/feed_team_model.dart';
import '../data/models/feed_tournament_model.dart';
import '../data/repositories/home_feed_repository.dart';

/// Provider for home feed repository
final homeFeedRepositoryProvider = Provider<HomeFeedRepository>((ref) {
  return HomeFeedRepository();
});

// ─── Generic pagination state ─────────────────────────────────────────────────

class HomeFeedState<T> {
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;

  HomeFeedState({
    List<T>? items,
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasMore = true,
  }) : items = items ?? [];

  HomeFeedState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
  }) =>
      HomeFeedState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
      );
}

// ─── Live Tournaments ─────────────────────────────────────────────────────────

class LiveTmntsNotifier
    extends StateNotifier<HomeFeedState<FeedTournamentModel>> {
  LiveTmntsNotifier(this.ref) : super(HomeFeedState()) {
    load();
  }

  final Ref ref;
  static const int _limit = 10;
  int _start = 0;
  bool _isLoadingMore = false;

  Future<void> load({bool isRefresh = false}) async {
    if (!isRefresh) {
      _start = 0;
      state = HomeFeedState(isLoading: true, hasMore: true);
    }
    final user = ref.read(currentUserProvider);
    if (user == null) {
      if (!isRefresh) state = HomeFeedState(isLoading: false, hasMore: false);
      return;
    }
    final items = await ref.read(homeFeedRepositoryProvider).getFeedLiveTmnts(
          userId: user.id,
          start: 0,
          limit: _limit,
        );
    _start = items.length;
    state = HomeFeedState(
      items: items,
      isLoading: false,
      hasMore: items.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || _isLoadingMore || state.isLoading) return;
    _isLoadingMore = true;
    state = state.copyWith(isLoadingMore: true);
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _isLoadingMore = false;
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    final more = await ref.read(homeFeedRepositoryProvider).getFeedLiveTmnts(
          userId: user.id,
          start: _start,
          limit: _limit,
        );
    _start += more.length;
    state = state.copyWith(
      items: [...state.items, ...more],
      isLoadingMore: false,
      hasMore: more.length >= _limit,
    );
    _isLoadingMore = false;
  }

  Future<void> refresh() => load(isRefresh: true);
}

final feedLiveTmntsProvider = StateNotifierProvider<LiveTmntsNotifier,
    HomeFeedState<FeedTournamentModel>>((ref) {
  ref.watch(currentUserProvider);
  return LiveTmntsNotifier(ref);
});

// ─── New Teams ────────────────────────────────────────────────────────────────

class NewTeamsNotifier extends StateNotifier<HomeFeedState<FeedNewTeamModel>> {
  NewTeamsNotifier(this.ref) : super(HomeFeedState()) {
    load();
  }

  final Ref ref;
  static const int _limit = 10;
  int _start = 0;
  bool _isLoadingMore = false;

  Future<void> load({bool isRefresh = false}) async {
    if (!isRefresh) {
      _start = 0;
      state = HomeFeedState(isLoading: true, hasMore: true);
    }
    final user = ref.read(currentUserProvider);
    if (user == null) {
      if (!isRefresh) state = HomeFeedState(isLoading: false, hasMore: false);
      return;
    }
    final items = await ref.read(homeFeedRepositoryProvider).getFeedNewTeams(
          userId: user.id,
          start: 0,
          limit: _limit,
        );
    _start = items.length;
    state = HomeFeedState(
      items: items,
      isLoading: false,
      hasMore: items.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || _isLoadingMore || state.isLoading) return;
    _isLoadingMore = true;
    state = state.copyWith(isLoadingMore: true);
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _isLoadingMore = false;
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    final more = await ref.read(homeFeedRepositoryProvider).getFeedNewTeams(
          userId: user.id,
          start: _start,
          limit: _limit,
        );
    _start += more.length;
    state = state.copyWith(
      items: [...state.items, ...more],
      isLoadingMore: false,
      hasMore: more.length >= _limit,
    );
    _isLoadingMore = false;
  }

  Future<void> refresh() => load(isRefresh: true);
}

final feedNewTeamsProvider =
    StateNotifierProvider<NewTeamsNotifier, HomeFeedState<FeedNewTeamModel>>(
        (ref) {
  ref.watch(currentUserProvider);
  return NewTeamsNotifier(ref);
});

// ─── Recommended Users ────────────────────────────────────────────────────────

class RecUsersNotifier extends StateNotifier<HomeFeedState<FeedRecUserModel>> {
  RecUsersNotifier(this.ref) : super(HomeFeedState()) {
    load();
  }

  final Ref ref;
  static const int _limit = 10;
  int _start = 0;
  bool _isLoadingMore = false;

  Future<void> load({bool isRefresh = false}) async {
    if (!isRefresh) {
      _start = 0;
      state = HomeFeedState(isLoading: true, hasMore: true);
    }
    final user = ref.read(currentUserProvider);
    if (user == null) {
      if (!isRefresh) state = HomeFeedState(isLoading: false, hasMore: false);
      return;
    }
    final items = await ref.read(homeFeedRepositoryProvider).getFeedRecUsers(
          userId: user.id,
          start: 0,
          limit: _limit,
        );
    _start = items.length;
    state = HomeFeedState(
      items: items,
      isLoading: false,
      hasMore: items.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || _isLoadingMore || state.isLoading) return;
    _isLoadingMore = true;
    state = state.copyWith(isLoadingMore: true);
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _isLoadingMore = false;
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    final more = await ref.read(homeFeedRepositoryProvider).getFeedRecUsers(
          userId: user.id,
          start: _start,
          limit: _limit,
        );
    _start += more.length;
    state = state.copyWith(
      items: [...state.items, ...more],
      isLoadingMore: false,
      hasMore: more.length >= _limit,
    );
    _isLoadingMore = false;
  }

  Future<void> refresh() => load(isRefresh: true);
}

final feedRecUsersProvider =
    StateNotifierProvider<RecUsersNotifier, HomeFeedState<FeedRecUserModel>>(
        (ref) {
  ref.watch(currentUserProvider);
  return RecUsersNotifier(ref);
});

// ─── Most Endorsed ────────────────────────────────────────────────────────────

class MostEndorsedNotifier
    extends StateNotifier<HomeFeedState<EndorsedPlayerModel>> {
  MostEndorsedNotifier(this.ref) : super(HomeFeedState()) {
    load();
  }

  final Ref ref;
  static const int _limit = 10;
  int _offset = 0;
  bool _isLoadingMore = false;

  Future<void> load({bool isRefresh = false}) async {
    if (!isRefresh) {
      _offset = 0;
      state = HomeFeedState(isLoading: true, hasMore: true);
    }
    final user = ref.read(currentUserProvider);
    if (user == null) {
      if (!isRefresh) state = HomeFeedState(isLoading: false, hasMore: false);
      return;
    }
    final items = await ref.read(homeFeedRepositoryProvider).getMostEndorsed(
          userId: user.id,
          offset: 0,
          limit: _limit,
        );
    _offset = items.length;
    state = HomeFeedState(
      items: items,
      isLoading: false,
      hasMore: items.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || _isLoadingMore || state.isLoading) return;
    _isLoadingMore = true;
    state = state.copyWith(isLoadingMore: true);
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _isLoadingMore = false;
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    final more = await ref.read(homeFeedRepositoryProvider).getMostEndorsed(
          userId: user.id,
          offset: _offset,
          limit: _limit,
        );
    _offset += more.length;
    state = state.copyWith(
      items: [...state.items, ...more],
      isLoadingMore: false,
      hasMore: more.length >= _limit,
    );
    _isLoadingMore = false;
  }

  Future<void> refresh() => load(isRefresh: true);
}

final mostEndorsedProvider = StateNotifierProvider<MostEndorsedNotifier,
    HomeFeedState<EndorsedPlayerModel>>((ref) {
  ref.watch(currentUserProvider);
  return MostEndorsedNotifier(ref);
});

// ─── User Profile ─────────────────────────────────────────────────────────────

final userProfileProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  return ref.read(homeFeedRepositoryProvider).getUserProfile(userId: user.id);
});

// ─── Feed Teams (Most Followed Teams) ────────────────────────────────────────

class FeedTeamsNotifier extends StateNotifier<HomeFeedState<FeedTeamModel>> {
  FeedTeamsNotifier(this.ref) : super(HomeFeedState()) {
    load();
  }

  final Ref ref;
  static const int _limit = 10;
  int _start = 0;
  bool _isLoadingMore = false;

  Future<void> load({bool isRefresh = false}) async {
    if (!isRefresh) {
      _start = 0;
      state = HomeFeedState(isLoading: true, hasMore: true);
    }
    final user = ref.read(currentUserProvider);
    if (user == null) {
      if (!isRefresh) state = HomeFeedState(isLoading: false, hasMore: false);
      return;
    }
    final teamsData =
        await ref.read(homeFeedRepositoryProvider).getFeedTeamList(
              userId: user.id,
              start: 0,
              limit: _limit,
            );

    final items = teamsData.map((t) => FeedTeamModel.fromJson(t)).toList();
    _start = items.length;
    state = HomeFeedState(
      items: items,
      isLoading: false,
      hasMore: items.length >= _limit,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || _isLoadingMore || state.isLoading) return;
    _isLoadingMore = true;
    state = state.copyWith(isLoadingMore: true);
    final user = ref.read(currentUserProvider);
    if (user == null) {
      _isLoadingMore = false;
      state = state.copyWith(isLoadingMore: false);
      return;
    }
    final teamsData =
        await ref.read(homeFeedRepositoryProvider).getFeedTeamList(
              userId: user.id,
              start: _start,
              limit: _limit,
            );

    final more = teamsData.map((t) => FeedTeamModel.fromJson(t)).toList();
    _start += more.length;
    state = state.copyWith(
      items: [...state.items, ...more],
      isLoadingMore: false,
      hasMore: more.length >= _limit,
    );
    _isLoadingMore = false;
  }

  Future<void> refresh() => load(isRefresh: true);
}

final feedTeamsProvider =
    StateNotifierProvider<FeedTeamsNotifier, HomeFeedState<FeedTeamModel>>(
        (ref) {
  ref.watch(currentUserProvider);
  return FeedTeamsNotifier(ref);
});
