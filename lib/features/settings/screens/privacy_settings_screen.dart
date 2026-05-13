import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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

class _PrivacySettingsScreenState
    extends ConsumerState<PrivacySettingsScreen> {
  bool _aboutExpanded = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        title: const Text(
          'Privacy Settings',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Header banner ─────────────────────────────────────────────
          Container(
            height: 170,
            width: double.infinity,
            color: AppColors.socaBlack,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.privacy_tip, color: AppColors.socaYellow, size: 56),
                  SizedBox(height: 8),
                  Text(
                    'Your Privacy',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── About SocaLoca (expandable) ───────────────────────────────
          _SettingsItem(
            icon: Icons.info_outline,
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

          // ── Manage Account (expandable) ───────────────────────────────
          _SettingsItem(
            icon: Icons.manage_accounts_outlined,
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
                    title: 'Deactivate / Delete Account',
                    icon: Icons.delete_outline,
                    onTap: () => AppSnackBar.showSuccess(
                        context, 'Account deletion — coming soon'),
                  ),
                ],
              ),
            ),
          ],
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

          // ── Data Privacy ──────────────────────────────────────────────
          _SettingsItem(
            icon: Icons.security_outlined,
            title: 'Data Privacy',
            onTap: () => _launch('https://socaloca.football/privacy-policy/'),
          ),
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

          // ── Terms & Conditions ────────────────────────────────────────
          _SettingsItem(
            icon: Icons.article_outlined,
            title: 'Terms & Conditions',
            onTap: () =>
                _launch('https://socaloca.football/terms-of-service/'),
          ),
          const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

          const SizedBox(height: 32),

          // ── Sign Out ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton.icon(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
              label: const Text(
                'SIGN OUT',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
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

  final IconData icon;
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
            Icon(icon, size: 24, color: AppColors.socaBlack),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.socaBlack,
                ),
              ),
            ),
            trailing ??
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
