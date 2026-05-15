import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/academies_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class AcademyTrialRegisterDialog extends ConsumerStatefulWidget {
  final String academyId;
  final String academyName;
  final String academyEmail;

  const AcademyTrialRegisterDialog({
    super.key,
    required this.academyId,
    required this.academyName,
    required this.academyEmail,
  });

  @override
  ConsumerState<AcademyTrialRegisterDialog> createState() =>
      _AcademyTrialRegisterDialogState();
}

class _AcademyTrialRegisterDialogState
    extends ConsumerState<AcademyTrialRegisterDialog> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final userId = StorageService.userId ?? '';
    final currentUser = StorageService.currentUser ?? {};
    final firstName = currentUser['firstName'] as String? ?? '';
    final lastName = currentUser['lastName'] as String? ?? '';
    final myName = '$firstName $lastName'.trim();

    try {
      final success =
          await ref.read(academiesRepositoryProvider).registerForTrial(
                userId: userId,
                academyId: widget.academyId,
                trialId: '',
                academyName: widget.academyName,
                myName: myName,
                email: _emailController.text.trim(),
                academyEmail: widget.academyEmail,
              );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            success
                ? 'Registration successful!'
                : 'Registration failed. Please try again.',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e',
              style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Register for Trial',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: AppColors.socaBlack,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.academyName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Your Email',
                labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.socaYellow),
                ),
              ),
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.socaBlack,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.socaBlack,
            foregroundColor: AppColors.socaYellow,
          ),
          child: _isSubmitting
              ? const AppLoader(size: 24, centered: false)
              : const Text(
                  'Register',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
        ),
      ],
    );
  }
}
