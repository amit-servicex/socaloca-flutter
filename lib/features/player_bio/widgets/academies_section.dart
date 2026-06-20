import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/academy_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Academies Section for Endorse Tab
/// Shows horizontal scrollable list of academies
class AcademiesSection extends StatelessWidget {
  final List<AcademyModel> academies;
  final bool isLoadingAcademies;

  const AcademiesSection({
    super.key,
    required this.academies,
    required this.isLoadingAcademies,
  });

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    if (url.startsWith('file:///')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingAcademies) {
      return const AppLoader();
    }

    if (academies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'ACADEMIES'.tr,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
            if (academies.length > 3)
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to all academies
                },
                child: Text(
                  'view all'.tr,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.socaGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: academies.length,
              itemBuilder: (context, index) {
                final academy = academies[index];
                log("this is the academy id ${academy.academyId}");
                return GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.academyBio
                        .replaceFirst(':academyId', academy.academyId ?? ''));
                    // TODO: Navigate to academy bio
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.socaGrey.withOpacity(0.2),
                          ),
                          child: ClipOval(
                            child: _isValidImageUrl(academy.imageUrl)
                                ? CachedNetworkImage(
                                    imageUrl: ApiConstants.getImageUrl(
                                        academy.imageUrl),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const AppLoader(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.school,
                                      color: AppColors.socaGrey,
                                      size: 30,
                                    ),
                                  )
                                : const Icon(
                                    Icons.school,
                                    color: AppColors.socaGrey,
                                    size: 30,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          academy.name ?? '',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.socaBlack,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
