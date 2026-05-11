import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String teamId,
    required String teamName,
    String? teamShortName,
    @JsonKey(name: 'imageUrl') String? teamImage,
    String? country,
    String? city,
    String? gameType,
    String? gender,
    @JsonKey(name: 'ageCat') String? ageCategory,
    String? ageGroup,
    @Default(0) int memberCount,
    @Default(0.0) double rating,
    @Default(0) int createdOn,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}

/// Extension for computed properties
extension TeamModelX on TeamModel {
  String get displayYear {
    if (createdOn > 0) {
      final date = DateTime.fromMillisecondsSinceEpoch(createdOn * 1000);
      return date.year.toString();
    }
    return DateTime.now().year.toString();
  }

  String get gameTypeYear => '${gameType ?? "Football"} | $displayYear';

  String get memberText =>
      '$memberCount ${memberCount == 1 ? "Member" : "Members"}';
}

