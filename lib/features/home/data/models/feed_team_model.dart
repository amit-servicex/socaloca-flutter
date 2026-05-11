import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_team_model.freezed.dart';
part 'feed_team_model.g.dart';

/// Model for teams in home feed (most followed teams)
/// Matches Android Team model used in CommonHomeFeedFragment
@freezed
class FeedTeamModel with _$FeedTeamModel {
  const factory FeedTeamModel({
    @JsonKey(name: 'teamId') required String id,
    @JsonKey(name: 'teamName') required String name,
    @JsonKey(name: 'teamLogo') String? logo,
    @JsonKey(name: 'teamCoverImage') String? coverImage,
    String? country,
    String? city,
    @JsonKey(name: 'adminId') String? adminId,
    @JsonKey(name: 'adminName') String? adminName,
    String? bio,
    @JsonKey(name: 'playerCount') @Default(0) int playersCount,
    @JsonKey(name: 'matchCount') @Default(0) int matchesCount,
    @JsonKey(name: 'followedByMe') @Default(false) bool isFollowing,
    @JsonKey(name: 'followerCount') @Default(0) int followersCount,
  }) = _FeedTeamModel;

  factory FeedTeamModel.fromJson(Map<String, dynamic> json) =>
      _$FeedTeamModelFromJson(json);
}
