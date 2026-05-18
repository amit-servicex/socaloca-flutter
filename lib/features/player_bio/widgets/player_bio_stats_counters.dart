import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/player_bio_model.dart';

/// Stats counters (Posts, Cheers, Followers, Following)
class PlayerBioStatsCounters extends StatelessWidget {
  final PlayerBioModel playerBio;

  const PlayerBioStatsCounters({
    super.key,
    required this.playerBio,
  });

  String _formatCount(int? count) {
    if (count == null || count == 0) return '0';
    if (count < 1000) return count.toString();
    if (count < 1000000) return '${(count / 1000).toStringAsFixed(1)}K';
    return '${(count / 1000000).toStringAsFixed(1)}M';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          // Posts
          _buildCounter(
            label: 'POSTS',
            count: playerBio.postCount ?? 0,
            onTap: () {
              // TODO: Navigate to posts list
            },
          ),

          // Cheers
          _buildCounter(
            label: 'CHEERS',
            count: playerBio.likeCount ?? 0,
            onTap: () {
              // TODO: Navigate to likes list
            },
          ),

          // Followers
          _buildCounter(
            label: 'FOLLOWERS',
            count: playerBio.followCount ?? 0,
            onTap: () {
              // TODO: Navigate to followers list
            },
          ),

          // Following
          _buildCounter(
            label: 'FOLLOWING',
            count: playerBio.followingCount ?? 0,
            onTap: () {
              // TODO: Navigate to following list
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCounter({
    required String label,
    required int count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            _formatCount(count),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }
}
