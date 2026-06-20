import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';

/// Feedback banner matching Android CommonHomeActivity feedbackBox.
/// Hidden by default; shown when user hasn't given feedback in 30+ days.
class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 20,
              color: AppColors.socaBlack,
            ),
            const SizedBox(width: 10),
            Text(
              AppStrings.helpUsToImprove,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: AppColors.socaBlack,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  AppStrings.feedbackUpper,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: AppColors.socaYellow,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
