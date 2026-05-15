import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/player_skill_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

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

  String _fmt(double? v) => (v == null || v == 0) ? '-' : v.toStringAsFixed(1);
  String _fmtInt(int? v) => (v == null || v == 0) ? '-' : '$v';

  @override
  Widget build(BuildContext context) {
    if (isLoadingSkills) {
      return const AppLoader();
    }

    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'RATINGS',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
            const Text(
              'view all',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Container(
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
                        'Average Rating | Endorsed By',
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
      ],
    );
  }

  Widget _buildRow(PlayerSkillModel skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.25), width: 0.8),
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
            '|',
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
