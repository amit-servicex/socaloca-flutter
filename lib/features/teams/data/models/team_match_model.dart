import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_match_model.freezed.dart';
part 'team_match_model.g.dart';

/// Simplified match model for team recent matches
@freezed
class TeamMatchModel with _$TeamMatchModel {
  const factory TeamMatchModel({
    String? matchId,
    String? matchDate,
    String? matchTime,
    String? gameType,
    String? country,
    String? city,
    @Default([]) List<TeamMatchTeamModel> teams,
    TeamMatchScoreModel? score,
  }) = _TeamMatchModel;

  factory TeamMatchModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchModelFromJson(json);
}

@freezed
class TeamMatchTeamModel with _$TeamMatchTeamModel {
  const factory TeamMatchTeamModel({
    String? teamId,
    String? teamName,
    String? teamShortName,
    @JsonKey(name: 'imageUrl') String? teamImage,
  }) = _TeamMatchTeamModel;

  factory TeamMatchTeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchTeamModelFromJson(json);
}

@freezed
class TeamMatchScoreModel with _$TeamMatchScoreModel {
  const factory TeamMatchScoreModel({
    @Default(0) int team1,
    @Default(0) int team2,
  }) = _TeamMatchScoreModel;

  factory TeamMatchScoreModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMatchScoreModelFromJson(json);
}
