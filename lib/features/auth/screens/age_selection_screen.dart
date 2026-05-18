import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

/// AgeSelectionFragment equivalent - matches Android XML layout exactly
/// User selects age group: Adult (16+), Youth (13-15), or Child (7-12)
class AgeSelectionScreen extends ConsumerWidget {
  AgeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg, // new_white
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo Box - marginTop 50dp
              SizedBox(height: 50),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/socaloca_logo.svg',
                  width: 200,
                  // height: 150,
                  // fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              // Top Box - marginLeft/Right 40dp
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // Adult Button - 16+ years old
                    InkWell(
                      onTap: () {
                        ref
                            .read(signupTempProvider.notifier)
                            .setAgeGroup('adult');
                        context.push(AppRoutes.signup);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I am over'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: AppColors.socaYellow,
                                height: 1.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '16 years'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'old'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Youth Button - 13-15 years old
                    InkWell(
                      onTap: () {
                        ref
                            .read(signupTempProvider.notifier)
                            .setAgeGroup('youth');
                        context.push(AppRoutes.youthConsent);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I am'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: AppColors.socaYellow,
                                height: 1.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '13-15 years'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'old'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Child Button - 7-12 years old (parent/guardian)
                    InkWell(
                      onTap: () {
                        ref
                            .read(signupTempProvider.notifier)
                            .setAgeGroup('child');
                        context.push(AppRoutes.childConsent);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I am a parent/guardian\nregistering on behalf of a'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.socaYellow,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '7-12'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'years'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'old'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.socaYellow,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
