import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../models/feed_post.dart';

/// Repository for social feed API calls
class FeedRepository {
  const FeedRepository();

  Future<List<FeedPost>> getFeed({
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
      print('  isFan: $isFan, isPlayer: $isPlayer, isCoach: $isCoach, isAdmin: $isAdmin');
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
        return [];
      }

      print('🟢 getFeed response status: ${responseData['status']}');
      print('🟢 getFeed response keys: ${responseData.keys.toList()}');

      if (responseData['status'] == 1) {
        final feedList = responseData['feed'] as List<dynamic>?;
        print('🟢 Feed list length: ${feedList?.length ?? 0}');
        
        if (feedList != null && feedList.isNotEmpty) {
          print('🟢 Parsing ${feedList.length} posts...');
          
          final posts = <FeedPost>[];
          for (var i = 0; i < feedList.length; i++) {
            try {
              final post = FeedPost.fromJson(feedList[i] as Map<String, dynamic>);
              posts.add(post);
            } catch (e) {
              print('❌ Error parsing post $i: $e');
              print('Post JSON: ${feedList[i]}');
            }
          }
          
          print('✅ Successfully parsed ${posts.length} posts');
          return posts;
        }
      } else {
        print('🔴 getFeed failed: ${responseData['message']}');
      }
      return [];
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
}
