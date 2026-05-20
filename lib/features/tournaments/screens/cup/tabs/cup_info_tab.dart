import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/shared/models/team_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/models/cup_models.dart';
import '../../../data/tournament_models.dart';
import '../../../providers/cup_providers.dart';
import '../../../widgets/tournament_banner_slider.dart';
import '../../../widgets/tournament_header_widget.dart';
import '../../../widgets/tournament_info_card.dart';
import '../../../widgets/teams_horizontal_list.dart';
import '../../../widgets/sponsors_horizontal_list.dart';

/// Cup Info Tab
/// Displays cup tournament information (banner, header, info card, teams, sponsors)
/// Matches Android TournamentCupDetailsFragment info section
/// Includes role-based visibility for join button and invitations section (admin/coach only)
class CupInfoTab extends ConsumerWidget {
  final TournamentCupModel cup;
  final VoidCallback onFollowTap;
  final VoidCallback onRequestToJoin;

  CupInfoTab({
    super.key,
    required this.cup,
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
          if (cup.banners != null && cup.banners!.isNotEmpty)
            TournamentBannerSlider(
              banners: cup.banners!
                  .map((b) => BannerModel(
                        imageUrl: b.imageUrl,
                        seq: b.seq,
                        link: b.link,
                      ))
                  .toList(),
              height: 200,
            )
          else ...[
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  // Banner Image (placeholder for now)
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey[300]!,
                            Colors.grey[400]!,
                          ],
                        ),
                      ),
                      child: Image.asset(
                          "assets/images/tournament_defalut_banner.jpg",
                          fit: BoxFit.cover)),
                ],
              ),
            )
          ],

          // Header with Follow Button
          _buildHeader(user),

          // Cup-specific info (rounds count)
          if (cup.rounds > 0)
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: AppColors.socaYellow,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Knockout Rounds: ${cup.rounds}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ),
            ),

          // Tournament Info Card
          TournamentInfoCard(
            tournament: TournamentModel(
              id: cup.id,
              tournamentId: cup.tournamentId,
              name: cup.name,
              logo: cup.logo,
              location: cup.location,
              venue: cup.venue,
              ageGroup: cup.ageGroup,
              ageCat: cup.ageCat,
              gameType: cup.gameType,
              gender: cup.gender,
              startDate: cup.startDate,
              endDate: cup.endDate,
              status: cup.status,
              tmntType: cup.tmntType,
              visibility: cup.visibility,
              country: cup.country,
              confed: cup.confed,
              parentId: cup.parentId,
              createdBy: cup.createdBy,
              notes: cup.notes,
              description: cup.description,
              prize: cup.prize,
              regFee: cup.regFee,
              orgDetails: cup.orgDetails,
              fsdDate: cup.fsdDate,
              fsdTime: cup.fsdTime,
              fsdGmtMs: cup.fsdGmtMs,
              teamPlayerType: cup.teamPlayerType,
              teamPlayerLimit: cup.teamPlayerLimit,
              followCount: cup.followCount,
              isFollowing: cup.isFollowing,
              teamCount: cup.teamCount,
              matchCount: cup.matchCount,
              withdrawable: cup.withdrawable,
            ),
          ),

          SizedBox(height: 8),

          // Teams Playing
          if (cup.teams != null && cup.teams!.isNotEmpty)
            TeamsHorizontalList(
              teams: cup.teams!
                  .map((t) => TeamModel(
                        id: t.teamId ?? '',
                        adminId: t.teamId,
                        name: t.teamName ?? '',
                        logo: t.logo,
                        country: t.country,
                      ))
                  .toList(),
              onTeamTap: (teamId) {
                // log("this is the teams id list  ${cup.teams?.map((i) => i.toJson())}");

                context.push('/teams/${teamId}');
              },
            ),

          SizedBox(height: 8),

          // Sponsors
          if (cup.sponsors != null && cup.sponsors!.isNotEmpty)
            SponsorsHorizontalList(
              sponsors: cup.sponsors!
                  .map((s) => SponsorModel(
                        id: s.id,
                        name: s.name,
                        logo: s.logo,
                        website: s.website,
                      ))
                  .toList(),
            ),

          SizedBox(height: 8),

          // Itinerary Button (shown when canView == true)
          _CupItinerarySection(tournamentId: cup.effectiveId),

          SizedBox(height: 8),

          // Invitations Section (admin/coach only)
          if (user != null && (user.isAdmin || user.isCoach))
            _CupInvitationsSection(cup: cup),

          SizedBox(height: 8),

          // Request to Join Button (role + status + visibility gated)
          _buildRequestToJoinButton(user),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(dynamic user) {
    return TournamentHeaderWidget(
      tournament: TournamentModel(
        id: cup.id,
        tournamentId: cup.tournamentId,
        name: cup.name,
        logo: cup.logo,
        location: cup.location,
        ageGroup: cup.ageGroup,
        ageCat: cup.ageCat,
        gameType: cup.gameType,
        startDate: cup.startDate,
        followCount: cup.followCount,
        isFollowing: cup.isFollowing,
        tmntType: cup.tmntType,
      ),
      isFollowing: cup.isFollowing,
      followCount: cup.followCount,
      onFollowTap: onFollowTap,
      showFollow:
          user?.isReferee != true && user?.userType?.toLowerCase() != 'referee',
    );
  }

  Widget _buildRequestToJoinButton(dynamic user) {
    if (user == null) return SizedBox.shrink();

    // Only admin or coach can request to join
    if (!user.isAdmin && !user.isCoach) return SizedBox.shrink();

    // Referees cannot join
    if (user.isReferee == true) return SizedBox.shrink();

    // Cannot join live or ended tournaments
    final status = cup.status?.toLowerCase() ?? '';
    if (status == 'live' || status == 'end') return SizedBox.shrink();

    // Local tournaments: user's country must match cup country
    final visibility = cup.visibility?.toLowerCase() ?? 'global';
    if (visibility == 'local') {
      final userCountry = (user.country as String?)?.toLowerCase() ?? '';
      final cupCountry = cup.country?.toLowerCase() ?? '';
      if (userCountry.isEmpty ||
          cupCountry.isEmpty ||
          userCountry != cupCountry) {
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
            'Request to Join Cup'.tr,
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

/// Watches cupItineraryUrlProvider and shows the itinerary button when URL is available
class _CupItinerarySection extends ConsumerWidget {
  final String tournamentId;

  _CupItinerarySection({required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itineraryAsync = ref.watch(cupItineraryUrlProvider(tournamentId));
    return itineraryAsync.when(
      data: (url) {
        if (url == null || url.isEmpty) return SizedBox.shrink();
        return CupItineraryButton(docUrl: url);
      },
      loading: () => SizedBox.shrink(),
      error: (_, __) => SizedBox.shrink(),
    );
  }
}

/// Cup Invitations Section widget — watches pending invites and renders accept/decline UI
class _CupInvitationsSection extends ConsumerWidget {
  final TournamentCupModel cup;

  _CupInvitationsSection({required this.cup});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentId = cup.effectiveId;
    final invitesAsync = ref.watch(checkCupInvitesProvider(tournamentId));

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
              ...teams.map((team) => _CupInvitationRow(team: team, cup: cup)),
            ],
          ),
        );
      },
      loading: () => SizedBox.shrink(),
      error: (_, __) => SizedBox.shrink(),
    );
  }
}

/// Single row for a pending cup invitation (team name + Accept/Decline)
class _CupInvitationRow extends ConsumerWidget {
  final CupTeamModel team;
  final TournamentCupModel cup;

  _CupInvitationRow({required this.team, required this.cup});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentId = cup.effectiveId;

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
    final notifier = ref.read(cupInviteResponseProvider(tournamentId).notifier);
    await notifier.respond(
      tournamentId: tournamentId,
      teamId: team.effectiveId,
      accept: accept,
      parentId: cup.parentId,
      teamName: team.teamName,
      tmntName: cup.name,
    );

    if (!context.mounted) return;
    final state = ref.read(cupInviteResponseProvider(tournamentId));
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
class CupItineraryButton extends StatelessWidget {
  final String docUrl;

  CupItineraryButton({super.key, required this.docUrl});

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
