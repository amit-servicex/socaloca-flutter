import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
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
import 'package:socaloca/shared/widgets/app_loader.dart';

class ClubBioScreen extends ConsumerStatefulWidget {
  final String clubId;

  ClubBioScreen({
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
                    SizedBox(height: 20),
                    _buildBasicInfo(bio),
                    if (bio.newsList.isNotEmpty) ...[
                      SizedBox(height: 16),
                      _buildNewsSection(bio.newsList),
                    ],
                    if (bio.matchList.isNotEmpty) ...[
                      SizedBox(height: 16),
                      _buildMatchesSection(bio.matchList),
                    ],
                    if (bio.playerList.isNotEmpty) ...[
                      SizedBox(height: 16),
                      _buildPlayersSection(bio.playerList),
                    ],
                    if (bio.teamList.isNotEmpty) ...[
                      SizedBox(height: 16),
                      _buildTeamsSection(bio.teamList),
                    ],
                    _buildKitSection(bio.clubDetails),
                    if (bio.sponsorList.isNotEmpty) ...[
                      SizedBox(height: 16),
                      _buildSponsorsSection(bio.sponsorList),
                    ],
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Scaffold(
        backgroundColor: AppColors.socaPageBg,
        body: AppLoader(),
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
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.photo_library, size: 25, color: AppColors.socaBlack),
          onPressed: () {},
        ),
        if (website != null && website.isNotEmpty)
          IconButton(
            icon: Icon(Icons.language, size: 25, color: AppColors.socaBlack),
            onPressed: () => _launchUrl(website),
          ),
      ],
    );
  }

  // ─── Basic Info (image + follow + info rows + trial) ─────────────────────

  Widget _buildBasicInfo(ClubBioModel bio) {
    final club = bio.clubDetails;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + follow button row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClubImage(club.fullImageUrl),
              SizedBox(width: 16),
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
                        padding: EdgeInsets.symmetric(vertical: 8),
                        elevation: 0,
                      ),
                      child: Text(
                        _isFollowing ? 'FOLLOWING' : 'FOLLOW',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaYellow,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${club.followCount} followers',
                    style: TextStyle(
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
          SizedBox(height: 16),

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
            SizedBox(height: 8),
            _buildPartnerBadge(club.partnerType!),
          ],

          // Trial section
          if (bio.trialDetails?.trialBadge == true) ...[
            SizedBox(height: 12),
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
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
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
        child: Icon(Icons.sports_soccer, color: AppColors.socaBlack, size: 40),
      );

  Widget _buildFifaRow(String fifaId) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            'FIFA ID: '.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.socaBlack,
            ),
          ),
          Text(
            fifaId,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(width: 6),
          Icon(Icons.verified, size: 18, color: AppColors.success),
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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.workspace_premium, size: 28, color: iconColor),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.socaBlack, width: 2),
      ),
      child: Column(
        children: [
          Text(
            'LIVE TRIAL'.tr,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 10),
          if (trial.isRegistered)
            Text(
              'REGISTERED'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            )
          else if (trial.isRegistrationClosed)
            Text(
              'REGISTRATION CLOSED'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            )
          else if (trial.isRegisterBtn)
            ElevatedButton(
              onPressed: () => context.push('/clubs/${widget.clubId}/trials'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'REGISTER'.tr,
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
        ClubBioSectionHeader(title: 'News & Announcements'),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: newsList.length,
          itemBuilder: (context, index) => _buildNewsCard(newsList[index]),
        ),
      ],
    );
  }

  Widget _buildNewsCard(ClubNewsModel news) {
    final imageUrl = news.fullImageUrl;
    final tapUrl = (news.link != null && news.link!.trim().isNotEmpty)
        ? news.link!
        : (news.isVideo && news.videoUrl != null && news.videoUrl!.isNotEmpty)
            ? news.videoUrl!
            : null;
    return GestureDetector(
      onTap: tapUrl != null ? () => _launchUrl(tapUrl) : null,
      child: Card(
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(12),
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
            if (imageUrl.isNotEmpty) SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (news.title != null && news.title!.isNotEmpty)
                    Text(
                      news.title!,
                      style: TextStyle(
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
                    SizedBox(height: 4),
                    Text(
                      news.description!,
                      style: TextStyle(
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
      ),
    );
  }

  // ─── Recent Matches ──────────────────────────────────────────────────────

  Widget _buildMatchesSection(List<MatchModel> matches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClubBioSectionHeader(title: 'Recent Matches'),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
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
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Home team
            Expanded(
              child: Column(
                children: [
                  _buildSmallTeamLogo(homeLogo),
                  SizedBox(height: 4),
                  Text(
                    match.homeTeamName,
                    style: TextStyle(
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    '$homeScore - $awayScore',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  if (match.matchDate != null && match.matchDate!.isNotEmpty)
                    Text(
                      match.matchDate!,
                      style: TextStyle(
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
                  SizedBox(height: 4),
                  Text(
                    match.awayTeamName,
                    style: TextStyle(
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Icon(Icons.sports_soccer,
                    size: 24, color: AppColors.socaBlack),
              )
            : Icon(Icons.sports_soccer, size: 24, color: AppColors.socaBlack),
      ),
    );
  }

  // ─── Featured Players ────────────────────────────────────────────────────

  Widget _buildPlayersSection(List<ClubPlayerModel> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Players'.tr,
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
                child: Text(
                  'View All Players'.tr,
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
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.socaGrey,
              ),
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(Icons.person,
                            size: 30, color: AppColors.socaBlack),
                      )
                    : Icon(Icons.person, size: 30, color: AppColors.socaBlack),
              ),
            ),
            SizedBox(height: 6),
            Text(
              player.fullName,
              style: TextStyle(
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
                style: TextStyle(
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
                style: TextStyle(
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
        ClubBioSectionHeader(title: 'Club Teams'),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
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
      margin: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(Icons.group,
                          size: 32, color: AppColors.socaBlack),
                    )
                  : Icon(Icons.group, size: 32, color: AppColors.socaBlack),
            ),
          ),
          SizedBox(height: 6),
          Text(
            team.teamName ?? '',
            style: TextStyle(
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

    if (kits.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClubBioSectionHeader(title: 'Kits'),
          SizedBox(height: 8),
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
                        errorWidget: (_, __, ___) => Icon(Icons.sports_soccer,
                            color: AppColors.socaBlack),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    kit.$1,
                    style: TextStyle(
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
        ClubBioSectionHeader(title: 'Sponsors'),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
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
      margin: EdgeInsets.only(right: 10),
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
                      errorWidget: (_, __, ___) => Icon(Icons.business,
                          size: 32, color: AppColors.socaBlack),
                    )
                  : Icon(Icons.business, size: 32, color: AppColors.socaBlack),
            ),
          ),
          SizedBox(height: 6),
          Text(
            sponsor.name ?? '',
            style: TextStyle(
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
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
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

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
