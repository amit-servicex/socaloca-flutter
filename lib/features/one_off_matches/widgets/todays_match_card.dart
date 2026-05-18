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

  TodaysMatchCard({
    super.key,
    required this.match,
    required this.onTap,
  });

  bool get _isLive {
    final matchTime = match.matchDateMs;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final matchDuration = 90 * 60 * 1000; // 90 minutes
    final extraTime = 45 * 60 * 1000; // 45 minutes buffer
    final matchLife = matchTime + matchDuration + extraTime;

    return currentTime >= matchTime && currentTime <= matchLife;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // LIVE indicator
            if (_isLive)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'LIVE'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            if (_isLive) SizedBox(height: 16),

            // Teams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home Team
                Expanded(
                  child: Column(
                    children: [
                      _TeamLogo(logoPath: match.homeTeamLogo, size: 80),
                      SizedBox(height: 12),
                      Text(
                        match.homeTeamName ?? 'Team A',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'VS'.tr,
                    style: TextStyle(
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
                      SizedBox(height: 12),
                      Text(
                        match.awayTeamName ?? 'Team B',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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

            SizedBox(height: 20),

            // Match details
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (match.gameType != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.socaYellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      match.gameType!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                ],
                if (match.ageGroup != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.socaYellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      match.ageGroup!,
                      style: TextStyle(
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
              SizedBox(height: 12),
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
  _TeamLogo({this.logoPath, this.size = 48});
  final String? logoPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(logoPath);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Icon(
                  Icons.shield,
                  color: AppColors.socaBlack,
                  size: 24,
                ),
              )
            : Icon(Icons.shield, color: AppColors.socaBlack, size: 24),
      ),
    );
  }
}
