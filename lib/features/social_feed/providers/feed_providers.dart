import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/feed_repository.dart';
import '../models/feed_post.dart';

// ─── Repository Provider ──────────────────────────────────────────────────────

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return const FeedRepository();
});

// ─── Feed Provider ────────────────────────────────────────────────────────────

class FeedState {
  final FeedPost? socaFeed;
  final List<FeedPost> posts;

  const FeedState({
    this.socaFeed,
    required this.posts,
  });

  List<FeedPost> get displayPosts => [
        if (socaFeed != null) socaFeed!,
        ...posts,
      ];
}

class FeedNotifier extends StateNotifier<AsyncValue<FeedState>> {
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
    print(
        '  isFan: ${user.isFan}, isPlayer: ${user.isPlayer}, isCoach: ${user.isCoach}, isAdmin: ${user.isAdmin}');

    try {
      final repository = ref.read(feedRepositoryProvider);
      final result = await repository.getFeed(
        userId: user.id,
        isFan: user.isFan,
        isPlayer: user.isPlayer,
        isCoach: user.isCoach,
        isAdmin: user.isAdmin,
        lastId: _lastId,
      );

      print('🟢 loadFeed: Loaded ${result.posts.length} posts');
      state = AsyncValue.data(
        FeedState(
          socaFeed: result.socaFeed,
          posts: result.posts,
        ),
      );
      _hasMore = result.posts.length >= 10; // Assuming 10 posts per page
      _lastId = result.lastId ??
          (result.posts.isNotEmpty
              ? result.posts.last.id
              : null); // Store normal feed cursor for pagination
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
    if (currentState is! AsyncData<FeedState>) return;

    _isLoadingMore = true;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    try {
      final repository = ref.read(feedRepositoryProvider);
      final result = await repository.getFeed(
        userId: user.id,
        isFan: user.isFan,
        isPlayer: user.isPlayer,
        isCoach: user.isCoach,
        isAdmin: user.isAdmin,
        lastId: _lastId,
      );

      if (result.posts.isEmpty) {
        _hasMore = false;
      } else {
        state = AsyncValue.data(
          FeedState(
            socaFeed: currentState.value.socaFeed,
            posts: [...currentState.value.posts, ...result.posts],
          ),
        );
        _lastId = result.lastId ?? result.posts.last.id; // Update last ID
      }
    } catch (error) {
      // Keep current state on error
      print('Error loading more posts: $error');
    } finally {
      _isLoadingMore = false;
    }
  }
}

final feedProvider =
    StateNotifierProvider<FeedNotifier, AsyncValue<FeedState>>((ref) {
  return FeedNotifier(ref);
});
