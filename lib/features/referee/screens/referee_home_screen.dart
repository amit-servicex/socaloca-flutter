import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/widgets/home_app_bar.dart';
import '../../home/widgets/home_drawer.dart';

/// Bottom-nav shell for the Referee role.
/// Tabs: Tournament · My Requests · My Matches · Live Matches · My Bio
class RefereeHomeScreen extends ConsumerStatefulWidget {
  const RefereeHomeScreen({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<RefereeHomeScreen> createState() => _RefereeHomeScreenState();
}

class _RefereeHomeScreenState extends ConsumerState<RefereeHomeScreen> {
  int _currentIndex = 0;

  static const _tabs = [
    _RefereeNavTab(
      icon: "assets/icons/ic_leaguescups_new.png",
      label: 'TOURNAMENT',
      route: AppRoutes.refereeTournament,
    ),
    _RefereeNavTab(
      icon: 'assets/icons/ic_referee_my_requests.png',
      label: 'REQUESTS',
      route: AppRoutes.refereeRequests,
    ),
    _RefereeNavTab(
      icon: 'assets/icons/ic_referee_my_matches.png',
      label: 'MY MATCHES',
      route: AppRoutes.refereeMatches,
    ),
    _RefereeNavTab(
      icon: 'assets/images/live_matchs.png',
      label: 'LIVE',
      route: AppRoutes.refereeLive,
    ),
    _RefereeNavTab(
      icon: 'assets/icons/ic_my_bio.png',
      label: 'MY BIO',
      route: AppRoutes.refereeBio,
    ),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    context.go(_tabs[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      endDrawer: HomeDrawer(),
      body: widget.child,
      bottomNavigationBar: _RefereeBottomNav(
        currentIndex: _currentIndex,
        tabs: _tabs,
        onTap: _onTap,
      ),
    );
  }
}

class _RefereeBottomNav extends StatelessWidget {
  const _RefereeBottomNav({
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
  });

  final int currentIndex;
  final List<_RefereeNavTab> tabs;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
            children: List.generate(tabs.length, (index) {
              final tab = tabs[index];
              final isActive = currentIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.socaYellow
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            tab.icon,
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 2),
                      Text(
                        tab.label,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontSize: 7,
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
    );
  }
}

class _RefereeNavTab {
  const _RefereeNavTab({
    required this.icon,
    required this.label,
    required this.route,
  });

  final String icon;
  final String label;
  final String route;
}
