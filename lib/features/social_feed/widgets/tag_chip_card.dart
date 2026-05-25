import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:socaloca/core/theme/app_colors.dart';

class TagChip extends StatelessWidget {
  const TagChip({required this.name, required this.imageUrl, required this.id});

  final String name;
  final String imageUrl;
  final String id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.academyBio.replaceFirst(':academyId', id));
      },
      // decoration: BoxDecoration(
      //   color: AppColors.socaGrey,
      //   borderRadius: BorderRadius.circular(20),
      //   border: Border.all(
      //     color: AppColors.socaBlack.withValues(alpha: 0.15),
      //   ),
      // ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.shield,
                      size: 14,
                      color: AppColors.socaBlack,
                    ),
                  )
                : const Icon(Icons.shield,
                    size: 18, color: AppColors.socaBlack),
          ),
          const SizedBox(width: 6),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }
}
