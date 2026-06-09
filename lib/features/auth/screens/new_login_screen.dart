import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

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
  NewLoginScreen({super.key});

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
      return AppStrings.pleaseEnterYourEmailMobileOrSocaLocaId;
    }

    final type = _detectInputType(identity);

    if (type == 'mobile' && identity.length < 7) {
      return AppStrings.pleaseEnterValidMobileNumber;
    }

    if (type == 'unknown') {
      return AppStrings.pleaseEnterValidEmailMobileOrSocaLocaId;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detectCountry();
      _initGoogleSignIn();
    });
  }

  Future<void> _initGoogleSignIn() async {
    try {
      await GoogleSignIn.instance.initialize(
        // Web client ID from Google Cloud Console — matches Android requestIdToken()
        serverClientId:
            '247756601333-i4p8he1a8ttnjlp8i812u8rhp5copmgk.apps.googleusercontent.com',
      );
    } catch (_) {
      // Non-fatal — authenticate() will surface the real error on tap
    }
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
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                AppStrings.selectCountry,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return ListTile(
                      title: Text(
                        country['name']!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                      trailing: Text(
                        country['code']!,
                        style: TextStyle(
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
      AppSnackBar.showError(context, AppStrings.pleaseEnterPassword);
      return;
    }
    if (password.length < 6) {
      AppSnackBar.showError(context, AppStrings.passwordAtLeastSixCharacters);
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
          _showNotRegisteredDialog(context, AppStrings.mobileNotRegistered);
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
                  context, AppStrings.failedAcceptPolicyTryAgain);
            }
            return;
          }
        }

        await ref
            .read(authStateProvider.notifier)
            .setUserSession(token: token ?? '', user: user);

        // Navigate based on user role (matches Android logic)
        if (mounted) {
          if (user.profile == false) {
            context.push(AppRoutes.createProfile);
            return;
          }
          _navigateBasedOnRole(
              user?.isReferee == true ? 'referee' : user?.userType);
        }

      case AuthFailure(:final error):
        // Match Android error messages
        if (error.toLowerCase().contains('wrong password') ||
            error.toLowerCase().contains('incorrect password')) {
          AppSnackBar.showError(context, AppStrings.wrongPassword);
        } else if (error.toLowerCase().contains('not registered') ||
            error.toLowerCase().contains('account not found')) {
          AppSnackBar.showError(context, AppStrings.accountNotRegistered);
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

  // ─── Social — Google ──────────────────────────────────────────────────────

  Future<void> _googleLogin() async {
    setState(() => _isSocialLoading = true);
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final parts = (googleUser.displayName ?? '').trim().split(RegExp(r'\s+'));
      final firstName = parts.isNotEmpty ? parts.first : '';
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      await _socialLogin(
        socialId: googleUser.id,
        email: googleUser.email,
        firstName: firstName,
        lastName: lastName,
        media: 'google',
      );
    } on GoogleSignInException catch (e) {
      log('Google SignIn exception: code=${e.code}, desc=${e.description}');
      if (mounted && e.code != GoogleSignInExceptionCode.canceled) {
        AppSnackBar.showError(
            context, AppStrings.googleSignInFailedWithCode(e.code));
      }
    } on PlatformException catch (e) {
      log('Google PlatformException: code=${e.code}, msg=${e.message}');
      if (mounted && e.code != 'sign_in_canceled') {
        AppSnackBar.showError(context, AppStrings.googleSignInFailed);
      }
    } catch (e) {
      log('Google login error: $e');
      if (mounted)
        AppSnackBar.showError(context, AppStrings.googleSignInFailed);
    } finally {
      if (mounted) setState(() => _isSocialLoading = false);
    }
  }

  // ─── Social — Facebook ────────────────────────────────────────────────────

  Future<void> _facebookLogin() async {
    setState(() => _isSocialLoading = true);
    try {
      final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      if (result.status != LoginStatus.success) {
        return; // cancelled or denied — finally resets loader
      }
      final data = await FacebookAuth.instance.getUserData(
        fields: 'name,email',
      );
      final fullName = (data['name'] as String? ?? '').trim();
      final parts = fullName.split(RegExp(r'\s+'));
      final firstName = parts.isNotEmpty ? parts.first : '';
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      await _socialLogin(
        socialId: (data['id'] as String?) ?? '',
        email: (data['email'] as String?) ?? '',
        firstName: firstName,
        lastName: lastName,
        media: 'facebook',
      );
    } catch (_) {
      if (mounted)
        AppSnackBar.showError(context, AppStrings.facebookSignInFailed);
    } finally {
      if (mounted) setState(() => _isSocialLoading = false);
    }
  }

  // ─── Shared social login handler ─────────────────────────────────────────
  // Mirrors Android loginReqListener:
  //   status==1 + !user.isProfile() → SocialAgeSelectionFragment (create profile)
  //   status==1 + user.isProfile()  → policyAccepted() → openMainScreen()

  Future<void> _socialLogin({
    required String socialId,
    required String email,
    required String firstName,
    required String lastName,
    required String media, // 'google' | 'facebook'
  }) async {
    final result = await ref.read(authRepositoryProvider).socialLogin(
          socialId: socialId,
          email: email,
          firstName: firstName,
          lastName: lastName,
          media: media,
        );
    if (!mounted) return;
    switch (result) {
      case AuthSuccess(:final data):
        if (data.isNewUser) {
          // New user — profile not yet created; save session so CreateProfileScreen
          // can read currentUserProvider for the userId.
          final user = data.user;
          if (user == null) {
            AppSnackBar.showError(
                context, AppStrings.unexpectedResponseTryAgain);
            return;
          }
          await ref
              .read(authStateProvider.notifier)
              .setUserSession(token: data.token ?? '', user: user);
          if (mounted) context.push(AppRoutes.socialAge);
        } else {
          final user = data.user;
          if (user == null) {
            _showNotRegisteredDialog(
                context, AppStrings.unexpectedResponseTryAgain);
            return;
          }
          // token may be absent for social login — pass empty string so session
          // is still stored locally (matches Android behaviour which omits token)
          await ref
              .read(authStateProvider.notifier)
              .setUserSession(token: data.token ?? '', user: user);
          if (mounted) {
            _navigateBasedOnRole(
                user.isReferee == true ? 'referee' : user.userType);
          }
        }
      case AuthFailure(:final error):
        AppSnackBar.showError(context, error);
    }
  }

  // ─── UI helpers ──────────────────────────────────────────────────────────

  void _showNotRegisteredDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(dialogContext),
                  child: const Icon(Icons.close, color: Colors.black, size: 22),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                        context.push(AppRoutes.ageSelection);
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.signUpUpper,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.tryAgain,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _black = AppColors.socaBlack;
  static Color _yellow = AppColors.socaYellow;
  static Color _pageBg = AppColors.socaPageBg;
  static Color _inputFill = AppColors.socaGrey;

  static String _privacyText = AppStrings.socaLocaPrivacyNotice;

  /// Rounded grey box with thin black stroke — mirrors rounded_new_gray_5dp_stoke_black_1dp
  BoxDecoration get _inputBoxDecoration => BoxDecoration(
        color: _inputFill,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black, width: 0.8),
        boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
      );

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: _pageBg,
        // No AppBar — matches Android (LoginActivity has no action bar)
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Logo ────────────────────────────────────────────────
                    SizedBox(height: height * .18),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/socaloca_logo.svg',
                        width: 200,
                        // height: 150,
                        // fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: height * .07),

                    // ── Form content — 40dp horizontal padding ───────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // "Login" title
                          Text(
                            AppStrings.login,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: _black,
                            ),
                          ),

                          // ── Mobile/Email/SocaLoca ID input box ───────────────
                          SizedBox(height: 30),
                          SocaLocaMobileEmailField(
                            controller: _identityCtrl,
                            hintText: AppStrings.mobileEmailSocaLocaIdRequired,
                            onChanged: _onIdentityChanged,
                            showCountryCode: _showCountryCode,
                            countryCode: _selectedCountryCode,
                            onCountryCodeTap: _showCountryPicker,
                          ),

                          // ── Password input box ───────────────────────────────
                          SizedBox(height: 15),
                          SocaLocaPasswordField(
                            controller: _passCtrl,
                            hintText: AppStrings.passwordHint,
                            textInputAction: TextInputAction.go,
                          ),

                          // ── Mandatory fields + Forgotten Password ────────────
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.mandatoryFields,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: _black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push(
                                    AppRoutes.forgotPassword,
                                    extra: false),
                                child: Text(
                                  AppStrings.forgottenPassword,
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
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.lightbulb_outline,
                                  size: 15, color: _black),
                              SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  AppStrings.findSocaLocaIdHint,
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
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: _isLoading ? null : _login,
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,
                              decoration: BoxDecoration(
                                color: _black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                AppStrings.logInUpper,
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
                          SizedBox(height: 25),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(height: 0.5, color: _black),
                              Container(
                                color: _pageBg,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  AppStrings.orContinueWith,
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
                          SizedBox(height: 25),
                          Row(
                            children: [
                              // Facebook button
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                                      _isSocialLoading ? null : _facebookLogin,
                                  child: Opacity(
                                    opacity: _isSocialLoading ? 0.5 : 1.0,
                                    child: Image.asset(
                                      'assets/images/facebook_button.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
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
                          SizedBox(height: 40),
                          Visibility(
                            visible: false,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: _inputFill,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 0.8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    AppStrings.professionalClubQuestion,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: _black,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.loginSignupHere,
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
                          SizedBox(height: 20),
                          Padding(
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
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading || _isSocialLoading)
              Container(
                color: Colors.black54,
                child: AppLoader(size: 500),
              ),
          ],
        ),
      ),
    );
  }
}
