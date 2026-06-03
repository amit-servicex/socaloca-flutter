import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

/// Custom text field matching Android design exactly
/// Background: grey with black border, 5dp rounded corners, 8dp elevation
/// Used in login, signup, and other auth screens
class SocaLocaTextField extends StatelessWidget {
  const SocaLocaTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.inputFormatters,
    this.prefixWidget,
    this.suffixWidget,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // 40dp + padding
      decoration: BoxDecoration(
        color: AppColors.socaGrey, // new_grey (#eaeae8)
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: AppColors.socaBlack, // black border
          width: 1, // 0.8dp ≈ 1px
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Prefix widget (e.g., country code)
          if (prefixWidget != null) prefixWidget!,

          // Text field
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              onChanged: onChanged,
              keyboardType: keyboardType,
              obscuringCharacter: '*',
              textInputAction: textInputAction,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              enabled: enabled,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400, // Regular
                fontSize: 18,
                color: AppColors.socaBlack,
                height: 1.0,
              ),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                  height: 1.0,
                ),
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 12,
                ),
                counterText: '', // Hide character counter
              ),
            ),
          ),

          // Suffix widget (e.g., visibility toggle)
          if (suffixWidget != null) suffixWidget!,
        ],
      ),
    );
  }
}

/// Password text field with visibility toggle
/// Matches Android password field design
class SocaLocaPasswordField extends StatefulWidget {
  const SocaLocaPasswordField({
    super.key,
    required this.controller,
    this.hintText = 'password *',
    this.onChanged,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  @override
  State<SocaLocaPasswordField> createState() => _SocaLocaPasswordFieldState();
}

class _SocaLocaPasswordFieldState extends State<SocaLocaPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SocaLocaTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      obscureText: !_isPasswordVisible,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      maxLength: 100,
      suffixWidget: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: InkWell(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(2),
              child: _isPasswordVisible
                  ? Image.asset(
                      "assets/icons/ic_password_eye.png",
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      "assets/icons/ic_visibility_off.png",
                      width: 30,
                      height: 30,
                    )
              // Icon(
              //   _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              //   color: AppColors.socaBlack,
              //   size: 26,
              // ),
              ),
        ),
      ),
    );
  }
}

/// Mobile/Email text field with optional country code picker
/// Matches Android mobile/email field design
class SocaLocaMobileEmailField extends StatelessWidget {
  const SocaLocaMobileEmailField({
    super.key,
    required this.controller,
    this.hintText = 'mobile number or email *',
    this.onChanged,
    this.showCountryCode = false,
    this.countryCode = '+91',
    this.onCountryCodeTap,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool showCountryCode;
  final String countryCode;
  final VoidCallback? onCountryCodeTap;

  @override
  Widget build(BuildContext context) {
    return SocaLocaTextField(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 100,
      prefixWidget: showCountryCode
          ? InkWell(
              onTap: onCountryCodeTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      countryCode,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                      color: AppColors.socaBlack,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

/// Flat text field for the Create Profile screen.
/// No border, no shadow — grey background with 5dp rounded corners.
class CreateProfileTextField extends StatelessWidget {
  const CreateProfileTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.inputFormatters,
    this.suffixWidget,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.socaGrey, // lighter grey background
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              onChanged: onChanged,
              keyboardType: keyboardType,
              obscuringCharacter: '*',
              textInputAction: textInputAction,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              enabled: enabled,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.socaBlack,
                height: 1.0,
              ),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.socaBlack,
                  height: 1.0,
                ),
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                counterText: '',
              ),
            ),
          ),
          if (suffixWidget != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: suffixWidget!,
            ),
        ],
      ),
    );
  }
}

/// Error text widget matching Android design
/// Shows below text field with Poppins Bold, 12sp
class SocaLocaFieldError extends StatelessWidget {
  const SocaLocaFieldError({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        errorText,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700, // Bold
          fontSize: 12,
          color: AppColors.socaBlack,
          height: 1.0,
        ),
      ),
    );
  }
}
