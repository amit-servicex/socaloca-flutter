import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';

/// Handles BOTH forgot-password flows:
/// - [isClubPath] = false → calls forgetAllPass (user path, NewLoginFragment flow)
/// - [isClubPath] = true  → calls forgetPass (club path, LoginClubFragment flow)
///
/// See DEAD_CODE_AUDIT.md for clarification on dual-path design.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key, required this.isClubPath});

  final bool isClubPath;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppSnackBar.showError(context, 'Please enter your email address');
      return;
    }

    setState(() => _isLoading = true);

    final result = await ref.read(authRepositoryProvider).forgotPassword(
          email: email,
          isClubPath: widget.isClubPath,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    switch (result) {
      case AuthSuccess():
        AppSnackBar.showSuccess(context, 'Reset link sent to $email');
        Navigator.of(context).pop();
      case AuthFailure(:final error):
        AppSnackBar.showError(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isClubPath ? 'Club Forgot Password' : 'Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email address and we\'ll send you a link to reset your password.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Send Reset Link',
              onPressed: _submit,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
