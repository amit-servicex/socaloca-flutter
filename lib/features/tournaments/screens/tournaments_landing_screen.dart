import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/features/pickup_match/screens/pickup_match_screen.dart';
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
    _tournamentTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _tournamentTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authStateProvider).user;
    final isReferee = user?.isReferee ?? false;

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
                  if (!isReferee)
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
                      indicatorWeight: 2,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'TOURNAMENTS'),
                        Tab(text: 'ONE-OFF'),
                        Tab(text: 'PICK-UP'),
                      ],
                    ),

                  // Tournament sub-tabs (only visible when TOURNAMENTS is selected)
                  AnimatedBuilder(
                    animation: _mainTabController,
                    builder: (context, child) {
                      if (_mainTabController.index == 0) {
                        return Container(
                          color: AppColors.socaPageBg,
                          width: double.infinity,
                          child: TabBar(
                            controller: _tournamentTabController,
                            labelColor: Colors.black,
                            unselectedLabelColor:
                                Colors.black.withValues(alpha: 0.6),
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
                            indicatorWeight: 2,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            dividerColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'Ongoing'),
                              Tab(text: 'Upcoming'),
                              Tab(text: 'My Leagues/Cups'),
                              Tab(text: 'Closed'),
                            ],
                          ),
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
              child: TabBarView(
                controller: _mainTabController,
                children: [
                  // TOURNAMENTS tab with sub-tabs
                  TabBarView(
                    controller: _tournamentTabController,
                    children: [
                      TournamentListScreen(status: 'ongoing'),
                      TournamentListScreen(status: 'upcoming'),
                      TournamentListScreen(status: 'my'),
                      TournamentListScreen(status: 'closed'),
                    ],
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
}
