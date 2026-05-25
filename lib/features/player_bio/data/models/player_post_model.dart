import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_post_model.freezed.dart';
part 'player_post_model.g.dart';

int? _toInt(dynamic v) =>
    v == null ? null : (v is num ? v.toInt() : int.tryParse(v.toString()));

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
    @JsonKey(name: 'size') int? size,
  }) = _PostMediaSource;

  factory PostMediaSource.fromJson(Map<String, dynamic> json) =>
      _$PostMediaSourceFromJson({
        ...json,
        'seq': _toInt(json['seq']),
        'size': _toInt(json['size']),
      });
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
    @JsonKey(name: 'postCat') dynamic postCat,
    @JsonKey(name: 'addedBy') String? addedBy,
    @JsonKey(name: 'addedOn') int? addedOn,
    @JsonKey(name: 'likeCount') int? likeCount,
    @JsonKey(name: 'commentCount') int? commentCount,
    @JsonKey(name: 'shareCount') int? shareCount,
    @JsonKey(name: 'reportCount') int? reportCount,
    @JsonKey(name: 'myLike') bool? myLike,
    @JsonKey(name: 'sources') List<PostMediaSource>? sources,
    @JsonKey(name: 'size') int? size,
    @JsonKey(name: 'postNotify') bool? postNotify,
    @JsonKey(name: 'tagged') List<dynamic>? tagged,
    @JsonKey(name: 'isDelete') bool? isDelete,
    @JsonKey(name: 'comments') List<dynamic>? comments,
  }) = _PlayerPostModel;

  factory PlayerPostModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerPostModelFromJson({
        ...json,
        'addedOn': _toInt(json['addedOn']),
        'likeCount': _toInt(json['likeCount']),
        'commentCount': _toInt(json['commentCount']),
        'shareCount': _toInt(json['shareCount']),
        'reportCount': _toInt(json['reportCount']),
        'size': _toInt(json['size']),
      });
}
