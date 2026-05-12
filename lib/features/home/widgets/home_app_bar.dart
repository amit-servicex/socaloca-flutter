import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

/// Maps route paths → display titles. Longer keys take priority over shorter
/// ones so sub-routes match before their parents.
const _routeTitles = {
  AppRoutes.mySkillRatings: 'My Ratings',
  AppRoutes.skillDetailViewAll: 'Skill Detail',
  AppRoutes.myEndorsementList: 'Endorsements',
  AppRoutes.myActivities: 'Activities',
  AppRoutes.createPost: 'Create Post',
  AppRoutes.editProfile: 'Edit Profile',
  AppRoutes.myPosts: 'My Posts',
  AppRoutes.gallery: 'Gallery',
  AppRoutes.skillDetail: 'Skill Detail',
  AppRoutes.myBio: 'My Bio',
  AppRoutes.teams: 'Teams',
  AppRoutes.tournaments: 'Tournaments',
  AppRoutes.clubsPartners: 'Clubs & Partners',
  AppRoutes.players: 'Players',
  AppRoutes.academies: 'Academies',
  AppRoutes.matches: 'Matches',
  AppRoutes.notifications: 'Notifications',
  AppRoutes.search: 'Search',
  AppRoutes.profile: 'Profile',
};

String? _titleForPath(String path) {
  // Sort by descending length so the most-specific match wins first.
  final keys = _routeTitles.keys.toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  for (final key in keys) {
    if (path == key || path.startsWith('$key/')) return _routeTitles[key];
  }
  // Dynamic segments (e.g. /players/:userId → 'Players')
  if (path.startsWith('/players/')) return 'Player';
  if (path.startsWith('/teams/')) return 'Team';
  if (path.startsWith('/clubs/')) return 'Club';
  if (path.startsWith('/tournaments/')) return 'Tournament';
  if (path.startsWith('/cups/')) return 'Cup';
  if (path.startsWith('/fa/')) return 'FA';
  if (path.startsWith('/confed/')) return 'Confederation';
  if (path.startsWith('/sponsor/')) return 'Sponsor';
  if (path.startsWith('/charity/')) return 'Charity';
  if (path.startsWith('/matches/')) return 'Match';
  if (path.startsWith('/pickup/')) return 'Pick-Up Match';
  if (path.startsWith('/one-off-matches/')) return 'Matches';
  if (path.startsWith('/match-management/')) return 'Match Management';
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
    final notificationCount = ref.watch(notificationCountProvider);
    final location = GoRouterState.of(context).uri.path;
    final isRoot = _rootRoutes.contains(location);
    final isHome = location == AppRoutes.home;
    final title = isHome ? null : _titleForPath(location);
    final showBack = !isRoot;

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
                  icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
                  onPressed: () => context.pop(),
                )
              else
                const SizedBox(width: 48),

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

              const Spacer(),

              // Search
              IconButton(
                icon: const Icon(Icons.search,
                    size: 25, color: AppColors.socaBlack),
                onPressed: () => context.push(AppRoutes.search),
              ),

              // Notification with badge
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
