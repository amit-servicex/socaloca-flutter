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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // Teams row
              Row(
                children: [
                  // Home team
                  Expanded(
                    child: Column(
                      children: [
                        _TeamLogo(logoPath: match.homeTeamLogo),
                        SizedBox(height: 6),
                        Text(
                          match.homeTeamName ?? 'TBD',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
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

                  // Score / VS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: _isPlayed
                        ? Column(
                            children: [
                              Text(
                                '${match.homeScore} - ${match.awayScore}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'FT'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'VS'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: AppColors.socaBlack,
                            ),
                          ),
                  ),

                  // Away team
                  Expanded(
                    child: Column(
                      children: [
                        _TeamLogo(logoPath: match.awayTeamLogo),
                        SizedBox(height: 6),
                        Text(
                          match.awayTeamName ?? 'TBD',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
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

              // Date + venue
              if (match.matchDate != null || match.venue != null) ...[
                SizedBox(height: 8),
                Divider(height: 1),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (match.matchDate != null) ...[
                      Icon(Icons.calendar_today,
                          size: 12, color: AppColors.socaBlack),
                      SizedBox(width: 4),
                      Text(
                        match.matchDate!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: AppColors.socaBlack.withOpacity(0.7),
                        ),
                      ),
                    ],
                    if (match.matchDate != null && match.venue != null)
                      SizedBox(width: 12),
                    if (match.venue != null) ...[
                      Icon(Icons.stadium, size: 12, color: AppColors.socaBlack),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          match.venue!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.socaBlack.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
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
