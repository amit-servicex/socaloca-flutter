import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/theme/app_colors.dart';
import '../models/feed_post.dart';

/// Feed post card widget matching Android feed item design
class FeedPostCard extends StatelessWidget {
  const FeedPostCard({super.key, required this.post});

  final FeedPost post;

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
                // User Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.socaGrey.withOpacity(0.2),
                  backgroundImage: post.userImage != null
                      ? NetworkImage(post.userImage!)
                      : null,
                  child: post.userImage == null
                      ? Text(
                          post.userName.isNotEmpty
                              ? post.userName[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.socaBlack,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                // User Name and Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              post.userName,
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
                          const Text(
                            '🇺🇸', // Fallback since country flag isn't in model
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(post.createdAt),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                // More options
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.socaBlack),
                  onPressed: () {
                    // TODO: Show options menu
                  },
                ),
              ],
            ),
          ),

          // Content
          if (post.content != null && post.content!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                post.content!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Images (Edge-to-edge)
          if (post.images.isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => _FullScreenImageScreen(
                      imageUrl: post.images.first,
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    post.images.first,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 400,
                        color: AppColors.socaBlack,
                        child: const Icon(Icons.image,
                            size: 48, color: AppColors.socaGrey),
                      );
                    },
                  ),
                  // "Double Tap to Cheer" overlay
                  Positioned(
                    bottom: 180,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
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
                ],
              ),
            )
          // Video
          else if (post.videoUrl != null) ...[
            Stack(
              alignment: Alignment.center,
              children: [
                if (post.thumbnail != null)
                  Image.network(
                    post.thumbnail!,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 400,
                        width: double.infinity,
                        color: AppColors.socaBlack,
                      );
                    },
                  )
                else
                  Container(
                    height: 400,
                    width: double.infinity,
                    color: AppColors.socaBlack,
                  ),
                const Icon(
                  Icons.play_circle_outline,
                  size: 64,
                  color: Colors.white,
                ),
                // "Double Tap to Cheer" overlay
                Positioned(
                  bottom: 180,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
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
              ],
            ),
          ],

          // Divider
          Container(
            height: 0.5,
            color: Colors.grey.shade300,
            width: double.infinity,
          ),

          // Cheers Count Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.pan_tool_alt_outlined,
                  size: 20,
                  color: AppColors.socaBlack,
                ),
                const SizedBox(width: 8),
                Text(
                  '${post.likeCount} cheers',
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
            color: Colors.grey.shade300,
            width: double.infinity,
          ),

          // Actions (Follow & Share)
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    // TODO: Handle Follow
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person_add_outlined,
                            size: 22, color: AppColors.socaBlack),
                        SizedBox(width: 8),
                        Text(
                          'Follow',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    // TODO: Handle Share
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
      'Dec'
    ];
    final hour = date.hour == 0 || date.hour == 12 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, $hour:$minute$period';
  }
}

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
            // Center Image
            Center(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.white, size: 64);
                },
              ),
            ),
            // Watermark Logo Overlay (Top-Left of the image area)
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
            // Back Button
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
