import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Section header widget for club bio screen
class ClubBioSectionHeader extends StatelessWidget {
  final String title;

  const ClubBioSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}
