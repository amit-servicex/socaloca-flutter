import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/primary_button.dart';

/// LoginClubFragment equivalent — club admin login.
/// Uses clubLogin endpoint. Forgot-password uses forgetPass (not forgetAllPass).
class ClubLoginScreen extends ConsumerStatefulWidget {
  const ClubLoginScreen({super.key});
  @override
  ConsumerState<ClubLoginScreen> createState() => _ClubLoginScreenState();
}

class _ClubLoginScreenState extends ConsumerState<ClubLoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Login'), backgroundColor: Colors.transparent, elevation: 0, foregroundColor: AppColors.textPrimary),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // TODO: implement club login with clubLogin endpoint
            TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Club Email')),
            const SizedBox(height: 16),
            TextFormField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            Align(alignment: Alignment.centerRight, child: TextButton(
              onPressed: () => context.push(AppRoutes.forgotPassword, extra: true), // isClubPath = true
              child: const Text('Forgot Password?'))),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Club Login', onPressed: () {}, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
