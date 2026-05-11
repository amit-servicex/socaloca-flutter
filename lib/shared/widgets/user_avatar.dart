import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.imageUrl,
    this.name,
    required this.radius,
    this.onTap,
    this.badgeColor,
    this.showBorder = false,
  });

  final String? imageUrl;
  final String? name;
  final double radius;
  final VoidCallback? onTap;
  final Color? badgeColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: showBorder
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              )
            : null,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
          child: ClipOval(
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: radius * 2,
                    height: radius * 2,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _initials(),
                    errorWidget: (_, __, ___) => _initials(),
                  )
                : _initials(),
          ),
        ),
      ),
    );
  }

  Widget _initials() {
    final letters = name != null && name!.isNotEmpty
        ? name!.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : '?';
    return Container(
      width: radius * 2,
      height: radius * 2,
      color: AppColors.primaryLight.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: Text(
        letters,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: radius * 0.55,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
