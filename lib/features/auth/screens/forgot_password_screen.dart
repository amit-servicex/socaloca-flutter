import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/services/location_service.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';

/// Mirrors ForgetPasswordFragmentNew.
///
/// Layout:
///   • Page bg #F6F6F6, no AppBar
///   • Logo centred (150 × 100 dp)
///   • "Forgot Password" title — 24sp Poppins Bold centred
///   • 3 RadioButtons: SocaLoca ID* (default) / Email* / Mobile Number*
///   • Input box — grey fill, thin black stroke
///     · Country-code prefix (tappable) shown only when signType == 'mobile'
///     · Hint text changes per selection
///   • Error text (12sp red) below input
///   • "* mandatory fields" label
///   • "SEND OTP" button — full-width, black bg, yellow text 22sp
///
/// [isClubPath] = true → club forgot-password (email-only, single step).
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  ForgotPasswordScreen({super.key, this.isClubPath = false});

  final bool isClubPath;

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  static String _typeSclId = 'sclId';
  static const String _typeEmail = 'email';
  static const String _typeMobile = 'mobile';

  String _signType = _typeSclId;
  final _inputCtrl = TextEditingController();
  String? _inputError;
  bool _isLoading = false;
  String _selectedCountryCode = '+91';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _detectCountry());
  }

  Future<void> _detectCountry() async {
    final country = await LocationService.detectCountry(context);
    if (!mounted || country == null) return;
    setState(() => _selectedCountryCode = country.phoneCode);
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }

  // ── Hint text per sign type ──────────────────────────────────────────────
  String get _hintText => switch (_signType) {
        _typeEmail => AppStrings.enterEmailRequired,
        _typeMobile => AppStrings.enterMobileNumberRequired,
        _ => AppStrings.enterSocaLocaIdRequired,
      };

  // ── Validation ───────────────────────────────────────────────────────────
  bool _validate() {
    final input = _inputCtrl.text.trim();
    String? err;
    switch (_signType) {
      case _typeMobile:
        if (input.length < 7) err = AppStrings.pleaseEnterValidMobileNumber;
        break;
      case _typeEmail:
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input)) {
          err = AppStrings.pleaseEnterValidEmail;
        }
        break;
      default:
        if (input.isEmpty) err = AppStrings.pleaseEnterValidSocaLocaId;
        break;
    }
    setState(() => _inputError = err);
    return err == null;
  }

  // ── Submit ───────────────────────────────────────────────────────────────
  Future<void> _sendOtp() async {
    if (!_validate()) return;
    setState(() => _isLoading = true);

    if (widget.isClubPath) {
      // Club path: legacy email reset link
      final result = await ref.read(authRepositoryProvider).forgotPassword(
            signType: _typeEmail,
            identifier: _inputCtrl.text.trim(),
            isClubPath: true,
          );
      if (!mounted) return;
      setState(() => _isLoading = false);
      switch (result) {
        case AuthSuccess():
          _showToast(AppStrings.resetLinkSentTo(_inputCtrl.text.trim()));
          if (mounted) Navigator.of(context).pop();
        case AuthFailure(:final error):
          setState(() => _inputError = error);
      }
      return;
    }

    // User path — multi-identifier OTP
    final result = await ref.read(authRepositoryProvider).forgotPassword(
          signType: _signType,
          identifier: _inputCtrl.text.trim(),
          countryCode: _signType == _typeMobile ? _selectedCountryCode : '',
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    switch (result) {
      case AuthSuccess(:final data):
        if (!data.contactExist && _signType == _typeSclId) {
          // SocaLoca ID has no email/mobile on file — show email dialog
          _showAddEmailDialog(data.userId);
          return;
        }
        _showToast(AppStrings.verificationCodeSent);
        if (mounted) {
          context.push(
            AppRoutes.resetPassword,
            extra: {
              'userId': data.userId,
              'signType': _signType,
              'identifier': _inputCtrl.text.trim(),
              'countryCode': _selectedCountryCode,
            },
          );
        }
      case AuthFailure(:final error):
        setState(() => _inputError = error);
    }
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: AppColors.socaBlack,
      ),
    );
  }

  // ── Email popup for SocaLoca ID users without contact ────────────────────
  void _showAddEmailDialog(String userId) {
    final emailCtrl = TextEditingController();
    String? dialogError;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setStateDialog) => AlertDialog(
          title: Text(
            AppStrings.addEmail,
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.addEmailOtpPrompt,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              ),
              SizedBox(height: 12),
              _buildInputBox(
                controller: emailCtrl,
                hint: AppStrings.emailAddressRequired,
                keyboardType: TextInputType.emailAddress,
              ),
              if (dialogError != null)
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    dialogError!,
                    style: TextStyle(
                        color: Colors.red, fontSize: 12, fontFamily: 'Poppins'),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(AppStrings.cancel,
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
            TextButton(
              onPressed: () async {
                final email = emailCtrl.text.trim();
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                  setStateDialog(
                      () => dialogError = AppStrings.pleaseEnterValidEmail);
                  return;
                }
                Navigator.of(ctx).pop();
                if (mounted) {
                  _showToast(AppStrings.verificationCodeSent);
                  context.push(
                    AppRoutes.resetPassword,
                    extra: {
                      'userId': userId,
                      'signType': _signType,
                      'identifier': _inputCtrl.text.trim(),
                      'countryCode': '',
                    },
                  );
                }
              },
              child: Text(AppStrings.sendOtp,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack)),
            ),
          ],
        ),
      ),
    );
  }

  // ── Country picker ───────────────────────────────────────────────────────
  Future<void> _pickCountry() async {
    final countries = [
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
      {'name': 'Ghana', 'code': '+233'},
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
    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(AppStrings.selectCountry,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (_, i) => ListTile(
                    dense: true,
                    title: Text(countries[i]['name']!,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                    trailing: Text(countries[i]['code']!,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    onTap: () {
                      setState(
                          () => _selectedCountryCode = countries[i]['code']!);
                      Navigator.of(ctx).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Input box helper ─────────────────────────────────────────────────────
  Widget _buildInputBox({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? formatters,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: AppColors.socaGrey,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: _inputError != null ? Colors.red : Colors.black,
            width: 0.8,
          ),
          boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8)],
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: formatters,
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 14, color: AppColors.socaBlack),
          decoration: InputDecoration(
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
                fontFamily: 'Poppins', fontSize: 14, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
          onChanged: (_) {
            if (_inputError != null) setState(() => _inputError = null);
          },
        ),
      );

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 40),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/socaloca_logo.svg',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),

                // ── Title ─────────────────────────────────────────────────
                Text(
                  AppStrings.forgotPassword,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.socaBlack,
                  ),
                ),
                SizedBox(height: 24),

                // ── Radio buttons (hidden for club path) ──────────────────
                if (!widget.isClubPath) ...[
                  _RadioOption(
                    label: AppStrings.socaLocaIdRequired,
                    value: _typeSclId,
                    groupValue: _signType,
                    onChanged: (v) => setState(() {
                      _signType = v;
                      _inputCtrl.clear();
                      _inputError = null;
                    }),
                  ),
                  _RadioOption(
                    label: AppStrings.emailRequired,
                    value: _typeEmail,
                    groupValue: _signType,
                    onChanged: (v) => setState(() {
                      _signType = v;
                      _inputCtrl.clear();
                      _inputError = null;
                    }),
                  ),
                  _RadioOption(
                    label: AppStrings.mobileNumberRequired,
                    value: _typeMobile,
                    groupValue: _signType,
                    onChanged: (v) => setState(() {
                      _signType = v;
                      _inputCtrl.clear();
                      _inputError = null;
                    }),
                  ),
                  SizedBox(height: 16),
                ],

                // ── Input box (with optional country code prefix) ─────────
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: _inputError != null ? Colors.red : Colors.black,
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0x22000000), blurRadius: 8)
                    ],
                  ),
                  child: Row(
                    children: [
                      // Country-code prefix — only when mobile selected
                      if (_signType == _typeMobile) ...[
                        GestureDetector(
                          onTap: _pickCountry,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _selectedCountryCode,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: AppColors.socaBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_drop_down,
                                    size: 18, color: AppColors.socaBlack),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            width: 0.5, height: 24, color: AppColors.socaBlack),
                      ],
                      // Text input
                      Expanded(
                        child: TextField(
                          controller: _inputCtrl,
                          keyboardType: _signType == _typeMobile
                              ? TextInputType.phone
                              : _signType == _typeEmail
                                  ? TextInputType.emailAddress
                                  : TextInputType.text,
                          maxLength: 100,
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
                            hintText: _hintText,
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey),
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                          ),
                          onChanged: (_) {
                            if (_inputError != null) {
                              setState(() => _inputError = null);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Error text ───────────────────────────────────────────
                if (_inputError != null) ...[
                  SizedBox(height: 6),
                  Text(
                    _inputError!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ],

                // ── Mandatory fields ─────────────────────────────────────
                SizedBox(height: 10),
                Text(
                  AppStrings.mandatoryFields,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack,
                  ),
                ),
                SizedBox(height: 24),

                // ── SEND OTP button ──────────────────────────────────────
                GestureDetector(
                  onTap: _isLoading ? null : _sendOtp,
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
                            widget.isClubPath
                                ? AppStrings.sendResetLink
                                : AppStrings.sendOtp,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: AppColors.socaYellow,
                            ),
                          ),
                  ),
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

// ─── Radio option widget ────────────────────────────────────────────────────
// Custom implementation avoids deprecated Radio.groupValue / Radio.onChanged
// (deprecated after Flutter v3.32.0).

class _RadioOption extends StatelessWidget {
  _RadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // Custom radio circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.socaBlack,
                  width: _selected ? 1.5 : 1,
                ),
              ),
              child: _selected
                  ? Center(
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
