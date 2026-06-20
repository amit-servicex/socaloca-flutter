import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/match_training_status_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Training Stats Section for Endorse Tab
/// Shows current and previous month training stats
class TrainingStatsSection extends StatelessWidget {
  final MatchTrainingStatusModel? trainCurrMonth;
  final MatchTrainingStatusModel? trainPrevMonth;
  final bool isOwnProfile;
  final bool isLoadingMatches;
  final VoidCallback? onAdd;

  const TrainingStatsSection({
    super.key,
    required this.trainCurrMonth,
    required this.trainPrevMonth,
    required this.isOwnProfile,
    required this.isLoadingMatches,
    this.onAdd,
  });

  String _getMonthName(int? month) {
    if (month == null) return '';
    final months = [
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
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
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
              child: isLoadingMatches
                  ? const AppLoader()
                  : Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Previous Month
                              Expanded(
                                child: _buildMonthColumn(
                                  _getMonthName(trainPrevMonth?.month),
                                  trainPrevMonth?.sessions ?? 0,
                                  trainPrevMonth?.mins ?? 0,
                                ),
                              ),
                              VerticalDivider(
                                color: AppColors.socaBlack.withOpacity(0.5),
                                thickness: 1,
                                width: 32,
                              ),
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
                        ),
                        if (isOwnProfile && onAdd != null) ...[
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: onAdd,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.socaBlack,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'ADD'.tr,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.socaYellow,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
            Positioned(
              top: -30,
              left: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'TRAINING STATS'.tr,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to all stats
                      },
                      child: Text(
                        'view all'.tr,
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthColumn(String monthName, int sessions, int minutes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          monthName.isNotEmpty ? monthName : 'Month',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
        const SizedBox(height: 12),
        _buildStatItem('Number of Sessions', sessions.toString()),
        const SizedBox(height: 16),
        _buildStatItem('Training Minutes', minutes.toString()),
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
