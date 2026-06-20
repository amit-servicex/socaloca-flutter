import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/player_bio_model.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';

/// Bio details section showing player information
class PlayerBioDetailsSection extends StatelessWidget {
  final PlayerBioModel playerBio;
  final bool isOwnProfile;

  const PlayerBioDetailsSection({
    super.key,
    required this.playerBio,
    required this.isOwnProfile,
  });

  String _getBornDisplay() {
    if (playerBio.dob != null && playerBio.dob!.isNotEmpty) {
      final parts = playerBio.dob!.split('-');
      if (parts.length == 3) {
        // Show full date if own profile, year only for others
        return isOwnProfile ? playerBio.dob! : parts[2];
      }
    }
    if (playerBio.yearOfBirth != null) {
      return playerBio.yearOfBirth.toString();
    }
    return '_';
  }

  bool _isYouthOrChild() {
    if (playerBio.dob == null || playerBio.dob!.isEmpty) return false;

    try {
      final parts = playerBio.dob!.split('-');
      if (parts.length == 3) {
        final year = int.parse(parts[2]);
        final currentYear = DateTime.now().year;
        final age = currentYear - year;
        return age < 18;
      }
    } catch (e) {
      // Ignore parsing errors
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ABOUT ME Section
        if (playerBio.aboutMe != null && playerBio.aboutMe!.isNotEmpty) ...[
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.socaGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  playerBio.aboutMe!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
              Positioned(
                  top: -25, left: 10, child: _buildSectionTitle('ABOUT ME')),
            ],
          ),
          const SizedBox(height: 20)
        ],
        const SizedBox(height: 15),

        // BIO Section
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGridRow('Born', _getBornDisplay(),
                            isBoldValue: true),
                        const SizedBox(height: 15),
                        _buildGridRowWithUpdate('Height (cms)',
                            playerBio.height?.toString() ?? '', context),
                        const SizedBox(height: 15),
                        _buildGridRow(
                            'Preferred Foot', playerBio.preferredFoot ?? '',
                            isBoldValue: true),
                        const SizedBox(height: 15),
                        _buildGridRow(
                            'Playing Level', playerBio.playLevel ?? '',
                            isBoldValue: true),
                      ],
                    ),
                  ),
                  // Vertical Divider
                  Container(
                    width: 1,
                    height: 150,
                    color: Colors.grey.shade400,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  // Right Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGridRow('Position', playerBio.playPosition ?? '',
                            isBoldValue: true),
                        if (playerBio.playPositionType != null) ...[
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              playerBio.playPositionType!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 15),
                        _buildGridRowWithUpdate('Nationality',
                            playerBio.nationality ?? '', context),
                        const SizedBox(height: 15),
                        _buildGridRow('Location', playerBio.country ?? '',
                            isBoldValue: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(top: -25, left: 10, child: _buildSectionTitle('BIO')),
          ],
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.socaBlack,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.socaYellow,
        ),
      ),
    );
  }

  Widget _buildGridRow(String label, String value, {bool isBoldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: isBoldValue ? FontWeight.w700 : FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridRowWithUpdate(
      String label, String value, BuildContext context) {
    bool hasValue = value.isNotEmpty;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          // flex: 3,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        if (!hasValue && isOwnProfile)
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.editProfile, extra: playerBio);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'UPDATE'.tr,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          )
        else
          Flexible(
            // flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),
          ),
      ],
    );
  }
}
