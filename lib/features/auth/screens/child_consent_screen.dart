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

/// Child Consent Screen (7-12 years old)
/// Collects minor's name and parent/guardian information before signup
/// Matches fragment_child_consent.xml layout
class ChildConsentScreen extends ConsumerStatefulWidget {
  ChildConsentScreen({super.key});

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
        _minorNameError = 'Please enter minor name';
      });
      isValid = false;
    }

    if (parentName.isEmpty) {
      setState(() {
        _parentNameError = 'Please enter parent/guardian name';
      });
      isValid = false;
    }

    if (parentEmail.isEmpty) {
      setState(() {
        _parentEmailError = 'Please enter a parent email';
      });
      isValid = false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(parentEmail)) {
      setState(() {
        _parentEmailError = 'Please enter a valid parent email';
      });
      isValid = false;
    }

    if (!_consentChecked) {
      AppSnackBar.showError(context, 'Please tick the checkbox');
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
          final consentId = data.consentId as String? ?? '';
          // Navigate to PIN setup screen
          context.push('${AppRoutes.pinSetup}?consentId=$consentId');

        case AuthFailure(:final error):
          AppSnackBar.showError(context, error);
      }
    } catch (e) {
      if (mounted) {
        AppSnackBar.showError(context, 'Error: $e');
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
                  'Accounts of children between the ages of 7 and 12 can only created and managed by a parent or guardian.'
                      .tr,
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
                  'Please fill out the fields below and tick the checkbox.'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'This is confirm that you are the legal guardian and will take full control and accountability of this account upon registering on behalf of a minor.'
                      .tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 36),

                // Childs Name
                _buildField(
                  label: 'Childs Name*',
                  controller: _minorNameController,
                  error: _minorNameError,
                  inputType: TextInputType.name,
                  onChanged: (_) => _removeErrors(),
                ),

                SizedBox(height: 20),

                // Parent/Guardian Name
                _buildField(
                  label: 'Parent/Guardians Name*',
                  controller: _parentNameController,
                  error: _parentNameError,
                  inputType: TextInputType.name,
                  onChanged: (_) => _removeErrors(),
                ),

                SizedBox(height: 20),

                // Parent/Guardian Email
                _buildField(
                  label: 'Parent/Guardians Email*',
                  controller: _parentEmailController,
                  error: _parentEmailError,
                  inputType: TextInputType.emailAddress,
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
                        'I consent that I am registering on behalf of a minor and will take full control of this SocaLoca account.'
                            .tr,
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
                    child: AppLoader(),
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
