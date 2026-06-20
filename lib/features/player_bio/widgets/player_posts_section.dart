import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_post_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Player Top Posts Section for Endorse Tab
/// Shows horizontal scrollable list of posts
class PlayerPostsSection extends StatelessWidget {
  final List<PlayerPostModel> posts;
  final bool isLoadingPosts;

  const PlayerPostsSection({
    super.key,
    required this.posts,
    required this.isLoadingPosts,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  String? _getFirstMediaUrl(PlayerPostModel post) {
    if (post.sources?.isNotEmpty == true) {
      final source = post.sources!.first;
      // This relies on the PlayerPostModel being fixed to correctly parse 'imageUrl' into 'url'.
      if (_isValidImageUrl(source.url)) return source.url;
      if (_isValidImageUrl(source.thumbnail)) return source.thumbnail;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingPosts) {
      return const AppLoader();
    }

    if (posts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    final mediaUrl = _getFirstMediaUrl(post);
                    log("this is the media url: $mediaUrl  ${post.toJson()}");
                    final source = post.sources?.isNotEmpty == true
                        ? post.sources!.first
                        : null;
                    final videoUrl = source?.videoUrl ?? '';
                    final imageUrl = source?.url ?? '';
                    final isVideo = videoUrl.isNotEmpty;

                    return GestureDetector(
                      onTap: () {
                        if (isVideo) {
                          context.push(
                            AppRoutes.fullScreenVideo,
                            extra: {
                              'videoUrl': ApiConstants.getImageUrl(videoUrl),
                              'thumbnail': imageUrl.isNotEmpty
                                  ? ApiConstants.getImageUrl(imageUrl)
                                  : null,
                            },
                          );
                        } else if (imageUrl.isNotEmpty) {
                          context.push(
                            AppRoutes.fullScreenImage,
                            extra: {
                              'imageUrl': ApiConstants.getImageUrl(imageUrl),
                            },
                          );
                        }
                      },
                      child: Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.socaGrey.withOpacity(0.2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (mediaUrl != null)
                                CachedNetworkImage(
                                  imageUrl: ApiConstants.getImageUrl(mediaUrl),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const AppLoader(),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(
                                      Icons.image,
                                      color: AppColors.socaGrey,
                                      size: 40,
                                    ),
                                  ),
                                )
                              else
                                const Center(
                                  child: Icon(
                                    Icons.article,
                                    color: AppColors.socaGrey,
                                    size: 40,
                                  ),
                                ),

                              // Play icon overlay for video posts
                              if (isVideo)
                                Center(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white.withValues(alpha: 0.9),
                                    size: 36,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),

                              // Engagement overlay
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${post.likeCount ?? 0}',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.comment,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${post.commentCount ?? 0}',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: -30,
              left: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'TOP POSTS'.tr,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                    if (posts.length > 3)
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to all posts
                        },
                        child: Text(
                          'view all'.tr,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
