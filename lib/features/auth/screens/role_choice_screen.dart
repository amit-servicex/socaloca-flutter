import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';

/// RoleChoiceFragment equivalent - matches Android XML layout exactly.
/// User selects their role: Player, Coach, Manager, Referee, Fan, or Professional Club.
/// After selection, navigates to appropriate login/signup flow.
class RoleChoiceScreen extends StatefulWidget {
  RoleChoiceScreen({super.key});

  @override
  State<RoleChoiceScreen> createState() => _RoleChoiceScreenState();
}

class _RoleChoiceScreenState extends State<RoleChoiceScreen> {
  String? _selectedRole;

  void _onRoleSelected(String role) {
    setState(() => _selectedRole = role);

    // Navigate based on role selection (matching Android logic)
    if (role == 'club') {
      context.push(AppRoutes.clubLogin);
    } else if (role == 'scout') {
      // Scout is hidden in Android (visibility="gone")
      context.push(AppRoutes.loginLanding);
    } else {
      context.push(AppRoutes.loginLanding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg, // new_white (#f6f6f6)
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 80), // Space for bottom text
                child: Column(
                  children: [
                    // Logo Box - marginTop 50dp
                    SizedBox(height: 100),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/socaloca_logo.svg',
                        width: 200,
                        // height: 150,
                        // fit: BoxFit.contain,
                      ),
                    ),

                    // Top Box - marginTop 30dp, marginLeft/Right 50dp
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "I AM" label with rounded background (3dp radius)
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 125,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.socaBlack, // new_black (#1c1c1c)
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              'I AM'.tr,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700, // poppins_bold
                                fontSize: 24,
                                color: AppColors
                                    .socaYellow, // new_yellow (#eeff41)
                                height: 1.0, // includeFontPadding="false"
                              ),
                            ),
                          ),

                          // Radio Group - marginTop 12dp (first item only)
                          SizedBox(height: 12),

                          // Player
                          _RadioOption(
                            value: 'player',
                            groupValue: _selectedRole,
                            label: 'A Player',
                            onChanged: (value) => _onRoleSelected(value!),
                          ),

                          // Coach
                          _RadioOption(
                            value: 'coach',
                            groupValue: _selectedRole,
                            label: 'A Coach',
                            onChanged: (value) => _onRoleSelected(value!),
                          ),

                          // Manager
                          _RadioOption(
                            value: 'manager',
                            groupValue: _selectedRole,
                            label: 'A Manager',
                            onChanged: (value) => _onRoleSelected(value!),
                          ),

                          // Referee
                          _RadioOption(
                            value: 'referee',
                            groupValue: _selectedRole,
                            label: 'A Referee',
                            onChanged: (value) => _onRoleSelected(value!),
                          ),

                          // Scout - hidden (visibility="gone" in Android)
                          // Not rendered

                          // Fan
                          _RadioOption(
                            value: 'fan',
                            groupValue: _selectedRole,
                            label: 'A Fan',
                            onChanged: (value) => _onRoleSelected(value!),
                          ),

                          // Professional Club
                          _RadioOption(
                            value: 'club',
                            groupValue: _selectedRole,
                            label: 'A Professional Club',
                            onChanged: (value) => _onRoleSelected(value!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Text - alignParentBottom, marginBottom 20dp
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Text(
              '*SocaLoca only collects the data is necessary to provides its service and\nstores it in the anonymised way in our own self-hosted analytics system.'
                  .tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400, // poppins_regular
                fontSize: 8,
                color: AppColors.socaBlack, // new_black
                height: 1.0, // includeFontPadding="false"
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Radio button option matching Android RadioButton style
class _RadioOption extends StatelessWidget {
  _RadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  final String value;
  final String? groupValue;
  final String label;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        // paddingVertical="10dp" paddingStart="7dp" paddingEnd="20dp"
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 7,
          right: 20,
        ),
        child: Row(
          children: [
            // Radio button circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColors.socaYellow : AppColors.socaBlack,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    )
                  : null,
            ),

            SizedBox(width: 12),

            // Label - poppins_bold, 16sp, new_black color
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700, // poppins_bold
                fontSize: 16,
                color: AppColors.socaBlack, // new_black
                height: 1.0, // includeFontPadding="false"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
