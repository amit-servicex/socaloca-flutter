import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../tournaments/data/tournament_models.dart';

/// Compact card for recent match with score display
class RecentMatchCard extends StatelessWidget {
  final TournamentMatchModel match;
  final VoidCallback onTap;

  const RecentMatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  String _formatMatchDate() {
    if (match.matchDateMs == 0) return '';
    final date = DateTime.fromMillisecondsSinceEpoch(match.matchDateMs);
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Home Team
                Expanded(
                  child: Row(
                    children: [
                      _TeamLogo(logoPath: match.homeTeamLogo, size: 40),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          match.homeTeamName ?? 'Team A',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Score
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${match.homeScore ?? 0} - ${match.awayScore ?? 0}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),

                // Away Team
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          match.awayTeamName ?? 'Team B',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _TeamLogo(logoPath: match.awayTeamLogo, size: 40),
                    ],
                  ),
                ),
              ],
            ),

            // Date
            if (match.matchDateMs > 0) ...[
              const SizedBox(height: 8),
              Text(
                _formatMatchDate(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.socaBlack.withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({this.logoPath, this.size = 48});
  final String? logoPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(logoPath);
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(
                  Icons.shield,
                  color: AppColors.socaBlack,
                  size: 24,
                ),
              )
            : const Icon(Icons.shield, color: AppColors.socaBlack, size: 24),
      ),
    );
  }
}
