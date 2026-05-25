import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/home/widgets/home_app_bar.dart';
import 'package:socaloca/features/home/widgets/home_drawer.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';

/// MainShellScreen wraps all post-login screens with a bottom navigation bar.
/// Mirrors CommonHomeActivity with tabs matching Android exactly.
/// Referee role shows its own 5-tab nav; all other roles share the regular nav.
class MainShellScreen extends ConsumerStatefulWidget {
  const MainShellScreen({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends ConsumerState<MainShellScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Regular user tabs (non-referee roles)
  static const _tabs = [
    _NavTab(
      image: 'assets/icons/ic_home_new.png',
      label: 'HOME',
      route: AppRoutes.home,
    ),
    _NavTab(
      image: 'assets/icons/ic_teams_new.png',
      label: 'TEAMS',
      route: AppRoutes.teams,
    ),
    _NavTab(
      image: 'assets/icons/ic_leaguescups_new.png',
      label: 'TOURNAMENTS',
      route: AppRoutes.tournaments,
    ),
    _NavTab(
      image: 'assets/icons/ic_clubs_partners_new.png',
      label: 'CLUBS',
      route: AppRoutes.clubsPartners,
    ),
    _NavTab(
      image: 'assets/icons/ic_players_black.png',
      label: 'PLAYERS',
      route: AppRoutes.players,
    ),
    _NavTab(
      image: 'assets/icons/ic_academies_new_2.png',
      label: 'ACADEMIES',
      route: AppRoutes.academies,
    ),
    _NavTab(
      image: 'assets/icons/ham_menu.png',
      label: 'MENU',
      route: 'MENU',
    ),
  ];

  // Referee-role tabs
  static const _refereeTabs = [
    _NavTab(
      image: 'assets/icons/ic_leaguescups_new.png',
      label: 'TOURNAMENT',
      route: AppRoutes.refereeTournament,
    ),
    _NavTab(
      image: 'assets/icons/ic_referee_my_requests.png',
      label: 'REQUESTS',
      route: AppRoutes.refereeRequests,
    ),
    _NavTab(
      image: 'assets/icons/ic_referee_my_matches.png',
      label: 'MY MATCHES',
      route: AppRoutes.refereeMatches,
    ),
    _NavTab(
      image: 'assets/images/live_matchs.png',
      label: 'LIVE',
      route: AppRoutes.refereeLive,
    ),
    _NavTab(
      image: 'assets/icons/ic_my_bio.png',
      label: 'MY BIO',
      route: AppRoutes.refereeBio,
    ),
  ];

  void _onTap(int index, List<_NavTab> tabs) {
    setState(() => _currentIndex = index);
    final route = tabs[index].route;
    if (route == 'MENU') {
      _scaffoldKey.currentState?.openEndDrawer();
    } else if (route == AppRoutes.home) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  String _labelForTab(_NavTab tab) {
    switch (tab.route) {
      case AppRoutes.home:
        return AppStrings.home.toUpperCase();
      case AppRoutes.teams:
        return AppStrings.teams.toUpperCase();
      case AppRoutes.tournaments:
        return AppStrings.tournaments.toUpperCase();
      case AppRoutes.clubsPartners:
        return AppStrings.clubs.toUpperCase();
      case AppRoutes.players:
        return AppStrings.players.toUpperCase();
      case AppRoutes.academies:
        return AppStrings.academies.toUpperCase();
      case 'MENU':
        return AppStrings.menu.toUpperCase();
      default:
        return tab.label;
    }
  }

  bool _shouldHideTab(_NavTab tab, {required bool isFan}) {
    // Players tab: only visible for fans
    if (!isFan && tab.route == AppRoutes.players) return true;
    // Menu tab: hidden for fans
    if (isFan && tab.route == 'MENU') return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final user = ref.read(currentUserProvider);
    final isReferee = user?.isReferee ?? false;
    final isFan = user?.isFan ?? false;
    final tabs = isReferee ? _refereeTabs : _tabs;

    return Scaffold(
      key: _scaffoldKey,
      appBar: const HomeAppBar(),
      endDrawer: HomeDrawer(),
      body: widget.child,
      bottomNavigationBar: Container(
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
                final isActive = _currentIndex == index;

                // Role-based visibility only applies to the regular tab set
                if (!isReferee && _shouldHideTab(tab, isFan: isFan)) {
                  return const SizedBox();
                }

                return Expanded(
                  child: InkWell(
                    onTap: () => _onTap(index, tabs),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.socaYellow
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            tab.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _labelForTab(tab),
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
    required this.image,
    required this.label,
    required this.route,
  });

  final String image;
  final String label;
  final String route;
}
