import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../data/models/search_user_model.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.user,
    this.isLast = false,
  });

  final SearchUserModel user;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isReferee = user.isReferee;
    final appearanceCount =
        isReferee ? user.refereeMatchCount : user.appearance;
    final appearanceLabel = isReferee
        ? '${appearanceCount} ${appearanceCount == 1 ? 'Match' : 'Matches'}'
        : '${appearanceCount} ${appearanceCount == 1 ? 'Appearance' : 'Appearances'}';

    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 10, 7, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAvatar(),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          if (user.positionText.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              user.positionText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                          if (user.displayNationality.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              'Nationality: ${user.displayNationality}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                          const SizedBox(height: 2),
                          Text(
                            appearanceLabel,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          if (!isReferee) ...[
                            const SizedBox(height: 7),
                            Text(
                              '${user.postCount < 0 ? 0 : user.postCount} ${(user.postCount == 1) ? 'Post' : 'Posts'}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  _StatsBox(user: user, showFollowers: !isReferee),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (!isLast)
              const Divider(height: 0.5, thickness: 0.5, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final imageUrl = user.profileImage;
    if (imageUrl == null ||
        imageUrl.isEmpty ||
        imageUrl.startsWith('file:///')) {
      return _defaultAvatar();
    }

    final fullImageUrl = ApiConstants.getImageUrl(imageUrl);
    if (fullImageUrl.isEmpty) return _defaultAvatar();

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF1F1F1), width: 2),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: fullImageUrl,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => _defaultAvatar(),
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F1F1),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, size: 32, color: Colors.grey),
    );
  }

  void _handleTap(BuildContext context) {
    if (user.isFan) return;
    if (user.isPlayer) {
      context.push(AppRoutes.playerBio.replaceFirst(':userId', user.userId));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile details not available yet'.tr)),
    );
  }
}

class _StatsBox extends StatelessWidget {
  const _StatsBox({required this.user, required this.showFollowers});

  final SearchUserModel user;
  final bool showFollowers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Metric(value: user.endorsedBy, label: 'ENDORSED BY'.tr),
        if (showFollowers) ...[
          const SizedBox(width: 5),
          _Metric(value: user.followers, label: 'FOLLOWERS'.tr),
        ],
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
