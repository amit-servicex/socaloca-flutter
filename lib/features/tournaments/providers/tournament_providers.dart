import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/auth_provider.dart';
import '../data/models/invitation_models.dart';
import '../data/tournament_models.dart';
import '../data/tournament_repository.dart';

/// Tournament details provider (family by tournamentId)
final tournamentDetailsProvider =
    FutureProvider.family<TournamentModel?, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getTournamentDetails(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// Tournament matches provider (family by tournamentId + isUpcoming)
final tournamentMatchesProvider =
    FutureProvider.family<List<TournamentMatchModel>, TournamentMatchesParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getTournamentMatches(
      userId: user.id,
      tournamentId: params.tournamentId,
      isUpcoming: params.isUpcoming,
      start: params.start,
      limit: params.limit,
    );
  },
);

/// Points table provider (family by tournamentId)
final pointsTableProvider =
    FutureProvider.family<List<PointsTableEntry>, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getPointsTable(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// Tournament stats provider (family by tournamentId + statType)
final tournamentStatsProvider =
    FutureProvider.family<List<PlayerStatEntry>, TournamentStatsParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getTournamentStats(
      userId: user.id,
      tournamentId: params.tournamentId,
      statType: params.statType,
    );
  },
);

/// My teams for tournament provider (family by tournamentId)
final myTeamsForTournamentProvider =
    FutureProvider.family<List<TeamModel>, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getMyTeamsForTournament(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// Tournament invitations provider
final tournamentInvitationsProvider =
    FutureProvider<List<Map<String, dynamic>>>(
  (ref) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getTournamentInvitations(
      userId: user.id,
    );
  },
);

/// Withdrawable teams provider
final withdrawableTeamsProvider = FutureProvider<List<TeamModel>>(
  (ref) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(tournamentRepositoryProvider);
    return await repository.getWithdrawableTeams(
      userId: user.id,
    );
  },
);

/// State notifier for tournament follow action
class TournamentFollowNotifier extends StateNotifier<AsyncValue<bool>> {
  TournamentFollowNotifier(this.ref) : super(const AsyncValue.data(false));

  final Ref ref;

  Future<void> toggleFollow({
    required String tournamentId,
    required bool currentFollowState,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = AsyncValue.error('User not logged in', StackTrace.current);
      return;
    }

    try {
      final repository = ref.read(tournamentRepositoryProvider);
      final result = await repository.followTournament(
        userId: user.id,
        tournamentId: tournamentId,
        myName: user.name ?? '',
        myImageUrl: user.profileImage,
        country: user.country,
        gender: user.userType,
        isPlayer: user.isPlayer,
        isCoach: user.isCoach,
        isAdmin: user.isAdmin,
        isFan: user.isFan,
      );

      if (result['success'] == true) {
        state = AsyncValue.data(result['isFollow'] as bool);
        // Invalidate tournament details to refresh follow state
        ref.invalidate(tournamentDetailsProvider(tournamentId));
      } else {
        state = AsyncValue.error('Failed to toggle follow', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final tournamentFollowProvider = StateNotifierProvider.family<
    TournamentFollowNotifier, AsyncValue<bool>, String>(
  (ref, tournamentId) => TournamentFollowNotifier(ref),
);

/// State notifier for join request action
class JoinRequestNotifier extends StateNotifier<AsyncValue<bool>> {
  JoinRequestNotifier(this.ref) : super(const AsyncValue.data(false));

  final Ref ref;

  Future<void> requestToJoin({
    required String tournamentId,
    required String teamId,
    String? parentId,
    String? teamName,
    String? tmntName,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = AsyncValue.error('User not logged in', StackTrace.current);
      return;
    }

    try {
      final repository = ref.read(tournamentRepositoryProvider);
      final success = await repository.requestToJoinTournament(
        userId: user.id,
        tournamentId: tournamentId,
        teamId: teamId,
        parentId: parentId,
        teamName: teamName,
        tmntName: tmntName,
      );

      state = AsyncValue.data(success);

      if (success) {
        // Invalidate tournament details to refresh
        ref.invalidate(tournamentDetailsProvider(tournamentId));
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final joinRequestProvider =
    StateNotifierProvider.family<JoinRequestNotifier, AsyncValue<bool>, String>(
  (ref, tournamentId) => JoinRequestNotifier(ref),
);

/// State notifier for withdrawal action
class WithdrawTeamNotifier extends StateNotifier<AsyncValue<bool>> {
  WithdrawTeamNotifier(this.ref) : super(const AsyncValue.data(false));

  final Ref ref;

  Future<void> withdrawTeam({
    required String tournamentId,
    required String teamId,
    String? reason,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserProvider);
    if (user == null) {
      state = AsyncValue.error('User not logged in', StackTrace.current);
      return;
    }

    try {
      final repository = ref.read(tournamentRepositoryProvider);
      final success = await repository.withdrawTeam(
        userId: user.id,
        tournamentId: tournamentId,
        teamId: teamId,
        reason: reason,
      );

      state = AsyncValue.data(success);

      if (success) {
        // Invalidate relevant providers
        ref.invalidate(tournamentDetailsProvider(tournamentId));
        ref.invalidate(withdrawableTeamsProvider);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final withdrawTeamProvider =
    StateNotifierProvider<WithdrawTeamNotifier, AsyncValue<bool>>(
  (ref) => WithdrawTeamNotifier(ref),
);

/// Parameter classes for family providers

class TournamentMatchesParams {
  final String tournamentId;
  final bool isUpcoming;
  final int start;
  final int limit;

  const TournamentMatchesParams({
    required this.tournamentId,
    required this.isUpcoming,
    this.start = 0,
    this.limit = 10,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentMatchesParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          isUpcoming == other.isUpcoming &&
          start == other.start &&
          limit == other.limit;

  @override
  int get hashCode =>
      tournamentId.hashCode ^
      isUpcoming.hashCode ^
      start.hashCode ^
      limit.hashCode;
}

class TournamentStatsParams {
  final String tournamentId;
  final String statType; // 'goals', 'assists', 'cards', 'mom'

  const TournamentStatsParams({
    required this.tournamentId,
    required this.statType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentStatsParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          statType == other.statType;

  @override
  int get hashCode => tournamentId.hashCode ^ statType.hashCode;
}
