import 'package:socaloca/core/constants/api_constants.dart';

class FeedPost {
  final String id;
  final String type;
  final String userId;
  final String userName;
  final String? userImage;
  final String? content;
  final List<String> images;
  final String? videoUrl;
  final String? thumbnail;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  // Added missing fields
// Added missing fields as nullable
  final String? postType;
  final int? size;
  final dynamic postCat;
  final bool? postNotify;
  final List<dynamic>? tagged;
  final int? reportCount;
  final bool? isDelete;
  final List<dynamic>? comments;

  bool get isSocaFeed => type == 'socaFeed';

  const FeedPost({
    required this.id,
    required this.type,
    required this.userId,
    required this.userName,
    this.userImage,
    this.content,
    this.images = const [],
    this.videoUrl,
    this.thumbnail,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.createdAt,
    this.metadata,

    // Added missing fields
    this.postType,
    this.size,
    this.postCat,
    this.postNotify,
    this.tagged,
    this.reportCount,
    this.isDelete,
    this.comments,
  });

  factory FeedPost.fromJson(Map<String, dynamic> json) {
    final userDetails = json['userDetails'] as Map<String, dynamic>?;
    final firstName = userDetails?['firstName'] as String? ?? '';
    final lastName = userDetails?['lastName'] as String? ?? '';
    var userName = '$firstName $lastName'.trim();

    final isSocaFeed = json['feedType'] == 'socaFeed';
    if (isSocaFeed && userName.isEmpty) {
      userName = 'SocaLoca';
    }

    final userImagePath = userDetails?['imageUrl'] as String?;
    final userImage = ApiConstants.getImageUrl(userImagePath);

    final userId =
        json['addedBy'] as String? ?? userDetails?['userId'] as String? ?? '';

    final sources = json['sources'] as List<dynamic>? ?? [];
    final images = <String>[];
    String? videoUrl;
    String? thumbnail;

    for (final source in sources) {
      if (source is Map<String, dynamic>) {
        if (source['imageUrl'] != null) {
          final imagePath = source['imageUrl'] as String;
          images.add(ApiConstants.getImageUrl(imagePath));
        }

        if (source['videoUrl'] != null) {
          videoUrl = source['videoUrl'] as String;
          if (!videoUrl.startsWith('http')) {
            videoUrl = ApiConstants.getImageUrl(videoUrl);
          }

          final thumbnailPath = source['thumbnail'] as String?;
          if (thumbnailPath != null) {
            thumbnail = thumbnailPath.startsWith('http')
                ? thumbnailPath
                : ApiConstants.getImageUrl(thumbnailPath);
          }
        }
      }
    }

    final addedOn = json['addedOn'] as num?;
    final createdAt = addedOn != null
        ? DateTime.fromMillisecondsSinceEpoch(addedOn.toInt())
        : DateTime.now();

    final title = json['title'] as String?;
    final description = json['description'] as String?;
    final content = [
      if (title != null && title.isNotEmpty) title,
      if (description != null && description.isNotEmpty) description,
    ].join('\n');

    return FeedPost(
      id: json['postId'] as String? ?? json['_id'] as String? ?? '',
      type: json['feedType'] as String? ??
          json['postType'] as String? ??
          'userPost',
      userId: userId,
      userName: userName.isEmpty ? 'Unknown' : userName,
      userImage: userImage.isEmpty ? null : userImage,
      content: content.isNotEmpty ? content : null,
      images: images,
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isLiked: json['myLike'] as bool? ?? false,
      createdAt: createdAt,
      metadata: json,

      // Added missing fields
      postType: json['postType'] as String?,
      size: (json['size'] as num?)?.toInt(),
      postCat: json['postCat'],
      postNotify: json['postNotify'] as bool?,
      tagged: json['tagged'] as List<dynamic>?,
      reportCount: (json['reportCount'] as num?)?.toInt(),
      isDelete: json['isDelete'] as bool?,
      comments: json['comments'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': id,
      'feedType': type,
      'postType': postType,
      'addedBy': userId,
      'userDetails': {
        'firstName': userName.split(' ').first,
        'lastName': userName.split(' ').skip(1).join(' '),
        'imageUrl': userImage,
      },
      'title': content,
      'sources': [
        ...images.map((img) => {'imageUrl': img}),
        if (videoUrl != null) {'videoUrl': videoUrl, 'thumbnail': thumbnail},
      ],
      'likeCount': likeCount,
      'commentCount': commentCount,
      'myLike': isLiked,
      'addedOn': createdAt.millisecondsSinceEpoch,

      // Added missing fields
      'postType': postType,
      'size': size,
      'postCat': postCat,
      'postNotify': postNotify,
      'tagged': tagged,
      'reportCount': reportCount,
      'isDelete': isDelete,
      'comments': comments,
    };
  }
}
