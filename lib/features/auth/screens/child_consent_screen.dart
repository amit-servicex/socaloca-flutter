import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../data/auth_models.dart';
import '../providers/auth_provider.dart';

/// Child Consent Screen (7-12 years old)
/// Collects minor's name and parent/guardian information before signup
/// Matches fragment_child_consent.xml layout
class ChildConsentScreen extends ConsumerStatefulWidget {
  const ChildConsentScreen({super.key});

  @override
  ConsumerState<ChildConsentScreen> createState() => _ChildConsentScreenState();
}

class _ChildConsentScreenState extends ConsumerState<ChildConsentScreen> {
  final _minorNameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _parentEmailController = TextEditingController();

  bool _consentChecked = false;
  bool _isLoading = false;
  String? _minorNameError;
  String? _parentNameError;
  String? _parentEmailError;

  @override
  void dispose() {
    _minorNameController.dispose();
    _parentNameController.dispose();
    _parentEmailController.dispose();
    super.dispose();
  }

  void _removeErrors() {
    setState(() {
      _minorNameError = null;
      _parentNameError = null;
      _parentEmailError = null;
    });
  }

  bool _validateForm() {
    bool isValid = true;
    final minorName = _minorNameController.text.trim();
    final parentName = _parentNameController.text.trim();
    final parentEmail = _parentEmailController.text.trim();

    setState(() {
      _minorNameError = null;
      _parentNameError = null;
      _parentEmailError = null;
    });

    if (minorName.isEmpty) {
      setState(() {
        _minorNameError = AppStrings.pleaseEnterMinorName;
      });
      isValid = false;
    }

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
            minorName: _minorNameController.text.trim(),
            parentName: _parentNameController.text.trim(),
            parentEmail: _parentEmailController.text.trim(),
            ageGroup: 'child',
          );

      if (!mounted) return;

      switch (result) {
        case AuthSuccess(:final data):
          // Extract consentId from response
          final consentId = data.consentId ?? '';
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Title
                Text(
                  AppStrings.childConsentIntro,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppColors.socaBlack,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  AppStrings.fillFieldsAndTickCheckbox,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  AppStrings.childGuardianConfirmation,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 36),

                // Childs Name
                _buildField(
                  label: AppStrings.childsNameRequired,
                  controller: _minorNameController,
                  error: _minorNameError,
                  inputType: TextInputType.name,
                  onChanged: (_) => _removeErrors(),
                ),

                const SizedBox(height: 20),

                // Parent/Guardian Name
                _buildField(
                  label: AppStrings.parentGuardianNameRequired,
                  controller: _parentNameController,
                  error: _parentNameError,
                  inputType: TextInputType.name,
                  onChanged: (_) => _removeErrors(),
                ),

                const SizedBox(height: 20),

                // Parent/Guardian Email
                _buildField(
                  label: AppStrings.parentGuardianEmailRequired,
                  controller: _parentEmailController,
                  error: _parentEmailError,
                  inputType: TextInputType.emailAddress,
                  onChanged: (_) => _removeErrors(),
                ),

                const SizedBox(height: 12),

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
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Proceed button
                InkWell(
                  onTap: _isLoading ? null : _handleProceed,
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          AppStrings.proceedUpper,
                          style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.socaYellow,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                      // AppLoader   (),
                      ),
                ),

                const SizedBox(height: 50),
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
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.socaBlack,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.socaGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            onChanged: onChanged,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: AppColors.socaBlack,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              error,
              style: const TextStyle(
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
