import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/game_stats_model.dart';
import '../data/models/player_bio_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Competition Stats Summary Section for Endorse Tab
/// Shows current year stats without year dropdown
class CompetitionStatsSummarySection extends StatelessWidget {
  final GameStatsModel? footballStats;
  final GameStatsModel? futsalStats;
  final PlayerBioModel playerBio;
  final bool isLoadingStats;

  const CompetitionStatsSummarySection({
    super.key,
    required this.footballStats,
    required this.futsalStats,
    required this.playerBio,
    required this.isLoadingStats,
  });

  @override
  Widget build(BuildContext context) {
    final isGoalkeeper = playerBio.playPosition?.toLowerCase() == 'goalkeeper';

    return Column(
      children: [
        _buildCompetitionSection(
            context, 'Football', footballStats, isGoalkeeper),
        const SizedBox(height: 16),
        _buildCompetitionSection(context, 'Futsal', futsalStats, isGoalkeeper),
      ],
    );
  }

  Widget _buildCompetitionSection(
    BuildContext context,
    String type,
    GameStatsModel? stats,
    bool isGoalkeeper,
  ) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoadingStats
                  ? const AppLoader()
                  : IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildStatItem('Appearances',
                                    stats?.matchCount.toString() ?? '0'),
                                const SizedBox(height: 16),
                                _buildStatItem('Goals',
                                    stats?.goalCount.toString() ?? '0'),
                                const SizedBox(height: 16),
                                _buildStatItem(
                                    'POM', stats?.mvpCount.toString() ?? '0'),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.socaBlack.withOpacity(0.5),
                            thickness: 1,
                            width: 32,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildStatItem(
                                  isGoalkeeper ? 'Clean Sheets' : 'Assists',
                                  isGoalkeeper
                                      ? (stats?.cleanSheetCount.toString() ??
                                          '0')
                                      : (stats?.assistCount.toString() ?? '0'),
                                ),
                                const SizedBox(height: 16),
                                _buildStatItem('Yellow Cards',
                                    stats?.yellowCardCount.toString() ?? '0'),
                                const SizedBox(height: 16),
                                _buildStatItem('Red Cards',
                                    stats?.redCardCount.toString() ?? '0'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Positioned(
              top: -20,
              left: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'COMPETITION STATS'.tr,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaYellow,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$type, ${DateTime.now().year}',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to past years
                      },
                      child: Text(
                        'past years'.tr,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}
