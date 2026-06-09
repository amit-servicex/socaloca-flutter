import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/match_training_status_model.dart';
import '../data/models/player_bio_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// My Matches Section for Endorse Tab
/// Shows Football and Futsal matches separately
class MyMatchesSection extends StatelessWidget {
  final MatchTrainingStatusModel? footballMatches;
  final MatchTrainingStatusModel? futsalMatches;
  final PlayerBioModel playerBio;
  final bool isOwnProfile;
  final bool isLoadingMatches;
  final VoidCallback? onAddFootball;
  final VoidCallback? onAddFutsal;

  MyMatchesSection({
    super.key,
    required this.footballMatches,
    required this.futsalMatches,
    required this.playerBio,
    required this.isOwnProfile,
    required this.isLoadingMatches,
    this.onAddFootball,
    this.onAddFutsal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMatchSection(context, 'Football', footballMatches, onAddFootball),
        SizedBox(height: 16),
        _buildMatchSection(context, 'Futsal', futsalMatches, onAddFutsal),
      ],
    );
  }

  Widget _buildMatchSection(
    BuildContext context,
    String type,
    MatchTrainingStatusModel? matches,
    VoidCallback? onAdd,
  ) {
    final isGoalkeeper = playerBio.playPosition?.toLowerCase() == 'goalkeeper';

    return Column(
      children: [
        SizedBox(height: 25),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: isLoadingMatches
                  ? AppLoader()
                  : Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildStatItem(
                                      'Number of matches',
                                      matches?.matches?.toString() ?? '0',
                                    ),
                                    SizedBox(height: 16),
                                    _buildStatItem(
                                      'Minutes played',
                                      matches?.mins?.toString() ?? '0',
                                    ),
                                    SizedBox(height: 16),
                                    _buildStatItem(
                                      'Number of goals',
                                      matches?.goals?.toString() ?? '0',
                                    ),
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
                                      isGoalkeeper
                                          ? 'Number of clean sheet'
                                          : 'Number of assists',
                                      isGoalkeeper
                                          ? (matches?.cleanSheetCount
                                                  ?.toString() ??
                                              '0')
                                          : (matches?.assists?.toString() ??
                                              '0'),
                                    ),
                                    SizedBox(height: 16),
                                    _buildStatItem(
                                      'Average match rating',
                                      matches?.rating != null
                                          ? matches!.rating!.toStringAsFixed(2)
                                          : '0.00',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isOwnProfile && onAdd != null) ...[
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: onAdd,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.socaBlack,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'ADD'.tr,
                                style: TextStyle(
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
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'MY MATCHES'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaYellow,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$type, ${matches?.year ?? DateTime.now().year}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(
                          AppRoutes.playerStats.replaceFirst(
                            ':userId',
                            playerBio?.userId ?? '',
                          ),
                        );
                      },
                      child: Text(
                        AppStrings.viewAll,
                        style: TextStyle(
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

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: AppColors.socaBlack,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
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
