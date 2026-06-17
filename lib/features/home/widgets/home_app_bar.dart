import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/home_providers.dart';

/// Root tab routes — no back button, logo centered, no title on home.
const _rootRoutes = {
  AppRoutes.home,
  AppRoutes.teams,
  AppRoutes.tournaments,
  AppRoutes.clubsPartners,
  AppRoutes.players,
  AppRoutes.academies,
};

/// Returns the translated app bar title for the given route path.
/// Called inside build() so AppStrings reads the current language each time.
String? _titleForPath(String path) {
  // Static route → translated title
  if (path == AppRoutes.mySkillRatings ||
      path == AppRoutes.myEndorsementList ||
      path.startsWith('${AppRoutes.mySkillRatings}/') ||
      path.startsWith('${AppRoutes.myEndorsementList}/')) {
    return AppStrings.endorsements;
  }
  if (path == AppRoutes.skillDetail ||
      path == AppRoutes.skillDetailViewAll ||
      path.startsWith('${AppRoutes.skillDetail}/')) {
    return AppStrings.skillDetail;
  }
  if (path == AppRoutes.myActivities) {
    return AppStrings.downloadActivities;
  }
  if (path == AppRoutes.createPost) {
    return AppStrings.createPost;
  }
  if (path == AppRoutes.editProfile) {
    return AppStrings.editProfile;
  }
  if (path == AppRoutes.myPosts) {
    return AppStrings.posts;
  }
  if (path == AppRoutes.gallery) {
    return AppStrings.gallery;
  }
  if (path == AppRoutes.myBio) {
    return AppStrings.myBio;
  }
  if (path == AppRoutes.teams || path.startsWith('${AppRoutes.teams}/')) {
    return AppStrings.teams;
  }
  if (path == AppRoutes.tournaments ||
      path.startsWith('${AppRoutes.tournaments}/')) {
    return AppStrings.tournaments;
  }
  if (path == AppRoutes.clubsPartners) return AppStrings.clubsAndPartners;
  if (path == AppRoutes.players) return AppStrings.players;
  if (path == AppRoutes.academies) return AppStrings.academies;
  if (path == AppRoutes.matches) return AppStrings.matches;
  if (path == AppRoutes.notifications) return AppStrings.notifications;
  if (path == AppRoutes.search) return AppStrings.search;
  if (path == AppRoutes.profile) return AppStrings.myBio;
  // Dynamic segments
  if (path.contains('/people')) return AppStrings.people;
  if (path.contains('/likes')) return AppStrings.likes;
  if (path.startsWith('/players/')) return AppStrings.players;
  if (path.startsWith('/members/')) return AppStrings.coachManagerBio;
  if (path.startsWith('/teams/')) return AppStrings.teams;
  if (path.startsWith('/clubs/')) return AppStrings.clubs;
  if (path.startsWith('/tournaments/')) return AppStrings.tournaments;
  if (path.startsWith('/cups/')) return AppStrings.cup;
  if (path.startsWith('/fa/')) return AppStrings.fa;
  if (path.startsWith('/confed/')) return AppStrings.confederations;
  if (path.startsWith('/sponsor/')) return AppStrings.sponsors;
  if (path.startsWith('/charity/')) return AppStrings.charitiesAndNgos;
  if (path.startsWith('/matches/')) return AppStrings.matches;
  if (path.startsWith('/pickup/')) return AppStrings.pickup;
  if (path.startsWith('/one-off-matches/')) return AppStrings.matches;
  if (path.startsWith('/match-management/')) return AppStrings.matches;
  return null;
}

/// App bar used across the entire app via MainShellScreen.
/// Reads the current GoRouter location to auto-display the screen title.
/// Shows logo (centered) on root tabs; shows title + back button elsewhere.
class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final notificationCount = ref.watch(notificationCountProvider);
    final location = GoRouterState.of(context).uri.path;
    final isRoot = _rootRoutes.contains(location);
    final isHome = location == AppRoutes.home;
    final title = isHome ? null : _titleForPath(location);
    final showBack = !isRoot;
    final user = ref.read(currentUserProvider);
    // log("this is the user role ${user?.isReferee}");
    return SafeArea(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              // Back button or spacer
              if (showBack)
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Image.asset(
                    'assets/icons/ic_back_new_black.png',
                    width: 50,
                    height: 50,
                  ),
                  onPressed: () => context.pop(),
                )
              else
                const SizedBox(width: 30),

              // Title or spacer (pushes logo to center when no title)
              if (title != null)
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else
                const Spacer(),

              // Logo — always visible
              Image.asset(
                'assets/images/logo.png',
                width: 40,
                height: 40,
              ),
              SizedBox(
                  width: !(user?.isFan ?? false)
                      ? MediaQuery.of(context).size.width * 0.18
                      : MediaQuery.of(context).size.width * 0.014),
              // const Spacer(),

              // Search
              if (!(user?.isReferee ?? false))
                IconButton(
                  icon: Image.asset(
                    "assets/icons/ic_search.png",
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () => context.push(AppRoutes.search),
                ),

              // Notification with badge
              Stack(
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/icons/ic_notification.png",
                      width: 24,
                      height: 24,
                    ),
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
              if ((user?.isFan ?? false) || (user?.isReferee ?? false))
                IconButton(
                  icon: Image.asset(
                    "assets/icons/ic_hamburger_menu.png",
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
