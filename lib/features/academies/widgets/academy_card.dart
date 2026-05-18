import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/academy_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Academy card widget for displaying academy information
class AcademyCard extends StatelessWidget {
  final AcademyModel academy;
  final VoidCallback onViewTap;

  AcademyCard({
    super.key,
    required this.academy,
    required this.onViewTap,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Academy Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.socaGrey.withOpacity(0.2),
              ),
              child: ClipOval(
                child: _isValidImageUrl(academy.imageUrl)
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.mediaBaseUrl}${academy.imageUrl}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => AppLoader(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            SizedBox(width: 17),

            // Academy Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Academy Name
                  Text(
                    academy.name ?? '',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2),

                  // Category
                  if (academy.category != null && academy.category!.isNotEmpty)
                    Text(
                      'CATEGORY ${academy.category}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  SizedBox(height: 2),

                  // City
                  if (academy.city != null && academy.city!.isNotEmpty)
                    Text(
                      academy.city!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  SizedBox(height: 12),

                  // VIEW Button
                  GestureDetector(
                    onTap: onViewTap,
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'VIEW'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                        textAlign: TextAlign.center,
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
