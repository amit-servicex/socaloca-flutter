import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String authorId,
    required String authorName,
    String? authorImage,
    String? authorType,
    String? text,
    @Default([]) List<String> images,
    String? videoUrl,
    String? videoThumb,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    @Default(false) bool isLiked,
    @Default(false) bool isBlocked,
    String? createdAt,
    String?
        postType, // 'user', 'club', 'academy', 'fa', 'confed', 'spon', 'charity'
    String? language,
    String? translatedText,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String id,
    required String postId,
    required String authorId,
    required String authorName,
    String? authorImage,
    required String text,
    @Default(0) int likesCount,
    @Default(false) bool isLiked,
    @Default(0) int repliesCount,
    String? createdAt,
    @Default([]) List<CommentModel> replies,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
