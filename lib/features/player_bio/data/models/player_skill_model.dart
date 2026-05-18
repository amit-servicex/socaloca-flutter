import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_skill_model.freezed.dart';
part 'player_skill_model.g.dart';

double? _toDouble(dynamic v) => v == null
    ? null
    : (v is num ? v.toDouble() : double.tryParse(v.toString()));

int? _toInt(dynamic v) =>
    v == null ? null : (v is num ? v.toInt() : int.tryParse(v.toString()));

/// Model for player skill from getPlayerSkills API
@freezed
class PlayerSkillModel with _$PlayerSkillModel {
  const factory PlayerSkillModel({
    @JsonKey(name: 'skillName') String? skillName,
    @JsonKey(name: 'skillShort') String? skillShort,
    @JsonKey(name: 'skillAvg') double? skillAvg,
    @JsonKey(name: 'ratingCounter') int? ratingCounter,
    @JsonKey(name: 'rateByMe') bool? rateByMe,
    @JsonKey(name: 'myRating') double? myRating,
  }) = _PlayerSkillModel;

  factory PlayerSkillModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerSkillModelFromJson({
        ...json,
        'skillAvg': _toDouble(json['skillAvg']),
        'myRating': _toDouble(json['myRating']),
        'ratingCounter': _toInt(json['ratingCounter']),
      });
}
