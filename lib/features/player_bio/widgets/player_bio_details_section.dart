import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/player_bio_model.dart';

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
    final isYouth = _isYouthOrChild();

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BIO DETAILS',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 15),

          // Born
          _buildDetailRow(
            label: 'Born',
            value: _getBornDisplay(),
          ),

          // Height (hidden for youth/child)
          if (!isYouth && playerBio.height != null)
            _buildDetailRow(
              label: 'Height',
              value: '${playerBio.height} cm',
            ),

          // Gender (shown for youth/child only)
          if (isYouth && playerBio.gender != null)
            _buildDetailRow(
              label: 'Gender',
              value: playerBio.gender!,
            ),

          // Preferred Foot
          if (playerBio.preferredFoot != null)
            _buildDetailRow(
              label: 'Preferred Foot',
              value: playerBio.preferredFoot!,
            ),

          // Playing Level
          if (playerBio.playLevel != null)
            _buildDetailRow(
              label: 'Playing Level',
              value: playerBio.playLevel!,
            ),

          // Jersey Size
          if (playerBio.jerseySize != null)
            _buildDetailRow(
              label: 'Jersey Size',
              value: playerBio.jerseySize!,
            ),

          // Shoe Size
          if (playerBio.shoeSize != null)
            _buildDetailRow(
              label: 'Shoe Size',
              value: playerBio.shoeSizeUnit != null
                  ? '${playerBio.shoeSize} (${playerBio.shoeSizeUnit})'
                  : playerBio.shoeSize!,
            ),

          // Nationality
          if (playerBio.nationality != null && playerBio.nationality!.isNotEmpty)
            _buildDetailRow(
              label: 'Nationality',
              value: playerBio.nationality!,
            ),

          // About Me
          if (playerBio.aboutMe != null && playerBio.aboutMe!.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              'ABOUT ME',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              playerBio.aboutMe!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.socaGrey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
