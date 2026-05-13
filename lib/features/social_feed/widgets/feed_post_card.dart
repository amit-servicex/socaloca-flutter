import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/feed_repository.dart';
import '../models/feed_post.dart';

/// Feed post card widget matching Android feed item design.
/// Implements double-tap to cheer (like) with animated heart overlay.
class FeedPostCard extends ConsumerStatefulWidget {
  const FeedPostCard({super.key, required this.post});

  final FeedPost post;

  @override
  ConsumerState<FeedPostCard> createState() => _FeedPostCardState();
}

class _FeedPostCardState extends ConsumerState<FeedPostCard>
    with SingleTickerProviderStateMixin {
  late bool _isLiked;
  late int _likeCount;
  late bool _isFollowing;
  bool _followLoading = false;

  bool get _isOwnPost => StorageService.userId == widget.post.userId;

  // Heart animation
  late AnimationController _heartController;
  late Animation<double> _heartScale;
  late Animation<double> _heartOpacity;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked;
    _likeCount = widget.post.likeCount;
    _isFollowing = widget.post.metadata?['isFollow'] as bool? ?? false;

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Scale: 0 → 1.2 (elastic overshoot) in first 400ms, then 1.2 → 0
    _heartScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 1.2, end: 0.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_heartController);

    // Opacity: fully visible for first 75%, then fade out
    _heartOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween(1.0),
        weight: 75,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 25,
      ),
    ]).animate(_heartController);
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  Future<void> _onDoubleTap() async {
    // Always play animation
    _heartController.forward(from: 0);

    // Only call API if not already liked (mirror Android: no unlike on double tap)
    if (_isLiked) return;

    // Optimistic update
    setState(() {
      _isLiked = true;
      _likeCount++;
    });

    final userId = StorageService.userId ?? '';
    if (userId.isEmpty) return;

    try {
      final success = await const FeedRepository().likePost(
        userId: userId,
        postId: widget.post.id,
        postType: widget.post.type,
      );
      if (!success && mounted) {
        // Revert optimistic update on failure
        setState(() {
          _isLiked = false;
          _likeCount--;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLiked = false;
          _likeCount--;
        });
      }
    }
  }

  Future<void> _onFollow() async {
    if (_followLoading) return;

    final userId = StorageService.userId ?? '';
    if (userId.isEmpty) return;

    final optimisticValue = !_isFollowing;
    setState(() {
      _isFollowing = optimisticValue;
      _followLoading = true;
    });

    try {
      final user = StorageService.currentUser ?? {};
      final firstName = user['firstName'] as String? ?? '';
      final lastName = user['lastName'] as String? ?? '';
      final myName = '$firstName $lastName'.trim();
      final myImageUrl = user['imageUrl'] as String? ?? '';

      final result = await const FeedRepository().followUser(
        userId: userId,
        toUserId: widget.post.userId,
        myName: myName,
        myImageUrl: myImageUrl,
        isPlayer: user['isPlayer'] as bool? ?? false,
        isCoach: user['isCoach'] as bool? ?? false,
        isAdmin: user['isAdmin'] as bool? ?? false,
        isFan: user['isFan'] as bool? ?? true,
      );

      if (mounted) {
        setState(() {
          _isFollowing = result ?? optimisticValue;
          _followLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isFollowing = !optimisticValue;
          _followLoading = false;
        });
      }
    }
  }

  void _onShare() {
    final post = widget.post;
    final userId = StorageService.userId ?? '';
    final content =
        post.content?.isNotEmpty == true ? '${post.content} - ' : '';
    SharePlus.instance.share(
      ShareParams(
        text:
            '${content}Check out this post on SocaLoca. https://socaloca.com/post/${post.id}/u/$userId',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.socaGrey.withValues(alpha: 0.2),
                  backgroundImage: widget.post.userImage != null
                      ? NetworkImage(widget.post.userImage!)
                      : null,
                  child: widget.post.userImage == null
                      ? Text(
                          widget.post.userName.isNotEmpty
                              ? widget.post.userName[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.socaBlack,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.post.userName,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.socaBlack,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 14,
                            color: AppColors.socaBlack,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          const Text('🌍', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(widget.post.createdAt),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.socaBlack),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Content text
          if (widget.post.content != null && widget.post.content!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                widget.post.content!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Media (image or video) — GestureDetector wraps both
          if (widget.post.images.isNotEmpty || widget.post.videoUrl != null)
            GestureDetector(
              onDoubleTap: _onDoubleTap,
              onTap: widget.post.images.isNotEmpty
                  ? () => Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (_) => _FullScreenImageScreen(
                            imageUrl: widget.post.images.first,
                          ),
                        ),
                      )
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Media content
                  if (widget.post.images.isNotEmpty)
                    Image.network(
                      widget.post.images.first,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 400,
                        color: AppColors.socaBlack,
                        child: const Icon(Icons.image,
                            size: 48, color: AppColors.socaGrey),
                      ),
                    )
                  else if (widget.post.videoUrl != null) ...[
                    if (widget.post.thumbnail != null)
                      Image.network(
                        widget.post.thumbnail!,
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 400,
                          width: double.infinity,
                          color: AppColors.socaBlack,
                        ),
                      )
                    else
                      Container(
                        height: 400,
                        width: double.infinity,
                        color: AppColors.socaBlack,
                      ),
                    const Icon(Icons.play_circle_outline,
                        size: 64, color: Colors.white),
                  ],

                  // "Double Tap to Cheer" hint text
                  Positioned(
                    bottom: 180,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        'Double Tap to Cheer',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Animated heart overlay (Instagram-style)
                  AnimatedBuilder(
                    animation: _heartController,
                    builder: (_, __) {
                      if (_heartController.isDismissed) {
                        return const SizedBox.shrink();
                      }
                      return Opacity(
                        opacity: _heartOpacity.value,
                        child: Transform.scale(
                          scale: _heartScale.value,
                          child: const Icon(
                            Icons.favorite,
                            color: AppColors.socaYellow,
                            size: 100,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 12,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

          // Divider
          Container(
            height: 0.5,
            color: AppColors.socaGrey,
            width: double.infinity,
          ),

          // Cheers Count Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _onDoubleTap,
                  child: Icon(
                    _isLiked ? Icons.pan_tool_alt : Icons.pan_tool_alt_outlined,
                    size: 20,
                    color:
                        _isLiked ? AppColors.socaYellow : AppColors.socaBlack,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$_likeCount ${_likeCount == 1 ? 'cheer' : 'cheers'}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 0.5,
            color: AppColors.socaGrey,
            width: double.infinity,
          ),

          // Actions (Follow & Share)
          Row(
            children: [
              if (!_isOwnPost) ...[
                Expanded(
                  child: InkWell(
                    onTap: _followLoading ? null : _onFollow,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isFollowing
                                ? Icons.person_remove_outlined
                                : Icons.person_add_outlined,
                            size: 22,
                            color: _isFollowing
                                ? AppColors.socaYellow
                                : AppColors.socaBlack,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isFollowing ? 'Following' : 'Follow',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: _isFollowing
                                  ? AppColors.socaYellow
                                  : AppColors.socaBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(width: 1, height: 24, color: Colors.grey.shade300),
              ],
              Expanded(
                child: InkWell(
                  onTap: _onShare,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.ios_share_rounded,
                            size: 22, color: AppColors.socaBlack),
                        SizedBox(width: 8),
                        Text(
                          'SHARE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppColors.socaBlack,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = date.hour == 0 || date.hour == 12 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, $hour:$minute$period';
  }
}

// ── Full Screen Image ──────────────────────────────────────────────────────────

class _FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const _FullScreenImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.error, color: Colors.white, size: 64),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/logo_transparent.png',
                  color: AppColors.socaBlack,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.sports_soccer,
                    color: AppColors.socaBlack,
                    size: 32,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 22),
                    SizedBox(width: 6),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
