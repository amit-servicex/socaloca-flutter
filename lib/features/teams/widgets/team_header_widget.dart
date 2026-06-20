import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/api_constants.dart';
import 'package:socaloca/core/theme/app_colors.dart';
import 'package:socaloca/features/teams/data/models/team_bio_model.dart';

class TeamHeader extends StatelessWidget {
  final TeamDetailsModel teamDetails;
  const TeamHeader({super.key, required this.teamDetails});

  @override
  Widget build(BuildContext context) {
    final image = teamDetails.teamImage;
    final imageUrl = image != null && image.isNotEmpty
        ? '${ApiConstants.imageBaseUrl}$image'
        : '';
    final teamName = teamDetails.teamName?.trim().isNotEmpty == true
        ? teamDetails.teamName!.trim()
        : 'Team';
    final city = teamDetails.city?.trim() ?? '';

    return Container(
      width: double.infinity,
      color: AppColors.socaPageBg,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.groups,
                        color: AppColors.socaGrey,
                        size: 36,
                      ),
                    )
                  : const Icon(
                      Icons.groups,
                      color: AppColors.socaGrey,
                      size: 36,
                    ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            teamName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.socaBlack,
            ),
          ),
          if (city.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              city,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
