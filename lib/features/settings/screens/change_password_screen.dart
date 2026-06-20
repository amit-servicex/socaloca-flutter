import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

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

    if (current.isEmpty) return AppStrings.pleaseEnterCurrentPassword;
    if (newPwd.isEmpty) return AppStrings.pleaseEnterNewPassword;
    if (newPwd.length < 6) return AppStrings.newPasswordMinLength;
    if (newPwd == current) return AppStrings.newPasswordSameAsCurrent;
    if (confirm.isEmpty) return AppStrings.pleaseConfirmNewPassword;
    if (confirm != newPwd) return AppStrings.passwordsDoNotMatch;
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
      AppSnackBar.showError(context, AppStrings.userSessionNotFound);
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
        AppSnackBar.showSuccess(
            context, AppStrings.passwordChangedSuccessfully);
        _currentCtrl.clear();
        _newCtrl.clear();
        _confirmCtrl.clear();
      } else {
        AppSnackBar.showError(
          context,
          message.isNotEmpty ? message : AppStrings.failedToChangePassword,
        );
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, AppStrings.somethingWentWrongTryAgain);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final storedUser = StorageService.currentUser;
    final currentUser = ref.watch(currentUserProvider);
    final socaId = currentUser?.sclId ??
        storedUser?['sclId'] as String? ??
        storedUser?['username'] as String? ??
        storedUser?['id'] as String? ??
        '';
    final profileImage =
        currentUser?.profileImage ?? storedUser?['imageUrl'] as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(26, 30, 26, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: _ProfileAvatar(imagePath: profileImage)),
            const SizedBox(height: 24),
            Text(
              'SocaLoca ID'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.1,
                color: AppColors.socaBlack,
              ),
            ),
            if (socaId.isNotEmpty)
              Text(
                socaId,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  color: AppColors.socaBlack,
                ),
              ),
            const SizedBox(height: 32),
            _PasswordField(
              controller: _currentCtrl,
              hint: AppStrings.currentPasswordHint,
              showPassword: _showCurrent,
              onToggle: () => setState(() => _showCurrent = !_showCurrent),
            ),
            const SizedBox(height: 16),
            _PasswordField(
              controller: _newCtrl,
              hint: AppStrings.newPasswordHint,
              showPassword: _showNew,
              onToggle: () => setState(() => _showNew = !_showNew),
            ),
            const SizedBox(height: 16),
            _PasswordField(
              controller: _confirmCtrl,
              hint: AppStrings.confirmPasswordHint,
              showPassword: _showConfirm,
              onToggle: () => setState(() => _showConfirm = !_showConfirm),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 38),
            Text(
              '* mandatory fields'.tr,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: _isLoading ? null : _submit,
              child: Container(
                alignment: Alignment.center,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _isLoading
                    ? const AppLoader(size: 24, centered: false)
                    : Text(
                        'CHANGE PASSWORD'.tr,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
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

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(imagePath);

    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _fallback(),
              )
            : _fallback(),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      color: const Color(0xFFE9E9E9),
      child: Icon(
        Icons.person,
        size: 42,
        color: Colors.grey[600],
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
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(2),
      ),
      child: TextField(
        controller: controller,
        obscureText: !showPassword,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17,
          color: AppColors.socaBlack,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17,
            color: AppColors.socaBlack,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          suffixIcon: IconButton(
            icon: showPassword
                ? Image.asset(
                    "assets/icons/ic_password_eye.png",
                    width: 24,
                    height: 24,
                  )
                : Image.asset("assets/icons/ic_visibility_off.png",
                    width: 24, height: 24),
            // Icon(
            //   showPassword
            //       ? Image.asset("assets/icons/ic_password_eye.png")
            //       : Image.asset("assets/icons/ic_visibility_off.png"),
            //   color: AppColors.socaBlack,
            //   size: 24,
            // ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
