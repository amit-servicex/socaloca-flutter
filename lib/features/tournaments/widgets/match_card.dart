import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/tournament_models.dart';

/// Match card widget — mirrors Android TournamentUpcomingMatchesAdapter / TournamentPlayedMatchesAdapter
class MatchCard extends StatelessWidget {
  MatchCard({
    super.key,
    required this.match,
    this.onTap,
  });

  final TournamentMatchModel match;
  final VoidCallback? onTap;

  bool get _isPlayed => match.homeScore != null && match.awayScore != null;

  @override
  Widget build(BuildContext context) {
    log("this is the details of the match ${match.toJson()}");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Venue at top
            if (match.venue != null && match.venue!.isNotEmpty) ...[
              Text(
                match.venue!.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.socaBlack.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
            ],

            // Teams and Score
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home team
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _TeamLogo(logoPath: match.homeTeamLogo),
                      SizedBox(height: 8),
                      Text(
                        match.homeTeamName ?? 'TBD',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Center Score and Status
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      // Score Box or VS Box
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _isPlayed
                              ? '${match.homeScore} : ${match.awayScore}'
                              : 'VS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      // Full time / Upcoming status
                      Text(
                        _isPlayed ? 'Full time'.tr : 'Upcoming'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.socaBlack.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Date Pill
                      if (match.matchDate != null &&
                          match.matchDate!.isNotEmpty)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            match.matchDate!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Away team
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _TeamLogo(logoPath: match.awayTeamLogo),
                      SizedBox(height: 8),
                      Text(
                        match.awayTeamName ?? 'TBD',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  _TeamLogo({this.logoPath});
  final String? logoPath;

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(logoPath);
    return Container(
      width: 48,
      height: 48,
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
