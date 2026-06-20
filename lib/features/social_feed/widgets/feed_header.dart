import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';

/// Profile + action buttons header for the social feed.
/// Matches Android CommonHomeFeedFragment collapsible header.
class FeedHeaderWidget extends ConsumerWidget {
  const FeedHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();

    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // // Greeting row + avatar
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child: Row(
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const Text(
        //             'Hello ,',
        //             style: TextStyle(
        //               fontFamily: 'Poppins',
        //               fontSize: 13,
        //               color: AppColors.socaBlack,
        //             ),
        //           ),
        //           Text(
        //             user.name,
        //             style: const TextStyle(
        //               fontFamily: 'Poppins',
        //               fontWeight: FontWeight.w700,
        //               fontSize: 18,
        //               color: AppColors.socaBlack,
        //             ),
        //           ),
        //         ],
        //       ),
        //       const Spacer(),
        //       // 60 dp avatar
        //       CircleAvatar(
        //         radius: 30,
        //         backgroundColor: AppColors.socaGrey,
        //         backgroundImage: user.profileImage != null
        //             ? NetworkImage(user.profileImage!)
        //             : null,
        //         child: user.profileImage == null
        //             ? Text(
        //                 user.name[0].toUpperCase(),
        //                 style: const TextStyle(
        //                   fontSize: 24,
        //                   fontWeight: FontWeight.bold,
        //                   color: AppColors.socaBlack,
        //                 ),
        //               )
        //             : null,
        //       ),
        //     ],
        //   ),
        // ),

        // const Divider(height: 1, thickness: 0.5, color: AppColors.socaBlack),

        // // Action buttons: My Bio | My Posts | Gallery
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     _ActionButton(
        //       icon: Icons.person_outline,
        //       label: 'My Bio',
        //       onTap: () => context.push(AppRoutes.profile),
        //     ),
        //     _ActionButton(
        //       icon: Icons.article_outlined,
        //       label: 'My Posts',
        //       onTap: () {},
        //     ),
        //     _ActionButton(
        //       icon: Icons.photo_library_outlined,
        //       label: 'Gallery',
        //       onTap: () {},
        //     ),
        //   ],
        // ),

        // const Divider(height: 1, thickness: 0.5, color: AppColors.socaGrey),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: AppColors.socaBlack),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
