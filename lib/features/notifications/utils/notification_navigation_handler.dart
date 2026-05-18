import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/models/notification_model.dart';

/// Handles navigation for all notification types
/// Based on Android implementation in CommonNotificationsFragment.java
class NotificationNavigationHandler {
  // Notification type constants
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigation not yet implemented for $type')),
      );
    }
  }

  static void _handleCardTap(
    BuildContext context,
    String type,
    Map<String, dynamic> payload,
  ) {
    switch (type) {
      // User social actions
      case likeUser:
      case followUser:
      case newUserJoin:
        _navigateToUserBio(context, payload);
        break;

      // Team actions
      case reqTeamJoin:
      case respTeamJoin:
      case inviteTeamUser:
      case editTeam:
      case newTeamAlert:
        _navigateToTeamBio(context, payload);
        break;

      case inviteTeamPlayer:
        // Navigate to Player Admin Team Landing (tab 3)
        _showNotImplemented(context, 'Player Admin Team Landing');
        break;

      case acceptTeamPlayer:
        // Navigate to Manage Team Landing (New Players tab)
        _showNotImplemented(context, 'Manage Team Landing');
        break;

      case declineTeamPlayer:
        // Navigate to Manage Team Landing
        _showNotImplemented(context, 'Manage Team Landing');
        break;

      case teamAddPlayer:
        // Navigate to Team All Players
        _showNotImplemented(context, 'Team All Players');
        break;

      // Match actions
      case hostMatch:
        // Navigate to Match Requests (One-Off Received tab)
        _showNotImplemented(context, 'Match Requests');
        break;

      case respondMatchReq:
      case sendMatchScore:
      case acceptMatchScore:
      case saveMatchRating:
        // Navigate to Match Manage
        _showNotImplemented(context, 'Match Manage');
        break;

      case matchNews:
      case teamMatchResult:
        // Navigate to Match Details
        _showNotImplemented(context, 'Match Details');
        break;

      case matchActivity:
        // Navigate to Match Stats
        _showNotImplemented(context, 'Match Stats');
        break;

      case liveMatchUpdate:
        // Navigate to Live Match Details
        _showNotImplemented(context, 'Live Match Details');
        break;

      // Pick-up matches
      case pickUpMatchRequest:
      case acceptPickUpRequest:
      case nearPickUp:
        // Navigate to Pick-Up Match Details
        _showNotImplemented(context, 'Pick-Up Match Details');
        break;

      // Tournament actions
      case tmntInvite:
      case tmntAccept:
      case tmntConfirm:
      case leagueNotice:
      case teamTournament:
      case newTmntAlert:
      case fixtureChange:
        _navigateToTournament(context, payload);
        break;

      // Cup tournament actions
      case cupInvite:
      case cupConfirm:
      case cupAccept:
      case cupNotice:
        // Navigate to Cup Details
        _showNotImplemented(context, 'Cup Details');
        break;

      // Social feed actions
      case likePost:
      case newUserPost:
      case userSkillPost:
      case userTagPost:
      case feedComment:
      case feedCommentLike:
        // Navigate to User Gallery
        _showNotImplemented(context, 'User Gallery');
        break;

      // Endorsements
      case endorsePlayer:
      case newEndorse:
        // Navigate to Endorsement List
        _showNotImplemented(context, 'Endorsement List');
        break;

      // Training activity
      case trainActivity:
        // Navigate to Training Stats
        _showNotImplemented(context, 'Training Stats');
        break;

      // Organization actions
      case fromClub:
        _navigateToClubBio(context, payload);
        break;

      case fromFA:
        // Navigate to FA Bio
        _showNotImplemented(context, 'FA Bio');
        break;

      case fromConfed:
        // Navigate to Confederation Bio
        _showNotImplemented(context, 'Confederation Bio');
        break;

      case fromCharityNgo:
        // Navigate to Charity Bio
        _showNotImplemented(context, 'Charity Bio');
        break;

      case fromSponsor:
        // Navigate to Sponsor Bio
        _showNotImplemented(context, 'Sponsor Bio');
        break;

      case fromAcademy:
      case acceptAcademy:
        _navigateToAcademyBio(context, payload);
        break;

      // Referee actions
      case assignReferee:
        // Navigate to Referee My Matches
        _showNotImplemented(context, 'Referee My Matches');
        break;

      default:
        _showNotImplemented(context, type);
    }
  }

  static void _handleAvatarTap(
    BuildContext context,
    String type,
    Map<String, dynamic> payload,
  ) {
    // Most avatar taps navigate to user/team/organization bio
    switch (type) {
      // User actions - navigate to user bio
      case likeUser:
      case followUser:
      case pickUpMatchRequest:
      case acceptPickUpRequest:
      case likePost:
      case endorsePlayer:
      case feedComment:
      case feedCommentLike:
      case hostMatch:
      case respondMatchReq:
      case sendMatchScore:
      case acceptMatchScore:
      case saveMatchRating:
      case newUserJoin:
      case newUserPost:
      case userSkillPost:
      case userTagPost:
      case newEndorse:
      case matchActivity:
      case trainActivity:
        _navigateToUserBio(context, payload);
        break;

      // Team actions - navigate to team bio
      case reqTeamJoin:
      case respTeamJoin:
      case inviteTeamUser:
      case editTeam:
      case teamAddPlayer:
      case newTeamAlert:
        _navigateToTeamBio(context, payload);
        break;

      // Match actions - navigate to match details
      case matchNews:
      case teamMatchResult:
        _showNotImplemented(context, 'Match Details');
        break;

      case liveMatchUpdate:
        _showNotImplemented(context, 'Live Match Details');
        break;

      case nearPickUp:
        _showNotImplemented(context, 'Pick-Up Match Details');
        break;

      // Tournament actions
      case tmntInvite:
      case tmntAccept:
      case tmntConfirm:
      case leagueNotice:
      case teamTournament:
      case newTmntAlert:
      case fixtureChange:
        _navigateToTournament(context, payload);
        break;

      // Cup actions
      case cupInvite:
      case cupConfirm:
      case cupAccept:
      case cupNotice:
        _showNotImplemented(context, 'Cup Details');
        break;

      // Organization actions
      case fromClub:
        _navigateToClubBio(context, payload);
        break;

      case fromFA:
        _showNotImplemented(context, 'FA Bio');
        break;

      case fromConfed:
        _showNotImplemented(context, 'Confederation Bio');
        break;

      case fromCharityNgo:
        _showNotImplemented(context, 'Charity Bio');
        break;

      case fromSponsor:
        _showNotImplemented(context, 'Sponsor Bio');
        break;

      case fromAcademy:
      case acceptAcademy:
        _navigateToAcademyBio(context, payload);
        break;

      // Referee actions
      case assignReferee:
        _showNotImplemented(context, 'Referee My Matches');
        break;

      // Team player actions
      case inviteTeamPlayer:
      case acceptTeamPlayer:
      case declineTeamPlayer:
        _showNotImplemented(context, 'Manage Team Landing');
        break;

      default:
        _showNotImplemented(context, type);
    }
  }

  // Navigation helper methods
  static void _navigateToUserBio(
      BuildContext context, Map<String, dynamic> payload) {
    final userId = payload['userId'] as String?;
    if (userId != null && userId.isNotEmpty) {
      context.push('/player-bio/$userId');
    } else {
      _showNotImplemented(context, 'User Bio (missing userId)');
    }
  }

  static void _navigateToTeamBio(
      BuildContext context, Map<String, dynamic> payload) {
    final teamId = payload['teamId'] as String?;
    if (teamId != null && teamId.isNotEmpty) {
      _showNotImplemented(context, 'Team Bio');
    } else {
      _showNotImplemented(context, 'Team Bio (missing teamId)');
    }
  }

  static void _navigateToTournament(
      BuildContext context, Map<String, dynamic> payload) {
    final tournamentId = payload['tournamentId'] as String?;
    final tmntType = payload['tmntType'] as String?;

    if (tournamentId != null && tournamentId.isNotEmpty) {
      if (tmntType == 'CUP') {
        _showNotImplemented(context, 'Cup Details');
      } else {
        _showNotImplemented(context, 'Tournament Details');
      }
    } else {
      _showNotImplemented(context, 'Tournament (missing tournamentId)');
    }
  }

  static void _navigateToClubBio(
      BuildContext context, Map<String, dynamic> payload) {
    final clubId = payload['clubId'] as String?;
    if (clubId != null && clubId.isNotEmpty) {
      context.push('/club-bio/$clubId');
    } else {
      _showNotImplemented(context, 'Club Bio (missing clubId)');
    }
  }

  static void _navigateToAcademyBio(
      BuildContext context, Map<String, dynamic> payload) {
    final academyId = payload['academyId'] as String?;
    if (academyId != null && academyId.isNotEmpty) {
      _showNotImplemented(context, 'Academy Bio');
    } else {
      _showNotImplemented(context, 'Academy Bio (missing academyId)');
    }
  }

  static void _showNotImplemented(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature screen not yet implemented'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
