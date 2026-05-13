import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
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
  String _inputLabel = 'Email or SocaLoca ID';

  @override
  void dispose() {
    _uKeyCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _onUKeyChanged(String value) {
    String label;
    if (_isSocaLocaId(value)) {
      label = 'SocaLoca ID *';
    } else if (value.isNotEmpty) {
      label = 'Email *';
    } else {
      label = 'Email or SocaLoca ID';
    }
    if (label != _inputLabel) setState(() => _inputLabel = label);
  }

  bool _isSocaLocaId(String v) =>
      RegExp(r'^[Ss][Cc][Ll]\d+$').hasMatch(v);

  bool _isEmail(String v) =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v);

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
              _errorMessage = 'Invalid credentials';
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
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Title
                const Text(
                  'Club Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sign in to your professional club account',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // Email / SocaLoca ID field
                Text(
                  _inputLabel,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _uKeyCtrl,
                  onChanged: _onUKeyChanged,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 14),
                  decoration: _inputDecoration('Enter email or SocaLoca ID'),
                  validator: (v) {
                    final val = v?.trim() ?? '';
                    if (val.isEmpty) return 'Please enter email or SocaLoca ID';
                    if (!_isEmail(val) && !_isSocaLocaId(val)) {
                      return 'Please enter a valid email or SocaLoca ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password field
                const Text(
                  'Password *',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscurePass,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) => _submit(),
                  style: const TextStyle(fontFamily: 'Lato', fontSize: 14),
                  decoration: _inputDecoration('Enter password').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePass = !_obscurePass),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please enter password';
                    return null;
                  },
                ),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        context.push(AppRoutes.forgotPassword, extra: true),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ),

                // Error message
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
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
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      disabledBackgroundColor:
                          AppColors.socaBlack.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.socaYellow,
                            ),
                          )
                        : const Text(
                            'CLUB LOGIN',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          const TextStyle(fontFamily: 'Lato', fontSize: 13, color: Colors.grey),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide:
            const BorderSide(color: AppColors.socaBlack, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }
}
