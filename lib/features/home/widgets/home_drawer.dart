import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';

/// Right-side drawer matching Android common_menu.xml.
/// Width: 300 dp, profile section: 220 dp black background.
class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null) return const SizedBox.shrink();

    final socaId = user.username ?? 'SCL${user.id}';

    return Drawer(
      width: 300,
      child: Column(
        children: [
          // ── Profile section (220 dp, black bg) ─────────────────────────
          Container(
            height: 220,
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
                    radius: 50,
                    backgroundColor: AppColors.socaGrey,
                    backgroundImage: user.profileImage != null
                        ? NetworkImage(user.profileImage!)
                        : null,
                    child: user.profileImage == null
                        ? Text(
                            user.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.socaBlack,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 10),
                  // Full name — yellow
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.socaYellow,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // SocaLoca ID label (white) + value (yellow) + copy icon (27 dp)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'SocaLoca ID: ',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        socaId,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaYellow,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: socaId));
                          AppSnackBar.showSuccess(
                              context, 'SocaLoca ID copied');
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
                    title: 'Trials',
                    onTap: () {
                      context.pop();
                      context.push(AppRoutes.trials);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.photo_library_outlined,
                    title: 'My Gallery',
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.edit_outlined,
                    title: 'Update Profile',
                    onTap: () {
                      context.pop();
                      context.push(AppRoutes.profile);
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.language,
                    title: 'Change Language',
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.headset_mic_outlined,
                    title: 'Help Desk',
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Settings',
                    onTap: () {
                      context.pop();
                    },
                  ),
                  _DrawerMenuItem(
                    icon: Icons.feedback_outlined,
                    title: 'Help Us To Improve',
                    onTap: () {
                      context.pop();
                    },
                  ),

                  // Legal links row — "Data Policy | Terms & Conditions"
                  const Divider(
                      height: 1, thickness: 0.5, color: AppColors.socaBlack),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Text(
                            'Data Policy',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '|',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Text(
                            'Terms & Conditions',
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
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () async {
                context.pop();
                await ref.read(authStateProvider.notifier).logout();
                if (context.mounted) {
                  context.go(AppRoutes.loginLanding);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'SIGN OUT',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
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
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Icon(icon, size: 22, color: AppColors.socaBlack),
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
          indent: 20,
        ),
      ],
    );
  }
}
