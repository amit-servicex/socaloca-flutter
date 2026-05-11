import 'package:flutter/material.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_model.dart';

/// Player card widget matching Android fan_player_cell.xml
class PlayerCard extends StatelessWidget {
  final PlayerModel player;
  final VoidCallback? onTap;

  const PlayerCard({
    super.key,
    required this.player,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: Player image and jersey
            Column(
              children: [
                // Player image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.socaBlack,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: player.imageUrl != null &&
                            player.imageUrl!.isNotEmpty &&
                            !player.imageUrl!.startsWith('file:///')
                        ? Image.network(
                            ApiConstants.getImageUrl(player.imageUrl),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.socaGrey,
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            color: AppColors.socaGrey,
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                
                // Jersey number badge
                if (player.teamJerseyNo != null &&
                    player.teamJerseyNo!.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.socaGrey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Jersey N°',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack,
                            height: 1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          player.teamJerseyNo!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.socaBlack,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            
            const SizedBox(width: 10),
            
            // Right side: Player info and button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Player name
                  Row(
                    children: [
                      if (player.firstName != null)
                        Text(
                          player.firstName!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack,
                            height: 1,
                          ),
                        ),
                      if (player.firstName != null && player.lastName != null)
                        const SizedBox(width: 3),
                      if (player.lastName != null)
                        Flexible(
                          child: Text(
                            player.lastName!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaBlack,
                              height: 1,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 3),
                  
                  // Position info
                  Row(
                    children: [
                      if (player.playPosition != null)
                        Text(
                          player.playPosition!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      if (player.playPosition != null &&
                          player.playPositionType != null) ...[
                        const SizedBox(width: 3),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: AppColors.socaBlack,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 3),
                      ],
                      if (player.playPositionType != null)
                        Text(
                          player.playPositionType!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.socaBlack,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // View details button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'VIEW DETAILS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaYellow,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
