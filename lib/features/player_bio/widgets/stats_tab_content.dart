import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/game_stats_model.dart';
import '../data/models/player_bio_model.dart';
import '../providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Stats tab content showing Football and Futsal statistics.
/// Set [embedded] = true when placed inside a parent scroll view — content
/// renders as a plain Column with padding instead of its own scroll.
class StatsTabContent extends ConsumerWidget {
  final String playerId;
  final PlayerBioModel playerBio;
  final bool embedded;

  StatsTabContent({
    super.key,
    required this.playerId,
    required this.playerBio,
    this.embedded = false,
  });

  bool _isGoalkeeper() {
    final position = playerBio.playPosition?.toLowerCase() ?? '';
    return position == 'goalkeeper';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerBioProvider(playerId));
    final isGoalkeeper = _isGoalkeeper();

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsSection(
          context: context,
          ref: ref,
          title: 'FOOTBALL',
          stats: state.footballStats,
          isGoalkeeper: isGoalkeeper,
          isLoading: state.isLoadingStats,
          year: state.selectedYear,
          onYearTap: () => _showYearPicker(context, ref),
        ),
        SizedBox(height: 20),
        _buildStatsSection(
          context: context,
          ref: ref,
          title: 'FUTSAL',
          stats: state.futsalStats,
          isGoalkeeper: isGoalkeeper,
          isLoading: state.isLoadingStats,
          year: state.selectedYear,
          onYearTap: () => _showYearPicker(context, ref),
        ),
      ],
    );

    if (embedded) {
      return Padding(padding: EdgeInsets.all(20), child: content);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: content,
    );
  }

  Widget _buildStatsSection({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required GameStatsModel? stats,
    required bool isGoalkeeper,
    required bool isLoading,
    required int year,
    required VoidCallback onYearTap,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and year
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              GestureDetector(
                onTap: onYearTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text(
                        year.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                        color: AppColors.socaBlack,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          if (isLoading)
            AppLoader()
          else if (stats == null)
            Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No stats available for this year'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaGrey,
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                // Appearances
                _buildStatRow(
                  label: 'Appearances',
                  value: stats.matchCount.toString(),
                ),

                // Goals
                _buildStatRow(
                  label: 'Goals',
                  value: stats.goalCount.toString(),
                ),

                // MVP
                _buildStatRow(
                  label: 'MVP',
                  value: stats.mvpCount.toString(),
                ),

                // Assists or Clean Sheets (based on position)
                _buildStatRow(
                  label: isGoalkeeper ? 'Clean Sheets' : 'Assists',
                  value: isGoalkeeper
                      ? stats.cleanSheetCount.toString()
                      : stats.assistCount.toString(),
                ),

                // Yellow Cards
                _buildStatRow(
                  label: 'Yellow Cards',
                  value: stats.yellowCardCount.toString(),
                ),

                // Red Cards
                _buildStatRow(
                  label: 'Red Cards',
                  value: stats.redCardCount.toString(),
                  isLast: true,
                ),
              ],
            ),

          // Past Years link
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to all stats screen
            },
            child: Text(
              'View Past Years →'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.socaYellow,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }

  void _showYearPicker(BuildContext context, WidgetRef ref) {
    final currentYear = DateTime.now().year;
    final years = List.generate(10, (index) => currentYear - index);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Year'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),
            SizedBox(height: 20),
            ...years.map((year) => ListTile(
                  title: Text(
                    year.toString(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    ref
                        .read(playerBioProvider(playerId).notifier)
                        .loadStats(year);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
