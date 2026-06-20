import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';

/// Mirrors Android LoginClubFragment.
/// POST clubLogin with { uKey, passKey }.
/// On success → saves ClubUser + sets isClubLogin → navigates to /club/bio.
class ClubLoginScreen extends ConsumerStatefulWidget {
  const ClubLoginScreen({super.key});

  @override
  ConsumerState<ClubLoginScreen> createState() => _ClubLoginScreenState();
}

class _ClubLoginScreenState extends ConsumerState<ClubLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uKeyCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _isLoading = false;
  bool _obscurePass = true;
  String? _errorMessage;

  // mirrors Android: detect whether input is a SocaLoca ID or email
  final String _inputLabel = AppStrings.emailOrSocaLocaId;

  @override
  void dispose() {
    _uKeyCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _onUKeyChanged(String value) {
    // Keep logic if needed, but UI no longer uses _inputLabel dynamically
    // as it statically says "Email */SocaLoca ID *" in the hint/label.
  }

  bool _isSocaLocaId(String v) => RegExp(r'^[Ss][Cc][Ll]\d+$').hasMatch(v);

  bool _isEmail(String v) => RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v);

  Future<void> _submit() async {
    setState(() => _errorMessage = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.clubLogin(
        uKey: _uKeyCtrl.text.trim(),
        passKey: _passCtrl.text,
      );

      if (!mounted) return;

      switch (result) {
        case AuthSuccess<ClubLoginResponse>(:final data):
          final clubUser = data.clubUser;
          if (clubUser == null) {
            setState(() {
              _errorMessage = AppStrings.invalidCredentials;
              _isLoading = false;
            });
            return;
          }
          // Save club user + mark as club session
          await StorageService.setClubUser(clubUser.toJson());
          await StorageService.setClubLogin(true);

          if (!mounted) return;
          context.go(AppRoutes.clubBioAdmin);

        case AuthFailure<ClubLoginResponse>(:final error):
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          log("tohis catch block executre ");
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // match light grey background
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .17),
                    // Logo
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/socaloca_logo.svg',
                        width: 200,
                        // height: 150,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: height * .1),

                    // Email / SocaLoca ID field
                    TextFormField(
                      controller: _uKeyCtrl,
                      onChanged: _onUKeyChanged,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      decoration: _inputDecoration(
                          AppStrings.emailOrSocaLocaIdRequired),
                      validator: (v) {
                        final val = v?.trim() ?? '';
                        if (val.isEmpty) {
                          return AppStrings.pleaseEnterEmailOrSocaLocaId;
                        }
                        if (!_isEmail(val) && !_isSocaLocaId(val)) {
                          return AppStrings.pleaseEnterValidEmailOrSocaLocaId;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    TextFormField(
                      controller: _passCtrl,
                      obscuringCharacter: '*',
                      obscureText: _obscurePass,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (_) => _submit(),
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      decoration:
                          _inputDecoration(AppStrings.password).copyWith(
                        suffixIcon: IconButton(
                          icon: !_obscurePass
                              ? Image.asset(
                                  "assets/icons/ic_password_eye.png",
                                  width: 34,
                                  height: 34,
                                )
                              : Image.asset(
                                  "assets/icons/ic_visibility_off.png",
                                  width: 34,
                                  height: 34,
                                ),

                          //  Icon(
                          //   _obscurePass
                          //       ? Icons.visibility_off_outlined
                          //       : Icons.visibility_outlined,
                          //   color: AppColors.socaBlack,
                          //   size: 22,
                          // ),
                          onPressed: () =>
                              setState(() => _obscurePass = !_obscurePass),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return AppStrings.pleaseEnterPassword;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      '* mandatory fields',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),

                    // Error message
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.error.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                size: 16, color: AppColors.error),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 13,
                                    color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          disabledBackgroundColor:
                              AppColors.socaBlack.withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child:

                            // _isLoading
                            //     ? SizedBox(
                            //         width: 22,
                            //         height: 22,
                            //         child: CircularProgressIndicator(
                            //           color: AppColors.socaYellow,
                            //           strokeWidth: 2.5,
                            //         ),
                            //       )
                            //     :

                            Text(
                          AppStrings.login.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Register as Club link
                    Center(
                      child: TextButton(
                        onPressed: () => context.push(AppRoutes.registerClub),
                        child: Text(
                          AppStrings.registerAsClub,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const AppLoader(size: 500),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      fillColor: Colors.transparent,
      labelText: label,
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.socaBlack,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.socaBlack, width: 1.5),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }
}
