import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../providers/legacy_contact_provider.dart';

class LegacyContactScreen extends ConsumerStatefulWidget {
  const LegacyContactScreen({super.key});

  @override
  ConsumerState<LegacyContactScreen> createState() =>
      _LegacyContactScreenState();
}

class _LegacyContactScreenState extends ConsumerState<LegacyContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String? _nameError;
  String? _emailError;
  bool _prefilled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(legacyContactProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Pre-fill form once existing contact data is loaded
  void _prefillIfNeeded(LegacyContactState state) {
    if (!_prefilled && state.hasContact && !state.isLoading) {
      _nameController.text = state.contactName;
      _emailController.text = state.contactEmail;
      _prefilled = true;
    }
  }

  bool _validate() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final myEmail = StorageService.userEmail ?? '';

    String? nameErr;
    String? emailErr;

    if (name.isEmpty) {
      nameErr = AppStrings.pleaseEnterName;
    }

    if (email.isEmpty) {
      emailErr = AppStrings.pleaseEnterEmail;
    } else if (!_isValidEmail(email)) {
      emailErr = AppStrings.pleaseEnterValidEmail;
    } else if (myEmail.isNotEmpty &&
        myEmail.toLowerCase() == email.toLowerCase()) {
      emailErr = AppStrings.thisIsYourOwnEmail;
    }

    setState(() {
      _nameError = nameErr;
      _emailError = emailErr;
    });

    return nameErr == null && emailErr == null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  Future<void> _save() async {
    if (!_validate()) return;

    final success = await ref.read(legacyContactProvider.notifier).save(
          contactName: _nameController.text.trim(),
          contactEmail: _emailController.text.trim(),
        );

    if (!mounted) return;
    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Legacy contact saved successfully.'.tr,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save. Please try again.'.tr,
              style: const TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(legacyContactProvider);
    _prefillIfNeeded(state);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: state.isLoading
          ? const AppLoader()
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Title ──────────────────────────────────────────────
                    Text(
                      'Legacy Contact'.tr,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Description ────────────────────────────────────────
                    Text(
                      AppStrings.legacyContactDescription,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.legacyContactInstruction,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Name field ─────────────────────────────────────────
                    _FormField(
                      controller: _nameController,
                      hint: AppStrings.nameRequired,
                      errorText: _nameError,
                      keyboardType: TextInputType.name,
                      onChanged: (_) {
                        if (_nameError != null) {
                          setState(() => _nameError = null);
                        }
                      },
                    ),
                    const SizedBox(height: 12),

                    // ── Email field ────────────────────────────────────────
                    _FormField(
                      controller: _emailController,
                      hint: AppStrings.emailRequired,
                      errorText: _emailError,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) {
                        if (_emailError != null) {
                          setState(() => _emailError = null);
                        }
                      },
                    ),
                    const SizedBox(height: 28),

                    // ── SAVE button ────────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: state.isSaving ? null : _save,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          color: AppColors.socaBlack,
                          alignment: Alignment.center,
                          child: state.isSaving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.socaYellow,
                                  ),
                                )
                              : Text(
                                  state.hasContact
                                      ? AppStrings.updateUpper
                                      : AppStrings.save,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: AppColors.socaYellow,
                                    letterSpacing: 1,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.hint,
    this.errorText,
    this.keyboardType,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: AppColors.socaBlack,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
