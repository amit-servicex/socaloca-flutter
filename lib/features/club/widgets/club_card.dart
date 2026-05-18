import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/club_model.dart';

/// Club card matching Android common_clubs_cell.xml layout exactly:
/// - 80dp circular image on the left
/// - Club info column to the right (17dp gap)
/// - VIEW button below the info text, 80dp wide, left-aligned
class ClubCard extends StatelessWidget {
  final ClubModel club;

  ClubCard({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildClubImage(),
            SizedBox(width: 17),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (club.trialBadge) ...[
                    _buildTrialBadge(),
                    SizedBox(height: 2),
                  ],
                  Text(
                    club.clubName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    club.partnerLabel,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (club.country != null && club.country!.isNotEmpty)
                    Text(
                      club.country!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  SizedBox(height: 12),
                  _buildViewButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClubImage() {
    return Container(
      width: 80,
      height: 80,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: club.fullImageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: club.fullImageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: AppColors.socaGrey),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.socaGrey,
                  child: Icon(
                    Icons.sports_soccer,
                    color: AppColors.socaBlack,
                    size: 40,
                  ),
                ),
              )
            : Container(
                color: AppColors.socaGrey,
                child: Icon(
                  Icons.sports_soccer,
                  color: AppColors.socaBlack,
                  size: 40,
                ),
              ),
      ),
    );
  }

  Widget _buildTrialBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.socaBlack, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        'LIVE TRIAL'.tr,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  Widget _buildViewButton(BuildContext context) {
    return SizedBox(
      width: 80,
      child: ElevatedButton(
        onPressed: () {
          context.push('/clubs/${club.clubId}');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socaBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
          elevation: 0,
        ),
        child: Text(
          'VIEW'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.socaYellow,
          ),
        ),
      ),
    );
  }
}
