import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Tournament header — logo, name, info, follow button
/// Mirrors Android TournamentsFragment header section
class TournamentHeaderWidget extends StatelessWidget {
  const TournamentHeaderWidget({
    super.key,
    required this.tournament,
    required this.isFollowing,
    required this.followCount,
    this.onFollowTap,
    this.onLogoTap,
  });

  final TournamentModel tournament;
  final bool isFollowing;
  final int followCount;
  final VoidCallback? onFollowTap;
  final VoidCallback? onLogoTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(tournament.logo);
    final status = tournament.status ?? '';

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament logo (circular, clickable)
          GestureDetector(
            onTap: onLogoTap,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.socaGrey,
                border: Border.all(color: AppColors.socaGrey, width: 2),
              ),
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.socaYellow,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.emoji_events,
                          color: AppColors.socaBlack,
                          size: 36,
                        ),
                      )
                    : const Icon(
                        Icons.emoji_events,
                        color: AppColors.socaBlack,
                        size: 36,
                      ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Info section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  tournament.name ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.socaBlack,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Age group + game type row
                Row(
                  children: [
                    if (tournament.ageGroup != null &&
                        tournament.ageGroup!.isNotEmpty) ...[
                      _InfoChip(label: tournament.ageGroup!),
                      const SizedBox(width: 6),
                    ],
                    if (tournament.gameType != null &&
                        tournament.gameType!.isNotEmpty)
                      _InfoChip(label: tournament.gameType!),
                  ],
                ),

                const SizedBox(height: 4),

                // Location
                if (tournament.location != null &&
                    tournament.location!.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 13, color: AppColors.socaBlack),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          tournament.location!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.socaBlack.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 4),

                // Date info
                _buildDateInfo(status),

                const SizedBox(height: 8),

                // Follow button + count
                Row(
                  children: [
                    GestureDetector(
                      onTap: onFollowTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isFollowing
                              ? AppColors.socaBlack
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.socaBlack),
                        ),
                        child: Text(
                          isFollowing ? 'Following' : 'Follow',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isFollowing
                                ? AppColors.socaYellow
                                : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _followCountText(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo(String status) {
    final startDate = tournament.startDate ?? '';
    if (startDate.isEmpty) return const SizedBox.shrink();

    String dateText;
    switch (status.toLowerCase()) {
      case 'init':
      case 'fixture':
        dateText = 'Starts $startDate';
        break;
      case 'live':
      case 'end':
        dateText = 'Started on $startDate';
        break;
      default:
        dateText = startDate;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today,
                size: 13, color: AppColors.socaBlack),
            const SizedBox(width: 3),
            Text(
              dateText,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack.withOpacity(0.7),
              ),
            ),
          ],
        ),
        // Final submission date for upcoming tournaments
        if ((status.toLowerCase() == 'init' ||
                status.toLowerCase() == 'fixture') &&
            tournament.fsdGmtMs > 0) ...[
          const SizedBox(height: 2),
          Text(
            'Final Submission: ${_formatFsdDate(tournament.fsdGmtMs)}',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        ],
      ],
    );
  }

  String _followCountText() {
    if (followCount == 1) return '1 follower';
    return '$followCount followers';
  }

  String _formatFsdDate(int ms) {
    if (ms == 0) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.socaYellow.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}
