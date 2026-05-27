import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';

/// Mirrors fragment_login_landing.xml exactly.
///
/// Layout:
///   • Background: #F6F6F6 (new_white)
///   • Logo 150×150dp centred, marginTop 50dp
///   • "Login" button — outlined (1dp black stroke, transparent fill, 5dp radius) — height 80dp, hPad 50dp
///   • "or" divider line
///   • "Sign Up" button — filled black, 5dp radius — height 80dp, hPad 50dp, yellow text
///   • Privacy text pinned at bottom of screen
class LoginLandingScreen extends StatelessWidget {
  LoginLandingScreen({super.key});

  static Color _black = AppColors.socaBlack; // #1C1C1C
  static Color _yellow = AppColors.socaYellow; // #EEFF41
  static Color _pageBg = AppColors.socaPageBg; // #F6F6F6

  static String _privacyText =
      '*SocaLoca only collects the data is necessary to provides its service and\n'
      'stores it in the anonymised way in our own self-hosted analytics system.';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: _pageBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    // Logo  — 150×150dp, centred, marginTop 50dp
                    SizedBox(height: height * .17),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/socaloca_logo.svg',
                        width: 180,
                        // height: 150,
                        // fit: BoxFit.contain,
                      ),
                    ),

                    // Buttons block — marginTop 50dp
                    SizedBox(height: height * .12),

                    // ── LOGIN button — outlined stroke, no fill ───────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.login),
                        child: Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: _black, width: 1),
                          ),
                          child: Text(
                            'Login'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: _black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ── OR divider ────────────────────────────────────────
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Full-width line
                          Container(height: 0.5, color: _black),
                          // "or" text with page-bg background to mask line
                          Container(
                            color: _pageBg,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'or'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: _black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── SIGN UP button — filled black ─────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.ageSelection),
                        child: Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Sign Up'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: _yellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Privacy text — pinned at bottom ──────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Text(
                _privacyText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 8,
                  color: _black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
