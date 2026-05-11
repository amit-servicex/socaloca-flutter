import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/tournament_models.dart';
import '../../providers/tournament_providers.dart';
import '../../widgets/tournament_banner_slider.dart';
import '../../widgets/tournament_header_widget.dart';
import '../../widgets/tournament_info_card.dart';
import '../../widgets/teams_horizontal_list.dart';
import '../../widgets/sponsors_horizontal_list.dart';
import 'tabs/league_matches_tab.dart';
import 'tabs/league_points_table_tab.dart';
import 'tabs/league_stats_tab.dart';
import 'tabs/league_match_management_tab.dart';

/// League Tournament Details Screen
/// Comprehensive tournament details with banner, info, teams, sponsors, and tabs
/// Matches Android TournamentDetailsFragment
class LeagueTournamentDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const LeagueTournamentDetailsScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<LeagueTournamentDetailsScreen> createState() =>
      _LeagueTournamentDetailsScreenState();
}

class _LeagueTournamentDetailsScreenState
    extends ConsumerState<LeagueTournamentDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabCount = 3;

  @override
  void initState() {
    super.initState();
    // Determine tab count based on user role
    final user = ref.read(currentUserProvider);
    if (user != null && _canManageMatches(user)) {
      _tabCount = 4; // Add MANAGE tab
    }
    _tabController = TabController(length: _tabCount, vsync: this);
  }

  bool _canManageMatches(user) {
    return user.isAdmin || user.isCoach || user.isReferee;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tournamentAsync =
        ref.watch(tournamentDetailsProvider(widget.tournamentId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: const Text(
          'Tournament Details',
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
      body: tournamentAsync.when(
        data: (tournament) {
          if (tournament == null) {
            return const Center(child: Text('Tournament not found'));
          }
          return _buildContent(tournament);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.socaYellow),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading tournament: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(
                      tournamentDetailsProvider(widget.tournamentId));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TournamentModel tournament) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Slider
                if (tournament.banners != null &&
                    tournament.banners!.isNotEmpty)
                  TournamentBannerSlider(
                    banners: tournament.banners!,
                    height: 200,
                  ),

                // Header with Follow Button
                TournamentHeaderWidget(
                  tournament: tournament,
                  isFollowing: tournament.isFollowing,
                  followCount: tournament.followCount,
                  onFollowTap: () => _handleFollowTap(tournament),
                ),

                // Tournament Info Card
                TournamentInfoCard(tournament: tournament),

                const SizedBox(height: 8),

                // Teams Playing
                if (tournament.teams != null && tournament.teams!.isNotEmpty)
                  TeamsHorizontalList(
                    teams: tournament.teams!,
                    onTeamTap: (teamId) {
                      context.push('${AppRoutes.teams}/$teamId');
                    },
                  ),

                const SizedBox(height: 8),

                // Sponsors
                if (tournament.sponsors != null &&
                    tournament.sponsors!.isNotEmpty)
                  SponsorsHorizontalList(
                    sponsors: tournament.sponsors!,
                  ),

                const SizedBox(height: 8),

                // Invitations Section (if user has invitations)
                _buildInvitationsSection(tournament),

                const SizedBox(height: 8),

                // Request to Join Button
                _buildRequestToJoinButton(tournament),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // Tabs Section
        Container(
          color: Colors.white,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: AppColors.socaBlack,
                unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
                indicatorColor: AppColors.socaYellow,
                indicatorWeight: 3,
                isScrollable: _tabCount > 3,
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
                tabs: [
                  const Tab(text: 'MATCHES'),
                  const Tab(text: 'POINTS'),
                  const Tab(text: 'STATS'),
                  if (_tabCount == 4) const Tab(text: 'MANAGE'),
                ],
              ),
            ],
          ),
        ),

        // Tab Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              LeagueMatchesTab(tournamentId: widget.tournamentId),
              LeaguePointsTableTab(tournamentId: widget.tournamentId),
              LeagueStatsTab(tournamentId: widget.tournamentId),
              if (_tabCount == 4)
                LeagueMatchManagementTab(tournamentId: widget.tournamentId),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvitationsSection(TournamentModel tournament) {
    // TODO: Implement invitations display
    // This would show pending invitations for user's teams
    return const SizedBox.shrink();
  }

  Widget _buildRequestToJoinButton(TournamentModel tournament) {
    // Don't show if tournament is closed
    if (tournament.status == 'end' || tournament.status == 'END') {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _handleRequestToJoin(tournament),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.socaYellow,
            foregroundColor: AppColors.socaBlack,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Request to Join',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleFollowTap(TournamentModel tournament) async {
    final notifier =
        ref.read(tournamentFollowProvider(widget.tournamentId).notifier);
    await notifier.toggleFollow(
      tournamentId: widget.tournamentId,
      currentFollowState: tournament.isFollowing,
    );

    // Refresh tournament details
    ref.invalidate(tournamentDetailsProvider(widget.tournamentId));
  }

  Future<void> _handleRequestToJoin(TournamentModel tournament) async {
    // Show team selection dialog
    final teamsAsync =
        ref.read(myTeamsForTournamentProvider(widget.tournamentId));

    teamsAsync.when(
      data: (teams) {
        if (teams.isEmpty) {
          _showNoTeamsDialog();
        } else {
          _showTeamSelectionDialog(teams, tournament);
        }
      },
      loading: () {
        // Show loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: AppColors.socaYellow),
          ),
        );
      },
      error: (error, stack) {
        _showErrorDialog('Failed to load teams: $error');
      },
    );
  }

  void _showNoTeamsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'No Eligible Teams',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'You don\'t have any teams eligible for this tournament.',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTeamSelectionDialog(
      List<TeamModel> teams, TournamentModel tournament) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Select Team',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return ListTile(
                title: Text(
                  team.teamName ?? 'Unknown',
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _submitJoinRequest(team, tournament);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitJoinRequest(
      TeamModel team, TournamentModel tournament) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColors.socaYellow),
      ),
    );

    final notifier =
        ref.read(joinRequestProvider(widget.tournamentId).notifier);
    await notifier.requestToJoin(
      tournamentId: widget.tournamentId,
      teamId: team.effectiveId,
      parentId: tournament.parentId,
      teamName: team.teamName,
      tmntName: tournament.name,
    );

    // Close loading dialog
    if (mounted) Navigator.pop(context);

    // Show result
    final state = ref.read(joinRequestProvider(widget.tournamentId));
    state.when(
      data: (success) {
        if (success) {
          _showSuccessDialog('Join request submitted successfully!');
        } else {
          _showErrorDialog('Failed to submit join request');
        }
      },
      loading: () {},
      error: (error, stack) {
        _showErrorDialog('Error: $error');
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Success',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
