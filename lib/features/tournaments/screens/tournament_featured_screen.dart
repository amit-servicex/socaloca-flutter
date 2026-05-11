import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/tournament_models.dart';
import '../data/tournament_repository.dart';
import '../widgets/tournament_banner_slider.dart';
import '../widgets/tournament_header_widget.dart';
import 'tabs/tournament_matches_tab.dart';
import 'tabs/tournament_points_table_tab.dart';
import 'tabs/tournament_stats_tab.dart';

/// Featured tournament screen — mirrors Android TournamentsFragment
/// Shows banner slider + header + tabs (Matches, Points Table, Stats)
class TournamentFeaturedScreen extends ConsumerStatefulWidget {
  const TournamentFeaturedScreen({super.key, required this.tournamentId});
  final String tournamentId;

  @override
  ConsumerState<TournamentFeaturedScreen> createState() =>
      _TournamentFeaturedScreenState();
}

class _TournamentFeaturedScreenState
    extends ConsumerState<TournamentFeaturedScreen>
    with SingleTickerProviderStateMixin {
  TournamentModel? _tournament;
  bool _loading = true;
  bool _isFollowing = false;
  int _followCount = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final data = await ref.read(tournamentRepositoryProvider).getTournamentDetails(
          userId: user.id,
          tournamentId: widget.tournamentId,
        );

    if (mounted && data != null) {
      setState(() {
        _tournament = data;
        _isFollowing = data.isFollowing;
        _followCount = data.followCount;
        _loading = false;
      });
    }
  }

  Future<void> _toggleFollow() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final result = await ref.read(tournamentRepositoryProvider).followTournament(
          userId: user.id,
          tournamentId: widget.tournamentId,
          myName: user.name,
          myImageUrl: user.profileImage,
          country: user.country,
          gender: user.userType,
          isPlayer: user.isPlayer,
          isCoach: user.isCoach,
          isAdmin: user.isAdmin,
          isFan: user.isFan,
        );

    if (result['success'] == true && mounted) {
      final newFollowing = result['isFollow'] as bool;
      setState(() {
        _isFollowing = newFollowing;
        _followCount += newFollowing ? 1 : -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Tournament',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.socaYellow),
            )
          : _tournament == null
              ? const Center(child: Text('Tournament not found'))
              : Column(
                  children: [
                    // Banner slider
                    if (_tournament!.banners != null &&
                        _tournament!.banners!.isNotEmpty)
                      TournamentBannerSlider(
                        banners: _tournament!.banners!,
                        height: 180,
                      ),

                    // Header
                    TournamentHeaderWidget(
                      tournament: _tournament!,
                      isFollowing: _isFollowing,
                      followCount: _followCount,
                      onFollowTap: _toggleFollow,
                    ),

                    // "View Tournament Details" button
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Navigate to full details screen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.socaBlack,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'View Tournament Details',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.socaYellow,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Tabs
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppColors.socaBlack,
                        unselectedLabelColor:
                            AppColors.socaBlack.withOpacity(0.5),
                        indicatorColor: AppColors.socaYellow,
                        indicatorWeight: 3,
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
                        tabs: const [
                          Tab(text: 'Matches'),
                          Tab(text: 'Points Table'),
                          Tab(text: 'Stats'),
                        ],
                      ),
                    ),

                    // Tab views
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          TournamentMatchesTab(
                              tournamentId: widget.tournamentId),
                          TournamentPointsTableTab(
                              tournamentId: widget.tournamentId),
                          TournamentStatsTab(tournamentId: widget.tournamentId),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
