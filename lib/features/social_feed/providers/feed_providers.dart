import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/feed_repository.dart';
import '../models/feed_post.dart';

// ─── Repository Provider ──────────────────────────────────────────────────────

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return const FeedRepository();
});

// ─── Feed Provider ────────────────────────────────────────────────────────────

class FeedNotifier extends StateNotifier<AsyncValue<List<FeedPost>>> {
  FeedNotifier(this.ref) : super(const AsyncValue.loading()) {
    // Don't auto-load in constructor, wait for profile to load first
    _initializeFeed();
  }

  final Ref ref;
  String? _lastId;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  /// Initialize feed after user profile loads (matching Android sequence)
  Future<void> _initializeFeed() async {
    // Wait a bit for profile to load first
    await Future.delayed(const Duration(milliseconds: 500));
    await loadFeed();
  }

  Future<void> loadFeed() async {
    // Prevent multiple simultaneous loads
    if (state is AsyncLoading && _isInitialized) {
      print('🟡 loadFeed: Already loading, skipping...');
      return;
    }

    _isInitialized = true;
    state = const AsyncValue.loading();
    _lastId = null;
    _hasMore = true;

    final user = ref.read(currentUserProvider);
    if (user == null) {
      print('🔴 loadFeed: User not logged in');
      state = AsyncValue.error('User not logged in', StackTrace.current);
      return;
    }

    print('🔵 loadFeed: User loaded');
    print('  id: ${user.id}');
    print('  name: ${user.name}');
    print('  isFan: ${user.isFan}, isPlayer: ${user.isPlayer}, isCoach: ${user.isCoach}, isAdmin: ${user.isAdmin}');

    try {
      final repository = ref.read(feedRepositoryProvider);
      final posts = await repository.getFeed(
        userId: user.id,
        isFan: user.isFan,
        isPlayer: user.isPlayer,
        isCoach: user.isCoach,
        isAdmin: user.isAdmin,
        lastId: _lastId,
      );

      print('🟢 loadFeed: Loaded ${posts.length} posts');
      state = AsyncValue.data(posts);
      _hasMore = posts.length >= 10; // Assuming 10 posts per page
      if (posts.isNotEmpty) {
        _lastId = posts.last.id; // Store last post ID for pagination
      }
    } catch (error, stackTrace) {
      print('🔴 loadFeed error: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadFeed();
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore) return;

    final currentState = state;
    if (currentState is! AsyncData<List<FeedPost>>) return;

    _isLoadingMore = true;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    try {
      final repository = ref.read(feedRepositoryProvider);
      final newPosts = await repository.getFeed(
        userId: user.id,
        isFan: user.isFan,
        isPlayer: user.isPlayer,
        isCoach: user.isCoach,
        isAdmin: user.isAdmin,
        lastId: _lastId,
      );

      if (newPosts.isEmpty) {
        _hasMore = false;
      } else {
        state = AsyncValue.data([...currentState.value, ...newPosts]);
        _lastId = newPosts.last.id; // Update last ID
      }
    } catch (error) {
      // Keep current state on error
      print('Error loading more posts: $error');
    } finally {
      _isLoadingMore = false;
    }
  }
}

final feedProvider = StateNotifierProvider<FeedNotifier, AsyncValue<List<FeedPost>>>((ref) {
  return FeedNotifier(ref);
});
