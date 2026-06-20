import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';

/// Parental Settings screen for youth/child signup
/// Equivalent to ParentalSettingsFragment.java
class ParentalSettingsScreen extends ConsumerStatefulWidget {
  final String consentId;
  final String pin;
  final bool isRegistration;

  const ParentalSettingsScreen({
    super.key,
    required this.consentId,
    required this.pin,
    this.isRegistration = true,
  });

  @override
  ConsumerState<ParentalSettingsScreen> createState() =>
      _ParentalSettingsScreenState();
}

class _ParentalSettingsScreenState
    extends ConsumerState<ParentalSettingsScreen> {
  final bool _commenting = false;
  bool _likingFollowing = false;
  bool _uploading = false;
  bool _consentGiven = false;

  void _handleSave() {
    if (!_consentGiven) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.pleaseProvideConsentToContinue),
        ),
      );
      return;
    }

    context.push(
      '${AppRoutes.signup}?consentId=${widget.consentId}&pin=${widget.pin}'
      '&commenting=${_commenting ? 1 : 0}'
      '&likingFollowing=${_likingFollowing ? 1 : 0}'
      '&uploading=${_uploading ? 1 : 0}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // Title
              Text(
                AppStrings.parentalControls,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: AppColors.socaBlack,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              // Subtitle
              Text(
                AppStrings.settings,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.socaBlack,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 36),

              // Liking and Following Switch
              _buildSwitchRow(
                AppStrings.likingAndFollowing,
                _likingFollowing,
                (value) => setState(() => _likingFollowing = value),
              ),

              const SizedBox(height: 12),

              // Uploading Photos & Videos Switch
              _buildSwitchRow(
                AppStrings.uploadingPhotosVideos,
                _uploading,
                (value) => setState(() => _uploading = value),
              ),

              const Spacer(),

              // Consent Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _consentGiven,
                    onChanged: (value) =>
                        setState(() => _consentGiven = value ?? false),
                    activeColor: AppColors.socaBlack,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.parentalControlConsent,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.socaBlack,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Save Button
              InkWell(
                onTap: _handleSave,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.saveAndContinueUpper,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Modify PIN Button (only show if not registration)
              if (!widget.isRegistration)
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.modifyPin,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.socaYellow,
          activeTrackColor: AppColors.socaYellow.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: AppColors.socaBlack,
            ),
          ),
        ),
      ],
    );
  }
}
