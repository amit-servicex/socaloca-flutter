import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';

/// Title provider — each child screen sets this so the AppBar updates.
final clubAppBarTitleProvider = StateProvider<String>((ref) => 'Club');

/// Club Admin home shell — AppBar + body only. No bottom navigation.
class ClubHomeScreen extends ConsumerWidget {
  const ClubHomeScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(clubAppBarTitleProvider);
    final clubName = StorageService.clubUser?['clubName'] as String? ?? 'Club';
    final displayTitle = title == 'Club' ? clubName : title;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaGrey,
        elevation: 0,
        leadingWidth: 160,

        leading: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Club Bio',
            // displayTitle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        title: Image.asset("assets/images/logo.png", height: 30),
        // centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        // leading: context.canPop()
        //     ? IconButton(
        //         icon: const Icon(Icons.arrow_back),
        //         onPressed: () => context.pop(),
        //       )
        //     : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.playedGray),
            tooltip: 'Logout',
            onPressed: () async {
              await StorageService.setClubLogin(false);
              if (context.mounted) context.go(AppRoutes.roleChoice);
            },
          ),
        ],
      ),
      body: child,
    );
  }
}
