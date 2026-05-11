import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/features/pickup_match/screens/pickup_match_screen.dart';
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
    _tournamentTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _tournamentTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Matches',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96),
          child: Column(
            children: [
              // Main tabs: TOURNAMENTS / ONE-OFF / PICK-UP
              TabBar(
                controller: _mainTabController,
                labelColor: AppColors.socaBlack,
                unselectedLabelColor:
                    AppColors.socaBlack.withValues(alpha: 0.5),
                labelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                indicatorColor: AppColors.socaYellow,
                indicatorWeight: 3,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
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
                    return TabBar(
                      controller: _tournamentTabController,
                      labelColor: AppColors.socaBlack,
                      unselectedLabelColor:
                          AppColors.socaBlack.withValues(alpha: 0.5),
                      labelStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      indicatorColor: AppColors.socaYellow,
                      indicatorWeight: 2,
                      isScrollable: true,
                      tabs: const [
                        Tab(text: 'ONGOING'),
                        Tab(text: 'UPCOMING'),
                        Tab(text: 'CLOSED'),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _mainTabController,
        children: [
          // TOURNAMENTS tab with sub-tabs
          TabBarView(
            controller: _tournamentTabController,
            children: const [
              TournamentListScreen(status: 'ongoing'),
              TournamentListScreen(status: 'upcoming'),
              TournamentListScreen(status: 'closed'),
            ],
          ),
          // ONE-OFF tab
          const OneOffMatchesScreen(),
          // PICK-UP tab — accessible to all roles
          const PickupMatchScreen(),
        ],
      ),
    );
  }
}
