import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../models/feed_post.dart';

class FeedResult {
  final FeedPost? socaFeed;
  final List<FeedPost> posts;
  final String? lastId;

  const FeedResult({
    this.socaFeed,
    required this.posts,
    this.lastId,
  });
}

/// Repository for social feed API calls
class FeedRepository {
  const FeedRepository();

  Future<FeedResult> getFeed({
    required String userId,
    required bool isFan,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    String? lastId,
    int limit = 10,
  }) async {
    try {
      print('🔵 getFeed called with:');
      print('  userId: $userId');
      print(
          '  isFan: $isFan, isPlayer: $isPlayer, isCoach: $isCoach, isAdmin: $isAdmin');
      print('  lastId: $lastId, limit: $limit');

      final body = <String, dynamic>{
        'userId': userId,
        'isFan': isFan,
        'isPlayer': isPlayer,
        'isCoach': isCoach,
        'isAdmin': isAdmin,
        'limit': limit,
        'deviceType': 'android', // Match Android app
      };

      // Only add lastId if it's not null (Android behavior)
      if (lastId != null) {
        body['lastId'] = lastId;
      }

      final data = await ApiClient.instance.post(
        ApiConstants.getFeed,
        body: body,
      );

      print('🟢 getFeed raw response keys: ${data.keys.toList()}');

      // The API returns nested response: { response: { status, feed, lastId, socaFeed } }
      final responseData = data['response'] as Map<String, dynamic>?;

      if (responseData == null) {
        print('🔴 No response data found');
        return const FeedResult(posts: []);
      }

      print('🟢 getFeed response status: ${responseData['status']}');
      print('🟢 getFeed response keys: ${responseData.keys.toList()}');

      if (responseData['status'] == 1) {
        FeedPost? socaFeed;
        final socaFeedJson = responseData['socaFeed'];
        if (lastId == null && socaFeedJson is Map<String, dynamic>) {
          try {
            socaFeed = FeedPost.fromJson({
              ...socaFeedJson,
              'feedType': 'socaFeed',
            });
          } catch (e) {
            print('❌ Error parsing socaFeed: $e');
            print('SocaFeed JSON: $socaFeedJson');
          }
        }

        final feedList = responseData['feed'] as List<dynamic>?;
        print('🟢 Feed list length: ${feedList?.length ?? 0}');

        final posts = <FeedPost>[];
        if (feedList != null && feedList.isNotEmpty) {
          print('🟢 Parsing ${feedList.length} posts...');

          for (var i = 0; i < feedList.length; i++) {
            try {
              final post =
                  FeedPost.fromJson(feedList[i] as Map<String, dynamic>);
              posts.add(post);
            } catch (e) {
              print('❌ Error parsing post $i: $e');
              print('Post JSON: ${feedList[i]}');
            }
          }

          print('✅ Successfully parsed ${posts.length} posts');
        }

        return FeedResult(
          socaFeed: socaFeed,
          posts: posts,
          lastId: responseData['lastId'] as String?,
        );
      } else {
        print('🔴 getFeed failed: ${responseData['message']}');
      }
      return const FeedResult(posts: []);
    } on ApiException catch (e) {
      print('🔴 getFeed error: ${e.message}');
      throw Exception('Failed to load feed: ${e.message}');
    } catch (e, stackTrace) {
      print('🔴 getFeed unexpected error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // ─── Like Post ────────────────────────────────────────────────────────────

  Future<bool> likePost({
    required String userId,
    required String postId,
    required String postType,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.likePost,
        body: {
          'userId': userId,
          'postId': postId,
          'postType': postType,
        },
      );

      final raw = data['response'] as Map<String, dynamic>? ?? data;
      return (raw['status'] as num?)?.toInt() == 1;
    } on ApiException catch (e) {
      print('Error liking post: ${e.message}');
      return false;
    }
  }

  // ─── Follow User ──────────────────────────────────────────────────────────

  /// Follows or unfollows a user. Returns `isFollow` (true=following, false=unfollowed).
  Future<bool?> followUser({
    required String userId,
    required String toUserId,
    required String myName,
    required String myImageUrl,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.followUser,
        body: {
          'userId': userId,
          'toUserId': toUserId,
          'myName': myName,
          'myImageUrl': myImageUrl,
          'isPlayer': isPlayer,
          'isCoach': isCoach,
          'isAdmin': isAdmin,
          'isFan': isFan,
        },
      );
      final raw = data['response'] ?? data;
      if ((raw['status'] as num?)?.toInt() == 1) {
        return raw['isFollow'] as bool?;
      }
      return null;
    } on ApiException catch (e) {
      print('Error following user: ${e.message}');
      return null;
    }
  }

  // ─── Comment on Post ──────────────────────────────────────────────────────

  Future<bool> commentOnPost({
    required String userId,
    required String postId,
    required String comment,
    required String postType,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.saveFeedComment,
        body: {
          'userId': userId,
          'postId': postId,
          'comment': comment,
          'postType': postType,
        },
      );

      return data['status'] == 1;
    } on ApiException catch (e) {
      print('Error commenting on post: ${e.message}');
      return false;
    }
  }

  // ─── Report Post ──────────────────────────────────────────────────────────

  Future<bool> reportPost({
    required String userId,
    required String postId,
    required String createdBy,
    required String cause,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.reportPost,
        body: {
          'userId': userId,
          'postId': postId,
          'createdBy': createdBy,
          'cause': cause,
        },
      );
      final raw = data['response'] as Map<String, dynamic>? ?? data;
      return (raw['status'] as num?)?.toInt() == 1;
    } on ApiException catch (e) {
      print('Error reporting post: ${e.message}');
      return false;
    }
  }

  // ─── Block Post ───────────────────────────────────────────────────────────

  Future<bool> blockPost({
    required String userId,
    required String postId,
    required String postType,
    required String cause,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.blockPost,
        body: {
          'userId': userId,
          'postId': postId,
          'postType': postType,
          'cause': cause,
        },
      );
      final raw = data['response'] as Map<String, dynamic>? ?? data;
      return (raw['status'] as num?)?.toInt() == 1;
    } on ApiException catch (e) {
      print('Error blocking post: ${e.message}');
      return false;
    }
  }

  // ─── Block User ───────────────────────────────────────────────────────────

  Future<bool> blockUser({
    required String userId,
    required String toUserId,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.blockUser,
        body: {
          'userId': userId,
          'toUserId': toUserId,
          'blocked': true,
        },
      );
      final raw = data['response'] as Map<String, dynamic>? ?? data;
      return (raw['status'] as num?)?.toInt() == 1;
    } on ApiException catch (e) {
      print('Error blocking user: ${e.message}');
      return false;
    }
  }

  // ─── Report User ──────────────────────────────────────────────────────────

  Future<bool> reportUser({
    required String userId,
    required String toUserId,
    required String cause,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.reportUser,
        body: {
          'userId': userId,
          'toUserId': toUserId,
          'cause': cause,
        },
      );
      final raw = data['response'] as Map<String, dynamic>? ?? data;
      return (raw['status'] as num?)?.toInt() == 1;
    } on ApiException catch (e) {
      print('Error reporting user: ${e.message}');
      return false;
    }
  }
}
