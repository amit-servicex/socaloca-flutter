import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A small coloured pill badge — used for match status, user type, etc.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.color,
    this.textColor = Colors.white,
    this.fontSize = 10,
  });

  final String label;
  final Color? color;
  final Color textColor;
  final double fontSize;

  /// Convenience factory for match status
  factory StatusBadge.matchStatus(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'live':
        color = AppColors.liveRed;
        break;
      case 'upcoming':
        color = AppColors.upcomingBlue;
        break;
      case 'played':
        color = AppColors.playedGray;
        break;
      default:
        color = AppColors.textSecondary;
    }
    return StatusBadge(label: status.toUpperCase(), color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color ?? AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
