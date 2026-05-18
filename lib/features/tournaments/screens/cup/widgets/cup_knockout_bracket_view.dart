import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../providers/cup_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Cup Knockout Bracket View
/// Shows knockout bracket tree for selected round
/// Matches Android TournamentCupMatchModeFragment
class CupKnockoutBracketView extends ConsumerWidget {
  final String tournamentId;
  final String roundId;
  final TournamentCupModel cup;

  CupKnockoutBracketView({
    super.key,
    required this.tournamentId,
    required this.roundId,
    required this.cup,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = CupKnockoutParams(
      tournamentId: tournamentId,
      roundId: roundId,
    );

    final matchesAsync = ref.watch(cupKnockoutMatchesProvider(params));

    return matchesAsync.when(
      data: (matches) {
        if (matches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_tree,
                  size: 64,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'No knockout matches yet'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(cupKnockoutMatchesProvider(params));
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Round Info
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: AppColors.socaYellow,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        _getRoundName(matches.first.level),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${matches.length} ${matches.length == 1 ? "Match" : "Matches"}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Matches List
                ...matches.map((match) => _buildMatchCard(match)),
              ],
            ),
          ),
        );
      },
      loading: () => AppLoader(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('Error loading bracket: $error'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(cupKnockoutMatchesProvider(params));
              },
              child: Text('Retry'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(CupMatchModel match) {
    final hasScore = match.homeScore != null && match.awayScore != null;
    final hasExtraTime =
        match.homeExtraTimeScore != null && match.awayExtraTimeScore != null;
    final hasPenalties =
        match.homePenaltyScore != null && match.awayPenaltyScore != null;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              match.winnerId != null ? AppColors.socaYellow : Colors.grey[300]!,
          width: match.winnerId != null ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Home Team
          _buildTeamRow(
            teamName: match.homeTeamName ?? 'TBD',
            teamLogo: match.homeTeamLogo,
            score: hasScore ? match.homeScore! : null,
            extraTimeScore: hasExtraTime ? match.homeExtraTimeScore : null,
            penaltyScore: hasPenalties ? match.homePenaltyScore : null,
            isWinner: match.winnerId == match.homeTeamId,
            isTop: true,
          ),

          // Divider
          Divider(height: 1, color: Colors.grey[300]),

          // Away Team
          _buildTeamRow(
            teamName: match.awayTeamName ?? 'TBD',
            teamLogo: match.awayTeamLogo,
            score: hasScore ? match.awayScore! : null,
            extraTimeScore: hasExtraTime ? match.awayExtraTimeScore : null,
            penaltyScore: hasPenalties ? match.awayPenaltyScore : null,
            isWinner: match.winnerId == match.awayTeamId,
            isTop: false,
          ),

          // Match Info
          if (match.matchDate != null || match.venue != null)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (match.matchDate != null) ...[
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      match.matchDate!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  if (match.matchDate != null && match.venue != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  if (match.venue != null) ...[
                    Icon(Icons.location_on, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        match.venue!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTeamRow({
    required String teamName,
    String? teamLogo,
    int? score,
    int? extraTimeScore,
    int? penaltyScore,
    required bool isWinner,
    required bool isTop,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isWinner ? AppColors.socaYellow.withOpacity(0.1) : Colors.white,
        borderRadius: isTop
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : null,
      ),
      child: Row(
        children: [
          // Team Logo
          ClipOval(
            child: _buildTeamLogo(teamLogo, 40),
          ),

          SizedBox(width: 12),

          // Team Name
          Expanded(
            child: Text(
              teamName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: isWinner ? FontWeight.w700 : FontWeight.w600,
                color: AppColors.socaBlack,
              ),
            ),
          ),

          // Scores
          if (score != null) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Regular Score
                Text(
                  '$score',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color:
                        isWinner ? AppColors.socaYellow : AppColors.socaBlack,
                  ),
                ),
                // Extra Time & Penalties
                if (extraTimeScore != null || penaltyScore != null)
                  Text(
                    '${extraTimeScore != null ? "ET: $extraTimeScore" : ""}${extraTimeScore != null && penaltyScore != null ? " " : ""}${penaltyScore != null ? "Pen: $penaltyScore" : ""}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ],

          // Winner Icon
          if (isWinner)
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.emoji_events,
                color: AppColors.socaYellow,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTeamLogo(String? logoUrl, double size) {
    if (logoUrl == null || logoUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(logoUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: fullImageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  String _getRoundName(String? level) {
    if (level == null) return 'Knockout Round';

    switch (level) {
      case '1':
        return 'Final';
      case '2':
        return 'Semi Finals';
      case '3':
        return 'Quarter Finals';
      case '4':
        return 'Round of 16';
      case '5':
        return 'Round of 32';
      default:
        return 'Round $level';
    }
  }
}
