import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_new_team_model.freezed.dart';
part 'feed_new_team_model.g.dart';

/// Model for new teams in home feed (from getFeedNewTeams API)
@freezed
class FeedNewTeamModel with _$FeedNewTeamModel {
  const factory FeedNewTeamModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'teamId') String? teamId,
    @JsonKey(name: 'teamName') String? teamName,
    @JsonKey(name: 'imageUrl') String? teamLogo,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'memberCount') @Default(0) int memberCount,
    @JsonKey(name: 'createdOn') int? createdOn,
    @JsonKey(name: 'gameType') String? teamType,
  }) = _FeedNewTeamModel;

  factory FeedNewTeamModel.fromJson(Map<String, dynamic> json) =>
      _$FeedNewTeamModelFromJson(json);
}
