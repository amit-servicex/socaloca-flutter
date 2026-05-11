// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentInviteModelImpl _$$TournamentInviteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentInviteModelImpl(
      id: json['_id'] as String?,
      inviteId: json['inviteId'] as String?,
      tournamentId: json['tournamentId'] as String,
      tournamentName: json['tournamentName'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String?,
      teamLogo: json['teamLogo'] as String?,
      invitedBy: json['invitedBy'] as String?,
      invitedByName: json['invitedByName'] as String?,
      invitedOn: (json['invitedOn'] as num?)?.toInt(),
      status: json['status'] as String?,
      respondedBy: json['respondedBy'] as String?,
      respondedOn: (json['respondedOn'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$TournamentInviteModelImplToJson(
        _$TournamentInviteModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'inviteId': instance.inviteId,
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'invitedBy': instance.invitedBy,
      'invitedByName': instance.invitedByName,
      'invitedOn': instance.invitedOn,
      'status': instance.status,
      'respondedBy': instance.respondedBy,
      'respondedOn': instance.respondedOn,
      'message': instance.message,
    };

_$JoinRequestModelImpl _$$JoinRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$JoinRequestModelImpl(
      id: json['_id'] as String?,
      requestId: json['requestId'] as String?,
      tournamentId: json['tournamentId'] as String,
      tournamentName: json['tournamentName'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String?,
      teamLogo: json['teamLogo'] as String?,
      requestedBy: json['requestedBy'] as String?,
      requestedByName: json['requestedByName'] as String?,
      requestedOn: (json['requestedOn'] as num?)?.toInt(),
      status: json['status'] as String?,
      respondedBy: json['respondedBy'] as String?,
      respondedOn: (json['respondedOn'] as num?)?.toInt(),
      message: json['message'] as String?,
      declineReason: json['declineReason'] as String?,
    );

Map<String, dynamic> _$$JoinRequestModelImplToJson(
        _$JoinRequestModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestId': instance.requestId,
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'requestedBy': instance.requestedBy,
      'requestedByName': instance.requestedByName,
      'requestedOn': instance.requestedOn,
      'status': instance.status,
      'respondedBy': instance.respondedBy,
      'respondedOn': instance.respondedOn,
      'message': instance.message,
      'declineReason': instance.declineReason,
    };

_$TeamEligibilityModelImpl _$$TeamEligibilityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamEligibilityModelImpl(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      teamLogo: json['teamLogo'] as String?,
      isEligible: json['isEligible'] as bool? ?? true,
      ineligibilityReason: json['ineligibilityReason'] as String?,
      alreadyJoined: json['alreadyJoined'] as bool? ?? false,
      alreadyRequested: json['alreadyRequested'] as bool? ?? false,
      alreadyInvited: json['alreadyInvited'] as bool? ?? false,
      isWithdrawn: json['isWithdrawn'] as bool? ?? false,
    );

Map<String, dynamic> _$$TeamEligibilityModelImplToJson(
        _$TeamEligibilityModelImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'isEligible': instance.isEligible,
      'ineligibilityReason': instance.ineligibilityReason,
      'alreadyJoined': instance.alreadyJoined,
      'alreadyRequested': instance.alreadyRequested,
      'alreadyInvited': instance.alreadyInvited,
      'isWithdrawn': instance.isWithdrawn,
    };

_$WithdrawRequestModelImpl _$$WithdrawRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WithdrawRequestModelImpl(
      id: json['_id'] as String?,
      tournamentId: json['tournamentId'] as String,
      tournamentName: json['tournamentName'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String?,
      teamLogo: json['teamLogo'] as String?,
      withdrawnBy: json['withdrawnBy'] as String?,
      withdrawnByName: json['withdrawnByName'] as String?,
      withdrawnOn: (json['withdrawnOn'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      approved: json['approved'] as bool? ?? false,
      approvedBy: json['approvedBy'] as String?,
      approvedOn: (json['approvedOn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WithdrawRequestModelImplToJson(
        _$WithdrawRequestModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'withdrawnBy': instance.withdrawnBy,
      'withdrawnByName': instance.withdrawnByName,
      'withdrawnOn': instance.withdrawnOn,
      'reason': instance.reason,
      'approved': instance.approved,
      'approvedBy': instance.approvedBy,
      'approvedOn': instance.approvedOn,
    };

_$MyTournamentTeamModelImpl _$$MyTournamentTeamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MyTournamentTeamModelImpl(
      id: json['_id'] as String?,
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String,
      logo: json['logo'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      gameType: json['gameType'] as String?,
      gender: json['gender'] as String?,
      ageGroup: json['ageGroup'] as String?,
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      isEligible: json['isEligible'] as bool? ?? false,
      ineligibilityReason: json['ineligibilityReason'] as String?,
    );

Map<String, dynamic> _$$MyTournamentTeamModelImplToJson(
        _$MyTournamentTeamModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'logo': instance.logo,
      'country': instance.country,
      'city': instance.city,
      'gameType': instance.gameType,
      'gender': instance.gender,
      'ageGroup': instance.ageGroup,
      'memberCount': instance.memberCount,
      'isEligible': instance.isEligible,
      'ineligibilityReason': instance.ineligibilityReason,
    };

_$InvitedTeamModelImpl _$$InvitedTeamModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitedTeamModelImpl(
      id: json['_id'] as String?,
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String,
      logo: json['logo'] as String?,
      country: json['country'] as String?,
      inviteStatus: json['inviteStatus'] as String?,
      invitedOn: (json['invitedOn'] as num?)?.toInt(),
      respondedOn: (json['respondedOn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$InvitedTeamModelImplToJson(
        _$InvitedTeamModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'logo': instance.logo,
      'country': instance.country,
      'inviteStatus': instance.inviteStatus,
      'invitedOn': instance.invitedOn,
      'respondedOn': instance.respondedOn,
    };

_$PendingRequestModelImpl _$$PendingRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PendingRequestModelImpl(
      id: json['_id'] as String?,
      requestId: json['requestId'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      teamLogo: json['teamLogo'] as String?,
      requestedBy: json['requestedBy'] as String?,
      requestedByName: json['requestedByName'] as String?,
      requestedOn: (json['requestedOn'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$PendingRequestModelImplToJson(
        _$PendingRequestModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestId': instance.requestId,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'requestedBy': instance.requestedBy,
      'requestedByName': instance.requestedByName,
      'requestedOn': instance.requestedOn,
      'message': instance.message,
    };
