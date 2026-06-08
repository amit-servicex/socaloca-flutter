import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_strings.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';

/// Mirrors Android CommonPrivacySettingsFragment.
/// Sections: About SocaLoca (expandable), Manage Account (expandable),
///           Data Privacy, Terms & Conditions, Sign Out.
class PrivacySettingsScreen extends ConsumerStatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  ConsumerState<PrivacySettingsScreen> createState() =>
      _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends ConsumerState<PrivacySettingsScreen> {
  bool _aboutExpanded = true;
  bool _manageExpanded = false;

  static const String _aboutText =
      'SocaLoca is the world\'s first global football social media platform '
      'dedicated to connecting players, clubs, coaches, referees, and fans. '
      'Our mission is to make football accessible to everyone, everywhere — '
      'from grassroots to professional. We provide tools for match management, '
      'player development, club administration, and community building within '
      'the beautiful game.';

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) AppSnackBar.showError(context, 'Could not open link');
    }
  }

  Future<void> _signOut() async {
    await ref.read(authStateProvider.notifier).logout();
    if (mounted) context.go(AppRoutes.roleChoice);
  }

  // ── Phase 1: Download Activity bottom sheet ────────────────────────────────

  void _showDownloadActivityDialog() {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final emailCtrl = TextEditingController(text: user.email ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (ctx) {
        String? emailError;
        bool isSubmitting = false;

        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            Future<void> handleSubmit() async {
              final email = emailCtrl.text.trim();
              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailRegex.hasMatch(email)) {
                setSheetState(
                    () => emailError = 'Please enter a valid email address');
                return;
              }
              setSheetState(() {
                emailError = null;
                isSubmitting = true;
              });
              try {
                await ApiClient.instance.post(
                  ApiConstants.downloadActivities,
                  body: {
                    'userId': user.id,
                    'firstName': user.firstName ?? '',
                    'lastName': user.lastName ?? '',
                    'imageUrl': user.profileImage ?? '',
                    'isPlayer': user.isPlayer,
                    'isCoach': user.isCoach,
                    'isAdmin': user.isAdmin,
                    'isFan': user.isFan,
                    'email': email,
                  },
                );
                if (ctx.mounted) Navigator.of(ctx).pop();
                if (mounted) {
                  AppSnackBar.showSuccess(context,
                      'Thank you for your request. Our team will contact you soon.');
                }
              } catch (_) {
                setSheetState(() => isSubmitting = false);
                if (mounted) {
                  AppSnackBar.showError(
                      context, 'Something went wrong. Please try again.');
                }
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Header ──────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Download Activities',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(ctx).pop(),
                            child: const Icon(Icons.close,
                                size: 22, color: AppColors.socaBlack),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 0.5, color: AppColors.socaBlack),

                    // ── Body ────────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SocaLoca is in compliance with GDPR practices to protect you the user!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'To request for your data, please fill in your email address here and we shall get back to you on how to pass the data to you.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Email field
                          TextField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack,
                            ),
                            decoration: InputDecoration(
                              hintText: AppStrings.email,
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF0F0F0),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: AppColors.socaBlack, width: 1),
                              ),
                            ),
                            onChanged: (_) {
                              if (emailError != null) {
                                setSheetState(() => emailError = null);
                              }
                            },
                          ),
                          if (emailError != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              emailError!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: isSubmitting
                                      ? null
                                      : () => Navigator.of(ctx).pop(),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: AppColors.socaBlack, width: 1.5),
                                    foregroundColor: AppColors.socaBlack,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed:
                                      isSubmitting ? null : handleSubmit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.socaBlack,
                                    foregroundColor: AppColors.socaYellow,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                  child: isSubmitting
                                      ? const SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.socaYellow,
                                          ),
                                        )
                                      : const Text(
                                          'SUBMIT',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ── Phase 2: Delete / Deactivate Account — two-step bottom sheet flow ───────

  void _showDeleteDeactivateChoiceDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Deactivate/Delete Account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(),
                      child: const Icon(Icons.close,
                          size: 22, color: AppColors.socaBlack),
                    ),
                  ],
                ),
              ),
              Container(height: 0.5, color: AppColors.socaBlack),

              // ── Body ──────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'We are sorry that you want to leave.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You may choose to either delete or deactivate your account.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Deletion will remove your account from the SocaLoca systems and you will not be able to use the account again.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Deactivation will make your account inactive. Should you want to reactivate your account, you just need to login to SocaLoca and your account will be restored.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Thank you.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.socaBlack,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              _showDeleteDeactivateConfirmDialog(
                                  permanent: true);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.socaBlack, width: 1.5),
                              foregroundColor: AppColors.socaBlack,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              _showDeleteDeactivateConfirmDialog(
                                  permanent: false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.socaBlack,
                              foregroundColor: AppColors.socaYellow,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            child: const Text(
                              'DEACTIVATE',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDeactivateConfirmDialog({required bool permanent}) {
    final action = permanent ? 'Delete' : 'Deactivate';
    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            Future<void> handleConfirm() async {
              final user = ref.read(currentUserProvider);
              if (user == null) return;

              setSheetState(() => isSubmitting = true);
              try {
                await ApiClient.instance.post(
                  ApiConstants.delAccount,
                  body: {
                    'userId': user.id,
                    'permanent': permanent,
                  },
                );
                if (ctx.mounted) Navigator.of(ctx).pop();
                final msg = permanent
                    ? 'Account submitted for deletion'
                    : 'Account deactivated';
                if (mounted) AppSnackBar.showSuccess(context, msg);
                await ref.read(authStateProvider.notifier).logout();
                if (mounted) context.go(AppRoutes.roleChoice);
              } catch (_) {
                setSheetState(() => isSubmitting = false);
                if (mounted) {
                  AppSnackBar.showError(
                      context, 'Something went wrong. Please try again.');
                }
              }
            }

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header ──────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$action Account',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: isSubmitting
                              ? null
                              : () => Navigator.of(ctx).pop(),
                          child: const Icon(Icons.close,
                              size: 22, color: AppColors.socaBlack),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 0.5, color: AppColors.socaBlack),

                  // ── Body ────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      children: [
                        Text(
                          'Are you sure you want to $action your Account?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.socaBlack,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: isSubmitting
                                    ? null
                                    : () => Navigator.of(ctx).pop(),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AppColors.socaBlack, width: 1.5),
                                  foregroundColor: AppColors.socaBlack,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25)),
                                ),
                                child: const Text(
                                  'NO',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    isSubmitting ? null : handleConfirm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.socaBlack,
                                  foregroundColor: AppColors.socaYellow,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25)),
                                ),
                                child: isSubmitting
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.socaYellow,
                                        ),
                                      )
                                    : const Text(
                                        'YES',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Header banner ─────────────────────────────────────────────
          Center(
              child: Image.asset(
            "assets/images/privacy_settings.jpg",
          )),

          // ── About SocaLoca (expandable) ───────────────────────────────
          _SettingsItem(
            icon: Image.asset("none"),
            title: 'About SocaLoca',
            trailing: Icon(
              _aboutExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 25,
              color: AppColors.socaBlack,
            ),
            onTap: () => setState(() => _aboutExpanded = !_aboutExpanded),
          ),
          if (_aboutExpanded)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: const Text(
                _aboutText,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.socaBlack,
                  height: 1.6,
                ),
              ),
            ),
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),
          _SettingsItem(
              icon: Image.asset(
                "assets/icons/ic_phone_book.png",
                height: 24,
                width: 24,
              ),
              title: 'Legacy Contact',
              onTap: () {
                context.push(AppRoutes.lagecy_contact);
              }),
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),
          // ── Manage Account (expandable) ───────────────────────────────
          _SettingsItem(
            icon: Image.asset(
              "assets/icons/ic_management.png",
              height: 24,
              width: 24,
            ),
            title: 'Manage Account',
            trailing: Icon(
              _manageExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 25,
              color: AppColors.socaBlack,
            ),
            onTap: () => setState(() => _manageExpanded = !_manageExpanded),
          ),
          if (_manageExpanded) ...[
            Container(
              color: const Color(0xFFF8F8F8),
              child: Column(
                children: [
                  _SettingsSubItem(
                    title: 'Download Activities',
                    icon: Icons.download_outlined,
                    onTap: _showDownloadActivityDialog,
                  ),
                  const Divider(
                      height: 1, thickness: 0.5, color: Color(0xFFDDDDDD),
                      indent: 52),
                  _SettingsSubItem(
                    title: 'Deactivate / Delete Account',
                    icon: Icons.delete_outline,
                    onTap: _showDeleteDeactivateChoiceDialog,
                  ),
                ],
              ),
            ),
          ],
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

          // ── Data Privacy ──────────────────────────────────────────────
          _SettingsItem(
            icon: Image.asset(
              "assets/icons/ic_secure_data.png",
              height: 24,
              width: 24,
            ),
            title: 'Data Privacy',
            onTap: () => _launch('https://socaloca.football/privacy-policy/'),
          ),
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

          // ── Terms & Conditions ────────────────────────────────────────
          _SettingsItem(
            icon: Image.asset(
              "assets/icons/ic_terms_and_conditions.png",
              height: 24,
              width: 24,
            ),
            title: 'Terms & Conditions',
            onTap: () => _launch('https://socaloca.football/terms-of-service/'),
          ),
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),
          _SettingsItem(
            icon: Image.asset(
              "assets/icons/ic_sign_out.png",
              height: 24,
              width: 24,
            ),
            title: 'Sign Out',
            onTap: _signOut,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  final Image icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            if (title != 'About SocaLoca') icon,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
            if (title == 'Manage Account' || title == 'About SocaLoca')
              const Icon(Icons.chevron_right,
                  size: 22, color: AppColors.socaBlack),
          ],
        ),
      ),
    );
  }
}

class _SettingsSubItem extends StatelessWidget {
  const _SettingsSubItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(52, 12, 20, 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
