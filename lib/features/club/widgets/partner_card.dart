import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Generic partner card matching common Android cell layout:
/// fa_partners_cell / confed_partners_cell / sponsors_partners_cell /
/// charity_ngo_partner_cell — all share the same visual structure.
class PartnerCard extends StatelessWidget {
  final String name;
  final String fullImageUrl;
  final String? partnerLabel;
  final String? country;
  final bool trialBadge;
  final VoidCallback onView;

  PartnerCard({
    super.key,
    required this.name,
    required this.fullImageUrl,
    this.partnerLabel,
    this.country,
    this.trialBadge = false,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            SizedBox(width: 17),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (trialBadge) ...[
                    _buildTrialBadge(),
                    SizedBox(height: 2),
                  ],
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (partnerLabel != null && partnerLabel!.isNotEmpty) ...[
                    Text(
                      partnerLabel!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (country != null && country!.isNotEmpty)
                    Text(
                      country!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: onView,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 80,
      height: 80,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: fullImageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: fullImageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.socaGrey),
                errorWidget: (_, __, ___) => _imagePlaceholder(),
              )
            : _imagePlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
        color: AppColors.socaGrey,
        child: Icon(Icons.sports_soccer, color: AppColors.socaBlack, size: 40),
      );

  Widget _buildTrialBadge() => Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.socaBlack),
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
