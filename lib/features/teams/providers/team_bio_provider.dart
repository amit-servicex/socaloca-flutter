import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/team_bio_model.dart';
import '../data/repositories/team_bio_repository.dart';

final teamBioRepositoryProvider = Provider<TeamBioRepository>((ref) {
  return TeamBioRepository();
});

final teamBioProvider =
    StateNotifierProvider.family<TeamBioNotifier, TeamBioState, String>(
        (ref, teamId) {
  final repository = ref.watch(teamBioRepositoryProvider);
  return TeamBioNotifier(repository, teamId);
});

class TeamBioState {
  final TeamBioModel? teamBio;
  final bool isLoading;
  final bool isFollowLoading;
  final bool isRequestLoading;
  final String? error;
  final bool isFollowing;
  final int followCount;
  final bool isAdmin;
  final bool isPending;
  final bool isMember;
  final bool joinRequest;
  final bool isArchive;
  final String? createdBy;
  final int? joinedOn;

  const TeamBioState({
    this.teamBio,
    this.isLoading = false,
    this.isFollowLoading = false,
    this.isRequestLoading = false,
    this.error,
    this.isFollowing = false,
    this.followCount = 0,
    this.isAdmin = false,
    this.isPending = false,
    this.isMember = false,
    this.joinRequest = false,
    this.isArchive = false,
    this.createdBy,
    this.joinedOn,
  });

  TeamBioState copyWith({
    TeamBioModel? teamBio,
    bool? isLoading,
    bool? isFollowLoading,
    bool? isRequestLoading,
    String? error,
    bool? isFollowing,
    int? followCount,
    bool? isAdmin,
    bool? isPending,
    bool? isMember,
    bool? joinRequest,
    bool? isArchive,
    String? createdBy,
    int? joinedOn,
  }) {
    return TeamBioState(
      teamBio: teamBio ?? this.teamBio,
      isLoading: isLoading ?? this.isLoading,
      isFollowLoading: isFollowLoading ?? this.isFollowLoading,
      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
      error: error,
      isFollowing: isFollowing ?? this.isFollowing,
      followCount: followCount ?? this.followCount,
      isAdmin: isAdmin ?? this.isAdmin,
      isPending: isPending ?? this.isPending,
      isMember: isMember ?? this.isMember,
      joinRequest: joinRequest ?? this.joinRequest,
      isArchive: isArchive ?? this.isArchive,
      createdBy: createdBy ?? this.createdBy,
      joinedOn: joinedOn ?? this.joinedOn,
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
      final result = await _repository.getTeamBio(teamId: _teamId);
      final actionInfo = result.actionInfo;

      state = state.copyWith(
        teamBio: result.teamBio,
        isLoading: false,
        isFollowing: actionInfo.isFollowing,
        followCount: actionInfo.followCount,
        isAdmin: actionInfo.isAdmin,
        isPending: actionInfo.isPending,
        isMember: actionInfo.isMember,
        joinRequest: actionInfo.joinRequest,
        isArchive: actionInfo.isArchive,
        createdBy: actionInfo.createdBy,
        joinedOn: actionInfo.joinedOn,
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

  Future<void> toggleFollow() async {
    if (state.isFollowLoading || state.teamBio == null) return;

    state = state.copyWith(isFollowLoading: true, error: null);
    try {
      final isFollowing = await _repository.followTeam(teamId: _teamId);
      final countDelta = isFollowing ? 1 : -1;
      final updatedCount = state.followCount + countDelta;
      state = state.copyWith(
        isFollowLoading: false,
        isFollowing: isFollowing,
        followCount: updatedCount < 0 ? 0 : updatedCount,
      );
    } catch (e) {
      state = state.copyWith(isFollowLoading: false);
      rethrow;
    }
  }

  Future<void> requestToJoin() async {
    if (state.isRequestLoading || state.teamBio == null) return;

    state = state.copyWith(isRequestLoading: true, error: null);
    try {
      final success = await _repository.requestTeamJoin(teamId: _teamId);
      state = state.copyWith(
        isRequestLoading: false,
        isPending: success ? true : state.isPending,
      );
      if (!success) {
        throw Exception('Failed to send request');
      }
    } catch (e) {
      state = state.copyWith(isRequestLoading: false);
      rethrow;
    }
  }
}
