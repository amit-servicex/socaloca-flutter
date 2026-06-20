import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../tournaments/data/tournament_models.dart';

/// Featured card for today's match with LIVE indicator
class TodaysMatchCard extends StatelessWidget {
  final TournamentMatchModel match;
  final VoidCallback onTap;

  const TodaysMatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  bool get _isLive {
    final matchTime = match.matchDateMs;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    const matchDuration = 90 * 60 * 1000; // 90 minutes
    const extraTime = 45 * 60 * 1000; // 45 minutes buffer
    final matchLife = matchTime + matchDuration + extraTime;

    return currentTime >= matchTime && currentTime <= matchLife;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // LIVE indicator
            if (_isLive)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  AppStrings.liveUpper,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            if (_isLive) const SizedBox(height: 16),

            // Teams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home Team
                Expanded(
                  child: Column(
                    children: [
                      _TeamLogo(logoPath: match.homeTeamLogo, size: 80),
                      const SizedBox(height: 12),
                      Text(
                        match.homeTeamName ?? AppStrings.teamALabel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),

                // VS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppStrings.vs,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),

                // Away Team
                Expanded(
                  child: Column(
                    children: [
                      _TeamLogo(logoPath: match.awayTeamLogo, size: 80),
                      const SizedBox(height: 12),
                      Text(
                        match.awayTeamName ?? AppStrings.teamBLabel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Match details
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (match.gameType != null) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.socaYellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      match.gameType!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                if (match.ageGroup != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.socaYellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      match.ageGroup!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
              ],
            ),

            if (match.venue != null) ...[
              const SizedBox(height: 12),
              Text(
                match.venue!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.socaBlack.withOpacity(0.7),
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
