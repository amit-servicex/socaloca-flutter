import '../../../core/constants/api_constants.dart';

/// Feed post model matching Android feed structure
class FeedPost {
  final String id;
  final String type; // userPost, clubPost, matchScoreEvent, etc.
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
  final Map<String, dynamic>? metadata; // Additional data based on type

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
  });

  factory FeedPost.fromJson(Map<String, dynamic> json) {
    // Extract user details
    final userDetails = json['userDetails'] as Map<String, dynamic>?;
    final firstName = userDetails?['firstName'] as String? ?? '';
    final lastName = userDetails?['lastName'] as String? ?? '';
    final userName = '$firstName $lastName'.trim();
    final userImagePath = userDetails?['imageUrl'] as String?;
    final userImage = ApiConstants.getImageUrl(userImagePath);
    final userId = json['addedBy'] as String? ?? userDetails?['userId'] as String? ?? '';

    // Extract sources (images/videos)
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
          // Video URLs are already full URLs (CloudFront)
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

    // Parse timestamp
    final addedOn = json['addedOn'] as num?;
    final createdAt = addedOn != null
        ? DateTime.fromMillisecondsSinceEpoch(addedOn.toInt())
        : DateTime.now();

    return FeedPost(
      id: json['postId'] as String? ?? json['_id'] as String? ?? '',
      type: json['feedType'] as String? ?? json['postType'] as String? ?? 'userPost',
      userId: userId,
      userName: userName.isEmpty ? 'Unknown' : userName,
      userImage: userImage.isEmpty ? null : userImage,
      content: json['title'] as String? ?? json['description'] as String?,
      images: images,
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isLiked: json['myLike'] as bool? ?? false,
      createdAt: createdAt,
      metadata: json,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': id,
      'feedType': type,
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
    };
  }

  FeedPost copyWith({
    String? id,
    String? type,
    String? userId,
    String? userName,
    String? userImage,
    String? content,
    List<String>? images,
    String? videoUrl,
    String? thumbnail,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) {
    return FeedPost(
      id: id ?? this.id,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      content: content ?? this.content,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnail: thumbnail ?? this.thumbnail,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata ?? this.metadata,
    );
  }
}
