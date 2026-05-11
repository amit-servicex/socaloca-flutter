import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_team_model.freezed.dart';
part 'player_team_model.g.dart';

/// Model for player team from getPlayerTeams API
@freezed
class PlayerTeamModel with _$PlayerTeamModel {
  const factory PlayerTeamModel({
    @JsonKey(name: 'teamId') String? teamId,
    @JsonKey(name: 'teamName') String? teamName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
  }) = _PlayerTeamModel;

  factory PlayerTeamModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerTeamModelFromJson(json);
}
