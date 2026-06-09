import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../providers/cup_providers.dart';

class CupKnockoutBracketView extends ConsumerWidget {
  const CupKnockoutBracketView({
    super.key,
    required this.tournamentId,
    required this.roundId,
    required this.cup,
  });

  final String tournamentId;
  final String roundId;
  final TournamentCupModel cup;

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
                Icon(Icons.account_tree, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  AppStrings.noKnockoutMatchesYet,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: AppColors.socaYellow,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getRoundName(matches.first.level),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${matches.length} ${matches.length == 1 ? "Match" : "Matches"}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...matches.map((match) => _buildMatchCard(context, match)),
              ],
            ),
          ),
        );
      },
      loading: () => const AppLoader(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(AppStrings.errorLoadingBracket(error)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(cupKnockoutMatchesProvider(params));
              },
              child: Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, CupMatchModel match) {
    final hasScore = match.homeScore != null && match.awayScore != null;
    final hasExtraTime = (match.homeExtraTimeScore ?? 0) > 0 ||
        (match.awayExtraTimeScore ?? 0) > 0;
    final hasPenalties =
        (match.homePenaltyScore ?? 0) > 0 || (match.awayPenaltyScore ?? 0) > 0;
    final venueText = match.venue ?? match.fieldName ?? match.city;
    final homeWins =
        match.winnerId != null && match.winnerId == match.homeTeamId;
    final awayWins =
        match.winnerId != null && match.winnerId == match.awayTeamId;

    return GestureDetector(
      onTap: () {
        final matchId = match.effectiveId;
        if (matchId.isEmpty) return;
        context.push(
          AppRoutes.liveMatchDetails.replaceFirst(':matchId', matchId),
          extra: {
            'tournamentId': tournamentId,
            'preferMatchData': true,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Home team
              Expanded(
                flex: 3,
                child: _buildTeamColumn(
                  name: match.homeTeamName,
                  logo: match.homeTeamLogo,
                  isWinner: homeWins,
                ),
              ),

              // Center: venue, score, date, time
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (venueText != null && venueText.isNotEmpty) ...[
                      Text(
                        venueText.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                    ],
                    // Score or VS
                    Text(
                      hasScore
                          ? '${match.homeScore}  :  ${match.awayScore}'
                          : 'VS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: hasScore ? 28 : 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.socaBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Extra time & penalty
                    if (hasScore && (hasExtraTime || hasPenalties)) ...[
                      const SizedBox(height: 4),
                      if (hasExtraTime)
                        Text(
                          'ET  ${match.homeExtraTimeScore ?? 0}  :  ${match.awayExtraTimeScore ?? 0}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      if (hasPenalties)
                        Text(
                          'Pen  ${match.homePenaltyScore ?? 0}  :  ${match.awayPenaltyScore ?? 0}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                    const SizedBox(height: 8),
                    if (match.matchDate != null && match.matchDate!.isNotEmpty)
                      Text(
                        match.matchDate!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    if (match.matchTime != null && match.matchTime!.isNotEmpty)
                      Text(
                        match.matchTime!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),

              // Away team
              Expanded(
                flex: 3,
                child: _buildTeamColumn(
                  name: match.awayTeamName,
                  logo: match.awayTeamLogo,
                  isWinner: awayWins,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamColumn({
    required String? name,
    required String? logo,
    required bool isWinner,
  }) {
    return Column(
      children: [
        Stack(
          children: [
            ClipOval(child: _buildTeamLogo(logo, 52)),
            if (isWinner)
              const Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.emoji_events,
                  color: AppColors.socaYellow,
                  size: 18,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name ?? 'TBD',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: isWinner ? FontWeight.w700 : FontWeight.w600,
            fontSize: 12,
            color: AppColors.socaBlack,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildTeamLogo(String? logoUrl, double size) {
    final fullImageUrl = ApiConstants.getImageUrl(logoUrl);
    if (fullImageUrl.isEmpty) {
      return _fallbackLogo(size);
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
      errorWidget: (context, url, error) => _fallbackLogo(size),
    );
  }

  Widget _fallbackLogo(double size) {
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
