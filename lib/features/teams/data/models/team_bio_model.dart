import 'package:freezed_annotation/freezed_annotation.dart';
import 'team_match_model.dart';

part 'team_bio_model.freezed.dart';
part 'team_bio_model.g.dart';

@freezed
class TeamBioModel with _$TeamBioModel {
  const factory TeamBioModel({
    required TeamDetailsModel teamDetails,
    @Default([]) List<TeamPlayerModel> players,
    @Default([]) List<TeamMatchModel> recentMatches,
    RatingDetailsModel? ratingDetails,
  }) = _TeamBioModel;

  factory TeamBioModel.fromJson(Map<String, dynamic> json) =>
      _$TeamBioModelFromJson(json);
}

@freezed
class TeamDetailsModel with _$TeamDetailsModel {
  const factory TeamDetailsModel({
    String? teamId,
    String? teamName,
    String? teamShortName,
    @JsonKey(name: 'imageUrl') String? teamImage,
    String? country,
    String? city,
    String? gameType,
    String? gender,
    @JsonKey(name: 'ageCat') String? ageCategory,
    String? ageGroup,
    String? coachName,
    @Default(0) int memberCount,
    @Default(0.0) double rating,
    @Default(0) int createdOn,
  }) = _TeamDetailsModel;

  factory TeamDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$TeamDetailsModelFromJson(json);
}

@freezed
class RatingDetailsModel with _$RatingDetailsModel {
  const factory RatingDetailsModel({
    @JsonKey(name: 'avgTeamWork') @Default(0) int teamWork,
    @JsonKey(name: 'avgTechnical') @Default(0) int technical,
    @JsonKey(name: 'avgAggressiveness') @Default(0) int aggressiveness,
    @JsonKey(name: 'avgTactical') @Default(0) int tactical,
    @JsonKey(name: 'avgOverall') @Default(0) int overall,
  }) = _RatingDetailsModel;

  factory RatingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RatingDetailsModelFromJson(json);
}

@freezed
class TeamPlayerModel with _$TeamPlayerModel {
  const factory TeamPlayerModel({
    String? userId,
    String? firstName,
    String? lastName,
    @JsonKey(name: 'imageUrl') String? profileImage,
    String? playPosition,
    @JsonKey(name: 'teamJerseyNo') String? jerseyNumber,
  }) = _TeamPlayerModel;

  factory TeamPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$TeamPlayerModelFromJson(json);
}

/// Extension for computed properties
extension TeamPlayerModelX on TeamPlayerModel {
  String get fullName => '${firstName ?? ""} ${lastName ?? ""}'.trim();
}

