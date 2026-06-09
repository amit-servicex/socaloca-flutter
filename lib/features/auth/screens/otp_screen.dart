import 'dart:async';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';

/// OtpFragment equivalent.
/// Receives `userId` and `type` via GoRouter extras (Map<String, String>).
/// 6-digit OTP with auto-advance, 60 s resend countdown.
class OtpScreen extends ConsumerStatefulWidget {
  OtpScreen({super.key, required this.userId, required this.type});

  final String userId;
  final String type; // 'email' | 'phone'

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  static const _otpLength = 6;

  final List<TextEditingController> _controllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  bool _isLoading = false;
  int _resendSeconds = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _resendTimer?.cancel();
        }
      });
    });
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  Future<void> _verify() async {
    if (_enteredOtp.length < _otpLength) {
      AppSnackBar.showError(context, AppStrings.fullDigitCode(_otpLength));
      return;
    }

    setState(() => _isLoading = true);

    final result = await ref.read(authRepositoryProvider).verifyOtp(
          otp: _enteredOtp,
          userId: widget.userId,
          type: widget.type,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    switch (result) {
      case AuthSuccess():
        AppSnackBar.showSuccess(context, AppStrings.verifiedSuccessfully);
        // After OTP verification, ALWAYS navigate to create profile
        // This matches Android behavior: OtpFragment -> ThankYouCreateProfile
        context.go(AppRoutes.createProfile);

      case AuthFailure(:final error):
        AppSnackBar.showError(context, error);
        // Clear fields on failure
        for (final c in _controllers) {
          c.clear();
        }
        _focusNodes.first.requestFocus();
    }
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      // Auto-advance to next field
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        // Auto-submit when last digit is entered
        _verify();
      }
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    // Move back on backspace when field is empty
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _resendSeconds == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.verifyCode),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ────────────────────────────────────────────
            Icon(
              Icons.mark_email_read_outlined,
              size: 64,
              color: AppColors.primary,
            ),
            SizedBox(height: 24),
            Text(
              AppStrings.enterVerificationCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppStrings.verificationCodeSentTo(widget.type),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 40),

            // ── OTP cells ─────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_otpLength, (i) {
                return SizedBox(
                  width: 46,
                  height: 56,
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (e) => _onKeyEvent(i, e),
                    child: TextFormField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.border, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.primary, width: 2),
                        ),
                        filled: true,
                        fillColor: AppColors.inputBackground,
                      ),
                      onChanged: (v) => _onDigitChanged(i, v),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 40),

            // ── Verify button ──────────────────────────────────────
            PrimaryButton(
              label: AppStrings.verify,
              onPressed: _verify,
              isLoading: _isLoading,
            ),
            SizedBox(height: 24),

            // ── Resend ─────────────────────────────────────────────
            Center(
              child: canResend
                  ? TextButton(
                      onPressed: _startResendTimer,
                      child: Text(
                        AppStrings.resendCode,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : Text(
                      AppStrings.resendCodeIn(_resendSeconds),
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
