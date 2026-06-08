import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;
import 'package:socaloca/core/router/app_routes.dart';
import 'package:socaloca/features/home/widgets/full_screen_post_show.dart';
import 'package:socaloca/features/social_feed/widgets/tag_chip_card.dart';

import '../../../core/constants/api_constants.dart';
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

  static const _kReasons = [
    'Misleading or Scam',
    'Sexually Inappropriate',
    'Offensive',
    'Violence',
    'Prohibited Content',
    'Spam',
    'False News',
    'Political candidate or Issue',
    'Other',
  ];

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _MoreOptionTile(
              icon: Icons.flag_outlined,
              label: 'Report Post',
              onTap: () {
                Navigator.pop(ctx);
                _showReasonPicker(
                  context,
                  title: 'Report Post',
                  onConfirm: (cause) => _doReportPost(context, cause),
                );
              },
            ),
            _MoreOptionTile(
              icon: Icons.block,
              label: 'Block Post',
              onTap: () {
                Navigator.pop(ctx);
                _showReasonPicker(
                  context,
                  title: 'Block Post',
                  onConfirm: (cause) => _doBlockPost(context, cause),
                );
              },
            ),
            _MoreOptionTile(
              icon: Icons.person_off_outlined,
              label: 'Block User',
              onTap: () {
                Navigator.pop(ctx);
                _showBlockUserConfirm(context);
              },
            ),
            _MoreOptionTile(
              icon: Icons.report_outlined,
              label: 'Report User',
              onTap: () {
                Navigator.pop(ctx);
                _showReasonPicker(
                  context,
                  title: 'Report User',
                  onConfirm: (cause) => _doReportUser(context, cause),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showReasonPicker(
    BuildContext context, {
    required String title,
    required void Function(String cause) onConfirm,
  }) {
    String selected = _kReasons.first;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: const Icon(Icons.close,
                        size: 22, color: AppColors.socaBlack),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Please select a reason',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _kReasons.map((reason) {
                  final isSelected = selected == reason;
                  return GestureDetector(
                    onTap: () => setSheetState(() => selected = reason),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.socaBlack : Colors.white,
                        border:
                            Border.all(color: AppColors.socaBlack, width: 1.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        reason,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              isSelected ? Colors.white : AppColors.socaBlack,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    onConfirm(selected);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.socaBlack,
                    side: const BorderSide(
                        color: AppColors.socaBlack, width: 1.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBlockUserConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Block ${widget.post.userName}'s Profile",
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.socaBlack,
          ),
        ),
        content: const Text(
          'You will no longer receive any post or view any comment from the user '
          'you are blocking. People you block can no longer tag you, start a '
          'conversation with you, add you in his/her network or see things you '
          'post in the SocaLoca feed. If you follow each other, blocking will '
          'automatically unfollow that user.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: AppColors.socaBlack,
            height: 1.5,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: AppColors.socaBlack, width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(AppStrings.no,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.socaBlack)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _doBlockUser(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(AppStrings.yes,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSnack(BuildContext context, String msg, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(fontFamily: 'Poppins')),
      backgroundColor: error ? Colors.red : Colors.green,
    ));
  }

  Future<void> _doReportPost(BuildContext context, String cause) async {
    final userId = StorageService.userId ?? '';
    if (userId.isEmpty) return;
    try {
      final ok = await const FeedRepository().reportPost(
        userId: userId,
        postId: widget.post.id,
        createdBy: widget.post.userId,
        cause: cause,
      );
      _showSnack(context,
          ok ? 'Report submitted. Thank you.' : 'Failed to report post.',
          error: !ok);
    } catch (_) {
      _showSnack(context, 'Failed to report post.', error: true);
    }
  }

  Future<void> _doBlockPost(BuildContext context, String cause) async {
    final userId = StorageService.userId ?? '';
    if (userId.isEmpty) return;
    try {
      final ok = await const FeedRepository().blockPost(
        userId: userId,
        postId: widget.post.id,
        postType: widget.post.type,
        cause: cause,
      );
      _showSnack(context, ok ? 'Post blocked.' : 'Failed to block post.',
          error: !ok);
    } catch (_) {
      _showSnack(context, 'Failed to block post.', error: true);
    }
  }

  Future<void> _doBlockUser(BuildContext context) async {
    final userId = StorageService.userId ?? '';
    if (userId.isEmpty) return;
    try {
      final ok = await const FeedRepository().blockUser(
        userId: userId,
        toUserId: widget.post.userId,
      );
      _showSnack(context, ok ? 'User blocked.' : 'Failed to block user.',
          error: !ok);
    } catch (_) {
      _showSnack(context, 'Failed to block user.', error: true);
    }
  }

  Future<void> _doReportUser(BuildContext context, String cause) async {
    final userId = StorageService.userId ?? '';
    if (userId.isEmpty) return;
    try {
      final ok = await const FeedRepository().reportUser(
        userId: userId,
        toUserId: widget.post.userId,
        cause: cause,
      );
      _showSnack(context,
          ok ? 'Report submitted. Thank you.' : 'Failed to report user.',
          error: !ok);
    } catch (_) {
      _showSnack(context, 'Failed to report user.', error: true);
    }
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
                          Text('🌍'.tr, style: const TextStyle(fontSize: 18)),
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
                  onPressed: () => _showMoreOptions(context),
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

          // Tagged entities
          if (widget.post.tagged != null && widget.post.tagged!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: widget.post.tagged!.map((tag) {
                  final t = tag as Map<String, dynamic>;
                  final name = t['name'] as String? ?? '';
                  final tagId = t['tagId'] as String? ?? '';
                  final imageUrl =
                      ApiConstants.getImageUrl(t['imageUrl'] as String?);
                  return TagChip(name: name, imageUrl: imageUrl, id: tagId);
                }).toList(),
              ),
            ),

          const SizedBox(height: 8),

          // Media (image or video) — GestureDetector wraps both
          if (widget.post.images.isNotEmpty || widget.post.videoUrl != null)
            GestureDetector(
              onDoubleTap: _onDoubleTap,
              onTap: widget.post.images.isNotEmpty
                  ? () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => FullScreenImageScreen(
                            imageUrl: widget.post.images.first,
                          ),
                        ),
                      )
                  : widget.post.videoUrl != null
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FullScreenVideoScreen(
                                videoUrl: widget.post.videoUrl!,
                                thumbnail: widget.post.thumbnail,
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
                      child: Text(
                        'Double Tap to Cheer'.tr,
                        style: const TextStyle(
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
                            child:
                                Image.asset("assets/icons/ic_cheers_old.png")),
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
                  child: Image.asset(
                    "assets/icons/ic_not_cheers.png",
                    width: 24,
                    height: 24,
                  ),
                  // Icon(
                  //   _isLiked ? Icons.pan_tool_alt : Icons.pan_tool_alt_outlined,
                  //   size: 20,
                  //   color:
                  //       _isLiked ? AppColors.socaYellow : AppColors.socaBlack,
                  // ),
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
                          Image.asset(
                            "assets/icons/ic_follow_feed.png",
                            width: 28,
                            height: 28,
                          ),
                          // Icon(
                          //   _isFollowing
                          //       ? Icons.person_remove_outlined
                          //       : Icons.person_add_outlined,
                          //   size: 22,
                          //   color: _isFollowing
                          //       ? AppColors.socaYellow
                          //       : AppColors.socaBlack,
                          // ),
                          const SizedBox(width: 8),
                          Text(
                            _isFollowing ? 'Following' : 'Follow',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: _isFollowing
                                  ? AppColors.socaBlack
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/ic_share_feed.png",
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SHARE'.tr,
                          style: const TextStyle(
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
    final months = [
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

// ── More Option Tile ──────────────────────────────────────────────────────────

class _MoreOptionTile extends StatelessWidget {
  const _MoreOptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.socaBlack, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.socaBlack,
        ),
      ),
      onTap: onTap,
      dense: true,
    );
  }
}

// ── Tag Chip ──────────────────────────────────────────────────────────────────

// ── Full Screen Image ──────────────────────────────────────────────────────────
