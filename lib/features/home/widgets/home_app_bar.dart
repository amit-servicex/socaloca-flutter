import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_providers.dart';

/// Custom app bar matching Android CommonHomeActivity header
/// Height: 56dp, Logo centered, Search and Notification icons on right
class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.showBackButton = false,
    this.title,
  });

  final bool showBackButton;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationCount = ref.watch(notificationCountProvider);

    return SafeArea(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              // Back button (left, conditional)
              if (showBackButton)
                IconButton(
                  icon:
                      const Icon(Icons.arrow_back, color: AppColors.socaBlack),
                  onPressed: () => context.pop(),
                )
              else
                const SizedBox(width: 40),

              // Title (if provided)
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else
                const Spacer(),

              // Logo (center)
              if (title == null)
                Image.asset(
                  'assets/images/logo.png',
                  width: 40,
                  height: 40,
                ),

              const Spacer(),

              // Search icon
              IconButton(
                icon: const Icon(Icons.search,
                    size: 25, color: AppColors.socaBlack),
                onPressed: () => context.push(AppRoutes.search),
              ),

              // Notification icon with badge
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications,
                        size: 25, color: AppColors.socaBlack),
                    onPressed: () => context.push(AppRoutes.notifications),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
