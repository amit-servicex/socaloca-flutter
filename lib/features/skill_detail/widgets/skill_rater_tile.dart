import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/skill_rater_model.dart';

/// One row in a skill rater list — avatar, name, subtitle, rating, online dot.
/// Mirrors skill_coach_cell.xml / skill_player_cell.xml.
class SkillRaterTile extends StatelessWidget {
  final SkillRaterModel rater;
  final bool showPosition;
  final bool isLast;

  const SkillRaterTile({
    super.key,
    required this.rater,
    this.showPosition = false,
    this.isLast = false,
  });

  String get _subtitle {
    if (showPosition &&
        rater.playPosition != null &&
        rater.playPosition!.isNotEmpty) {
      return '${rater.playPosition} · ${rater.country}';
    }
    return rater.country;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              // Avatar with online dot
              Stack(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: ClipOval(
                      child:
                          rater.imageUrl != null && rater.imageUrl!.isNotEmpty
                              ? Image.network(
                                  rater.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                )
                              : const Icon(Icons.person,
                                  size: 24, color: Colors.grey),
                    ),
                  ),
                  if (rater.isOnline)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),

              // Name + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${rater.firstName} ${rater.lastName}'.trim(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    if (_subtitle.isNotEmpty)
                      Text(
                        _subtitle,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),

              // Rating value
              Text(
                '${rater.rating}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaBlack,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 0.5, color: Colors.black12),
      ],
    );
  }
}
