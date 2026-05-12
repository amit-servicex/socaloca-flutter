import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/player_skill_model.dart';

/// Player Skills/Ratings Section for Endorse Tab
/// Shows list of skills with ratings and overall rating
class PlayerSkillsSection extends StatelessWidget {
  final List<PlayerSkillModel> skills;
  final double? overallRating;
  final bool isLoadingSkills;
  final bool isOwnProfile;

  const PlayerSkillsSection({
    super.key,
    required this.skills,
    required this.overallRating,
    required this.isLoadingSkills,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingSkills) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: AppColors.socaYellow,
          ),
        ),
      );
    }

    if (skills.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Overall Rating
                  if (overallRating != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.socaYellow.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Overall Rating',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.socaBlack,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                overallRating!.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.socaBlack,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.star,
                                color: AppColors.socaYellow,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 12),

                  // Skills List
                  ...skills.map((skill) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skill.skillName ?? '',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: AppColors.socaBlack,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  skill.rating?.toStringAsFixed(1) ?? '0.0',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.socaBlack,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.star,
                                  color: AppColors.socaYellow,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),

                  // Rate Button for other profiles
                  if (!isOwnProfile) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Navigate to rate player
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.socaBlack),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Rate Player',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.socaBlack,
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
                      child: const Text(
                        'SKILLS & RATINGS',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                    if (skills.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          // TODO: Navigate to all skills
                        },
                        child: const Text(
                          'view all',
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
}
