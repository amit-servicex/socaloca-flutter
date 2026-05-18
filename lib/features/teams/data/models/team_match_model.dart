import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_match_model.freezed.dart';
part 'team_match_model.g.dart';

/// Match model for team recent matches.
@freezed
class TeamMatchModel with _$TeamMatchModel {
  const factory TeamMatchModel({
    @JsonKey(name: '_id') String? id,
    String? matchId,
    String? roundId,
    @Default(false) bool configure,
    String? tournamentId,
    @Default(false) bool isDelete,
    @Default(0) int level,
    String? matchName,
    @Default(0) int seq,
    String? createdBy,
    String? createdByChild,
    String? matchDate,
    String? matchTime,
    int? matchDateTimeGmt,
    String? gameType,
    String? gameSemiType,
    String? matchType,
    String? myTeamId,
    String? myTeamName,
    String? myTeamShortName,
    String? opponentTeamId,
    String? opponentTeamName,
    String? opponentTeamShortName,
    String? country,
    String? city,
    String? stadiumName,
    String? fieldName,
    String? locationName,
    @Default(0.0) double locationLat,
    @Default(0.0) double locationLng,
    @Default(0) int totalTimeMins,
    String? ageGroup,
    @Default(false) bool referees,
    @Default(0) int substitutes,
    String? matchNote,
    @Default(false) bool active,
    String? acceptStatus,
    int? createdOn,
    String? acceptedBy,
    String? scoreStatus,
    @Default(false) bool myTeamScore,
    @Default(false) bool opponentTeamScore,
    @Default(false) bool penaltyScore,
    @Default(false) bool extraTimeScore,
    @Default(false) bool extraTimeSaved,
    @Default(false) bool penaltySaved,
    @Default(false) bool myTeamCard,
    @Default(false) bool substituteSaved,
    @Default(false) bool opponentTeamCard,
    @Default(false) bool myTeamMvp,
    @Default(false) bool opponentTeamMvp,
    @Default(false) bool myTeamRating,
    @Default(false) bool opponentRating,
    String? myMvpPlayerId,
    String? myMvpPlayerName,
    String? opponentMvpPlayerId,
    String? opponentMvpPlayerName,
    @Default(false) bool matchMvp,
    String? mvpTeamId,
    String? mvpPlayerId,
    String? mvpPlayerName,
    String? leg,
    String? round,
    @Default([]) List<dynamic> myPlayers,
    @Default([]) List<dynamic> opponentPlayers,
    dynamic myCoach,
    dynamic oppoCoach,
    dynamic myManager,
    dynamic oppoManager,
    @Default(false) bool mgmtSaved,
    @Default(false) bool penaltyNum,
    @Default(false) bool extraTimeNum,
    @Default(false) bool cleansheetSaved,
    dynamic myTeamCleanSheet,
    dynamic oppoTeamCleanSheet,
    @Default([]) List<TeamMatchTeamModel> teams,
    TeamMatchScoreModel? score,
  }) = _TeamMatchModel;

  factory TeamMatchModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchModelFromJson(json);
}

@freezed
class TeamMatchTeamModel with _$TeamMatchTeamModel {
  const factory TeamMatchTeamModel({
    @JsonKey(name: '_id') String? id,
    String? teamId,
    String? createdBy,
    String? teamName,
    String? teamShortName,
    @JsonKey(name: 'imageUrl') String? teamImage,
    String? country,
    String? city,
    String? gender,
    String? ageGroup,
    @JsonKey(name: 'ageCat') String? ageCategory,
    String? gameType,
    int? createdOn,
    @Default(0) int followCount,
    @Default(false) bool archive,
    @Default([]) List<dynamic> admins,
    @Default([]) List<dynamic> teamPlayers,
    @Default([]) List<dynamic> coaches,
    @Default([]) List<dynamic> managers,
    @Default(false) bool directTeam,
    @Default(0) int rating,
    @Default(0) int ratingCounter,
    @Default(false) bool isDelete,
    String? lastUpdateBy,
    int? lastUpdated,
  }) = _TeamMatchTeamModel;

  factory TeamMatchTeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchTeamModelFromJson(json);
}

@freezed
class TeamMatchScoreModel with _$TeamMatchScoreModel {
  const factory TeamMatchScoreModel({
    @JsonKey(name: '_id') String? id,
    String? gameType,
    String? gameSemiType,
    String? tournamentId,
    String? matchId,
    String? roundId,
    String? initiatedBy,
    String? myTeamId,
    String? opponentTeamId,
    int? initiatedOn,
    @Default(0) int myGoals,
    @Default(0) int opponentGoals,
    int? myEtGoals,
    int? opponentEtGoals,
    int? myPtGoals,
    int? opponentPtGoals,
    @Default(false) bool active,
    @Default([]) List<dynamic> extraTime,
    @Default([]) List<dynamic> penalty,
    @Default([]) List<dynamic> subs,
    @Default(0) int myPenalty,
    @Default(0) int opponentPenalty,
    @Default(0) int myExtraTime,
    @Default(0) int opponentExtraTime,
    String? acceptStatus,
    @Default(0) int responseTime,
    String? responseBy,
  }) = _TeamMatchScoreModel;

  factory TeamMatchScoreModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchScoreModelFromJson(json);
}
