import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../providers/tournament_providers.dart';
import '../../../widgets/tournament_banner_slider.dart';
import '../../../widgets/tournament_header_widget.dart';
import '../../../widgets/tournament_info_card.dart';
import '../../../widgets/teams_horizontal_list.dart';
import '../../../widgets/sponsors_horizontal_list.dart';

/// League Info Tab
/// Displays league tournament information (banner, header, info card, teams,
/// sponsors, itinerary, invitations, join button).
/// Matches Android TournamentDetailsFragment info section.
class LeagueInfoTab extends ConsumerWidget {
  final TournamentModel tournament;
  final VoidCallback onFollowTap;
  final VoidCallback onRequestToJoin;

  LeagueInfoTab({
    super.key,
    required this.tournament,
    required this.onFollowTap,
    required this.onRequestToJoin,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Slider
          if (tournament.banners != null && tournament.banners!.isNotEmpty)
            TournamentBannerSlider(
              banners: tournament.banners!,
              height: 200,
            ),

          // Header with Follow Button
          TournamentHeaderWidget(
            tournament: tournament,
            isFollowing: tournament.isFollowing,
            followCount: tournament.followCount,
            onFollowTap: onFollowTap,
          ),

          // Tournament Info Card
          TournamentInfoCard(tournament: tournament),

          SizedBox(height: 8),

          // Teams Playing
          if (tournament.teams != null && tournament.teams!.isNotEmpty)
            TeamsHorizontalList(
              teams: tournament.teams!,
              onTeamTap: (teamId) {
                context.push('${AppRoutes.teams}/$teamId');
              },
            ),

          SizedBox(height: 8),

          // Sponsors
          if (tournament.sponsors != null && tournament.sponsors!.isNotEmpty)
            SponsorsHorizontalList(
              sponsors: tournament.sponsors!,
            ),

          SizedBox(height: 8),

          // Itinerary Button
          if (tournament.itinerary?.canView == true &&
              tournament.itinerary?.doc != null &&
              tournament.itinerary!.doc!.isNotEmpty)
            _LeagueItineraryButton(docUrl: tournament.itinerary!.doc!),

          SizedBox(height: 8),

          // Invitations Section (admin/coach only)
          if (user != null && (user.isAdmin || user.isCoach))
            _LeagueInvitationsSection(tournament: tournament),

          SizedBox(height: 8),

          // Request to Join Button
          _buildRequestToJoinButton(user),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRequestToJoinButton(dynamic user) {
    if (user == null) return SizedBox.shrink();

    // Only admin or coach can request to join
    if (!user.isAdmin && !user.isCoach) return SizedBox.shrink();

    // Referees cannot join
    if (user.isReferee == true) return SizedBox.shrink();

    // Cannot join live or ended tournaments
    final status = tournament.status?.toLowerCase() ?? '';
    if (status == 'live' || status == 'end') return SizedBox.shrink();

    // Local tournaments: user's country must match tournament country
    final visibility = tournament.visibility?.toLowerCase() ?? 'global';
    if (visibility == 'local') {
      final userCountry = (user.country as String?)?.toLowerCase() ?? '';
      final tmntCountry = tournament.country?.toLowerCase() ?? '';
      if (userCountry.isEmpty ||
          tmntCountry.isEmpty ||
          userCountry != tmntCountry) {
        return SizedBox.shrink();
      }
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onRequestToJoin,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.socaYellow,
            foregroundColor: AppColors.socaBlack,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            'Request to Join'.tr,
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
}

/// Invitations section — watches pending invites and renders accept/decline UI
class _LeagueInvitationsSection extends ConsumerWidget {
  final TournamentModel tournament;

  _LeagueInvitationsSection({required this.tournament});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentId = tournament.effectiveId;
    final invitesAsync = ref.watch(checkInvitesProvider(tournamentId));

    return invitesAsync.when(
      data: (teams) {
        if (teams.isEmpty) return SizedBox.shrink();
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pending Invitations'.tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.socaBlack,
                ),
              ),
              SizedBox(height: 8),
              ...teams.map(
                (team) => _LeagueInvitationRow(
                  team: team,
                  tournament: tournament,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => SizedBox.shrink(),
      error: (_, __) => SizedBox.shrink(),
    );
  }
}

/// Single row for a pending league invitation (team name + Accept/Decline)
class _LeagueInvitationRow extends ConsumerWidget {
  final TeamModel team;
  final TournamentModel tournament;

  _LeagueInvitationRow({
    required this.team,
    required this.tournament,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentId = tournament.effectiveId;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              team.teamName ?? 'Unknown Team',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _respond(context, ref, tournamentId, accept: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: Text(
              'Accept'.tr,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
          ),
          SizedBox(width: 6),
          ElevatedButton(
            onPressed: () =>
                _respond(context, ref, tournamentId, accept: false),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: Text(
              'Decline'.tr,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _respond(
    BuildContext context,
    WidgetRef ref,
    String tournamentId, {
    required bool accept,
  }) async {
    final notifier = ref.read(inviteResponseProvider(tournamentId).notifier);
    await notifier.respond(
      tournamentId: tournamentId,
      teamId: team.effectiveId,
      accept: accept,
      parentId: tournament.parentId,
      teamName: team.teamName,
      tmntName: tournament.name,
    );

    if (!context.mounted) return;
    final state = ref.read(inviteResponseProvider(tournamentId));
    state.when(
      data: (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? (accept ? 'Invitation accepted.' : 'Invitation declined.')
                  : 'Action failed. Please try again.',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      },
      loading: () {},
      error: (e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: $e',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}

/// Itinerary button — opens a document URL via url_launcher
class _LeagueItineraryButton extends StatelessWidget {
  final String docUrl;

  _LeagueItineraryButton({required this.docUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: Icon(Icons.description_outlined),
          label: Text(
            'View Itinerary'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          onPressed: () => _launch(context),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

  Future<void> _launch(BuildContext context) async {
    final uri = Uri.tryParse(docUrl);
    if (uri == null) return;
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Itinerary'.tr),
            content: SelectableText(docUrl),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Close'.tr),
              ),
            ],
          ),
        );
      }
    }
  }
}
