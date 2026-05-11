import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_bio_model.dart';

/// Player bio header with avatar, name, country, etc.
class PlayerBioHeader extends StatelessWidget {
  final PlayerBioModel playerBio;
  final bool isOwnProfile;

  const PlayerBioHeader({
    super.key,
    required this.playerBio,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = playerBio.firstName ?? '';
    final lastName = playerBio.lastName ?? '';
    final profileName = playerBio.profileName ?? '';
    final sclId = playerBio.sclId ?? '';
    final imageUrl = playerBio.imageUrl;
    final preferredJersey = playerBio.preferredJersey;
    final isVerified = playerBio.isVerifyBadge ?? false;
    final isOnline = playerBio.isOnline ?? false;

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Jersey Number (top-left corner)
              if (preferredJersey != null && preferredJersey.isNotEmpty)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.socaYellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      preferredJersey,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ),

              const Spacer(),

              // Player Avatar
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.socaBlack,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: imageUrl != null &&
                              imageUrl.isNotEmpty &&
                              !imageUrl.startsWith('file:///')
                          ? Image.network(
                              ApiConstants.getImageUrl(imageUrl),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: AppColors.socaGrey,
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              color: AppColors.socaGrey,
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  // Online/Offline indicator
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Country Flag (placeholder)
              Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.socaGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.flag,
                  size: 20,
                  color: AppColors.socaBlack,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Player Name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firstName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                lastName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              if (isVerified) ...[
                const SizedBox(width: 5),
                const Icon(
                  Icons.verified,
                  size: 20,
                  color: Colors.blue,
                ),
              ],
            ],
          ),

          const SizedBox(height: 5),

          // Profile Name
          if (profileName.isNotEmpty)
            Text(
              '@$profileName',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.socaGrey,
              ),
            ),

          const SizedBox(height: 5),

          // Socaloca ID
          if (sclId.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.socaGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'SCL ID: $sclId',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

          const SizedBox(height: 10),

          // Position
          if (playerBio.playPosition != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  playerBio.playPosition!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.socaBlack,
                  ),
                ),
                if (playerBio.playPositionType != null) ...[
                  const SizedBox(width: 5),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.socaBlack,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    playerBio.playPositionType!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ],
            ),

          // Country
          if (playerBio.country != null)
            Text(
              playerBio.country!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.socaGrey,
              ),
            ),
        ],
      ),
    );
  }
}
