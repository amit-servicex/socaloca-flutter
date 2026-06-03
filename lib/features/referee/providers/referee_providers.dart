import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/referee_bio_model.dart';
import '../data/models/referee_match_model.dart';
import '../data/models/referee_tournament_model.dart';
import '../data/referee_repository.dart';

// ─── Repository provider ──────────────────────────────────────────────────────

final refereeRepositoryProvider = Provider<RefereeRepository>(
  (_) => RefereeRepository(),
);

// ─── Tournament dropdown (shared between Matches + Live tabs) ─────────────────

final refereeTournamentDropdownProvider =
    FutureProvider.autoDispose<List<TournamentDropdownItem>>((ref) {
  return ref.read(refereeRepositoryProvider).getMatchesTournamentDropdown();
});

final refereeRequestsDropdownProvider =
    FutureProvider.autoDispose<List<TournamentDropdownItem>>((ref) {
  return ref.read(refereeRepositoryProvider).getRequestsTournamentDropdown();
});

final refereeLiveDropdownProvider =
    FutureProvider.autoDispose<List<TournamentDropdownItem>>((ref) {
  return ref.read(refereeRepositoryProvider).getMatchesTournamentDropdown();
});

// ─── Selected tournament filter (per-tab) ────────────────────────────────────

final refereeSelectedTmntRequestsProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final refereeSelectedTmntMatchesProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final refereeSelectedTmntLiveProvider =
    StateProvider.autoDispose<String?>((ref) => null);

// ─── Tournaments tab ──────────────────────────────────────────────────────────

class _TournamentsNotifier
    extends StateNotifier<AsyncValue<List<RefereeTournamentModel>>> {
  _TournamentsNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  final RefereeRepository _repo;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repo.getTournaments();
      state = AsyncValue.data(list);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final refereeTournamentsProvider = StateNotifierProvider.autoDispose<
    _TournamentsNotifier, AsyncValue<List<RefereeTournamentModel>>>(
  (ref) => _TournamentsNotifier(ref.read(refereeRepositoryProvider)),
);

// ─── My Requests tab ─────────────────────────────────────────────────────────

class _RequestsNotifier
    extends StateNotifier<AsyncValue<List<RefereeMatchModel>>> {
  _RequestsNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  final RefereeRepository _repo;

  Future<void> load({String? tournamentId}) async {
    state = const AsyncValue.loading();
    try {
      final list = await _repo.getRequests(tournamentId: tournamentId);
      state = AsyncValue.data(list);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  void removeMatch(String matchId) {
    state.whenData((list) {
      state = AsyncValue.data(
        list.where((m) => m.matchId != matchId).toList(),
      );
    });
  }
}

final refereeRequestsProvider = StateNotifierProvider.autoDispose<
    _RequestsNotifier, AsyncValue<List<RefereeMatchModel>>>(
  (ref) => _RequestsNotifier(ref.read(refereeRepositoryProvider)),
);

// ─── My Matches tab ───────────────────────────────────────────────────────────

class _MatchesNotifier
    extends StateNotifier<AsyncValue<List<RefereeMatchModel>>> {
  _MatchesNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  final RefereeRepository _repo;
  static const _limit = 10;
  String? _tournamentId;
  int _start = 0;
  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> load({String? tournamentId}) async {
    _tournamentId = tournamentId;
    _start = 0;
    hasMore = true;
    isLoadingMore = false;
    state = const AsyncValue.loading();
    try {
      final list = await _repo.getMatches(
        tournamentId: tournamentId,
        start: _start,
        limit: _limit,
      );
      _start += _limit;
      hasMore = list.length == _limit;
      state = AsyncValue.data(_sortedMatches(list));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    final current = state.valueOrNull ?? [];
    isLoadingMore = true;
    try {
      final list = await _repo.getMatches(
        tournamentId: _tournamentId,
        start: _start,
        limit: _limit,
      );
      _start += _limit;
      hasMore = list.length == _limit;
      state = AsyncValue.data(_sortedMatches([...current, ...list]));
    } catch (_) {
      state = AsyncValue.data(current);
    } finally {
      isLoadingMore = false;
    }
  }

  List<RefereeMatchModel> _sortedMatches(List<RefereeMatchModel> matches) {
    final sorted = [...matches];
    sorted.sort(
        (a, b) => (b.matchDateTimeGmt ?? 0).compareTo(a.matchDateTimeGmt ?? 0));
    return sorted;
  }
}

final refereeMatchesProvider = StateNotifierProvider.autoDispose<
    _MatchesNotifier, AsyncValue<List<RefereeMatchModel>>>(
  (ref) => _MatchesNotifier(ref.read(refereeRepositoryProvider)),
);

// ─── Live Matches tab ─────────────────────────────────────────────────────────

class _LiveMatchesNotifier
    extends StateNotifier<AsyncValue<List<RefereeMatchModel>>> {
  _LiveMatchesNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  final RefereeRepository _repo;
  static const _limit = 10;
  String? _tournamentId;
  int _start = 0;
  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> load({String? tournamentId}) async {
    _tournamentId = tournamentId;
    _start = 0;
    hasMore = true;
    isLoadingMore = false;
    state = const AsyncValue.loading();
    try {
      final list = await _repo.getLiveMatches(
        tournamentId: tournamentId,
        start: _start,
        limit: _limit,
      );
      _start += _limit;
      hasMore = list.length == _limit;
      state = AsyncValue.data(_sortedMatches(list));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    final current = state.valueOrNull ?? [];
    isLoadingMore = true;
    try {
      final list = await _repo.getLiveMatches(
        tournamentId: _tournamentId,
        start: _start,
        limit: _limit,
      );
      _start += _limit;
      hasMore = list.length == _limit;
      state = AsyncValue.data(_sortedMatches([...current, ...list]));
    } catch (_) {
      state = AsyncValue.data(current);
    } finally {
      isLoadingMore = false;
    }
  }

  List<RefereeMatchModel> _sortedMatches(List<RefereeMatchModel> matches) {
    final sorted = [...matches];
    sorted.sort(
        (a, b) => (b.matchDateTimeGmt ?? 0).compareTo(a.matchDateTimeGmt ?? 0));
    return sorted;
  }
}

final refereeLiveMatchesProvider = StateNotifierProvider.autoDispose<
    _LiveMatchesNotifier, AsyncValue<List<RefereeMatchModel>>>(
  (ref) => _LiveMatchesNotifier(ref.read(refereeRepositoryProvider)),
);

// ─── My Bio tab ───────────────────────────────────────────────────────────────

class _RefereeBioState {
  final RefereeBioModel? bio;
  final bool isLoading;
  final String? error;
  final List<RefereeActivityModel> recentActivities;
  final bool isLoadingActivities;

  const _RefereeBioState({
    this.bio,
    this.isLoading = false,
    this.error,
    this.recentActivities = const [],
    this.isLoadingActivities = false,
  });

  _RefereeBioState copyWith({
    RefereeBioModel? bio,
    bool? isLoading,
    String? error,
    List<RefereeActivityModel>? recentActivities,
    bool? isLoadingActivities,
  }) =>
      _RefereeBioState(
        bio: bio ?? this.bio,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        recentActivities: recentActivities ?? this.recentActivities,
        isLoadingActivities: isLoadingActivities ?? this.isLoadingActivities,
      );
}

class RefereeBioNotifier extends StateNotifier<_RefereeBioState> {
  RefereeBioNotifier(this._repo) : super(const _RefereeBioState());

  final RefereeRepository _repo;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final bio = await _repo.getRefBio();
      state = state.copyWith(isLoading: false, bio: bio);
      _loadActivities();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _loadActivities() async {
    state = state.copyWith(isLoadingActivities: true);
    try {
      final list = await _repo.getActivities();
      state =
          state.copyWith(isLoadingActivities: false, recentActivities: list);
    } catch (_) {
      state = state.copyWith(isLoadingActivities: false);
    }
  }
}

final refereeBioProvider =
    StateNotifierProvider.autoDispose<RefereeBioNotifier, _RefereeBioState>(
  (ref) => RefereeBioNotifier(ref.read(refereeRepositoryProvider)),
);
