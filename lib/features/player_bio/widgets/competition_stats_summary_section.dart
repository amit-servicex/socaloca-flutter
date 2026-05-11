import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/game_stats_model.dart';
import '../data/models/player_bio_model.dart';

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

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Competition Stats',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 16),

          if (isLoadingStats)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
            )
          else ...[
            // Football Section
            _buildStatsSection(
              'Football',
              footballStats,
              isGoalkeeper,
            ),

            const SizedBox(height: 20),

            // Futsal Section
            _buildStatsSection(
              'Futsal',
              futsalStats,
              isGoalkeeper,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsSection(
    String title,
    GameStatsModel? stats,
    bool isGoalkeeper,
  ) {
    if (stats == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No stats available',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaGrey,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatItem('Matches', stats.matchCount.toString()),
            ),
            Expanded(
              child: _buildStatItem('Goals', stats.goalCount.toString()),
            ),
            Expanded(
              child: _buildStatItem(
                isGoalkeeper ? 'Clean Sheets' : 'Assists',
                isGoalkeeper
                    ? stats.cleanSheetCount.toString()
                    : stats.assistCount.toString(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatItem('Yellow Cards', stats.yellowCardCount.toString()),
            ),
            Expanded(
              child: _buildStatItem('Red Cards', stats.redCardCount.toString()),
            ),
            Expanded(
              child: _buildStatItem('MVP', stats.mvpCount.toString()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: AppColors.socaGrey,
          ),
        ),
        const SizedBox(height: 4),
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
