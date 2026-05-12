import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/home/widgets/home_app_bar.dart';
import 'package:socaloca/features/home/widgets/home_drawer.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';

/// MainShellScreen wraps all post-login screens with a bottom navigation bar.
/// Mirrors CommonHomeActivity with 6 tabs matching Android exactly.
///
/// Bottom nav: Home, Teams, Leagues/Cups, Clubs/Partners, Trials, Academies
class MainShellScreen extends ConsumerStatefulWidget {
  const MainShellScreen({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends ConsumerState<MainShellScreen> {
  int _currentIndex = 0;

  // 6 tabs matching Android CommonHomeActivity
  static const _tabs = [
    _NavTab(icon: Icons.home, label: 'HOME', route: AppRoutes.home),
    _NavTab(icon: Icons.groups, label: 'TEAMS', route: AppRoutes.teams),
    _NavTab(
        icon: Icons.emoji_events,
        label: 'TOURNAMENTS',
        route: AppRoutes.tournaments),
    _NavTab(
        icon: Icons.business, label: 'CLUBS', route: AppRoutes.clubsPartners),
    _NavTab(
        icon: Icons.person_2_outlined,
        label: 'PLAYERS',
        route: AppRoutes.players),
    _NavTab(icon: Icons.school, label: 'ACADEMIES', route: AppRoutes.academies),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    context.go(_tabs[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      endDrawer: const HomeDrawer(),
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_tabs.length, (index) {
                final tab = _tabs[index];
                final isActive = _currentIndex == index;
                return Expanded(
                  child: InkWell(
                    onTap: () => _onTap(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon with yellow circular background when active
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.socaYellow
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            tab.icon,
                            size: 20,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Label - uppercase, 8sp
                        Text(
                          tab.label,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 8,
                            color: AppColors.socaBlack,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTab {
  const _NavTab({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;
}
