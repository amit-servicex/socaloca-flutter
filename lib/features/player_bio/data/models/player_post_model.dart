import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_post_model.freezed.dart';
part 'player_post_model.g.dart';

/// Model for post media source
@freezed
class PostMediaSource with _$PostMediaSource {
  const factory PostMediaSource({
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'thumbnail') String? thumbnail,
  }) = _PostMediaSource;

  factory PostMediaSource.fromJson(Map<String, dynamic> json) =>
      _$PostMediaSourceFromJson(json);
}

/// Model for player post from getUserPosts API
@freezed
class PlayerPostModel with _$PlayerPostModel {
  const factory PlayerPostModel({
    @JsonKey(name: 'postId') String? postId,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'addedOn') int? addedOn,
    @JsonKey(name: 'likeCount') int? likeCount,
    @JsonKey(name: 'commentCount') int? commentCount,
    @JsonKey(name: 'shareCount') int? shareCount,
    @JsonKey(name: 'sources') List<PostMediaSource>? sources,
  }) = _PlayerPostModel;

  factory PlayerPostModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerPostModelFromJson(json);
}
