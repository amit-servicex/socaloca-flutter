import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_post_model.freezed.dart';
part 'club_post_model.g.dart';

/// Club post/gallery item — mirrors Android ClubPost.java.
@freezed
class ClubPostModel with _$ClubPostModel {
  const factory ClubPostModel({
    @JsonKey(name: 'postId') String? postId,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'videoUrl') String? videoUrl,
    @JsonKey(name: 'postCaption') String? postCaption,
    @JsonKey(name: 'timestamp') int? timestamp,
    @JsonKey(name: 'likeCount') int? likeCount,
  }) = _ClubPostModel;

  factory ClubPostModel.fromJson(Map<String, dynamic> json) =>
      _$ClubPostModelFromJson(json);
}

extension ClubPostModelX on ClubPostModel {
  bool get isVideo =>
      videoUrl != null && videoUrl!.isNotEmpty;
}
