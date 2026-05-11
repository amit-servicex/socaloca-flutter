import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_skill_model.freezed.dart';
part 'player_skill_model.g.dart';

/// Model for player skill from getPlayerSkills API
@freezed
class PlayerSkillModel with _$PlayerSkillModel {
  const factory PlayerSkillModel({
    @JsonKey(name: 'skillName') String? skillName,
    @JsonKey(name: 'rating') double? rating,
  }) = _PlayerSkillModel;

  factory PlayerSkillModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerSkillModelFromJson(json);
}
