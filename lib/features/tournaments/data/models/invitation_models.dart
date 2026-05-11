import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_models.freezed.dart';
part 'invitation_models.g.dart';

/// Tournament Invitation Model
/// Represents an invitation for a team to join a tournament
@freezed
class TournamentInviteModel with _$TournamentInviteModel {
  const factory TournamentInviteModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'inviteId') String? inviteId,
    required String tournamentId,
    String? tournamentName,
    required String teamId,
    String? teamName,
    String? teamLogo,
    String? invitedBy,
    String? invitedByName,
    int? invitedOn,
    String? status, // 'pending', 'accepted', 'declined'
    String? respondedBy,
    int? respondedOn,
    String? message,
  }) = _TournamentInviteModel;

  factory TournamentInviteModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentInviteModelFromJson(json);
}

extension TournamentInviteModelX on TournamentInviteModel {
  String get effectiveId => inviteId ?? id ?? '';
  bool get isPending => status == 'pending' || status == null;
  bool get isAccepted => status == 'accepted';
  bool get isDeclined => status == 'declined';
}

/// Join Request Model
/// Represents a team's request to join a tournament
@freezed
class JoinRequestModel with _$JoinRequestModel {
  const factory JoinRequestModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'requestId') String? requestId,
    required String tournamentId,
    String? tournamentName,
    required String teamId,
    String? teamName,
    String? teamLogo,
    String? requestedBy,
    String? requestedByName,
    int? requestedOn,
    String? status, // 'pending', 'accepted', 'declined'
    String? respondedBy,
    int? respondedOn,
    String? message,
    String? declineReason,
  }) = _JoinRequestModel;

  factory JoinRequestModel.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestModelFromJson(json);
}

extension JoinRequestModelX on JoinRequestModel {
  String get effectiveId => requestId ?? id ?? '';
  bool get isPending => status == 'pending' || status == null;
  bool get isAccepted => status == 'accepted';
  bool get isDeclined => status == 'declined';
}

/// Team Eligibility Model
/// Represents whether a team is eligible to join a tournament
@freezed
class TeamEligibilityModel with _$TeamEligibilityModel {
  const factory TeamEligibilityModel({
    required String teamId,
    required String teamName,
    String? teamLogo,
    @Default(true) bool isEligible,
    String? ineligibilityReason,
    @Default(false) bool alreadyJoined,
    @Default(false) bool alreadyRequested,
    @Default(false) bool alreadyInvited,
    @Default(false) bool isWithdrawn,
  }) = _TeamEligibilityModel;

  factory TeamEligibilityModel.fromJson(Map<String, dynamic> json) =>
      _$TeamEligibilityModelFromJson(json);
}

/// Withdraw Request Model
/// Represents a team's withdrawal from a tournament
@freezed
class WithdrawRequestModel with _$WithdrawRequestModel {
  const factory WithdrawRequestModel({
    @JsonKey(name: '_id') String? id,
    required String tournamentId,
    String? tournamentName,
    required String teamId,
    String? teamName,
    String? teamLogo,
    String? withdrawnBy,
    String? withdrawnByName,
    int? withdrawnOn,
    String? reason,
    @Default(false) bool approved,
    String? approvedBy,
    int? approvedOn,
  }) = _WithdrawRequestModel;

  factory WithdrawRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestModelFromJson(json);
}

/// My Tournament Team Model
/// Represents a team that the user manages and can use to join tournaments
@freezed
class MyTournamentTeamModel with _$MyTournamentTeamModel {
  const factory MyTournamentTeamModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'teamId') String? teamId,
    required String teamName,
    String? logo,
    String? country,
    String? city,
    String? gameType,
    String? gender,
    String? ageGroup,
    @Default(0) int memberCount,
    @Default(false) bool isEligible,
    String? ineligibilityReason,
  }) = _MyTournamentTeamModel;

  factory MyTournamentTeamModel.fromJson(Map<String, dynamic> json) =>
      _$MyTournamentTeamModelFromJson(json);
}

extension MyTournamentTeamModelX on MyTournamentTeamModel {
  String get effectiveId => teamId ?? id ?? '';
}

/// Invited Team Model
/// Represents a team that has been invited to a tournament (for admin view)
@freezed
class InvitedTeamModel with _$InvitedTeamModel {
  const factory InvitedTeamModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'teamId') String? teamId,
    required String teamName,
    String? logo,
    String? country,
    String? inviteStatus, // 'pending', 'accepted', 'declined'
    int? invitedOn,
    int? respondedOn,
  }) = _InvitedTeamModel;

  factory InvitedTeamModel.fromJson(Map<String, dynamic> json) =>
      _$InvitedTeamModelFromJson(json);
}

extension InvitedTeamModelX on InvitedTeamModel {
  String get effectiveId => teamId ?? id ?? '';
}

/// Pending Request Model (for admin view)
/// Represents a pending join request that needs admin approval
@freezed
class PendingRequestModel with _$PendingRequestModel {
  const factory PendingRequestModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'requestId') String? requestId,
    required String teamId,
    required String teamName,
    String? teamLogo,
    String? requestedBy,
    String? requestedByName,
    int? requestedOn,
    String? message,
  }) = _PendingRequestModel;

  factory PendingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PendingRequestModelFromJson(json);
}

extension PendingRequestModelX on PendingRequestModel {
  String get effectiveId => requestId ?? id ?? '';
}
