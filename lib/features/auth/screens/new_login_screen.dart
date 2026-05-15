import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/services/location_service.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Mirrors fragment_new_login.xml exactly.
///
/// Layout:
///   • Background #F6F6F6 (new_white)
///   • Logo 150×150dp, centred, marginTop 50dp
///   • Horizontal padding 40dp for all form content
///   • "Login" title — 18sp Poppins Bold centred
///   • Phone/email input box — grey fill (#EAEAE8), 2dp radius, 0.8dp black stroke, elevation 8
///     – country-code prefix hidden by default (shown when phone detected)
///     – hint: "Mobile number */Email */SocaLoca ID *"
///   • Password input box — same styling, eye toggle right
///   • "* mandatory fields" + "Forgotten Password?" row
///   • Light-bulb hint about SocaLoca ID
///   • LOG IN button — black fill, 5dp radius, yellow "LOG IN" 22sp allCaps
///   • "or continue with" divider
///   • Facebook / Google image buttons side by side
///   • Club login box (invisible by default — shown on demand by future impl)
///   • Privacy text scrolls with content (inside ScrollView)
class NewLoginScreen extends ConsumerStatefulWidget {
  const NewLoginScreen({super.key});

  @override
  ConsumerState<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends ConsumerState<NewLoginScreen> {
  final _identityCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _isLoading = false;
  bool _isSocialLoading = false;
  bool _showCountryCode = false;
  String _selectedCountryCode =
      '+91'; // Default to India, will be auto-detected
  String _selectedCountryName = 'India';

  // Mirrors NewLoginFragment.showHideCountryCodeBox() — shows code prefix when
  // input looks like a phone number (starts with digit)
  void _onIdentityChanged(String value) {
    final looksLikePhone = value.isNotEmpty && RegExp(r'^\d').hasMatch(value);
    if (looksLikePhone != _showCountryCode) {
      setState(() => _showCountryCode = looksLikePhone);
    }
  }

  // Detect input type: email, mobile, or SocaLoca ID
  String _detectInputType(String input) {
    if (RegExp(r'^[Ss][Cc][Ll]\d+$').hasMatch(input)) {
      return 'socaloca_id';
    } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(input)) {
      return 'email';
    } else if (RegExp(r'^\d+$').hasMatch(input)) {
      return 'mobile';
    }
    return 'unknown';
  }

  // Validate input based on type
  String? _validateIdentity(String identity) {
    if (identity.isEmpty) {
      return 'Please enter your email, mobile number or SocaLoca ID';
    }

    final type = _detectInputType(identity);

    if (type == 'mobile' && identity.length < 7) {
      return 'Please enter valid mobile number';
    }

    if (type == 'unknown') {
      return 'Please enter valid email, mobile number or SocaLoca ID';
    }

    return null;
  }

  @override
  void dispose() {
    _identityCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _detectCountry());
  }

  Future<void> _detectCountry() async {
    final country = await LocationService.detectCountry(context);
    if (!mounted || country == null)
      return; // null = GPS failed, keep +91 default
    setState(() {
      _selectedCountryCode = country.phoneCode;
      _selectedCountryName = country.name;
    });
  }

  // Show country picker dialog
  Future<void> _showCountryPicker() async {
    final countries = _getCountryList();

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Select Country',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return ListTile(
                      title: Text(
                        country['name']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                      trailing: Text(
                        country['code']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedCountryCode = country['code']!;
                          _selectedCountryName = country['name']!;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get list of countries for picker
  List<Map<String, String>> _getCountryList() {
    return [
      {'name': 'Afghanistan', 'code': '+93'},
      {'name': 'Albania', 'code': '+355'},
      {'name': 'Algeria', 'code': '+213'},
      {'name': 'Argentina', 'code': '+54'},
      {'name': 'Australia', 'code': '+61'},
      {'name': 'Austria', 'code': '+43'},
      {'name': 'Bangladesh', 'code': '+880'},
      {'name': 'Belgium', 'code': '+32'},
      {'name': 'Brazil', 'code': '+55'},
      {'name': 'Canada', 'code': '+1'},
      {'name': 'Chile', 'code': '+56'},
      {'name': 'China', 'code': '+86'},
      {'name': 'Colombia', 'code': '+57'},
      {'name': 'Denmark', 'code': '+45'},
      {'name': 'Egypt', 'code': '+20'},
      {'name': 'England', 'code': '+44'},
      {'name': 'Finland', 'code': '+358'},
      {'name': 'France', 'code': '+33'},
      {'name': 'Germany', 'code': '+49'},
      {'name': 'Greece', 'code': '+30'},
      {'name': 'India', 'code': '+91'},
      {'name': 'Indonesia', 'code': '+62'},
      {'name': 'Republic of Ireland', 'code': '+353'},
      {'name': 'Italy', 'code': '+39'},
      {'name': 'Japan', 'code': '+81'},
      {'name': 'Kenya', 'code': '+254'},
      {'name': 'Korea Republic', 'code': '+82'},
      {'name': 'Malaysia', 'code': '+60'},
      {'name': 'Mexico', 'code': '+52'},
      {'name': 'Netherlands', 'code': '+31'},
      {'name': 'New Zealand', 'code': '+64'},
      {'name': 'Nigeria', 'code': '+234'},
      {'name': 'Norway', 'code': '+47'},
      {'name': 'Pakistan', 'code': '+92'},
      {'name': 'Peru', 'code': '+51'},
      {'name': 'Philippines', 'code': '+63'},
      {'name': 'Poland', 'code': '+48'},
      {'name': 'Portugal', 'code': '+351'},
      {'name': 'Russia', 'code': '+7'},
      {'name': 'Saudi Arabia', 'code': '+966'},
      {'name': 'Singapore', 'code': '+65'},
      {'name': 'South Africa', 'code': '+27'},
      {'name': 'Spain', 'code': '+34'},
      {'name': 'Sweden', 'code': '+46'},
      {'name': 'Switzerland', 'code': '+41'},
      {'name': 'Thailand', 'code': '+66'},
      {'name': 'Türkiye', 'code': '+90'},
      {'name': 'Ukraine', 'code': '+380'},
      {'name': 'United Arab Emirates', 'code': '+971'},
      {'name': 'USA', 'code': '+1'},
      {'name': 'Vietnam', 'code': '+84'},
    ];
  }

  // ─── modSignIn ────────────────────────────────────────────────────────────

  Future<void> _login() async {
    final identity = _identityCtrl.text.trim();
    final password = _passCtrl.text;

    // Validate identity
    final identityError = _validateIdentity(identity);
    if (identityError != null) {
      AppSnackBar.showError(context, identityError);
      return;
    }

    // Validate password
    if (password.isEmpty) {
      AppSnackBar.showError(context, 'Please enter password');
      return;
    }
    if (password.length < 6) {
      AppSnackBar.showError(context, 'Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    final inputType = _detectInputType(identity);
    final result = await ref.read(authRepositoryProvider).login(
          identity: identity,
          password: password,
          countryCode: inputType == 'mobile' ? _selectedCountryCode : null,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    switch (result) {
      case AuthSuccess(:final data):
        final user = data.user;
        final token = data.token;
        if (user == null) {
          AppSnackBar.showError(
              context, 'Unexpected response. Please try again.');
          return;
        }

        // Check if policy needs to be accepted (Android checks policyAccepted field)
        // If user hasn't accepted policy, call accUserPolicy
        if (user.policyAccepted == false) {
          final policyResult =
              await ref.read(authRepositoryProvider).acceptUserPolicy(
                    userId: user.id,
                  );

          if (policyResult is AuthFailure) {
            if (mounted) {
              AppSnackBar.showError(
                  context, 'Failed to accept policy. Please try again.');
            }
            return;
          }
        }

        await ref
            .read(authStateProvider.notifier)
            .setUserSession(token: token ?? '', user: user);

        // Navigate based on user role (matches Android logic)
        if (mounted) {
          _navigateBasedOnRole(
              user?.isReferee == true ? 'referee' : user?.userType);
        }

      case AuthFailure(:final error):
        // Match Android error messages
        if (error.toLowerCase().contains('wrong password') ||
            error.toLowerCase().contains('incorrect password')) {
          AppSnackBar.showError(context, 'Wrong password');
        } else if (error.toLowerCase().contains('not registered') ||
            error.toLowerCase().contains('account not found')) {
          AppSnackBar.showError(context, 'Account not registered');
        } else {
          AppSnackBar.showError(context, error);
        }
    }
  }

  // Navigate based on user role (matches Android NewLoginFragment logic)
  // Referee → RefHomeActivity (/referee), everyone else → HomeActivity (/)
  void _navigateBasedOnRole(String? userType) {
    log("this is the role ${userType}");
    if (userType == 'referee') {
      context.go(AppRoutes.refereeTournament);
    } else {
      context.go(AppRoutes.home);
    }
  }

  // ─── Social — Google ──────────────────────────────────────────────────────

  Future<void> _googleLogin() async {
    setState(() => _isSocialLoading = true);
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      await _socialLogin(
        socialId: googleUser.id,
        email: googleUser.email,
        name: googleUser.displayName ?? '',
        profilePic: googleUser.photoUrl ?? '',
        loginType: 'google',
      );
    } catch (_) {
      if (mounted) AppSnackBar.showError(context, 'Google sign-in failed');
    } finally {
      if (mounted) setState(() => _isSocialLoading = false);
    }
  }

  // ─── Social — Facebook ────────────────────────────────────────────────────

  Future<void> _facebookLogin() async {
    setState(() => _isSocialLoading = true);
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) {
        setState(() => _isSocialLoading = false);
        return;
      }
      final data = await FacebookAuth.instance.getUserData(
        fields: 'name,email,picture.width(200)',
      );
      await _socialLogin(
        socialId: (data['id'] as String?) ?? '',
        email: (data['email'] as String?) ?? '',
        name: (data['name'] as String?) ?? '',
        profilePic: (data['picture']?['data']?['url'] as String?) ?? '',
        loginType: 'facebook',
      );
    } catch (_) {
      if (mounted) AppSnackBar.showError(context, 'Facebook sign-in failed');
    } finally {
      if (mounted) setState(() => _isSocialLoading = false);
    }
  }

  Future<void> _socialLogin({
    required String socialId,
    required String email,
    required String name,
    required String profilePic,
    required String loginType,
  }) async {
    final result = await ref.read(authRepositoryProvider).socialLogin(
          socialId: socialId,
          email: email,
          name: name,
          profilePic: profilePic,
          loginType: loginType,
        );
    if (!mounted) return;
    switch (result) {
      case AuthSuccess(:final data):
        if (data.isNewUser) {
          context.push(AppRoutes.socialAge);
        } else {
          final user = data.user;
          final token = data.token;
          if (user == null || token == null) {
            AppSnackBar.showError(
                context, 'Unexpected response. Please try again.');
            return;
          }
          await ref
              .read(authStateProvider.notifier)
              .setUserSession(token: token, user: user);
          if (mounted) context.go(AppRoutes.home);
        }
      case AuthFailure(:final error):
        AppSnackBar.showError(context, error);
    }
  }

  // ─── UI helpers ──────────────────────────────────────────────────────────

  static const Color _black = AppColors.socaBlack;
  static const Color _yellow = AppColors.socaYellow;
  static const Color _pageBg = AppColors.socaPageBg;
  static const Color _inputFill = AppColors.socaGrey;

  static const String _privacyText =
      '*SocaLoca only collects the data is necessary to provides its service and\n'
      'stores it in the anonymised way in our own self-hosted analytics system.';

  /// Rounded grey box with thin black stroke — mirrors rounded_new_gray_5dp_stoke_black_1dp
  BoxDecoration get _inputBoxDecoration => BoxDecoration(
        color: _inputFill,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black, width: 0.8),
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
      );

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: _pageBg,
        // No AppBar — matches Android (LoginActivity has no action bar)
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Logo ────────────────────────────────────────────────
                const SizedBox(height: 50),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/socaloca_logo.svg',
                    width: 200,
                    // height: 150,
                    // fit: BoxFit.contain,
                  ),
                ),

                // ── Form content — 40dp horizontal padding ───────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // "Login" title
                      const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: _black,
                        ),
                      ),

                      // ── Mobile/Email/SocaLoca ID input box ───────────────
                      const SizedBox(height: 30),
                      SocaLocaMobileEmailField(
                        controller: _identityCtrl,
                        hintText: 'Mobile number */Email */SocaLoca ID *',
                        onChanged: _onIdentityChanged,
                        showCountryCode: _showCountryCode,
                        countryCode: _selectedCountryCode,
                        onCountryCodeTap: _showCountryPicker,
                      ),

                      // ── Password input box ───────────────────────────────
                      const SizedBox(height: 15),
                      SocaLocaPasswordField(
                        controller: _passCtrl,
                        hintText: 'Password',
                        textInputAction: TextInputAction.go,
                      ),

                      // ── Mandatory fields + Forgotten Password ────────────
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '* mandatory fields',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: _black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.push(AppRoutes.forgotPassword,
                                extra: false),
                            child: const Text(
                              'Forgotten Password?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: _black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ── Light-bulb SocaLoca ID hint ──────────────────────
                      const SizedBox(height: 5),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb_outline,
                              size: 15, color: _black),
                          SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              'Find your new SocaLoca ID in the sliding hamburger menu',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                color: _black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ── LOG IN button ────────────────────────────────────
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: _isLoading ? null : _login,
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: _isLoading
                              ? const AppLoader(size: 24, centered: false)
                              : const Text(
                                  'LOG IN',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: _yellow,
                                  ),
                                ),
                        ),
                      ),

                      // ── "or continue with" divider ───────────────────────
                      const SizedBox(height: 25),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(height: 0.5, color: _black),
                          Container(
                            color: _pageBg,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: const Text(
                              'or continue with',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: _black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ── Social buttons — Facebook (left) Google (right) ──
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          // Facebook button
                          Expanded(
                            child: GestureDetector(
                              onTap: _isSocialLoading ? null : _facebookLogin,
                              child: Opacity(
                                opacity: _isSocialLoading ? 0.5 : 1.0,
                                child: Image.asset(
                                  'assets/images/facebook_button.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Google button
                          Expanded(
                            child: GestureDetector(
                              onTap: _isSocialLoading ? null : _googleLogin,
                              child: Opacity(
                                opacity: _isSocialLoading ? 0.5 : 1.0,
                                child: Image.asset(
                                  'assets/images/google_plus_button.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ── Club login box (invisible by default) ────────────
                      // Mirrors loginAsClub — android:visibility="invisible"
                      // Shown in future when club flow is integrated
                      const SizedBox(height: 40),
                      Visibility(
                        visible: false,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: _inputFill,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black, width: 0.8),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'Are you a Professional Football Club?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: _black,
                                ),
                              ),
                              Text(
                                'Login/Signup here',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: _black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Privacy text (scrolls with content) ─────────────
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          _privacyText,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                            color: _black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
