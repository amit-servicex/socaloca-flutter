import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/team_filter_model.dart';
import '../data/models/team_model.dart';
import '../data/repositories/teams_repository.dart';

final teamsRepositoryProvider = Provider<TeamsRepository>((ref) {
  return TeamsRepository();
});

final teamsProvider =
    StateNotifierProvider<TeamsNotifier, TeamsState>((ref) {
  final repository = ref.watch(teamsRepositoryProvider);
  return TeamsNotifier(repository);
});

class TeamsState {
  final List<TeamModel> teams;
  final TeamFilterModel filters;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final bool hasMore;

  const TeamsState({
    this.teams = const [],
    this.filters = const TeamFilterModel(),
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 0,
    this.hasMore = true,
  });

  TeamsState copyWith({
    List<TeamModel>? teams,
    TeamFilterModel? filters,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return TeamsState(
      teams: teams ?? this.teams,
      filters: filters ?? this.filters,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class TeamsNotifier extends StateNotifier<TeamsState> {
  final TeamsRepository _repository;
  static const int _limit = 10;

  TeamsNotifier(this._repository) : super(const TeamsState());

  void setLocation(String location) {
    state = state.copyWith(
      filters: state.filters.copyWith(location: location),
    );
  }

  void setGameType(String gameType) {
    state = state.copyWith(
      filters: state.filters.copyWith(gameType: gameType),
    );
  }

  void setGender(String gender) {
    state = state.copyWith(
      filters: state.filters.copyWith(gender: gender),
    );
  }

  void setAgeRange(String ageRange) {
    state = state.copyWith(
      filters: state.filters.copyWith(ageRange: ageRange),
    );
  }

  void setAgeCategory(String ageCategory) {
    state = state.copyWith(
      filters: state.filters.copyWith(ageCategory: ageCategory),
    );
  }

  Future<void> search({bool requireFilters = false}) async {
    if (state.isLoading) return;

    // Skip filter validation if not required (for initial load)
    if (requireFilters && !state.filters.hasAnyFilter) {
      return;
    }

    print('🔍 Starting search with filters: ${state.filters}');

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 0,
      teams: [],
      hasMore: true,
    );

    try {
      final teams = await _repository.getTeams(
        location: state.filters.location,
        gameType: state.filters.gameType,
        gender: state.filters.gender,
        ageRange: state.filters.ageRange,
        ageCategory: state.filters.ageCategory,
        start: 0,
        limit: _limit,
      );

      print('✅ Search completed. Found ${teams.length} teams');

      state = state.copyWith(
        teams: teams,
        isLoading: false,
        currentPage: 1,
        hasMore: teams.length >= _limit,
      );
    } catch (e, stackTrace) {
      print('❌ Search error: $e');
      print('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newTeams = await _repository.getTeams(
        location: state.filters.location,
        gameType: state.filters.gameType,
        gender: state.filters.gender,
        ageRange: state.filters.ageRange,
        ageCategory: state.filters.ageCategory,
        start: state.currentPage * _limit,
        limit: _limit,
      );

      state = state.copyWith(
        teams: [...state.teams, ...newTeams],
        isLoadingMore: false,
        currentPage: state.currentPage + 1,
        hasMore: newTeams.length >= _limit,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(currentPage: 0, teams: [], hasMore: true);
    await search();
  }
}

