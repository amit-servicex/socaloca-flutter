import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/api_constants.dart';
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
  const HomeDrawer({super.key});

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

    if (user == null) return const SizedBox.shrink();

    final socaId =
        user.sclId?.isNotEmpty == true ? user.sclId! : 'SCL${user.id}';
    final bioState = ref.watch(playerBioProvider(user.id));
    // log("this is the user profile ${user.profileImage}");
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [
            // ── Profile section (220 dp, black bg) ─────────────────────────
            Container(
              height: 280,
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 100 dp circular avatar
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.socaGrey,
                      backgroundImage: (user.profileImage?.isEmpty ?? true)
                          ? Image.asset("assets/images/avatar1.png").image
                          : NetworkImage(ApiConstants.getImageUrl(
                              user.profileImage ?? '')),
                      // : null,
                      // child: (user.profileImage?.isEmpty ?? true)
                      //     ? Text(
                      //         user.name?.isNotEmpty == true
                      //             ? user.name![0].toUpperCase()
                      //             : 'S',
                      //         style: TextStyle(
                      //           fontSize: 36,
                      //           fontWeight: FontWeight.bold,
                      //           color: AppColors.socaBlack,
                      //         ),
                      //       )
                      //     : null,
                    ),
                    const SizedBox(height: 10),
                    // Full name — yellow
                    Text(
                      user.name ?? AppStrings.socaLocaUser,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: AppColors.socaYellow,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // SocaLoca ID label (white) + value (yellow) + copy icon (27 dp)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.socaLocaIdLabel,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              socaId,
                              style: const TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.socaYellow,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: socaId));
                                AppSnackBar.showSuccess(
                                    context, AppStrings.socaLocaIdCopied);
                              },
                              child: const Padding(
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
                    if (user.isReferee == false && user.isFan == false) ...[
                      _DrawerMenuItem(
                        icon: Image.asset(
                          "assets/icons/trials.png",
                          width: 24,
                          height: 24,
                        ),
                        title: AppStrings.trials,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.trials);
                        },
                      ),
                      _DrawerMenuItem(
                        icon: Image.asset(
                          "assets/icons/ic_gallery_new.png",
                          width: 24,
                          height: 24,
                        ),
                        title: AppStrings.myGallery,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(
                            AppRoutes.myPosts,
                            extra: {
                              'userId': user.id,
                              'isOwnProfile': true,
                            },
                          );
                        },
                      ),
                    ],
                    _DrawerMenuItem(
                      icon: Image.asset(
                        "assets/icons/ic_update_profile.png",
                        width: 24,
                        height: 24,
                      ),
                      title: AppStrings.updateProfile,
                      onTap: () {
                        final playerBio = bioState.playerBio;
                        if (playerBio == null) {
                          AppSnackBar.showSuccess(
                              context, AppStrings.loadingProfilePleaseTryAgain);
                          return;
                        }
                        Navigator.of(context).pop();
                        context.push(AppRoutes.editProfile, extra: playerBio);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Image.asset(
                        "assets/icons/ic_change_20password.png",
                        width: 24,
                        height: 24,
                      ),
                      title: AppStrings.changePassword,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push(AppRoutes.changePassword);
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Image.asset(
                        "assets/icons/ic_change_language.png",
                        width: 24,
                        height: 24,
                      ),
                      title: AppStrings.changeLanguage,
                      onTap: () {
                        Navigator.of(context).pop();
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
                      icon: Image.asset(
                        "assets/icons/ic_helpdesk.png",
                        width: 24,
                        height: 24,
                      ),
                      title: AppStrings.helpDesk,
                      onTap: () {
                        Navigator.of(context).pop();
                        launchUrl(
                          Uri.parse(
                              'https://organise.socaloca.football/support.php'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    _DrawerMenuItem(
                      icon: Image.asset(
                        "assets/icons/ic_settings.png",
                        width: 24,
                        height: 24,
                      ),
                      title: AppStrings.privacySettings,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push(AppRoutes.privacySettings);
                      },
                    ),

                    if (user.isReferee == false && user.isFan == false) ...[
                      _DrawerMenuItem(
                        icon: Image.asset(
                          "assets/icons/help_us_to_improve.png",
                          width: 24,
                          height: 24,
                        ),
                        title: AppStrings.helpUsToImprove,
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.survey);
                        },
                      ),
                    ],
                    // Legal links row — "Data Policy | Terms & Conditions"
                    // Divider(
                    //     height: 1, thickness: 0.5, color: AppColors.socaBlack),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    //   child: Row(
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           Navigator.of(context).pop();
                    //           launchUrl(
                    //             Uri.parse(
                    //                 'https://socaloca.football/privacy-policy/'),
                    //             mode: LaunchMode.externalApplication,
                    //           );
                    //         },
                    //         child: Text(
                    //           AppStrings.dataPolicy,
                    //           style: TextStyle(
                    //             fontFamily: 'Lato',
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 14,
                    //             color: AppColors.socaBlack,
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 8),
                    //         child: Text(
                    //           '|'.tr,
                    //           style: TextStyle(
                    //             fontSize: 14,
                    //             color: AppColors.socaBlack,
                    //           ),
                    //         ),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           Navigator.of(context).pop();
                    //           launchUrl(
                    //             Uri.parse(
                    //                 'https://socaloca.football/terms-of-service/'),
                    //             mode: LaunchMode.externalApplication,
                    //           );
                    //         },
                    //         child: Text(
                    //           AppStrings.termsAndConditions,
                    //           style: TextStyle(
                    //             fontFamily: 'Lato',
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 14,
                    //             color: AppColors.socaBlack,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
            //       Navigator.of(context).pop();
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
  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Image icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Row(
              children: [
                const SizedBox(width: 20),
                icon,
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
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
        const Divider(
          height: 1,
          thickness: 0.5,
          color: AppColors.socaBlack,
          indent: 0,
        ),
      ],
    );
  }
}
