import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/router/app_routes.dart';

import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';

/// Title provider — each child screen sets this so the AppBar updates.
final clubAppBarTitleProvider = StateProvider<String>((ref) => AppStrings.club);

/// Club Admin home shell — AppBar + body only. No bottom navigation.
class ClubHomeScreen extends ConsumerWidget {
  const ClubHomeScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(clubAppBarTitleProvider);
    final clubName =
        StorageService.clubUser?['clubName'] as String? ?? AppStrings.club;
    final displayTitle = title == AppStrings.club ? clubName : title;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaGrey,
        elevation: 0,
        leadingWidth: 160,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppStrings.clubBio,
            // displayTitle,
            style: const TextStyle(
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
        //         icon: Icon(Icons.arrow_back),
        //         onPressed: () => context.pop(),
        //       )
        //     : null,
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/icons/ic_sign_out.png",
              width: 28,
              height: 28,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            tooltip: AppStrings.signOut,
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
