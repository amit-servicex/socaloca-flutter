import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/match_training_status_model.dart';

/// Training Stats Section for Endorse Tab
/// Shows current and previous month training stats
class TrainingStatsSection extends StatelessWidget {
  final MatchTrainingStatusModel? trainCurrMonth;
  final MatchTrainingStatusModel? trainPrevMonth;
  final bool isOwnProfile;
  final bool isLoadingMatches;

  const TrainingStatsSection({
    super.key,
    required this.trainCurrMonth,
    required this.trainPrevMonth,
    required this.isOwnProfile,
    required this.isLoadingMatches,
  });

  String _getMonthName(int? month) {
    if (month == null) return '';
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return month >= 1 && month <= 12 ? months[month - 1] : '';
  }

  @override
  Widget build(BuildContext context) {
    final hasData = (trainCurrMonth?.sessions ?? 0) > 0 ||
        (trainPrevMonth?.sessions ?? 0) > 0;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Training Stats Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              if (hasData)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all training stats
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          if (isLoadingMatches)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
            )
          else if (!hasData)
            Column(
              children: [
                const Text(
                  'No training stats available',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaGrey,
                  ),
                ),
                if (isOwnProfile) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to add training
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            )
          else
            Row(
              children: [
                // Previous Month
                Expanded(
                  child: _buildMonthColumn(
                    _getMonthName(trainPrevMonth?.month),
                    trainPrevMonth?.sessions ?? 0,
                    trainPrevMonth?.mins ?? 0,
                  ),
                ),

                const SizedBox(width: 20),

                // Current Month
                Expanded(
                  child: _buildMonthColumn(
                    _getMonthName(trainCurrMonth?.month),
                    trainCurrMonth?.sessions ?? 0,
                    trainCurrMonth?.mins ?? 0,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMonthColumn(String monthName, int sessions, int minutes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          monthName,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
        const SizedBox(height: 12),
        _buildStatItem('Number of Sessions', sessions.toString()),
        const SizedBox(height: 8),
        _buildStatItem('Training Minutes', minutes.toString()),
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
