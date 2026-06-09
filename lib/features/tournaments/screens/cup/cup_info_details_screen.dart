import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/cup_models.dart';
import '../../providers/cup_providers.dart';
import 'tabs/cup_info_tab.dart';

/// Screen shown when user taps the info icon on CupTournamentDetailsScreen.
/// Loads getCupDetails API and renders CupInfoTab.
class CupInfoDetailsScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const CupInfoDetailsScreen({super.key, required this.tournamentId});

  @override
  ConsumerState<CupInfoDetailsScreen> createState() =>
      _CupInfoDetailsScreenState();
}

class _CupInfoDetailsScreenState extends ConsumerState<CupInfoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cupAsync = ref.watch(cupDetailsProvider(widget.tournamentId));

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

      body: cupAsync.when(
        data: (cup) {
          if (cup == null) {
            return Center(child: Text(AppStrings.tournamentNotFound));
          }
          return CupInfoTab(
            cup: cup,
            onFollowTap: () => _handleFollowTap(cup),
            onRequestToJoin: () => _handleRequestToJoin(cup),
          );
        },
        loading: () => const AppLoader(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(AppStrings.errorLoadingDetails(error)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(cupDetailsProvider(widget.tournamentId)),
                child: Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleFollowTap(TournamentCupModel cup) async {
    final notifier = ref.read(cupFollowProvider(widget.tournamentId).notifier);
    await notifier.toggleFollow(
      tournamentId: widget.tournamentId,
      currentFollowState: cup.isFollowing,
    );
    ref.invalidate(cupDetailsProvider(widget.tournamentId));
    ref.invalidate(cupReadyDetailProvider(widget.tournamentId));
    ref.invalidate(cupReadyOrDetailsProvider(widget.tournamentId));
  }

  Future<void> _handleRequestToJoin(TournamentCupModel cup) async {
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
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AppLoader(),
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
          AppStrings.noEligibleTeams,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          AppStrings.noEligibleTeamsCup,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok),
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
          AppStrings.selectTeam,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700),
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
                  _submitJoinRequest(team, cup);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
        ],
      ),
    );
  }

  Future<void> _submitJoinRequest(
      CupTeamModel team, TournamentCupModel cup) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AppLoader(),
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

    if (mounted) Navigator.pop(context);

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
      error: (error, stack) => _showErrorDialog('Error: $error'),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppStrings.success,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(message, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok),
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
          AppStrings.error,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(message, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }
}
