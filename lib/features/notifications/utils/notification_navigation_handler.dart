import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/storage_service.dart';
import '../data/models/notification_model.dart';

/// Handles navigation for all notification types.
/// Card tap → matches Android respondAction.
/// Avatar tap → matches Android respondActionForBio.
class NotificationNavigationHandler {
  // ── Notification type constants (match NotificationParams.java) ────────────
  static const String likeUser = 'likeUser';
  static const String followUser = 'followUser';
  static const String reqTeamJoin = 'requestTeamJoin';
  static const String respTeamJoin = 'respondTeamJoinRequest';
  static const String inviteTeamUser = 'inviteTeamUser';
  static const String inviteTeamPlayer = 'inviteTeamPlayer';
  static const String acceptTeamPlayer = 'acceptTeamPlayer';
  static const String declineTeamPlayer = 'declineTeamPlayer';
  static const String editTeam = 'editTeam';
  static const String teamAddPlayer = 'teamAddPlayer';
  static const String newTeamAlert = 'newTeamAlert';
  static const String hostMatch = 'hostMatch';
  static const String respondMatchReq = 'acceptDeclineMatchRequest';
  static const String sendMatchScore = 'sendMatchScore';
  static const String acceptMatchScore = 'acceptMatchScore';
  static const String saveMatchRating = 'saveMatchRating';
  static const String matchNews = 'matchNews';
  static const String teamMatchResult = 'teamMatchResult';
  static const String matchActivity = 'matchActivity';
  static const String liveMatchUpdate = 'liveMatchUpdate';
  static const String pickUpMatchRequest = 'pickUpRequest';
  static const String acceptPickUpRequest = 'acceptPickUpRequest';
  static const String nearPickUp = 'nearPickUp';
  static const String tmntInvite = 'tournamentInvite';
  static const String tmntAccept = 'tournamentAccept';
  static const String tmntConfirm = 'tournamentConfirm';
  static const String leagueNotice = 'leagueNotice';
  static const String teamTournament = 'teamTournament';
  static const String newTmntAlert = 'newTmntAlert';
  static const String fixtureChange = 'fixtureChange';
  static const String cupInvite = 'cupInvite';
  static const String cupConfirm = 'cupConfirm';
  static const String cupAccept = 'cupAccept';
  static const String cupNotice = 'cupNotice';
  static const String likePost = 'likePost';
  static const String newUserPost = 'newUserPost';
  static const String userSkillPost = 'userSkillPost';
  static const String userTagPost = 'userTagPost';
  static const String feedComment = 'feedComment';
  static const String feedCommentLike = 'feedCommentLike';
  static const String endorsePlayer = 'endorsePlayer';
  static const String newEndorse = 'newEndorse';
  static const String trainActivity = 'trainActivity';
  static const String fromClub = 'fromClub';
  static const String fromFA = 'fromFA';
  static const String fromConfed = 'fromConfed';
  static const String fromCharityNgo = 'fromCharity';
  static const String fromSponsor = 'fromSpon';
  static const String fromAcademy = 'fromAcademy';
  static const String acceptAcademy = 'acceptAcademy';
  static const String assignReferee = 'assignReferee';
  static const String newUserJoin = 'newUserJoin';

  // ── Match type constants (match Params.java) ───────────────────────────────
  static const String _cupGroup = 'CUP_GROUP';
  static const String _cupKnock = 'CUP_KNOCK';
  static const String _leagueMatch = 'LEAGUE_MATCH';
  static const String _cupLeague = 'CUP_LEAGUE';
  static const String _oneOff = 'ONE_OFF';
  static const String _cup = 'CUP';

  static void handleNotificationTap({
    required BuildContext context,
    required NotificationModel notification,
    required bool isAvatarTap,
  }) {
    final type = notification.notificationType;
    final payload = notification.payload;

    try {
      if (isAvatarTap) {
        _handleAvatarTap(context, type, payload);
      } else {
        _handleCardTap(context, type, payload);
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }

  // ── Card tap: matches Android respondAction ────────────────────────────────

  static void _handleCardTap(
    BuildContext context,
    String type,
    Map<String, dynamic> payload,
  ) {
    switch (type) {
      case likeUser:
        // Android: LikeListFragment → my bio
        context.push('/my-bio');
        break;

      case followUser:
        // Android: FollowFragment → my endorsements/followers
        context.push('/my-bio/endorsements');
        break;

      case respTeamJoin:
      case inviteTeamUser:
      case editTeam:
      case newTeamAlert:
        _navigateToTeamBio(context, payload);
        break;

      case declineTeamPlayer:
      case reqTeamJoin:
        // Android: ManageTeamLandingFragment (from teamDetails)
        _navigateToTeamFromDetails(context, payload);
        break;

      case acceptTeamPlayer:
        // Android: ManageTeamLandingFragment with NEW_PLAYERS tab
        _navigateToTeamFromDetails(context, payload);
        break;

      case hostMatch:
        // Android: MatchRequestsFragment (ONE_OFF_RECEIVED tab)
        _showNotImplemented(context, 'Match Requests');
        break;

      case respondMatchReq:
      case sendMatchScore:
      case acceptMatchScore:
      case saveMatchRating:
        _navigateToMatchManage(context, payload);
        break;

      case endorsePlayer:
        _navigateToSkillDetail(context, payload);
        break;

      case tmntInvite:
      case tmntAccept:
      case tmntConfirm:
      case leagueNotice:
        _navigateToTournament(context, payload);
        break;

      case acceptPickUpRequest:
      case pickUpMatchRequest:
        _navigateToPickupMatch(context, payload);
        break;

      case inviteTeamPlayer:
        // Android: PlayerAdminTeamLandingFragment tab 3 → player invitations
        context.push('/player-invitations');
        break;

      case likePost:
        // Android: MyGalleryNewFragment for current user
        final myId = StorageService.userId ?? '';
        context.push('/my-bio/posts',
            extra: {'userId': myId, 'isOwnProfile': true});
        break;

      case fromClub:
        _navigateToClubBio(context, payload);
        break;

      case fromFA:
        _navigateToFaBio(context, payload);
        break;

      case fromConfed:
        _navigateToConfedBio(context, payload);
        break;

      case fromCharityNgo:
        _navigateToCharityBio(context, payload);
        break;

      case fromSponsor:
        _navigateToSponsorBio(context, payload);
        break;

      case cupInvite:
      case cupConfirm:
      case cupAccept:
      case cupNotice:
        _navigateToCupDetails(context, payload);
        break;

      case feedComment:
      case feedCommentLike:
        // Android: CommentFragment (requires permission check)
        _showNotImplemented(context, 'Comments');
        break;

      case acceptAcademy:
      case fromAcademy:
        _navigateToAcademyBio(context, payload);
        break;

      case matchNews:
        _navigateToMatchDetailsFromMatchNews(context, payload);
        break;

      case teamTournament:
      case newTmntAlert:
        _navigateToTournamentOrCup(context, payload);
        break;

      case teamAddPlayer:
        _navigateToTeamPlayers(context, payload);
        break;

      case teamMatchResult:
        _navigateToMatchDetailsFromResult(context, payload);
        break;

      case nearPickUp:
        _navigateToPickupMatch(context, payload);
        break;

      case newUserJoin:
        _navigateToUserBioByProfileId(context, payload);
        break;

      case newUserPost:
      case userSkillPost:
      case userTagPost:
        _navigateToCreatorPosts(context, payload);
        break;

      case fixtureChange:
        _navigateToFixtureChange(context, payload);
        break;

      case newEndorse:
        context.push('/my-bio/endorsements');
        break;

      case matchActivity:
        // Android: MatchStatsFragment → not yet in Flutter
        _showNotImplemented(context, 'Match Stats');
        break;

      case trainActivity:
        // Android: TrainingStatsFragment → not yet in Flutter
        _showNotImplemented(context, 'Training Stats');
        break;

      case assignReferee:
        context.push('/referee/matches');
        break;

      case liveMatchUpdate:
        _navigateToLiveMatch(context, payload);
        break;

      default:
        _showNotImplemented(context, type);
    }
  }

  // ── Avatar tap: matches Android respondActionForBio ────────────────────────

  static void _handleAvatarTap(
    BuildContext context,
    String type,
    Map<String, dynamic> payload,
  ) {
    switch (type) {
      // User bio of the actor
      case reqTeamJoin:
      case likeUser:
      case followUser:
      case pickUpMatchRequest:
      case acceptPickUpRequest:
      case likePost:
      case endorsePlayer:
      case feedComment:
      case feedCommentLike:
        _navigateToActorUserBio(context, payload);
        break;

      case hostMatch:
      case respondMatchReq:
      case sendMatchScore:
      case acceptMatchScore:
      case saveMatchRating:
        _navigateToActorUserBio(context, payload);
        break;

      case newUserPost:
      case userSkillPost:
      case userTagPost:
        _navigateToCreatorPosts(context, payload);
        break;

      case newEndorse:
      case matchActivity:
      case trainActivity:
        _navigateToActorUserBio(context, payload);
        break;

      // Team bio
      case respTeamJoin:
      case inviteTeamUser:
      case editTeam:
      case teamAddPlayer:
      case newTeamAlert:
        _navigateToTeamBio(context, payload);
        break;

      case declineTeamPlayer:
        _navigateToTeamFromDetails(context, payload);
        break;

      case acceptTeamPlayer:
        _navigateToTeamFromDetails(context, payload);
        break;

      case inviteTeamPlayer:
        context.push('/player-invitations');
        break;

      // Match destinations (same as card tap)
      case matchNews:
        _navigateToMatchDetailsFromMatchNews(context, payload);
        break;

      case teamMatchResult:
        _navigateToMatchDetailsFromResult(context, payload);
        break;

      case liveMatchUpdate:
        _navigateToLiveMatch(context, payload);
        break;

      case nearPickUp:
        _navigateToPickupMatch(context, payload);
        break;

      // Tournament
      case tmntInvite:
      case tmntAccept:
      case tmntConfirm:
      case leagueNotice:
        _navigateToTournament(context, payload);
        break;

      case teamTournament:
      case newTmntAlert:
        _navigateToTournamentOrCup(context, payload);
        break;

      case fixtureChange:
        _navigateToFixtureChange(context, payload);
        break;

      // Cup
      case cupInvite:
      case cupConfirm:
      case cupAccept:
      case cupNotice:
        _navigateToCupDetails(context, payload);
        break;

      // Org bios
      case fromClub:
        _navigateToClubBio(context, payload);
        break;

      case fromFA:
        _navigateToFaBio(context, payload);
        break;

      case fromConfed:
        _navigateToConfedBio(context, payload);
        break;

      case fromCharityNgo:
        _navigateToCharityBio(context, payload);
        break;

      case fromSponsor:
        _navigateToSponsorBio(context, payload);
        break;

      case fromAcademy:
      case acceptAcademy:
        _navigateToAcademyBio(context, payload);
        break;

      case newUserJoin:
        _navigateToUserBioByProfileId(context, payload);
        break;

      case assignReferee:
        context.push('/referee/matches');
        break;

      default:
        _showNotImplemented(context, type);
    }
  }

  // ── Navigation helpers ─────────────────────────────────────────────────────

  /// Navigate to a user's bio using payload['userId'] + role flags (avatar tap).
  static void _navigateToActorUserBio(
      BuildContext context, Map<String, dynamic> payload) {
    final userId = payload['userId'] as String?;
    if (userId == null || userId.isEmpty) return;
    final isFan = payload['isFan'] == true;
    if (!isFan) {
      context.push('/players/$userId');
    }
  }

  /// Navigate to user bio using payload['profileUserId'] (newUserJoin).
  static void _navigateToUserBioByProfileId(
      BuildContext context, Map<String, dynamic> payload) {
    final userId =
        payload['profileUserId'] as String? ?? payload['userId'] as String?;
    if (userId == null || userId.isEmpty) return;
    final isFan = payload['isFan'] == true;
    if (!isFan) {
      context.push('/players/$userId');
    }
  }

  static void _navigateToTeamBio(
      BuildContext context, Map<String, dynamic> payload) {
    final teamId = payload['teamId'] as String?;
    if (teamId != null && teamId.isNotEmpty) {
      context.push('/teams/$teamId');
    }
  }

  static void _navigateToTeamPlayers(
      BuildContext context, Map<String, dynamic> payload) {
    final teamId = payload['teamId'] as String?;
    if (teamId != null && teamId.isNotEmpty) {
      context.push('/teams/$teamId/players');
    }
  }

  /// Navigate to team bio from nested teamDetails JSON in payload.
  static void _navigateToTeamFromDetails(
      BuildContext context, Map<String, dynamic> payload) {
    try {
      final teamDetailsRaw = payload['teamDetails'];
      if (teamDetailsRaw == null) return;
      Map<String, dynamic> teamDetails;
      if (teamDetailsRaw is String) {
        // JSON-encoded string (as in Android)
        teamDetails = jsonDecode(teamDetailsRaw) as Map<String, dynamic>;
      } else if (teamDetailsRaw is Map<String, dynamic>) {
        teamDetails = teamDetailsRaw;
      } else {
        return;
      }
      final teamId =
          teamDetails['teamId'] as String? ?? teamDetails['_id'] as String?;
      if (teamId != null && teamId.isNotEmpty) {
        context.push('/teams/$teamId');
      }
    } catch (_) {}
  }

  static void _navigateToTournament(
      BuildContext context, Map<String, dynamic> payload) {
    final tournamentId = payload['tournamentId'] as String?;
    if (tournamentId != null && tournamentId.isNotEmpty) {
      context.push('/tournaments/$tournamentId');
    }
  }

  static void _navigateToCupDetails(
      BuildContext context, Map<String, dynamic> payload) {
    final tournamentId = payload['tournamentId'] as String?;
    if (tournamentId != null && tournamentId.isNotEmpty) {
      context.push('/cups/$tournamentId');
    }
  }

  /// teamTournament / newTmntAlert: navigate based on tmntType (LEAGUE vs CUP).
  static void _navigateToTournamentOrCup(
      BuildContext context, Map<String, dynamic> payload) {
    final tournamentId = payload['tournamentId'] as String?;
    final tmntType = payload['tmntType'] as String?;
    if (tournamentId == null || tournamentId.isEmpty) return;
    if (tmntType == _cup) {
      context.push('/cups/$tournamentId');
    } else {
      context.push('/tournaments/$tournamentId');
    }
  }

  /// fixtureChange: navigate based on matchType (LEAGUE_MATCH vs CUP_LEAGUE).
  static void _navigateToFixtureChange(
      BuildContext context, Map<String, dynamic> payload) {
    final tournamentId = payload['tournamentId'] as String?;
    final matchType = payload['matchType'] as String?;
    if (tournamentId == null || tournamentId.isEmpty) return;
    if (matchType == _cupLeague) {
      context.push('/cups/$tournamentId');
    } else {
      context.push('/tournaments/$tournamentId');
    }
  }

  static void _navigateToMatchManage(
      BuildContext context, Map<String, dynamic> payload) {
    final matchId = payload['matchId'] as String?;
    if (matchId != null && matchId.isNotEmpty) {
      context.push('/match-management/$matchId');
    }
  }

  static void _navigateToPickupMatch(
      BuildContext context, Map<String, dynamic> payload) {
    final matchId = payload['matchId'] as String?;
    if (matchId != null && matchId.isNotEmpty) {
      context.push('/pickup/$matchId');
    }
  }

  static void _navigateToLiveMatch(
      BuildContext context, Map<String, dynamic> payload) {
    final matchId = payload['matchId'] as String?;
    final tournamentId = payload['tournamentId'] as String?;
    if (matchId != null && matchId.isNotEmpty) {
      context.push('/live-match/$matchId',
          extra: {'tournamentId': tournamentId ?? ''});
    }
  }

  /// matchNews: navigate to match details for cup/league match types only.
  static void _navigateToMatchDetailsFromMatchNews(
      BuildContext context, Map<String, dynamic> payload) {
    final matchId = payload['matchId'] as String?;
    final matchType = payload['matchType'] as String?;
    final tournamentId = payload['tournamentId'] as String?;
    if (matchId == null || matchId.isEmpty) return;
    if (matchType == _cupGroup ||
        matchType == _cupKnock ||
        matchType == _leagueMatch) {
      if (tournamentId == null || tournamentId.isEmpty) return;
      context.push('/matches/$matchId',
          extra: {'tournamentId': tournamentId, 'manageable': false});
    }
  }

  /// teamMatchResult: navigate to match details (cup/league) or one-off match.
  static void _navigateToMatchDetailsFromResult(
      BuildContext context, Map<String, dynamic> payload) {
    final matchId = payload['matchId'] as String?;
    final matchType = payload['matchType'] as String?;
    if (matchId == null || matchId.isEmpty || matchType == null) return;

    if (matchType == _cupGroup ||
        matchType == _cupKnock ||
        matchType == _leagueMatch) {
      final tournamentId = payload['tournamentId'] as String?;
      if (tournamentId == null || tournamentId.isEmpty) return;
      context.push('/matches/$matchId',
          extra: {'tournamentId': tournamentId, 'manageable': false});
    } else if (matchType == _oneOff) {
      final isAdmin = payload['isAdmin'] == true;
      context
          .push('/match-management/$matchId', extra: {'manageable': isAdmin});
    }
  }

  static void _navigateToSkillDetail(
      BuildContext context, Map<String, dynamic> payload) {
    final skillName = payload['skillName'] as String?;
    final skillShort = payload['skillShort'] as String?;
    if (skillName != null && skillShort != null) {
      final myId = StorageService.userId ?? '';
      context.push('/skill-detail', extra: {
        'skillName': skillName,
        'skillShort': skillShort,
        'playerId': myId
      });
    }
  }

  static void _navigateToCreatorPosts(
      BuildContext context, Map<String, dynamic> payload) {
    final creatorId = payload['createdBy'] as String?;
    if (creatorId != null && creatorId.isNotEmpty) {
      context.push('/my-bio/posts',
          extra: {'userId': creatorId, 'isOwnProfile': false});
    }
  }

  static void _navigateToClubBio(
      BuildContext context, Map<String, dynamic> payload) {
    final clubId = payload['clubId'] as String?;
    if (clubId != null && clubId.isNotEmpty) {
      context.push('/clubs/$clubId');
    }
  }

  static void _navigateToFaBio(
      BuildContext context, Map<String, dynamic> payload) {
    final faId = payload['faId'] as String?;
    if (faId != null && faId.isNotEmpty) {
      context.push('/fa/$faId');
    }
  }

  static void _navigateToConfedBio(
      BuildContext context, Map<String, dynamic> payload) {
    final confedId = payload['confedId'] as String?;
    if (confedId != null && confedId.isNotEmpty) {
      context.push('/confed/$confedId');
    }
  }

  static void _navigateToCharityBio(
      BuildContext context, Map<String, dynamic> payload) {
    final charityId = payload['charityId'] as String?;
    if (charityId != null && charityId.isNotEmpty) {
      context.push('/charity/$charityId');
    }
  }

  static void _navigateToSponsorBio(
      BuildContext context, Map<String, dynamic> payload) {
    final sponsorId = payload['sponsorId'] as String?;
    if (sponsorId != null && sponsorId.isNotEmpty) {
      context.push('/sponsor/$sponsorId');
    }
  }

  static void _navigateToAcademyBio(
      BuildContext context, Map<String, dynamic> payload) {
    final academyId = payload['academyId'] as String?;
    if (academyId != null && academyId.isNotEmpty) {
      context.push('/academies/$academyId');
    }
  }

  static void _showNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature not yet available'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
