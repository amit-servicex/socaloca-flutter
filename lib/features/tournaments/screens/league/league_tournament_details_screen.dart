import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/shared/providers/auth_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/tournament_models.dart';
import '../../providers/tournament_providers.dart';
import 'tabs/league_info_tab.dart';
import 'tabs/league_matches_tab.dart';
import 'tabs/league_stats_tab.dart';
import 'tabs/league_match_management_tab.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// League Tournament Details Screen
/// Tabs: INFO, MATCHES, STATS (+ optional MANAGE for admins/coaches/referees)
/// Matches Android TournamentDetailsFragment
class LeagueTournamentDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  LeagueTournamentDetailsScreen({
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
        title: Text(
          'Tournament Details'.tr,
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
          icon: Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
      ),
      body: tournamentAsync.when(
        data: (tournament) {
          if (tournament == null) {
            return Center(child: Text('Tournament not found'.tr));
          }
          return _buildContent(tournament);
        },
        loading: () => AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Error loading tournament: $error'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(
                      tournamentDetailsProvider(widget.tournamentId));
                },
                child: Text('Retry'.tr),
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
        // Tab bar
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withValues(alpha: 0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 3,
            isScrollable: _tabCount > 3,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: 'INFO'),
              Tab(text: 'MATCHES'),
              Tab(text: 'STATS'),
              if (_tabCount == 4) Tab(text: 'MANAGE'),
            ],
          ),
        ),

        // Tab views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              LeagueInfoTab(
                tournament: tournament,
                onFollowTap: () => _handleFollowTap(tournament),
                onRequestToJoin: () => _handleRequestToJoin(tournament),
              ),
              LeagueMatchesTab(tournamentId: widget.tournamentId),
              LeagueStatsTab(tournamentId: widget.tournamentId),
              if (_tabCount == 4)
                LeagueMatchManagementTab(tournamentId: widget.tournamentId),
            ],
          ),
        ),
      ],
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
          builder: (context) => AppLoader(),
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
        title: Text(
          'No Eligible Teams'.tr,
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          'You don\'t have any teams eligible for this tournament.'.tr,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'.tr),
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
        title: Text(
          'Select Team'.tr,
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
                  style: TextStyle(fontFamily: 'Poppins'),
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
            child: Text('Cancel'.tr),
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
      builder: (context) => AppLoader(),
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
        title: Text(
          'Success'.tr,
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'.tr),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error'.tr,
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'.tr),
          ),
        ],
      ),
    );
  }
}
