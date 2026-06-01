import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/services/location_service.dart';
import '../../../shared/widgets/socaloca_text_field.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// NewSignUpFragment equivalent - matches Android XML layout exactly
/// User enters mobile/email and password to create account
class SignupScreen extends ConsumerStatefulWidget {
  SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _mobileOrEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _selectedCountryCode = '+91'; // Default to India
  String _selectedCountryIso = 'IN';
  String _selectedCountryName = 'India';
  String _inputType = 'email'; // 'email' or 'mobile'
  String? _mobileOrEmailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _detectCountry());
  }

  @override
  void dispose() {
    _mobileOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _detectCountry() async {
    final country = await LocationService.detectCountry(context);
    if (!mounted || country == null)
      return; // null = GPS failed, keep +91 default
    setState(() {
      _selectedCountryCode = country.phoneCode;
      _selectedCountryIso = country.iso;
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
                'Select Country'.tr,
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
                          _selectedCountryIso = country['iso']!;
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

  // Get phone code for country ISO code
  String _getPhoneCodeForCountry(String countryCode) {
    final map = {
      'US': '+1',
      'CA': '+1',
      'GB': '+44',
      'IN': '+91',
      'AU': '+61',
      'DE': '+49',
      'FR': '+33',
      'IT': '+39',
      'ES': '+34',
      'BR': '+55',
      'MX': '+52',
      'AR': '+54',
      'CL': '+56',
      'CO': '+57',
      'PE': '+51',
      'CN': '+86',
      'JP': '+81',
      'KR': '+82',
      'SG': '+65',
      'MY': '+60',
      'TH': '+66',
      'VN': '+84',
      'PH': '+63',
      'ID': '+62',
      'PK': '+92',
      'BD': '+880',
      'NG': '+234',
      'ZA': '+27',
      'EG': '+20',
      'KE': '+254',
      'SA': '+966',
      'AE': '+971',
      'TR': '+90',
      'RU': '+7',
      'UA': '+380',
      'PL': '+48',
      'NL': '+31',
      'BE': '+32',
      'SE': '+46',
      'NO': '+47',
      'DK': '+45',
      'FI': '+358',
      'PT': '+351',
      'GR': '+30',
      'IE': '+353',
      'NZ': '+64',
      'CH': '+41',
      'AT': '+43',
      'CZ': '+420',
      'HU': '+36',
    };
    return map[countryCode] ?? '+91';
  }

  // Get country name for ISO code
  String _getCountryNameForCode(String countryCode) {
    final map = {
      'US': 'USA',
      'CA': 'Canada',
      'GB': 'England',
      'IN': 'India',
      'AU': 'Australia',
      'DE': 'Germany',
      'FR': 'France',
      'IT': 'Italy',
      'ES': 'Spain',
      'BR': 'Brazil',
      'MX': 'Mexico',
      'AR': 'Argentina',
      'CL': 'Chile',
      'CO': 'Colombia',
      'PE': 'Peru',
      'CN': 'China',
      'JP': 'Japan',
      'KR': 'Korea Republic',
      'SG': 'Singapore',
      'MY': 'Malaysia',
      'TH': 'Thailand',
      'VN': 'Vietnam',
      'PH': 'Philippines',
      'ID': 'Indonesia',
      'PK': 'Pakistan',
      'BD': 'Bangladesh',
      'NG': 'Nigeria',
      'ZA': 'South Africa',
      'EG': 'Egypt',
      'KE': 'Kenya',
      'SA': 'Saudi Arabia',
      'AE': 'United Arab Emirates',
      'TR': 'Türkiye',
      'RU': 'Russia',
      'UA': 'Ukraine',
      'PL': 'Poland',
      'NL': 'Netherlands',
      'BE': 'Belgium',
      'SE': 'Sweden',
      'NO': 'Norway',
      'DK': 'Denmark',
      'FI': 'Finland',
      'PT': 'Portugal',
      'GR': 'Greece',
      'IE': 'Republic of Ireland',
      'NZ': 'New Zealand',
      'CH': 'Switzerland',
      'AT': 'Austria',
      'CZ': 'Czech Republic',
      'HU': 'Hungary',
    };
    return map[countryCode] ?? 'India';
  }

  // Get list of countries for picker
  List<Map<String, String>> _getCountryList() {
    return [
      {'name': 'Afghanistan', 'code': '+93', 'iso': 'AF'},
      {'name': 'Albania', 'code': '+355', 'iso': 'AL'},
      {'name': 'Algeria', 'code': '+213', 'iso': 'DZ'},
      {'name': 'Argentina', 'code': '+54', 'iso': 'AR'},
      {'name': 'Australia', 'code': '+61', 'iso': 'AU'},
      {'name': 'Austria', 'code': '+43', 'iso': 'AT'},
      {'name': 'Bangladesh', 'code': '+880', 'iso': 'BD'},
      {'name': 'Belgium', 'code': '+32', 'iso': 'BE'},
      {'name': 'Brazil', 'code': '+55', 'iso': 'BR'},
      {'name': 'Canada', 'code': '+1', 'iso': 'CA'},
      {'name': 'Chile', 'code': '+56', 'iso': 'CL'},
      {'name': 'China', 'code': '+86', 'iso': 'CN'},
      {'name': 'Colombia', 'code': '+57', 'iso': 'CO'},
      {'name': 'Denmark', 'code': '+45', 'iso': 'DK'},
      {'name': 'Egypt', 'code': '+20', 'iso': 'EG'},
      {'name': 'England', 'code': '+44', 'iso': 'GB'},
      {'name': 'Finland', 'code': '+358', 'iso': 'FI'},
      {'name': 'France', 'code': '+33', 'iso': 'FR'},
      {'name': 'Germany', 'code': '+49', 'iso': 'DE'},
      {'name': 'Greece', 'code': '+30', 'iso': 'GR'},
      {'name': 'India', 'code': '+91', 'iso': 'IN'},
      {'name': 'Indonesia', 'code': '+62', 'iso': 'ID'},
      {'name': 'Republic of Ireland', 'code': '+353', 'iso': 'IE'},
      {'name': 'Italy', 'code': '+39', 'iso': 'IT'},
      {'name': 'Japan', 'code': '+81', 'iso': 'JP'},
      {'name': 'Kenya', 'code': '+254', 'iso': 'KE'},
      {'name': 'Korea Republic', 'code': '+82', 'iso': 'KR'},
      {'name': 'Malaysia', 'code': '+60', 'iso': 'MY'},
      {'name': 'Mexico', 'code': '+52', 'iso': 'MX'},
      {'name': 'Netherlands', 'code': '+31', 'iso': 'NL'},
      {'name': 'New Zealand', 'code': '+64', 'iso': 'NZ'},
      {'name': 'Nigeria', 'code': '+234', 'iso': 'NG'},
      {'name': 'Norway', 'code': '+47', 'iso': 'NO'},
      {'name': 'Pakistan', 'code': '+92', 'iso': 'PK'},
      {'name': 'Peru', 'code': '+51', 'iso': 'PE'},
      {'name': 'Philippines', 'code': '+63', 'iso': 'PH'},
      {'name': 'Poland', 'code': '+48', 'iso': 'PL'},
      {'name': 'Portugal', 'code': '+351', 'iso': 'PT'},
      {'name': 'Russia', 'code': '+7', 'iso': 'RU'},
      {'name': 'Saudi Arabia', 'code': '+966', 'iso': 'SA'},
      {'name': 'Singapore', 'code': '+65', 'iso': 'SG'},
      {'name': 'South Africa', 'code': '+27', 'iso': 'ZA'},
      {'name': 'Spain', 'code': '+34', 'iso': 'ES'},
      {'name': 'Sweden', 'code': '+46', 'iso': 'SE'},
      {'name': 'Switzerland', 'code': '+41', 'iso': 'CH'},
      {'name': 'Thailand', 'code': '+66', 'iso': 'TH'},
      {'name': 'Türkiye', 'code': '+90', 'iso': 'TR'},
      {'name': 'Ukraine', 'code': '+380', 'iso': 'UA'},
      {'name': 'United Arab Emirates', 'code': '+971', 'iso': 'AE'},
      {'name': 'USA', 'code': '+1', 'iso': 'US'},
      {'name': 'Vietnam', 'code': '+84', 'iso': 'VN'},
    ];
  }

  void _onInputChanged(String value) {
    setState(() {
      _mobileOrEmailError = null;
      if (value.isEmpty) {
        _inputType = 'email';
      } else if (RegExp(r'^[0-9]+$').hasMatch(value)) {
        _inputType = 'mobile';
      } else {
        _inputType = 'email';
      }
    });
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _passwordError = null;
    });
  }

  bool _isPasswordStrong(String password) {
    return password.length >= 6;
  }

  bool _validateForm() {
    bool isValid = true;
    final input = _mobileOrEmailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _mobileOrEmailError = null;
      _passwordError = null;
    });

    if (input.isEmpty) {
      setState(() {
        _mobileOrEmailError = 'Please enter mobile or email';
      });
      isValid = false;
    } else if (_inputType == 'mobile' && input.length < 7) {
      setState(() {
        _mobileOrEmailError = 'Please enter a valid mobile number';
      });
      isValid = false;
    } else if (_inputType == 'email' && !input.contains('@')) {
      setState(() {
        _mobileOrEmailError = 'Please enter a valid email';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Please enter password';
      });
      isValid = false;
    } else if (password.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> _handleSignup() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final input = _mobileOrEmailController.text.trim();
      final password = _passwordController.text;

      final result = await ref.read(authRepositoryProvider).signUp(
            emailOrMobile: input,
            password: password,
            signType: _inputType,
            countryCode: _inputType == 'mobile' ? _selectedCountryCode : null,
            countryIso: _selectedCountryIso,
            ageGroup: 'adult', // TODO: Get from age selection screen
          );

      if (!mounted) return;

      switch (result) {
        case AuthSuccess(:final data):
          final user = data.user;
          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Unexpected response. Please try again.'.tr)),
            );
            return;
          }

          // Save user session with token
          final token = data.token ?? user.token ?? '';
          await ref.read(authStateProvider.notifier).setUserSession(
                token: token,
                user: user,
              );
          log("this gkjsdfg is the isprofile ${user.profile} and isverified ${user.isVerified}");
          // Navigate based on verification and profile status
          if (!user.isVerified) {
            // Navigate to OTP screen for verification
            context.push(AppRoutes.otp, extra: {
              'userId': user.id,
              'type': _inputType,
            });
          } else if (!user.profile) {
            // Navigate to create profile screen
            log("this gkjsdfg is the isprofile enter inside the if statement ");
            context.push(AppRoutes.createProfile);
          } else {
            // Already verified and has profile, go to home
            context.go(AppRoutes.home);
          }

        case AuthFailure(:final error):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordStrength = _passwordController.text.isEmpty
        ? null
        : _isPasswordStrong(_passwordController.text)
            ? 'Strong'
            : 'Weak';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg, // new_white
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Logo Box - marginTop 50dp
                SizedBox(height: 50),
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/socaloca_logo.svg',
                    width: 200,
                    // height: 150,
                    // fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                // Top Box - marginLeft/Right 40dp,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      // Title
                      Text(
                        'Sign Up'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.socaBlack,
                          height: 1.0,
                        ),
                      ),

                      SizedBox(height: 30),

                      // Mobile/Email Input Box
                      SocaLocaMobileEmailField(
                        controller: _mobileOrEmailController,
                        hintText: 'mobile number or email *'.tr,
                        onChanged: _onInputChanged,
                        showCountryCode: _inputType == 'mobile',
                        countryCode: _selectedCountryCode,
                        onCountryCodeTap: _showCountryPicker,
                      ),

                      // Mobile/Email Error
                      if (_mobileOrEmailError != null)
                        SocaLocaFieldError(errorText: _mobileOrEmailError!),

                      SizedBox(height: 15),

                      // Password Input Box
                      SocaLocaPasswordField(
                        controller: _passwordController,
                        hintText: 'password *'.tr,
                        onChanged: _onPasswordChanged,
                      ),

                      // Password Error
                      if (_passwordError != null)
                        SocaLocaFieldError(errorText: _passwordError!),

                      // Password Status Box
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Minimum 6 characters'.tr,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppColors.socaBlack,
                            ),
                          ),
                          if (passwordStrength != null)
                            Text(
                              passwordStrength,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 5),

                      // Mandatory fields text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '* mandatory fields'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      // Continue Button
                      InkWell(
                        onTap: _isLoading ? null : _handleSignup,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'SIGN UP'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: AppColors.socaYellow,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      // Or continue with
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 0.5,
                            color: AppColors.socaBlack,
                          ),
                          Container(
                            color: AppColors.socaPageBg,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'or continue with'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: AppColors.socaBlack,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),

                      // Social buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Facebook button
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // TODO: Implement Facebook login
                              },
                              child: Image.asset(
                                'assets/images/facebook_button.png',
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1877F2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          // Google button
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // TODO: Implement Google login
                              },
                              child: Image.asset(
                                'assets/images/google_plus_button.png',
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Icon(
                                      Icons.g_mobiledata,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 90),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Text - positioned at bottom
          Positioned(
            left: 40,
            right: 20,
            bottom: 20,
            child: Text(
              '*SocaLoca only collects the data is necessary to provides its service and\nstores it in the anonymised way in our own self-hosted analytics system.'
                  .tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 8,
                color: AppColors.socaBlack,
                height: 1.0,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: AppLoader(size: 500),
            ),
        ],
      ),
    );
  }
}
