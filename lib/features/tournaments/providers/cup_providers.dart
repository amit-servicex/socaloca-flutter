import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/auth_provider.dart';
import '../data/models/cup_models.dart';
import '../data/repositories/cup_repository.dart';

/// Cup details provider (family by tournamentId)
final cupDetailsProvider = FutureProvider.family<TournamentCupModel?, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupDetails(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// Cup ready detail provider (for active/live cups)
final cupReadyDetailProvider =
    FutureProvider.family<TournamentCupModel?, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupReadyDetail(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// Cup group matches provider
final cupGroupMatchesProvider =
    FutureProvider.family<CupGroupModel?, CupGroupMatchesParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupGroupMatches(
      userId: user.id,
      tournamentId: params.tournamentId,
      roundId: params.roundId,
      groupId: params.groupId,
    );
  },
);

/// Cup group point table provider
final cupGroupPointTableProvider =
    FutureProvider.family<List<CupGroupPointTableEntry>, CupGroupTableParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupLeagueTable(
      userId: user.id,
      tournamentId: params.tournamentId,
      groupId: params.groupId,
    );
  },
);

/// Cup knockout matches provider
final cupKnockoutMatchesProvider =
    FutureProvider.family<List<CupMatchModel>, CupKnockoutParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupKnockMatches(
      userId: user.id,
      tournamentId: params.tournamentId,
      roundId: params.roundId,
    );
  },
);

/// Cup group stats provider (group stage stats)
final cupGroupStatsProvider =
    FutureProvider.family<List<CupPlayerStatEntry>, CupGroupStatsParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupGroupStats(
      userId: user.id,
      tournamentId: params.tournamentId,
      statType: params.statType,
      roundId: params.roundId,
      groupId: params.groupId,
    );
  },
);

/// Cup match stats provider (knockout stats)
final cupMatchStatsProvider =
    FutureProvider.family<List<CupPlayerStatEntry>, CupMatchStatsParams>(
  (ref, params) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupMatchStats(
      userId: user.id,
      tournamentId: params.tournamentId,
      statType: params.statType,
      roundId: params.roundId,
    );
  },
);

/// My teams for cup provider
final myTeamsForCupProvider = FutureProvider.family<List<CupTeamModel>, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getMyTeamsForCup(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// State notifier for cup follow action
class CupFollowNotifier extends StateNotifier<AsyncValue<bool>> {
  CupFollowNotifier(this.ref) : super(const AsyncValue.data(false));

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
      final repository = ref.read(cupRepositoryProvider);
      final result = await repository.followCup(
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
        // Invalidate cup details to refresh follow state
        ref.invalidate(cupDetailsProvider(tournamentId));
      } else {
        state = AsyncValue.error('Failed to toggle follow', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final cupFollowProvider =
    StateNotifierProvider.family<CupFollowNotifier, AsyncValue<bool>, String>(
  (ref, tournamentId) => CupFollowNotifier(ref),
);

/// State notifier for cup join request action
class CupJoinRequestNotifier extends StateNotifier<AsyncValue<bool>> {
  CupJoinRequestNotifier(this.ref) : super(const AsyncValue.data(false));

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
      final repository = ref.read(cupRepositoryProvider);
      final success = await repository.requestCup(
        userId: user.id,
        tournamentId: tournamentId,
        teamId: teamId,
        parentId: parentId,
        teamName: teamName,
        tmntName: tmntName,
      );

      state = AsyncValue.data(success);

      if (success) {
        // Invalidate cup details to refresh
        ref.invalidate(cupDetailsProvider(tournamentId));
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<Map<String, dynamic>> checkEligibility({
    required String tournamentId,
    required String teamId,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) {
      return {'eligible': false, 'message': 'User not logged in'};
    }

    try {
      final repository = ref.read(cupRepositoryProvider);
      return await repository.checkReqForCup(
        userId: user.id,
        tournamentId: tournamentId,
        teamId: teamId,
      );
    } catch (e) {
      return {'eligible': false, 'message': e.toString()};
    }
  }
}

final cupJoinRequestProvider = StateNotifierProvider.family<
    CupJoinRequestNotifier, AsyncValue<bool>, String>(
  (ref, tournamentId) => CupJoinRequestNotifier(ref),
);

/// Cup itinerary URL provider — returns the doc URL if canView is true, else null
final cupItineraryUrlProvider = FutureProvider.family<String?, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupItineraryUrl(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// Check cup pending join requests (for organizer admin/coach)
final checkCupInvitesProvider =
    FutureProvider.family<List<CupTeamModel>, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];
    final repository = ref.watch(cupRepositoryProvider);
    return await repository.checkCupPendingInvites(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);

/// State notifier for accepting/declining cup join requests
class CupInviteResponseNotifier extends StateNotifier<AsyncValue<bool>> {
  CupInviteResponseNotifier(this.ref) : super(const AsyncValue.data(false));

  final Ref ref;

  Future<void> respond({
    required String tournamentId,
    required String teamId,
    required bool accept,
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
      final repository = ref.read(cupRepositoryProvider);
      final success = await repository.acceptDeclineCupRequest(
        userId: user.id,
        tournamentId: tournamentId,
        teamId: teamId,
        accept: accept,
        parentId: parentId,
        teamName: teamName,
        tmntName: tmntName,
      );
      state = AsyncValue.data(success);
      if (success) ref.invalidate(checkCupInvitesProvider(tournamentId));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final cupInviteResponseProvider = StateNotifierProvider.family<
    CupInviteResponseNotifier, AsyncValue<bool>, String>(
  (ref, tournamentId) => CupInviteResponseNotifier(ref),
);

/// Parameter classes for family providers

class CupGroupMatchesParams {
  final String tournamentId;
  final String roundId;
  final String groupId;

  const CupGroupMatchesParams({
    required this.tournamentId,
    required this.roundId,
    required this.groupId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CupGroupMatchesParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          roundId == other.roundId &&
          groupId == other.groupId;

  @override
  int get hashCode =>
      tournamentId.hashCode ^ roundId.hashCode ^ groupId.hashCode;
}

class CupGroupTableParams {
  final String tournamentId;
  final String groupId;

  const CupGroupTableParams({
    required this.tournamentId,
    required this.groupId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CupGroupTableParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          groupId == other.groupId;

  @override
  int get hashCode => tournamentId.hashCode ^ groupId.hashCode;
}

class CupKnockoutParams {
  final String tournamentId;
  final String roundId;

  const CupKnockoutParams({
    required this.tournamentId,
    required this.roundId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CupKnockoutParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          roundId == other.roundId;

  @override
  int get hashCode => tournamentId.hashCode ^ roundId.hashCode;
}

class CupGroupStatsParams {
  final String tournamentId;
  final String statType; // 'goals', 'assists', 'cards', 'mom'
  final String? roundId;
  final String? groupId;

  const CupGroupStatsParams({
    required this.tournamentId,
    required this.statType,
    this.roundId,
    this.groupId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CupGroupStatsParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          statType == other.statType &&
          roundId == other.roundId &&
          groupId == other.groupId;

  @override
  int get hashCode =>
      tournamentId.hashCode ^
      statType.hashCode ^
      (roundId?.hashCode ?? 0) ^
      (groupId?.hashCode ?? 0);
}

class CupMatchStatsParams {
  final String tournamentId;
  final String statType; // 'goals', 'assists', 'cards', 'mom'
  final String? roundId;

  const CupMatchStatsParams({
    required this.tournamentId,
    required this.statType,
    this.roundId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CupMatchStatsParams &&
          runtimeType == other.runtimeType &&
          tournamentId == other.tournamentId &&
          statType == other.statType &&
          roundId == other.roundId;

  @override
  int get hashCode =>
      tournamentId.hashCode ^ statType.hashCode ^ (roundId?.hashCode ?? 0);
}
