import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Youth Consent Screen (13-15 years old)
/// Collects parent/guardian information before signup
/// Matches fragment_youth_consent.xml layout
class YouthConsentScreen extends ConsumerStatefulWidget {
  YouthConsentScreen({super.key});

  @override
  ConsumerState<YouthConsentScreen> createState() => _YouthConsentScreenState();
}

class _YouthConsentScreenState extends ConsumerState<YouthConsentScreen> {
  final _parentNameController = TextEditingController();
  final _parentEmailController = TextEditingController();
  final _parentPhoneController = TextEditingController();

  bool _consentChecked = false;
  bool _isLoading = false;
  String? _parentNameError;
  String? _parentEmailError;
  String? _parentPhoneError;

  @override
  void dispose() {
    _parentNameController.dispose();
    _parentEmailController.dispose();
    _parentPhoneController.dispose();
    super.dispose();
  }

  void _removeErrors() {
    setState(() {
      _parentNameError = null;
      _parentEmailError = null;
      _parentPhoneError = null;
    });
  }

  bool _validateForm() {
    bool isValid = true;
    final parentName = _parentNameController.text.trim();
    final parentEmail = _parentEmailController.text.trim();
    final parentPhone = _parentPhoneController.text.trim();

    setState(() {
      _parentNameError = null;
      _parentEmailError = null;
      _parentPhoneError = null;
    });

    if (parentName.isEmpty) {
      setState(() {
        _parentNameError = AppStrings.pleaseEnterParentGuardianName;
      });
      isValid = false;
    }

    if (parentEmail.isEmpty) {
      setState(() {
        _parentEmailError = AppStrings.pleaseEnterParentEmail;
      });
      isValid = false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(parentEmail)) {
      setState(() {
        _parentEmailError = AppStrings.pleaseEnterValidParentEmail;
      });
      isValid = false;
    }

    if (parentPhone.isEmpty) {
      setState(() {
        _parentPhoneError = AppStrings.pleaseEnterMobileNumber;
      });
      isValid = false;
    } else if (parentPhone.length < 7) {
      setState(() {
        _parentPhoneError = AppStrings.pleaseEnterValidMobileNumber;
      });
      isValid = false;
    }

    if (!_consentChecked) {
      AppSnackBar.showError(context, AppStrings.pleaseTickCheckbox);
      isValid = false;
    }

    return isValid;
  }

  Future<void> _handleProceed() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final result = await ref.read(authRepositoryProvider).preRegister(
            parentName: _parentNameController.text.trim(),
            parentEmail: _parentEmailController.text.trim(),
            parentPhone: _parentPhoneController.text.trim(),
            ageGroup: 'youth',
          );

      if (!mounted) return;

      switch (result) {
        case AuthSuccess(:final data):
          // Extract consentId from response
          final consentId = data.consentId as String? ?? '';
          // Navigate to PIN setup screen
          context.push('${AppRoutes.pinSetup}?consentId=$consentId');

        case AuthFailure(:final error):
          AppSnackBar.showError(context, error);
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, AppStrings.errorMessage(e));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),

                // Title
                Text(
                  AppStrings.youthConsentTitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppColors.socaBlack,
                    height: 1.3,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  AppStrings.fillFieldsAndTickCheckbox,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  AppStrings.childGuardianConfirmation,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 36),

                // Parent/Guardian Name
                _buildField(
                  label: AppStrings.parentGuardianNameRequired,
                  controller: _parentNameController,
                  error: _parentNameError,
                  inputType: TextInputType.name,
                  onChanged: (_) => _removeErrors(),
                ),

                SizedBox(height: 20),

                // Parent/Guardian Email
                _buildField(
                  label: AppStrings.parentGuardianEmailRequired,
                  controller: _parentEmailController,
                  error: _parentEmailError,
                  inputType: TextInputType.emailAddress,
                  onChanged: (_) => _removeErrors(),
                ),

                SizedBox(height: 20),

                // Parent/Guardian Phone
                _buildField(
                  label: AppStrings.parentGuardianPhoneRequired,
                  controller: _parentPhoneController,
                  error: _parentPhoneError,
                  inputType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: (_) => _removeErrors(),
                ),

                SizedBox(height: 12),

                // Consent checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _consentChecked,
                      onChanged: (value) =>
                          setState(() => _consentChecked = value ?? false),
                      activeColor: AppColors.socaBlack,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.minorConsentText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Proceed button
                InkWell(
                  onTap: _isLoading ? null : _handleProceed,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.proceedUpper,
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.socaYellow,
                              fontWeight: FontWeight.bold),
                        ),
                      )

                      // AppLoader(),
                      ),
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String? error,
    required TextInputType inputType,
    int? maxLength,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.socaBlack,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.socaGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            maxLength: maxLength,
            onChanged: onChanged,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.socaBlack,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              counterText: '',
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              error,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
