import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/tournaments/screens/cup/tabs/cup_stage_tab.dart';
import 'package:socaloca/features/tournaments/screens/cup/tabs/cup_stats_tab.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/cup_models.dart';
import '../../providers/cup_providers.dart';
import '../../widgets/tournament_banner_slider.dart';
import '../../widgets/tournament_header_widget.dart';
import '../../widgets/tournament_info_card.dart';
import '../../widgets/teams_horizontal_list.dart';
import '../../widgets/sponsors_horizontal_list.dart';
import '../../../tournaments/data/tournament_models.dart';
import 'tabs/cup_info_tab.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Cup Tournament Details Screen
/// Comprehensive cup tournament details with banner, info, teams, sponsors, and tabs
/// Matches Android TournamentCupDetailsFragment
class CupTournamentDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  CupTournamentDetailsScreen({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<CupTournamentDetailsScreen> createState() =>
      _CupTournamentDetailsScreenState();
}

class _CupTournamentDetailsScreenState
    extends ConsumerState<CupTournamentDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cupAsync = ref.watch(cupDetailsProvider(widget.tournamentId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: Text(
          'Cup Tournament'.tr,
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
      body: cupAsync.when(
        data: (cup) {
          if (cup == null) {
            return Center(child: Text('Cup tournament not found'.tr));
          }
          return _buildContent(cup);
        },
        loading: () => AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Error loading cup: $error'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(cupDetailsProvider(widget.tournamentId));
                },
                child: Text('Retry'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TournamentCupModel cup) {
    return Column(
      children: [
        // Tabs Section at top
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 3,
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
              Tab(text: 'STAGE'),
              Tab(text: 'STATS'),
            ],
          ),
        ),

        // Tab Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Info Tab - Shows banner, header, info card, teams, sponsors
              CupInfoTab(
                cup: cup,
                onFollowTap: () => _handleFollowTap(cup),
                onRequestToJoin: () => _handleRequestToJoin(cup),
              ),

              // Stage Tab - Shows group stage or knockout bracket
              CupStageTab(
                tournamentId: widget.tournamentId,
                cup: cup,
              ),

              // Stats Tab - Shows stats for group/knockout modes
              CupStatsTab(
                tournamentId: widget.tournamentId,
                cup: cup,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleFollowTap(TournamentCupModel cup) async {
    final notifier = ref.read(cupFollowProvider(widget.tournamentId).notifier);
    await notifier.toggleFollow(
      tournamentId: widget.tournamentId,
      currentFollowState: cup.isFollowing,
    );

    // Refresh cup details
    ref.invalidate(cupDetailsProvider(widget.tournamentId));
  }

  Future<void> _handleRequestToJoin(TournamentCupModel cup) async {
    // Show team selection dialog
    final teamsAsync = ref.read(myTeamsForCupProvider(widget.tournamentId));

    teamsAsync.when(
      data: (teams) {
        if (teams.isEmpty) {
          _showNoTeamsDialog();
        } else {
          _showTeamSelectionDialog(teams, cup);
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
          'You don\'t have any teams eligible for this cup.'.tr,
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
      List<CupTeamModel> teams, TournamentCupModel cup) {
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
                  _submitJoinRequest(team, cup);
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
      CupTeamModel team, TournamentCupModel cup) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppLoader(),
    );

    final notifier =
        ref.read(cupJoinRequestProvider(widget.tournamentId).notifier);
    await notifier.requestToJoin(
      tournamentId: widget.tournamentId,
      teamId: team.effectiveId,
      parentId: cup.parentId,
      teamName: team.teamName,
      tmntName: cup.name,
    );

    // Close loading dialog
    if (mounted) Navigator.pop(context);

    // Show result
    final state = ref.read(cupJoinRequestProvider(widget.tournamentId));
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
