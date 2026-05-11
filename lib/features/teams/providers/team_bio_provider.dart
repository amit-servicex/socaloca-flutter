import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/team_bio_model.dart';
import '../data/repositories/team_bio_repository.dart';

final teamBioRepositoryProvider = Provider<TeamBioRepository>((ref) {
  return TeamBioRepository();
});

final teamBioProvider = StateNotifierProvider.family<TeamBioNotifier,
    TeamBioState, String>((ref, teamId) {
  final repository = ref.watch(teamBioRepositoryProvider);
  return TeamBioNotifier(repository, teamId);
});

class TeamBioState {
  final TeamBioModel? teamBio;
  final bool isLoading;
  final String? error;

  const TeamBioState({
    this.teamBio,
    this.isLoading = false,
    this.error,
  });

  TeamBioState copyWith({
    TeamBioModel? teamBio,
    bool? isLoading,
    String? error,
  }) {
    return TeamBioState(
      teamBio: teamBio ?? this.teamBio,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TeamBioNotifier extends StateNotifier<TeamBioState> {
  final TeamBioRepository _repository;
  final String _teamId;

  TeamBioNotifier(this._repository, this._teamId)
      : super(const TeamBioState()) {
    loadTeamBio();
  }

  Future<void> loadTeamBio() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final teamBio = await _repository.getTeamBio(teamId: _teamId);

      state = state.copyWith(
        teamBio: teamBio,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await loadTeamBio();
  }
}

