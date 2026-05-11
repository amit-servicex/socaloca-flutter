import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/api_constants.dart';

part 'club_news_model.freezed.dart';
part 'club_news_model.g.dart';

@freezed
class ClubNewsModel with _$ClubNewsModel {
  const factory ClubNewsModel({
    required String newsId,
    String? title,
    String? description,
    String? imageUrl,
    String? videoUrl,
    String? videoThumb,
    String? videoId,
    String? link,
    String? newsDate,
    @Default(0) int newsDateGmt,
    String? newsCat, // "image" | "video"
  }) = _ClubNewsModel;

  factory ClubNewsModel.fromJson(Map<String, dynamic> json) =>
      _$ClubNewsModelFromJson(json);

  /// Custom factory to handle API response with image URL conversion
  factory ClubNewsModel.fromApiJson(Map<String, dynamic> json) {
    final mappedJson = {
      'newsId': json['newsId'] ?? json['_id'],
      'title': json['title'],
      'description': json['description'],
      'imageUrl': json['imageUrl'],
      'videoUrl': json['videoUrl'],
      'videoThumb': json['videoThumb'],
      'videoId': json['videoId'],
      'link': json['link'],
      'newsDate': json['newsDate'],
      'newsDateGmt': json['newsDateGmt'] ?? 0,
      'newsCat': json['newsCat'],
    };

    return ClubNewsModel.fromJson(mappedJson);
  }
}

/// Extension methods for ClubNewsModel
extension ClubNewsModelX on ClubNewsModel {
  /// Get full image URL
  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);

  /// Get full video thumbnail URL
  String get fullVideoThumbUrl => ApiConstants.getImageUrl(videoThumb);

  /// Check if this is a video news item
  bool get isVideo => newsCat == 'video';

  /// Check if this is an image news item
  bool get isImage => newsCat == 'image';
}
