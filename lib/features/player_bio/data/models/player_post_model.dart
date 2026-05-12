import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_post_model.freezed.dart';
part 'player_post_model.g.dart';

/// Model for post media source.
/// API returns 'imageUrl' for images and 'videoUrl' / 'thumbnail' for videos.
@freezed
class PostMediaSource with _$PostMediaSource {
  const factory PostMediaSource({
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'videoUrl') String? videoUrl,
    @JsonKey(name: 'thumbnail') String? thumbnail,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'seq') int? seq,
  }) = _PostMediaSource;

  factory PostMediaSource.fromJson(Map<String, dynamic> json) =>
      _$PostMediaSourceFromJson(json);
}

/// Convenience getter — returns the displayable URL for a media source.
extension PostMediaSourceExt on PostMediaSource {
  /// Returns imageUrl for images, thumbnail for videos (first frame preview).
  String? get url => imageUrl ?? thumbnail;
}

/// Model for player post from getUserPosts API
@freezed
class PlayerPostModel with _$PlayerPostModel {
  const factory PlayerPostModel({
    @JsonKey(name: 'postId') String? postId,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'postType') String? postType,
    @JsonKey(name: 'postCat') String? postCat,
    @JsonKey(name: 'addedOn') int? addedOn,
    @JsonKey(name: 'likeCount') int? likeCount,
    @JsonKey(name: 'commentCount') int? commentCount,
    @JsonKey(name: 'shareCount') int? shareCount,
    @JsonKey(name: 'myLike') bool? myLike,
    @JsonKey(name: 'sources') List<PostMediaSource>? sources,
  }) = _PlayerPostModel;

  factory PlayerPostModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerPostModelFromJson(json);
}
