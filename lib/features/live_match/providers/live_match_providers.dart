import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/live_match_models.dart';
import '../repositories/live_match_repository.dart';

// ─── Repository ───────────────────────────────────────────────────────────────

final liveMatchRepositoryProvider = Provider<LiveMatchRepository>(
  (_) => LiveMatchRepository(),
);

// ─── Filter state ─────────────────────────────────────────────────────────────

final playerLiveSelectedTournamentProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final playerLiveSelectedCountryProvider =
    StateProvider.autoDispose<String?>((ref) => null);

// ─── Tournament dropdown ──────────────────────────────────────────────────────

final liveMatchTournamentDropdownProvider =
    FutureProvider.autoDispose<List<Map<String, String>>>((ref) {
  return ref.read(liveMatchRepositoryProvider).getTournamentDropdown();
});

// ─── Country dropdown ─────────────────────────────────────────────────────────

final liveMatchCountryDropdownProvider =
    FutureProvider.autoDispose<List<String>>((ref) {
  return ref.read(liveMatchRepositoryProvider).getCountryDropdown();
});

// ─── Player live match list (with pagination + 60-second auto-refresh) ────────

class PlayerLiveMatchState {
  const PlayerLiveMatchState({
    this.matches = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasReachedEnd = false,
  });

  final List<LiveMatchListItem> matches;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasReachedEnd;

  PlayerLiveMatchState copyWith({
    List<LiveMatchListItem>? matches,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasReachedEnd,
  }) =>
      PlayerLiveMatchState(
        matches: matches ?? this.matches,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        error: error,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      );
}

class PlayerLiveMatchNotifier extends StateNotifier<PlayerLiveMatchState> {
  PlayerLiveMatchNotifier(this._repo) : super(const PlayerLiveMatchState()) {
    load();
    _startAutoRefresh();
  }

  final LiveMatchRepository _repo;
  Timer? _refreshTimer;
  String? _tournamentId;
  String? _country;
  bool _isFetching = false;
  static const int _limit = 10;

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => _refresh(),
    );
  }

  Future<void> load({
    String? tournamentId,
    String? country,
  }) async {
    if (_isFetching) return;
    _tournamentId = tournamentId;
    _country = country;
    _isFetching = true;
    state = state.copyWith(isLoading: true, error: null, hasReachedEnd: false);
    try {
      final items = await _repo.getPlayerLiveMatches(
        tournamentId: _tournamentId,
        country: _country,
        start: 0,
        limit: _limit,
      );
      state = state.copyWith(
        matches: items,
        isLoading: false,
        hasReachedEnd: items.length < _limit,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || state.hasReachedEnd || state.isLoading) return;
    _isFetching = true;
    state = state.copyWith(isLoadingMore: true);
    try {
      final nextItems = await _repo.getPlayerLiveMatches(
        tournamentId: _tournamentId,
        country: _country,
        start: state.matches.length,
        limit: _limit,
      );
      state = state.copyWith(
        matches: [...state.matches, ...nextItems],
        isLoadingMore: false,
        hasReachedEnd: nextItems.length < _limit,
      );
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _refresh() async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      final items = await _repo.getPlayerLiveMatches(
        tournamentId: _tournamentId,
        country: _country,
        start: 0,
        limit: _limit,
      );
      state = state.copyWith(
        matches: items,
        hasReachedEnd: items.length < _limit,
      );
    } catch (_) {
      // silent on auto-refresh failure
    } finally {
      _isFetching = false;
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}

final playerLiveMatchProvider = StateNotifierProvider.autoDispose<
    PlayerLiveMatchNotifier, PlayerLiveMatchState>(
  (ref) => PlayerLiveMatchNotifier(ref.read(liveMatchRepositoryProvider)),
);

// ─── Live match detail (with 60-second polling) ───────────────────────────────

class LiveMatchDetailState {
  const LiveMatchDetailState({
    this.detail,
    this.isLoading = false,
    this.error,
  });

  final LiveMatchDetail? detail;
  final bool isLoading;
  final String? error;

  LiveMatchDetailState copyWith({
    LiveMatchDetail? detail,
    bool? isLoading,
    String? error,
  }) =>
      LiveMatchDetailState(
        detail: detail ?? this.detail,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class LiveMatchDetailNotifier extends StateNotifier<LiveMatchDetailState> {
  LiveMatchDetailNotifier(
    this._repo,
    this._matchId,
    this._tournamentId,
    this._preferMatchData,
  ) : super(const LiveMatchDetailState()) {
    _fetch();
    _startPolling();
  }

  final LiveMatchRepository _repo;
  final String _matchId;
  final String _tournamentId;
  final bool _preferMatchData;
  Timer? _pollTimer;
  bool _isFetching = false;

  void _startPolling() {
    _pollTimer = Timer.periodic(
      const Duration(seconds: 60),
      (_) {
        if (!_isFetching) _fetch();
      },
    );
  }

  Future<void> _fetch() async {
    if (_isFetching) return;
    _isFetching = true;
    if (state.detail == null) {
      state = state.copyWith(isLoading: true, error: null);
    }
    try {
      final detail = await _repo.getLiveMatchDetail(
        matchId: _matchId,
        tournamentId: _tournamentId,
        preferMatchData: _preferMatchData,
      );
      if (detail != null) {
        state = LiveMatchDetailState(detail: detail);
      }
    } catch (e) {
      if (state.detail == null) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() => _fetch();

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }
}

// Family provider — one instance per matchId+tournamentId pair
final liveMatchDetailProvider = StateNotifierProvider.autoDispose.family<
    LiveMatchDetailNotifier, LiveMatchDetailState, (String, String, bool)>(
  (ref, args) => LiveMatchDetailNotifier(
    ref.read(liveMatchRepositoryProvider),
    args.$1,
    args.$2,
    args.$3,
  ),
);
