import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';

/// Live match banner matching Android CommonHomeActivity LiveMatchBox.
/// Always visible at the bottom of the home screen body.
class LiveMatchBanner extends StatelessWidget {
  const LiveMatchBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 3),
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
            Image.asset(
              'assets/images/sl_live.gif',
              height: 30,
              width: 70,
            ),
            const SizedBox(width: 10),
            Text(
              AppStrings.liveMatchUpdate,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
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
                  AppStrings.viewUpper,
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
