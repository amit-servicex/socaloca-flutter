import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:socaloca/core/theme/app_colors.dart';

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.id,
    this.tagType = 'user',
    this.isPlayer = false,
    this.isCoach = false,
    this.isAdmin = false,
  });

  final String name;
  final String imageUrl;
  final String id;

  /// "user" | "academy" | "team" etc.
  final String tagType;

  /// Role flags — only relevant when tagType == "user"
  final bool isPlayer;
  final bool isCoach;
  final bool isAdmin;

  void _onTap(BuildContext context) {
    if (id.isEmpty) return;

    switch (tagType) {
      case 'academy':
        context.push(AppRoutes.academyBio.replaceFirst(':academyId', id));
        break;
      case 'user':
      default:
        // Player takes priority; coaches/admins go to the members route
        if (isPlayer) {
          context.push(AppRoutes.playerBio.replaceFirst(':userId', id));
        } else {
          context.push(AppRoutes.coachAdminBio.replaceFirst(':userId', id));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(20),
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
                      Icons.person,
                      size: 14,
                      color: AppColors.socaBlack,
                    ),
                  )
                : const Icon(Icons.person,
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
