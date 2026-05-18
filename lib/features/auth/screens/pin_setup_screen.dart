import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';

/// PIN Setup screen for youth/child signup - 4 digit PIN for parental control
/// Equivalent to PinSetUpRegisterFragment.java
class PinSetupScreen extends ConsumerStatefulWidget {
  final String consentId;
  final bool isRegistration;

  PinSetupScreen({
    super.key,
    required this.consentId,
    this.isRegistration = true,
  });

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  final List<TextEditingController> _pinControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Auto-focus first digit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getEnteredPin() {
    return _pinControllers.map((c) => c.text).join();
  }

  bool _validatePin() {
    final pin = _getEnteredPin();

    if (pin.length != 4) {
      _showMessage('Please enter all 4 digits');
      return false;
    }

    // Check for repeating digits (1111, 2222, etc.)
    if (RegExp(r'^(\d)\1{3}$').hasMatch(pin)) {
      _showMessage('PIN cannot be all same digits');
      return false;
    }

    // Check for sequential numbers
    if (pin == '1234' || pin == '4321' || pin == '0123' || pin == '3210') {
      _showMessage('PIN cannot be sequential numbers');
      return false;
    }

    return true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleContinue() {
    if (_validatePin()) {
      final pin = _getEnteredPin();
      // Navigate to Parental Settings
      context.push(
        '${AppRoutes.parentalSettings}?consentId=${widget.consentId}&pin=$pin',
      );
    }
  }

  void _clearPin() {
    for (var controller in _pinControllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),

              // Title
              Center(
                child: Text(
                  'Parental Controls'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: AppColors.socaBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Spacer(),

              // Subtitle
              Center(
                child: Text(
                  'Set Your PIN'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),

              SizedBox(height: 40),

              // PIN Input Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 72,
                    height: 72,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      controller: _pinControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: AppColors.socaBlack,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.socaBlack,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.socaBlack,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.socaYellow,
                            width: 2.5,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        }
                      },
                      onTap: () {
                        _pinControllers[index].clear();
                      },
                    ),
                  );
                }).toList(),
              ),

              Spacer(),

              // Forgot PIN (only show if not registration)
              if (!widget.isRegistration)
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forget pin?'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ),

              // Continue Button
              InkWell(
                onTap: _handleContinue,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'SAVE AND CONTINUE'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32),

              // Info Text
              Text(
                '*Please note you can modify the pin from the "Parentals Control" in the hamburger menu, located at the top right of SOCALOCA app.'
                    .tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.socaBlack,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
