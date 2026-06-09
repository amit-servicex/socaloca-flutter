import 'dart:async';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';

/// Mirrors ResetPasswordFragmentNew.
///
/// Layout:
///   • Page bg #F6F6F6, no AppBar
///   • Logo centred
///   • OTP field (numeric)
///   • New Password field with * masking + eye toggle
///   • Confirm Password field with * masking + eye toggle
///   • "RESET" button — full-width, black bg, yellow text 22sp
///   • "Haven't received the code? RESEND" link
///
/// Receives via GoRouter extras (Map<String, dynamic>):
///   userId, signType, identifier, countryCode
///
/// [isClubPath] = true → club reset (token-based, no OTP).
class ResetPasswordScreen extends ConsumerStatefulWidget {
  ResetPasswordScreen({
    super.key,
    this.isClubPath = false,
    this.userId = '',
    this.signType = 'email',
    this.identifier = '',
    this.countryCode = '',
  });

  final bool isClubPath;
  final String userId;
  final String signType;
  final String identifier;
  final String countryCode;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _otpCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String? _otpError;
  String? _passError;
  String? _confirmError;

  bool _isLoading = false;
  bool _isResending = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  // Resend cooldown — mirrors Android (no explicit timer, but we add 60 s UX)
  int _resendSeconds = 0;
  Timer? _resendTimer;

  @override
  void dispose() {
    _otpCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  // ── Validation ───────────────────────────────────────────────────────────
  bool _validate() {
    final otp = _otpCtrl.text.trim();
    final pass = _passCtrl.text;
    final confirm = _confirmCtrl.text;

    String? otpErr;
    String? passErr;
    String? confirmErr;

    if (otp.isEmpty) otpErr = AppStrings.pleaseEnterOtp;

    if (pass.isEmpty) {
      passErr = AppStrings.pleaseEnterPassword;
    } else if (pass.length < 6) {
      passErr = AppStrings.minimumSixCharacters;
    }

    if (confirm.isEmpty) {
      confirmErr = AppStrings.pleaseConfirmPassword;
    } else if (confirm != pass) {
      confirmErr = AppStrings.passwordDoesNotMatch;
    }

    setState(() {
      _otpError = otpErr;
      _passError = passErr;
      _confirmError = confirmErr;
    });

    return otpErr == null && passErr == null && confirmErr == null;
  }

  // ── Reset ────────────────────────────────────────────────────────────────
  Future<void> _reset() async {
    if (!_validate()) return;
    setState(() => _isLoading = true);

    final result = await ref.read(authRepositoryProvider).resetPassword(
          userId: widget.userId,
          otp: _otpCtrl.text.trim(),
          password: _passCtrl.text,
          isClubPath: widget.isClubPath,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    switch (result) {
      case AuthSuccess():
        _showToast(AppStrings.passwordResetSuccess);
        // Mirrors Android: Intent with FLAG_ACTIVITY_NEW_TASK | CLEAR_TASK
        if (mounted) context.go(AppRoutes.login);
      case AuthFailure(:final error):
        setState(() => _otpError = error.toLowerCase().contains('otp') ||
                error.toLowerCase().contains('incorrect')
            ? error
            : null);
        if (_otpError == null) {
          // Non-OTP error — show as general snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error, style: TextStyle(fontFamily: 'Poppins')),
              backgroundColor: Colors.red,
            ),
          );
        }
    }
  }

  // ── Resend OTP ───────────────────────────────────────────────────────────
  Future<void> _resend() async {
    if (_resendSeconds > 0 || _isResending) return;
    setState(() => _isResending = true);

    final result =
        await ref.read(authRepositoryProvider).resendForgotPasswordOtp(
              signType: widget.signType,
              identifier: widget.identifier,
              countryCode: widget.countryCode,
            );

    if (!mounted) return;
    setState(() => _isResending = false);

    switch (result) {
      case AuthSuccess():
        _showToast(AppStrings.verificationCodeSent);
        _startResendCooldown();
      case AuthFailure(:final error):
        _showToast(error);
    }
  }

  void _startResendCooldown() {
    setState(() => _resendSeconds = 60);
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

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: AppColors.socaBlack,
      ),
    );
  }

  // ── Field builder ────────────────────────────────────────────────────────
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? error,
    bool obscure = false,
    VoidCallback? onToggleObscure,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? formatters,
    VoidCallback? onClearError,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.socaGrey,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: error != null ? Colors.red : Colors.black,
              width: 0.8,
            ),
            boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  obscuringCharacter: '*',
                  keyboardType: keyboardType,
                  inputFormatters: formatters,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: label,
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  ),
                  onChanged: (_) {
                    if (onClearError != null) onClearError();
                  },
                ),
              ),
              if (onToggleObscure != null)
                GestureDetector(
                  onTap: onToggleObscure,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: !obscure
                          ? Image.asset(
                              "assets/icons/ic_password_eye.png",
                              width: 28,
                              height: 28,
                            )
                          : Image.asset(
                              "assets/icons/ic_visibility_off.png",
                              width: 28,
                              height: 28,
                            )),
                ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: EdgeInsets.only(top: 6, left: 2),
            child: Text(
              error,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Logo ──────────────────────────────────────────────────
                SizedBox(height: height * .2),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/socaloca_logo.svg',
                    width: 170,
                    // height: 100,
                    // fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: height * .07),

                // ── OTP field ────────────────────────────────────────────
                _buildField(
                  controller: _otpCtrl,
                  label: AppStrings.otpLabel,
                  error: _otpError,
                  keyboardType: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  onClearError: () {
                    if (_otpError != null) setState(() => _otpError = null);
                  },
                ),
                SizedBox(height: 12),

                // ── New Password ─────────────────────────────────────────
                _buildField(
                  controller: _passCtrl,
                  label: AppStrings.password,
                  error: _passError,
                  obscure: _obscurePass,
                  onToggleObscure: () =>
                      setState(() => _obscurePass = !_obscurePass),
                  onClearError: () {
                    if (_passError != null) setState(() => _passError = null);
                  },
                ),
                SizedBox(height: 12),

                // ── Confirm Password ─────────────────────────────────────
                _buildField(
                  controller: _confirmCtrl,
                  label: AppStrings.confirmPassword,
                  error: _confirmError,
                  obscure: _obscureConfirm,
                  onToggleObscure: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  onClearError: () {
                    if (_confirmError != null) {
                      setState(() => _confirmError = null);
                    }
                  },
                ),
                SizedBox(height: 28),

                // ── RESET button ─────────────────────────────────────────
                GestureDetector(
                  onTap: _isLoading ? null : _reset,
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    color: AppColors.socaBlack,
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.socaYellow,
                            ),
                          )
                        : Text(
                            AppStrings.resetUpper,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: AppColors.socaYellow,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),

                // ── Resend row ────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.haventReceivedCode,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    _resendSeconds > 0
                        ? Text(
                            AppStrings.resendUpperWithSeconds(_resendSeconds),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          )
                        : GestureDetector(
                            onTap: _isResending ? null : _resend,
                            child: _isResending
                                ? SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.socaBlack,
                                    ),
                                  )
                                : Text(
                                    AppStrings.resendUpper,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.socaBlack,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                          ),
                  ],
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
