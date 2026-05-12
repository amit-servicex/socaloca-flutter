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
    final imageUrl = playerBio.imageUrl;
    final preferredJersey = playerBio.preferredJersey;
    final isVerified = playerBio.isVerifyBadge ?? false;
    final isOnline = playerBio.isOnline ?? false;

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      color: Colors.white,
      child: Column(
        children: [
          // Player Avatar with Online indicator
          Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.socaBlack,
                    width: 2.5,
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
                            child: const Icon(Icons.person, size: 60, color: Colors.white),
                          ),
                        )
                      : Container(
                          color: AppColors.socaGrey,
                          child: const Icon(Icons.person, size: 60, color: Colors.white),
                        ),
                ),
              ),
              // Online indicator
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.socaYellow,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.socaBlack,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Player Name and Jersey
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$firstName $lastName'.trim(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
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
              if (preferredJersey != null && preferredJersey.isNotEmpty) ...[
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    preferredJersey,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 5),

          // Profile Name
          if (profileName.isNotEmpty)
            Text(
              profileName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),

          const SizedBox(height: 15),

          // Country Flag Image (placeholder using icon if no image)
          if (playerBio.country != null && playerBio.country!.isNotEmpty)
            Container(
              width: 45,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Image.network(
                 'https://flagcdn.com/w40/in.png',
                 fit: BoxFit.cover,
                 errorBuilder: (_, __, ___) => const Icon(Icons.flag, color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}
