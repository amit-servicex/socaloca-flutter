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
                'Skills & Ratings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              if (skills.isNotEmpty && !isLoadingSkills)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all skills
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
          const SizedBox(height: 12),

          if (isLoadingSkills)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: AppColors.socaYellow,
                ),
              ),
            )
          else if (skills.isEmpty)
            Column(
              children: [
                const Text(
                  'No ratings available',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaGrey,
                  ),
                ),
                if (!isOwnProfile) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to rate player
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
                      'Rate',
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
            Column(
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
        ],
      ),
    );
  }
}
