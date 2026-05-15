import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/api_constants.dart';
import '../data/models/search_user_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class SearchResultCard extends StatelessWidget {
  final SearchUserModel user;

  const SearchResultCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            _buildAvatar(),
            const SizedBox(width: 12),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Position/Role
                  if (user.playPosition != null &&
                      user.playPosition!.isNotEmpty)
                    Text(
                      user.playPosition!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),

                  // Nationality
                  if (user.country != null && user.country!.isNotEmpty)
                    Text(
                      'Nationality: ${user.country}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 4),

                  // Appearances
                  Text(
                    '${user.appearance} ${user.appearance == 1 ? 'Appearance' : 'Appearances'}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Posts
                  Text(
                    '${user.postCount} ${user.postCount == 1 ? 'Post' : 'Posts'}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Endorsed By & Followers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${user.endorsedBy}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'ENDORSED BY',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Column(
                        children: [
                          Text(
                            '${user.followers}',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            'FOLLOWERS',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final imageUrl = user.profileImage;
    log("this is the image url: $imageUrl");
    if (imageUrl == null ||
        imageUrl.isEmpty ||
        imageUrl.startsWith('file:///')) {
      return _buildDefaultAvatar();
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);

    if (fullImageUrl.isEmpty) {
      return _buildDefaultAvatar();
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: fullImageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 60,
          height: 60,
          color: Colors.grey[200],
          child: const AppLoader(),
        ),
        errorWidget: (context, url, error) => _buildDefaultAvatar(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        size: 30,
        color: Colors.grey,
      ),
    );
  }

  void _handleTap(BuildContext context) {
    // Navigate based on user type
    if (user.isPlayer) {
      context.push('/player-bio/${user.userId}');
    } else if (user.isCoach || user.isAdmin) {
      // TODO: Navigate to Coach/Admin Bio when implemented
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coach/Admin Bio not yet implemented')),
      );
    } else if (user.isReferee) {
      // TODO: Navigate to Referee Bio when implemented
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Referee Bio not yet implemented')),
      );
    }
  }
}
