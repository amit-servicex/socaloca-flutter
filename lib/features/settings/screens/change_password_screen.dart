import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_snackbar.dart';

/// Mirrors Android FanChangePasswordFragment.
/// Payload: { userId, currentPassword, newPassword }
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  String? _validate() {
    final current = _currentCtrl.text.trim();
    final newPwd = _newCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (current.isEmpty) return 'Please enter your current password';
    if (newPwd.isEmpty) return 'Please enter a new password';
    if (newPwd.length < 6) return 'New password must be at least 6 characters';
    if (newPwd == current) return 'New password cannot be the same as current';
    if (confirm.isEmpty) return 'Please confirm your new password';
    if (confirm != newPwd) return 'Passwords do not match';
    return null;
  }

  Future<void> _submit() async {
    final error = _validate();
    if (error != null) {
      AppSnackBar.showError(context, error);
      return;
    }

    final userId = StorageService.userId;
    if (userId == null || userId.isEmpty) {
      AppSnackBar.showError(context, 'User session not found. Please log in again.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiClient.instance.post(
        ApiConstants.changePassword,
        body: {
          'userId': userId,
          'currentPassword': _currentCtrl.text.trim(),
          'newPassword': _newCtrl.text.trim(),
        },
      );

      if (!mounted) return;

      final resp = response['response'] as Map<String, dynamic>? ?? response;
      final status = (resp['status'] as num?)?.toInt() ?? 0;
      final message = resp['message'] as String? ?? '';

      if (status == 1) {
        AppSnackBar.showSuccess(context, 'Password changed successfully');
        _currentCtrl.clear();
        _newCtrl.clear();
        _confirmCtrl.clear();
      } else {
        AppSnackBar.showError(
          context,
          message.isNotEmpty ? message : 'Failed to change password. Please try again.',
        );
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, 'Something went wrong. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = StorageService.currentUser;
    final socaId = user?['username'] as String? ?? user?['id'] as String? ?? '';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SocaLoca ID row
            if (socaId.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SocaLoca ID: ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  Text(
                    socaId,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],

            _PasswordField(
              controller: _currentCtrl,
              hint: 'Current Password',
              showPassword: _showCurrent,
              onToggle: () => setState(() => _showCurrent = !_showCurrent),
            ),
            const SizedBox(height: 16),
            _PasswordField(
              controller: _newCtrl,
              hint: 'New Password',
              showPassword: _showNew,
              onToggle: () => setState(() => _showNew = !_showNew),
            ),
            const SizedBox(height: 16),
            _PasswordField(
              controller: _confirmCtrl,
              hint: 'Confirm New Password',
              showPassword: _showConfirm,
              onToggle: () => setState(() => _showConfirm = !_showConfirm),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 32),

            GestureDetector(
              onTap: _isLoading ? null : _submit,
              child: Container(
                alignment: Alignment.center,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppColors.socaYellow,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.socaYellow,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.showPassword,
    required this.onToggle,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final bool showPassword;
  final VoidCallback onToggle;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black, width: 0.8),
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
      ),
      child: TextField(
        controller: controller,
        obscureText: !showPassword,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.socaBlack,
              size: 20,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
