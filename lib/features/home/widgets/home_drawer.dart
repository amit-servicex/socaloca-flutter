import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'language_selection_bottom_sheet.dart';

/// Right-side drawer matching Android common_menu.xml.
/// Width: 300 dp, profile section: 220 dp black background.
class HomeDrawer extends ConsumerStatefulWidget {
  HomeDrawer({super.key});

  @override
  ConsumerState<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends ConsumerState<HomeDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = StorageService.userId;
      if (userId != null && userId.isNotEmpty) {
        ref.read(playerBioProvider(userId).notifier).load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final user = ref.watch(currentUserProvider);

    if (user == null) return SizedBox.shrink();

    final socaId =
        user.sclId?.isNotEmpty == true ? user.sclId! : 'SCL${user.id}';
    final bioState = ref.watch(playerBioProvider(user.id));

    return SafeArea(
      child: Drawer(
        width: 300,
        child: Column(
          children: [
            // ── Profile section (220 dp, black bg) ─────────────────────────
            Container(
              height: 250,
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 100 dp circular avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.socaGrey,
                      backgroundImage: user.profileImage != null
                          ? NetworkImage(user.profileImage!)
                          : null,
                      child: user.profileImage == null
                          ? Text(
                              user.name?.isNotEmpty == true
                                  ? user.name![0].toUpperCase()
                                  : 'S',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppColors.socaBlack,
                              ),
                            )
                          : null,
                    ),
                    SizedBox(height: 10),
                    // Full name — yellow
                    Text(
                      user.name ?? 'SocaLoca User',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.socaYellow,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    // SocaLoca ID label (white) + value (yellow) + copy icon (27 dp)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SocaLoca ID: '.tr,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          socaId,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: AppColors.socaYellow,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: socaId));
                            AppSnackBar.showSuccess(
                                context, 'SocaLoca ID copied');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.copy,
                              size: 27,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Menu items ──────────────────────────────────────────────────
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _DrawerMenuItem(
                      icon: Icons.sports_soccer,
                      title: AppStrings.trials,
                      onTap: () {
                        context.pop();
                        context.push(AppRoutes.trials);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.photo_library_outlined,
                      title: AppStrings.myGallery,
                      onTap: () {
                        context.pop();
                        context.push(AppRoutes.gallery);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.edit_outlined,
                      title: AppStrings.updateProfile,
                      onTap: () {
                        final playerBio = bioState.playerBio;
                        if (playerBio == null) {
                          AppSnackBar.showSuccess(
                              context, 'Loading profile, please try again');
                          return;
                        }
                        context.pop();
                        context.push(AppRoutes.editProfile, extra: playerBio);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.lock_outline,
                      title: AppStrings.changePassword,
                      onTap: () {
                        context.pop();
                        context.push(AppRoutes.changePassword);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.language,
                      title: AppStrings.changeLanguage,
                      onTap: () {
                        context.pop();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => LanguageSelectionBottomSheet(
                            onLanguageSelected: (code, name) {},
                          ),
                        );
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.headset_mic_outlined,
                      title: AppStrings.helpDesk,
                      onTap: () {
                        context.pop();
                        launchUrl(
                          Uri.parse(
                              'https://organise.socaloca.football/support.php'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: AppStrings.privacySettings,
                      onTap: () {
                        context.pop();
                        context.push(AppRoutes.privacySettings);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Icons.feedback_outlined,
                      title: AppStrings.helpUsToImprove,
                      onTap: () {
                        context.pop();
                        AppSnackBar.showSuccess(context, 'Coming soon');
                      },
                    ),

                    // Legal links row — "Data Policy | Terms & Conditions"
                    Divider(
                        height: 1, thickness: 0.5, color: AppColors.socaBlack),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pop();
                              launchUrl(
                                Uri.parse(
                                    'https://socaloca.football/privacy-policy/'),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Text(
                              AppStrings.dataPolicy,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|'.tr,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pop();
                              launchUrl(
                                Uri.parse(
                                    'https://socaloca.football/terms-of-service/'),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Text(
                              AppStrings.termsAndConditions,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.socaBlack,
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

            // ── Sign Out ────────────────────────────────────────────────────
            // Container(
            //   color: Colors.white,
            //   padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       context.pop();
            //       await ref.read(authStateProvider.notifier).logout();
            //       if (context.mounted) {
            //         context.go(AppRoutes.roleChoice);
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.socaBlack,
            //       foregroundColor: AppColors.socaYellow,
            //       minimumSize: Size(double.infinity, 48),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: Text(
            //       AppStrings.signOutUpper,
            //       style: TextStyle(
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.w700,
            //         fontSize: 14,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: SafeArea(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(icon, size: 22, color: AppColors.socaBlack),
                  SizedBox(width: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: AppColors.socaBlack,
          indent: 20,
        ),
      ],
    );
  }
}
