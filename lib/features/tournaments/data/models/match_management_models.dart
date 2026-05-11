import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_management_models.freezed.dart';
part 'match_management_models.g.dart';

/// Match Score Model - for entering/editing match scores
@freezed
class MatchScoreModel with _$MatchScoreModel {
  const factory MatchScoreModel({
    @JsonKey(name: 'matchId') required String matchId,
    required int homeScore,
    required int awayScore,
    int? homeExtraTimeScore,
    int? awayExtraTimeScore,
    int? homePenaltyScore,
    int? awayPenaltyScore,
    String? winnerId,
    String? status, // 'pending', 'accepted'
    String? submittedBy,
    int? submittedOn,
  }) = _MatchScoreModel;

  factory MatchScoreModel.fromJson(Map<String, dynamic> json) =>
      _$MatchScoreModelFromJson(json);
}

/// Match Goal Model - for recording goal scorers
@freezed
class MatchGoalModel with _$MatchGoalModel {
  const factory MatchGoalModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String playerId,
    required String playerName,
    String? playerImage,
    required String teamId,
    required String teamName,
    required int minute, // Minute of goal
    @Default(false) bool isOwnGoal,
    @Default(false) bool isPenalty,
    String? assistPlayerId,
    String? assistPlayerName,
  }) = _MatchGoalModel;

  factory MatchGoalModel.fromJson(Map<String, dynamic> json) =>
      _$MatchGoalModelFromJson(json);
}

/// Match Card Model - for recording yellow/red cards
@freezed
class MatchCardModel with _$MatchCardModel {
  const factory MatchCardModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String playerId,
    required String playerName,
    String? playerImage,
    required String teamId,
    required String teamName,
    required String cardType, // 'yellow' or 'red'
    required int minute, // Minute of card
    String? reason,
  }) = _MatchCardModel;

  factory MatchCardModel.fromJson(Map<String, dynamic> json) =>
      _$MatchCardModelFromJson(json);
}

/// Match MVP Model - for selecting Man of the Match
@freezed
class MatchMVPModel with _$MatchMVPModel {
  const factory MatchMVPModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String playerId,
    required String playerName,
    String? playerImage,
    required String teamId,
    required String teamName,
    String? selectedBy,
    int? selectedOn,
  }) = _MatchMVPModel;

  factory MatchMVPModel.fromJson(Map<String, dynamic> json) =>
      _$MatchMVPModelFromJson(json);
}

/// Match Player Model - for squad management
@freezed
class MatchPlayerModel with _$MatchPlayerModel {
  const factory MatchPlayerModel({
    required String playerId,
    required String playerName,
    String? playerImage,
    required String teamId,
    String? position,
    String? jerseyNumber,
    @Default(false) bool isStarting, // Starting XI or substitute
    @Default(false) bool isPlaying, // Currently on field
    int? minuteIn, // Substitution minute (when entered)
    int? minuteOut, // Substitution minute (when left)
    String? replacedPlayerId, // Player they replaced
  }) = _MatchPlayerModel;

  factory MatchPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerModelFromJson(json);
}

/// Match Squad Model - complete squad for a match
@freezed
class MatchSquadModel with _$MatchSquadModel {
  const factory MatchSquadModel({
    @JsonKey(name: 'matchId') required String matchId,
    required String teamId,
    required String teamName,
    @Default([]) List<MatchPlayerModel> startingXI,
    @Default([]) List<MatchPlayerModel> substitutes,
  }) = _MatchSquadModel;

  factory MatchSquadModel.fromJson(Map<String, dynamic> json) =>
      _$MatchSquadModelFromJson(json);
}

/// Match Details Model - comprehensive match data for management
@freezed
class MatchDetailsModel with _$MatchDetailsModel {
  const factory MatchDetailsModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') String? matchId,
    String? tournamentId,
    String? tournamentName,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamLogo,
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamLogo,
    int? homeScore,
    int? awayScore,
    String? status,
    String? matchDate,
    @Default(0) int matchDateMs,
    String? venue,
    String? gameType,
    String? ageGroup,
    // Management data
    MatchScoreModel? scoreData,
    @Default([]) List<MatchGoalModel> goals,
    @Default([]) List<MatchCardModel> cards,
    MatchMVPModel? mvp,
    MatchSquadModel? homeSquad,
    MatchSquadModel? awaySquad,
    // Permissions
    @Default(false) bool canManage,
    @Default(false) bool canEditScore,
    @Default(false) bool canAcceptScore,
  }) = _MatchDetailsModel;

  factory MatchDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MatchDetailsModelFromJson(json);
}

extension MatchDetailsModelX on MatchDetailsModel {
  String get effectiveId => matchId ?? id ?? '';
}

/// Match Photo Model
@freezed
class MatchPhotoModel with _$MatchPhotoModel {
  const factory MatchPhotoModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String imageUrl,
    String? caption,
    String? uploadedBy,
    int? uploadedOn,
  }) = _MatchPhotoModel;

  factory MatchPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$MatchPhotoModelFromJson(json);
}

/// Match Video Model
@freezed
class MatchVideoModel with _$MatchVideoModel {
  const factory MatchVideoModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String videoUrl,
    String? thumbnailUrl,
    String? title,
    String? description,
    String? uploadedBy,
    int? uploadedOn,
    @Default(0) int duration, // Duration in seconds
  }) = _MatchVideoModel;

  factory MatchVideoModel.fromJson(Map<String, dynamic> json) =>
      _$MatchVideoModelFromJson(json);
}

/// Match Rating Model
@freezed
class MatchRatingModel with _$MatchRatingModel {
  const factory MatchRatingModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String playerId,
    required String playerName,
    String? playerImage,
    required String teamId,
    @Default(0.0) double rating, // 0-10 scale
    String? ratedBy,
    int? ratedOn,
    String? comment,
  }) = _MatchRatingModel;

  factory MatchRatingModel.fromJson(Map<String, dynamic> json) =>
      _$MatchRatingModelFromJson(json);
}

/// Substitution Model
@freezed
class SubstitutionModel with _$SubstitutionModel {
  const factory SubstitutionModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') required String matchId,
    required String teamId,
    required String playerInId,
    required String playerInName,
    required String playerOutId,
    required String playerOutName,
    required int minute,
    String? reason,
  }) = _SubstitutionModel;

  factory SubstitutionModel.fromJson(Map<String, dynamic> json) =>
      _$SubstitutionModelFromJson(json);
}
