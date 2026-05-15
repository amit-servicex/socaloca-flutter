import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_bio_model.dart';
import '../data/models/club_model.dart';
import '../data/models/club_news_model.dart';
import '../data/models/club_player_model.dart';
import '../data/models/club_sponsor_model.dart';
import '../data/models/club_team_model.dart';
import '../providers/club_bio_provider.dart';
import '../widgets/club_bio_info_row.dart';
import '../widgets/club_bio_section_header.dart';
import '../../../shared/models/match_model.dart';

class ClubBioScreen extends ConsumerStatefulWidget {
  final String clubId;

  const ClubBioScreen({
    super.key,
    required this.clubId,
  });

  @override
  ConsumerState<ClubBioScreen> createState() => _ClubBioScreenState();
}

class _ClubBioScreenState extends ConsumerState<ClubBioScreen> {
  bool _isFollowing = false;
  bool _followInitialized = false;

  @override
  Widget build(BuildContext context) {
    final bioAsync = ref.watch(clubBioProvider(widget.clubId));

    return bioAsync.when(
      data: (bio) {
        if (bio == null) {
          return Scaffold(
            backgroundColor: AppColors.socaPageBg,
            appBar: AppBar(backgroundColor: Colors.white, elevation: 2),
            body: _buildError('Club not found'),
          );
        }

        if (!_followInitialized) {
          _isFollowing = bio.clubDetails.following;
          _followInitialized = true;
        }

        return Scaffold(
          backgroundColor: AppColors.socaPageBg,
          appBar:
              _buildAppBar(bio.clubDetails.clubName, bio.clubDetails.website),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildBasicInfo(bio),
                    if (bio.newsList.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildNewsSection(bio.newsList),
                    ],
                    if (bio.matchList.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildMatchesSection(bio.matchList),
                    ],
                    if (bio.playerList.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildPlayersSection(bio.playerList),
                    ],
                    if (bio.teamList.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildTeamsSection(bio.teamList),
                    ],
                    _buildKitSection(bio.clubDetails),
                    if (bio.sponsorList.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildSponsorsSection(bio.sponsorList),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: _buildError(error.toString()),
      ),
    );
  }

  // ─── App Bar ─────────────────────────────────────────────────────────────

  AppBar _buildAppBar(String clubName, String? website) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title: Text(
        clubName,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.photo_library,
              size: 25, color: AppColors.socaBlack),
          onPressed: () {},
        ),
        if (website != null && website.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.language,
                size: 25, color: AppColors.socaBlack),
            onPressed: () => _launchUrl(website),
          ),
      ],
    );
  }

  // ─── Basic Info (image + follow + info rows + trial) ─────────────────────

  Widget _buildBasicInfo(ClubBioModel bio) {
    final club = bio.clubDetails;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + follow button row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClubImage(club.fullImageUrl),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: ElevatedButton(
                      onPressed: _handleFollowTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 0,
                      ),
                      child: Text(
                        _isFollowing ? 'FOLLOWING' : 'FOLLOW',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${club.followCount} followers',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Info rows
          if (club.orgFifaId != null && club.orgFifaId!.isNotEmpty)
            _buildFifaRow(club.orgFifaId!),
          if (club.nickName != null && club.nickName!.isNotEmpty)
            ClubBioInfoRow(label: 'Nickname', value: club.nickName!),
          if (club.formedYear != null && club.formedYear!.isNotEmpty)
            ClubBioInfoRow(label: 'Formed', value: club.formedYear!),
          if (club.country != null && club.country!.isNotEmpty)
            ClubBioInfoRow(label: 'Country', value: club.country!),
          if (club.city != null && club.city!.isNotEmpty)
            ClubBioInfoRow(label: 'City', value: club.city!),
          if (club.stadiumsAsStr.isNotEmpty)
            ClubBioInfoRow(label: 'Stadium', value: club.stadiumsAsStr),
          if (club.manager != null && club.manager!.isNotEmpty)
            ClubBioInfoRow(label: 'Manager', value: club.manager!),
          if (club.league != null && club.league!.isNotEmpty)
            ClubBioInfoRow(label: 'League', value: club.league!),

          // Partnership badge
          if (club.partnerType != null &&
              club.partnerType!.isNotEmpty &&
              club.partnerType!.toLowerCase() != 'nopartner') ...[
            const SizedBox(height: 8),
            _buildPartnerBadge(club.partnerType!),
          ],

          // Trial section
          if (bio.trialDetails?.trialBadge == true) ...[
            const SizedBox(height: 12),
            _buildTrialSection(bio.trialDetails!),
          ],
        ],
      ),
    );
  }

  Widget _buildClubImage(String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.socaGrey),
                errorWidget: (_, __, ___) => _imageFallback(),
              )
            : _imageFallback(),
      ),
    );
  }

  Widget _imageFallback() => Container(
        color: AppColors.socaGrey,
        child: const Icon(Icons.sports_soccer,
            color: AppColors.socaBlack, size: 40),
      );

  Widget _buildFifaRow(String fifaId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Text(
            'FIFA ID: ',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
          Text(
            fifaId,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.verified, size: 18, color: AppColors.success),
        ],
      ),
    );
  }

  Widget _buildPartnerBadge(String partnerType) {
    final label =
        '${partnerType[0].toUpperCase()}${partnerType.substring(1)} Partner';
    final iconColor = partnerType == 'platinum'
        ? Colors.grey[400]!
        : partnerType == 'gold'
            ? Colors.amber
            : Colors.grey[600]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium, size: 28, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrialSection(ClubTrialStatusModel trial) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.socaBlack, width: 2),
      ),
      child: Column(
        children: [
          const Text(
            'LIVE TRIAL',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 10),
          if (trial.isRegistered)
            const Text(
              'REGISTERED',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            )
          else if (trial.isRegistrationClosed)
            const Text(
              'REGISTRATION CLOSED',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            )
          else if (trial.isRegisterBtn)
            ElevatedButton(
              onPressed: () => _handleTrialRegister("0" ?? ''),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'REGISTER',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─── News & Announcements ────────────────────────────────────────────────

  Widget _buildNewsSection(List<ClubNewsModel> newsList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ClubBioSectionHeader(title: 'News & Announcements'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: newsList.length,
          itemBuilder: (context, index) => _buildNewsCard(newsList[index]),
        ),
      ],
    );
  }

  Widget _buildNewsCard(ClubNewsModel news) {
    final imageUrl = news.fullImageUrl;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                      width: 60, height: 60, color: AppColors.socaGrey),
                ),
              ),
            if (imageUrl.isNotEmpty) const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (news.title != null && news.title!.isNotEmpty)
                    Text(
                      news.title!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (news.description != null &&
                      news.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      news.description!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Recent Matches ──────────────────────────────────────────────────────

  Widget _buildMatchesSection(List<MatchModel> matches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ClubBioSectionHeader(title: 'Recent Matches'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: matches.length,
          itemBuilder: (context, index) => _buildMatchCard(matches[index]),
        ),
      ],
    );
  }

  Widget _buildMatchCard(MatchModel match) {
    final homeScore = match.score?.homeGoals ?? 0;
    final awayScore = match.score?.awayGoals ?? 0;
    final homeLogo = ApiConstants.getImageUrl(match.homeTeamLogo);
    final awayLogo = ApiConstants.getImageUrl(match.awayTeamLogo);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Home team
            Expanded(
              child: Column(
                children: [
                  _buildSmallTeamLogo(homeLogo),
                  const SizedBox(height: 4),
                  Text(
                    match.homeTeamName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Score
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    '$homeScore - $awayScore',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  if (match.matchDate != null && match.matchDate!.isNotEmpty)
                    Text(
                      match.matchDate!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            // Away team
            Expanded(
              child: Column(
                children: [
                  _buildSmallTeamLogo(awayLogo),
                  const SizedBox(height: 4),
                  Text(
                    match.awayTeamName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallTeamLogo(String imageUrl) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(Icons.sports_soccer,
                    size: 24, color: AppColors.socaBlack),
              )
            : const Icon(Icons.sports_soccer,
                size: 24, color: AppColors.socaBlack),
      ),
    );
  }

  // ─── Featured Players ────────────────────────────────────────────────────

  Widget _buildPlayersSection(List<ClubPlayerModel> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Players',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: navigate to full players list
                },
                child: const Text(
                  'View All Players',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.socaBlack,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: players.length,
          itemBuilder: (context, index) => _buildPlayerCard(players[index]),
        ),
      ],
    );
  }

  Widget _buildPlayerCard(ClubPlayerModel player) {
    final imageUrl = player.fullImageUrl;
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.socaGrey,
              ),
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(Icons.person,
                            size: 30, color: AppColors.socaBlack),
                      )
                    : const Icon(Icons.person,
                        size: 30, color: AppColors.socaBlack),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              player.fullName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.socaBlack,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (player.position != null && player.position!.isNotEmpty)
              Text(
                player.position!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (player.jersey != 0)
              Text(
                '#${player.jersey}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ─── Club Teams ──────────────────────────────────────────────────────────

  Widget _buildTeamsSection(List<ClubTeamModel> teams) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ClubBioSectionHeader(title: 'Club Teams'),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: teams.length,
            itemBuilder: (context, index) => _buildTeamCard(teams[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamCard(ClubTeamModel team) {
    final imageUrl = team.fullImageUrl;
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(Icons.group,
                          size: 32, color: AppColors.socaBlack),
                    )
                  : const Icon(Icons.group,
                      size: 32, color: AppColors.socaBlack),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            team.teamName ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ─── Kits ────────────────────────────────────────────────────────────────

  Widget _buildKitSection(ClubModel clubDetails) {
    final kits = <(String, String)>[];
    if (clubDetails.homeKit != null && clubDetails.homeKit!.isNotEmpty) {
      kits.add(('Home', ApiConstants.getImageUrl(clubDetails.homeKit)));
    }
    if (clubDetails.awayKit != null && clubDetails.awayKit!.isNotEmpty) {
      kits.add(('Away', ApiConstants.getImageUrl(clubDetails.awayKit)));
    }
    if (clubDetails.thirdKit != null && clubDetails.thirdKit!.isNotEmpty) {
      kits.add(('Third', ApiConstants.getImageUrl(clubDetails.thirdKit)));
    }

    if (kits.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClubBioSectionHeader(title: 'Kits'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: kits.map((kit) {
              return Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.socaGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: kit.$2,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(
                            Icons.sports_soccer,
                            color: AppColors.socaBlack),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kit.$1,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Sponsors ────────────────────────────────────────────────────────────

  Widget _buildSponsorsSection(List<ClubSponsorModel> sponsors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ClubBioSectionHeader(title: 'Sponsors'),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sponsors.length,
            itemBuilder: (context, index) => _buildSponsorCard(sponsors[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildSponsorCard(ClubSponsorModel sponsor) {
    final imageUrl = sponsor.fullImageUrl;
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.socaGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(Icons.business,
                          size: 32, color: AppColors.socaBlack),
                    )
                  : const Icon(Icons.business,
                      size: 32, color: AppColors.socaBlack),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            sponsor.name ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.socaBlack,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ─── Error ───────────────────────────────────────────────────────────────

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.socaBlack,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Actions ─────────────────────────────────────────────────────────────

  void _handleFollowTap() async {
    setState(() => _isFollowing = !_isFollowing);
    try {
      await ref.read(followClubProvider(widget.clubId).future);
    } catch (e) {
      setState(() => _isFollowing = !_isFollowing);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update follow status: $e')),
        );
      }
    }
  }

  void _handleTrialRegister(String trialId) async {
    final email = StorageService.userEmail ?? '';
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email not found')),
      );
      return;
    }
    try {
      final success = await ref.read(
        trialRegisterProvider(
            (clubId: widget.clubId, email: email, trialId: trialId)).future,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success
                ? 'Successfully registered for trial'
                : 'Failed to register for trial'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
