import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:socaloca/features/my_bio/screens/my_skill_ratings_screen.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/player_skill_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class PlayerSkillsSection extends StatelessWidget {
  final List<PlayerSkillModel> skills;
  final double? overallRating;
  final bool isLoadingSkills;
  final bool isOwnProfile;
  final String userid;
  const PlayerSkillsSection(
      {super.key,
      required this.skills,
      required this.overallRating,
      required this.isLoadingSkills,
      required this.isOwnProfile,
      required this.userid});

  String _fmt(double? v) => (v == null || v == 0) ? '-' : v.toStringAsFixed(1);
  String _fmtInt(int? v) => (v == null || v == 0) ? '-' : '$v';

  @override
  Widget build(BuildContext context) {
    if (isLoadingSkills) {
      return const AppLoader();
    }

    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Stack(
          children: [
            // Header row

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.socaGrey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Column headers
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: 110,
                            child: Text(
                              'Average Rating | Endorsed By'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Skill rows
                    ...skills.map((skill) => _buildRow(skill)),

                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .85,
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
                        'RATINGS'.tr,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MySkillRatingsScreen(
                              userId: userid ?? '',
                            ),
                          ),
                        );
                        // context.push(
                        //   AppRoutes.playerStats.replaceFirst(
                        //     ':userId',
                        //     userid,
                        //   ),
                        // );
                      },
                      child: Text(
                        AppStrings.viewAll,
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

  Widget _buildRow(PlayerSkillModel skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.grey.withValues(alpha: 0.25), width: 0.8),
        ),
      ),
      child: Row(
        children: [
          // Skill name
          Expanded(
            child: Text(
              skill.skillName ?? '',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
          ),

          // Average Rating
          SizedBox(
            width: 55,
            child: Text(
              _fmt(skill.skillAvg),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),

          // Divider
          Text(
            '|'.tr,
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
          ),

          // Endorsed By (ratingCounter)
          SizedBox(
            width: 55,
            child: Text(
              _fmtInt(skill.ratingCounter),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
