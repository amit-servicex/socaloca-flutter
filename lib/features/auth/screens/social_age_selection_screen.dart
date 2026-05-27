import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

/// Social login age selection — mirrors SocialAgeSelectionFragment.
/// Adult (16+) → SocialThankYouScreen → CreateProfileScreen.
/// Youth/Child → existing consent flows.
class SocialAgeSelectionScreen extends ConsumerWidget {
  SocialAgeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/socaloca_logo.svg',
                  width: 200,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // Adult (16+)
                    InkWell(
                      onTap: () {
                        ref
                            .read(signupTempProvider.notifier)
                            .setAgeGroup('adult');
                        context.push(AppRoutes.socialThankYou);
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

                    // Youth (13-15)
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

                    // Child (7-12) — parent/guardian registers
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
                              'I am a parent/guardian\nregistering on behalf of a'.tr,
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

/// Shown after adult age selection during social login.
/// "Thank you" message + "Create Profile" button → CreateProfileScreen.
class SocialThankYouScreen extends StatelessWidget {
  SocialThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: 60),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/socaloca_logo.svg',
                  width: 200,
                ),
              ),
              SizedBox(height: 60),
              Text(
                'Thank you for joining SocaLoca!'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Please create your profile to get started.'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: AppColors.socaBlack,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () => context.push(AppRoutes.createProfile),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'CREATE PROFILE'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
