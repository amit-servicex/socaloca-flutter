import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/models/team_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/tournament_models.dart';
import '../../providers/tournament_providers.dart';
import 'tabs/league_info_tab.dart';

/// Opened when user taps the info icon on LeagueTournamentDetailsScreen.
/// Loads tournamentDetailsProvider and shows LeagueInfoTab.
class LeagueInfoDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const LeagueInfoDetailsScreen({super.key, required this.tournamentId});

  @override
  ConsumerState<LeagueInfoDetailsScreen> createState() =>
      _LeagueInfoDetailsScreenState();
}

class _LeagueInfoDetailsScreenState
    extends ConsumerState<LeagueInfoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final tournamentAsync =
        ref.watch(tournamentDetailsProvider(widget.tournamentId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   title: Text(
      //     'Tournament Details'.tr,
      //     style: const TextStyle(
      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w700,
      //       fontSize: 18,
      //       color: AppColors.socaBlack,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
      //     onPressed: () => context.pop(),
      //   ),
      // ),

      body: tournamentAsync.when(
        data: (tournament) {
          if (tournament == null) {
            return Center(child: Text(AppStrings.tournamentNotFound));
          }
          return LeagueInfoTab(
            tournament: tournament,
            onFollowTap: () => _handleFollowTap(tournament),
            onRequestToJoin: () => _handleRequestToJoin(tournament),
          );
        },
        loading: () => const AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(AppStrings.errorMessage(error)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref
                    .invalidate(tournamentDetailsProvider(widget.tournamentId)),
                child: Text(AppStrings.retry),
              ),
            ],
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
    ref.invalidate(tournamentDetailsProvider(widget.tournamentId));
  }

  Future<void> _handleRequestToJoin(TournamentModel tournament) async {
    final teamsAsync =
        ref.read(myTeamsForTournamentProvider(widget.tournamentId));
    teamsAsync.when(
      data: (teams) {
        if (teams.isEmpty) {
          _showDialog(
            title: AppStrings.noEligibleTeams,
            content: AppStrings.noEligibleTeamsTournament,
          );
        } else {
          _showTeamDialog(teams, tournament);
        }
      },
      loading: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const AppLoader(),
      ),
      error: (e, _) => _showDialog(
        title: AppStrings.error,
        content: 'Failed to load teams: $e',
      ),
    );
  }

  void _showTeamDialog(List<TeamModel> teams, TournamentModel tournament) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.selectTeam,
            style: const TextStyle(
                fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: teams.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(teams[i].name ?? 'Unknown',
                  style: const TextStyle(fontFamily: 'Poppins')),
              onTap: () {
                Navigator.pop(context);
                _submitJoinRequest(teams[i], tournament);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.cancel))
        ],
      ),
    );
  }

  Future<void> _submitJoinRequest(
      TeamModel team, TournamentModel tournament) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AppLoader(),
    );
    final notifier =
        ref.read(joinRequestProvider(widget.tournamentId).notifier);
    await notifier.requestToJoin(
      tournamentId: widget.tournamentId,
      teamId: team.id,
      parentId: tournament.parentId,
      teamName: team.name,
      tmntName: tournament.name,
    );
    if (mounted) Navigator.pop(context);
    final state = ref.read(joinRequestProvider(widget.tournamentId));
    state.when(
      data: (success) => _showDialog(
        title: success ? AppStrings.success : AppStrings.error,
        content: success
            ? 'Join request submitted successfully!'
            : 'Failed to submit join request',
      ),
      loading: () {},
      error: (e, _) => _showDialog(
          title: AppStrings.error, content: AppStrings.errorMessage(e)),
    );
  }

  void _showDialog({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title,
            style: const TextStyle(
                fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Text(content, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.ok))
        ],
      ),
    );
  }
}
