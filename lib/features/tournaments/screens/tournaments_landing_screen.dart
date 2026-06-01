import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/features/pickup_match/screens/pickup_match_screen.dart';
import 'package:socaloca/shared/models/user_model.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../one_off_matches/screens/one_off_matches_screen.dart';
import 'tournament_list_screen.dart';

/// Main tournaments landing screen with 3 main tabs:
/// - TOURNAMENTS (with 3 sub-tabs: Ongoing, Upcoming, Closed)
/// - ONE-OFF (standalone matches)
/// - PICK-UP (informal pickup matches — all roles)
class TournamentsLandingScreen extends ConsumerStatefulWidget {
  const TournamentsLandingScreen({super.key});

  @override
  ConsumerState<TournamentsLandingScreen> createState() =>
      _TournamentsLandingScreenState();
}

class _TournamentsLandingScreenState
    extends ConsumerState<TournamentsLandingScreen>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _tournamentTabController;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
    _tournamentTabController = TabController(
      length: _tournamentTabsFor(ref.read(authStateProvider).user).length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _tournamentTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).user;
    final tournamentTabs = _tournamentTabsFor(user);
    final usesTournamentOnlyLanding = _usesTournamentOnlyLanding(user);
    _syncTournamentTabController(tournamentTabs.length);

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Dynamic Top Bar Area ──
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Main tabs: TOURNAMENTS / ONE-OFF / PICK-UP
                  if (!_usesTournamentTopTabBarOnlyLanding(user))
                    TabBar(
                      controller: _mainTabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black.withValues(alpha: 0.6),
                      labelStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      indicatorColor: Colors.black,
                      indicatorWeight: 3,
                      isScrollable: false,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: AppStrings.tournaments.toUpperCase()),
                        Tab(text: AppStrings.oneOff.toUpperCase()),
                        if (!_usesTournamentTopTabBarOnlyLanding(user))
                          Tab(text: AppStrings.pickup.toUpperCase()),
                      ],
                    ),
                  // Tournament sub-tabs (only visible when TOURNAMENTS is selected)
                  if (usesTournamentOnlyLanding)
                    _TournamentTabBar(
                      controller: _tournamentTabController,
                      tabs: tournamentTabs,
                    )
                  else
                    AnimatedBuilder(
                      animation: _mainTabController,
                      builder: (context, child) {
                        if (_mainTabController.index == 0) {
                          return _TournamentTabBar(
                            controller: _tournamentTabController,
                            tabs: tournamentTabs,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                ],
              ),
            ),

            // ── Tab Views ──
            Expanded(
              child: usesTournamentOnlyLanding
                  ? _TournamentTabView(
                      controller: _tournamentTabController,
                      tabs: tournamentTabs,
                    )
                  : TabBarView(
                      controller: _mainTabController,
                      children: [
                        _TournamentTabView(
                          controller: _tournamentTabController,
                          tabs: tournamentTabs,
                        ),
                        // ONE-OFF tab
                        OneOffMatchesScreen(),
                        // PICK-UP tab — accessible to all roles
                        PickupMatchScreen(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  bool _usesTournamentOnlyLanding(UserModel? user) {
    final userType = user?.userType?.toLowerCase();
    return (user?.isReferee ?? false) ||
        (user?.isFan ?? false) ||
        userType == 'referee' ||
        userType == 'fan';
  }

  bool _usesTournamentTopTabBarOnlyLanding(UserModel? user) {
    final userType = user?.userType?.toLowerCase();
    return (user?.isReferee ?? false) ||
            // (user?.isFan ?? false) ||
            userType == 'referee'
        // ||
        // userType == 'fan'
        ;
  }

  List<_TournamentTabSpec> _tournamentTabsFor(UserModel? user) {
    final tabs = <_TournamentTabSpec>[
      _TournamentTabSpec(label: AppStrings.ongoing, status: 'ongoing'),
      _TournamentTabSpec(label: AppStrings.upcoming, status: 'upcoming'),
    ];

    if (!_usesTournamentOnlyLanding(user)) {
      tabs.add(
        _TournamentTabSpec(label: AppStrings.myLeaguesCups, status: 'my'),
      );
    }

    tabs.add(_TournamentTabSpec(label: AppStrings.closed, status: 'closed'));
    return tabs;
  }

  void _syncTournamentTabController(int length) {
    if (_tournamentTabController.length == length) return;
    _tournamentTabController.dispose();
    _tournamentTabController = TabController(length: length, vsync: this);
  }
}

class _TournamentTabSpec {
  const _TournamentTabSpec({
    required this.label,
    required this.status,
  });

  final String label;
  final String status;
}

class _TournamentTabBar extends StatelessWidget {
  const _TournamentTabBar({
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<_TournamentTabSpec> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black.withValues(alpha: 0.6),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      indicatorColor: Colors.black,
      indicatorWeight: 3,
      isScrollable: false,
      dividerColor: Colors.transparent,
      tabs: [
        for (final tab in tabs) Tab(text: tab.label),
      ],
    );
  }
}

class _TournamentTabView extends StatelessWidget {
  const _TournamentTabView({
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<_TournamentTabSpec> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        for (final tab in tabs) TournamentListScreen(status: tab.status),
      ],
    );
  }
}
