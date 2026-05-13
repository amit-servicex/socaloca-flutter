import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../data/tournament_models.dart';
import '../../../widgets/tournament_banner_slider.dart';
import '../../../widgets/tournament_header_widget.dart';
import '../../../widgets/tournament_info_card.dart';
import '../../../widgets/teams_horizontal_list.dart';
import '../../../widgets/sponsors_horizontal_list.dart';

/// Cup Info Tab
/// Displays cup tournament information (banner, header, info card, teams, sponsors)
/// Matches Android Cup Info tab
class CupInfoTab extends StatelessWidget {
  final TournamentCupModel cup;
  final VoidCallback onFollowTap;
  final VoidCallback onRequestToJoin;

  const CupInfoTab({
    super.key,
    required this.cup,
    required this.onFollowTap,
    required this.onRequestToJoin,
  });

  @override
  Widget build(BuildContext context) {
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
            ),

          // Header with Follow Button
          _buildHeader(),

          // Cup-specific info (rounds count)
          if (cup.rounds > 0)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: AppColors.socaYellow,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Knockout Rounds: ${cup.rounds}',
                    style: const TextStyle(
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

          const SizedBox(height: 8),

          // Teams Playing
          if (cup.teams != null && cup.teams!.isNotEmpty)
            TeamsHorizontalList(
              teams: cup.teams!
                  .map((t) => TeamModel(
                        id: t.id,
                        teamId: t.teamId,
                        teamName: t.teamName,
                        imageUrl: t.logo,
                        country: t.country,
                      ))
                  .toList(),
              onTeamTap: (teamId) {
                context.push('${AppRoutes.teams}/$teamId');
              },
            ),

          const SizedBox(height: 8),

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

          const SizedBox(height: 8),

          // Request to Join Button
          _buildRequestToJoinButton(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
    );
  }

  Widget _buildRequestToJoinButton() {
    // Don't show if tournament is closed
    if (cup.status == 'end' || cup.status == 'END') {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onRequestToJoin,
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
            'Request to Join Cup',
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
