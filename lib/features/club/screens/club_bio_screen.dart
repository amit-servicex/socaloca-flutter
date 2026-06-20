import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/club/data/models/club_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_bio_model.dart';
import '../data/models/club_news_model.dart';
import '../data/models/club_player_model.dart';
import '../providers/club_bio_provider.dart';
import '../../../shared/models/match_model.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import 'nps_survey_screen.dart';

class ClubBioScreen extends ConsumerStatefulWidget {
  final String clubId;

  const ClubBioScreen({super.key, required this.clubId});

  @override
  ConsumerState<ClubBioScreen> createState() => _ClubBioScreenState();
}

class _ClubBioScreenState extends ConsumerState<ClubBioScreen> {
  bool _isFollowing = false;
  bool _followInitialized = false;
  // Guard: show the NPS dialog only once per screen load (same as Android)
  bool _npsDialogShown = false;

  @override
  Widget build(BuildContext context) {
    final bioAsync = ref.watch(clubBioProvider(widget.clubId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: SafeArea(
        child: bioAsync.when(
          loading: () => const AppLoader(),
          error: (e, _) => _buildError(e.toString()),
          data: (result) {
            final (bio, npsSurvey) = result;
            if (bio == null) return _buildError(AppStrings.clubNotFound);

            if (!_followInitialized) {
              _isFollowing = bio.clubDetails.following;
              _followInitialized = true;
            }

            // Trigger NPS dialog when server flag is true — once per load
            if (npsSurvey && !_npsDialogShown) {
              _npsDialogShown = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _showNpsSurveyDialog();
              });
            }

            final club = bio.clubDetails;
            final logoUrl = ApiConstants.getImageUrl(club.imageUrl);

            // Resolve badge asset from partnerType
            String? badgeAsset;
            final pt = club.partnerType;
            if (pt == 'platinum') {
              badgeAsset = 'assets/icons/ic_platinum_badge.png';
            } else if (pt == 'gold') {
              badgeAsset = 'assets/icons/ic_gold_badge.png';
            } else if (pt == 'silver') {
              badgeAsset = 'assets/icons/ic_silver_badge.png';
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top Bar ────────────────────────────────────────────
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          club.clubName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        if (badgeAsset != null) ...[
                          const SizedBox(width: 12),
                          Container(
                              width: 1.5,
                              height: 24,
                              color: AppColors.socaBlack),
                          const SizedBox(width: 12),
                          Image.asset(badgeAsset, width: 28, height: 28),
                        ],
                        const Spacer(),
                        IconButton(
                          icon: Image.asset('assets/icons/ic_gallery_new.png',
                              width: 28, height: 28),
                          onPressed: () {},
                        ),
                        if (club.website != null && club.website!.isNotEmpty)
                          IconButton(
                            icon: Image.asset('assets/icons/ic_website.png',
                                width: 28, height: 28),
                            onPressed: () => _launchUrl(club.website!),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Club Info ────────────────────────────────────────────
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          club.clubName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo + followers count
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  // color: Colors.black,
                                  padding: const EdgeInsets.all(4),
                                  child: logoUrl.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: logoUrl,
                                          fit: BoxFit.contain)
                                      : const Icon(Icons.shield,
                                          color: AppColors.socaYellow,
                                          size: 48),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: _handleFollowTap,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.socaBlack,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    child: Text(
                                      _isFollowing
                                          ? AppStrings.following.toUpperCase()
                                          : AppStrings.follow.toUpperCase(),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: AppColors.socaYellow,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppStrings.followersCount(club.followCount),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            // Info rows
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      _buildInfoRow(AppStrings.fifaIdLabel,
                                          club.orgFifaId ?? ''),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, bottom: 4),
                                        child: Image.asset(
                                          "assets/icons/id_verified.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  _buildInfoRow(
                                      AppStrings.nickname, club.nickName ?? ''),
                                  _buildInfoRow(AppStrings.formedIn,
                                      club.formedYear ?? ''),
                                  _buildInfoRow(
                                      AppStrings.country, club.country ?? ''),
                                  _buildInfoRow(
                                      AppStrings.city, club.city ?? ''),
                                  _buildInfoRow(
                                      AppStrings.stadium, club.stadiumsAsStr),
                                  _buildInfoRow(
                                      AppStrings.manager, club.manager ?? ''),
                                  const SizedBox(height: 4),
                                  Text(AppStrings.league,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 13)),
                                  if (club.league != null &&
                                      club.league!.isNotEmpty)
                                    Text(club.league!,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 4),
                                  Text(AppStrings.otherCompetitions,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 13)),
                                  if (club.confed != null &&
                                      club.confed!.isNotEmpty)
                                    Text(club.confed!,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700)),
                                  if (club.comps.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(AppStrings.competitions,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13)),
                                    Text(club.competitionsStr,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Follow button (replaces Upgrade button from admin)

                        // Trial section
                        if (bio.trialDetails?.trialBadge == true) ...[
                          const SizedBox(height: 12),
                          _buildTrialSection(bio.trialDetails!),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── News ────────────────────────────────────────────────
                  if (bio.newsList.isNotEmpty) ...[
                    _buildNewsSection(bio.newsList),
                    const SizedBox(height: 12),
                  ],

                  // ── Matches ─────────────────────────────────────────────
                  if (bio.matchList.isNotEmpty) ...[
                    _buildMatchesSection(bio.matchList),
                    const SizedBox(height: 12),
                  ],

                  // ── Players ─────────────────────────────────────────────
                  if (bio.playerList.isNotEmpty) ...[
                    _buildPlayersSection(bio.playerList),
                    const SizedBox(height: 12),
                  ],

                  // ── Club Teams ───────────────────────────────────────────
                  Container(
                    color: AppColors.socaGrey,
                    child: Column(
                      children: [
                        _SectionHeader(title: AppStrings.clubTeams),
                        if (bio.teamList.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Wrap(
                              spacing: 24,
                              runSpacing: 12,
                              children: bio.teamList.map((t) {
                                if (t.ageGroup != null &&
                                    t.ageGroup!.isNotEmpty) {
                                  return RichText(
                                    text: TextSpan(
                                      text: '${t.ageGroup ?? ''} ',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: t.gender == 'male'
                                              ? AppStrings.men
                                              : AppStrings.women,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Text(
                                  t.teamName ?? '',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Kits ─────────────────────────────────────────────────
                  Container(
                    color: AppColors.socaGrey,
                    child: Column(
                      children: [
                        _SectionHeader(title: AppStrings.homeAwayThirdKit),
                        Container(
                          color: Colors.grey.shade200,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                _KitCard(url: club.homeKit),
                                const VerticalDivider(
                                    width: 0,
                                    thickness: 1,
                                    color: AppColors.socaBlack),
                                _KitCard(url: club.awayKit),
                                const VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                    color: AppColors.socaBlack),
                                _KitCard(url: club.thirdKit),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Sponsors ─────────────────────────────────────────────
                  Container(
                    color: AppColors.socaGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _SectionHeader(title: AppStrings.clubSponsors),
                        if (bio.sponsorList.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: bio.sponsorList.map((s) {
                                final url = ApiConstants.getImageUrl(s.logo);
                                return Container(
                                  width: 70,
                                  height: 37,
                                  color: Colors.transparent,
                                  child: url.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: url, fit: BoxFit.contain)
                                      : Center(
                                          child: Text(
                                            s.name ?? '',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                );
                              }).toList(),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(AppStrings.kit,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Info row (matches admin _buildInfoRow) ──────────────────────────────────

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text('$label:',
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: Colors.black),
          children: [
            TextSpan(
                text: value,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  // ── Trial section ────────────────────────────────────────────────────────────

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
          Text(
            AppStrings.liveTrial,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 10),
          if (trial.isRegistered)
            Text(
              AppStrings.registered.toUpperCase(),
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success),
            )
          else if (trial.isRegistrationClosed)
            Text(
              AppStrings.registrationClosed,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error),
            )
          else if (trial.isRegisterBtn)
            ElevatedButton(
              onPressed: () => context.push('/clubs/${widget.clubId}/trials'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Text(
                AppStrings.register.toUpperCase(),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaYellow),
              ),
            ),
        ],
      ),
    );
  }

  // ── News ──────────────────────────────────────────────────────────────────────

  Widget _buildNewsSection(List<ClubNewsModel> newsList) {
    return Container(
      color: AppColors.socaGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: AppStrings.newsAnnouncements),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: newsList.length,
            itemBuilder: (_, i) => _buildNewsCard(newsList[i]),
          ),
        ],
      ),
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
        margin: const EdgeInsets.only(bottom: 8),
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
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                        width: 56, height: 56, color: AppColors.socaGrey),
                  ),
                ),
              if (imageUrl.isNotEmpty) const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (news.title != null && news.title!.isNotEmpty)
                      Text(news.title!,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaBlack),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    if (news.description != null &&
                        news.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(news.description!,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: AppColors.socaBlack),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
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

  // ── Matches ───────────────────────────────────────────────────────────────────

  Widget _buildMatchesSection(List<MatchModel> matches) {
    return Container(
      color: AppColors.socaGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: AppStrings.recentMatches),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: matches.length,
            itemBuilder: (_, i) => _buildMatchCard(matches[i]),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(MatchModel match) {
    final homeScore = match.score?.homeGoals ?? 0;
    final awayScore = match.score?.awayGoals ?? 0;
    final homeLogo = ApiConstants.getImageUrl(match.homeTeamLogo);
    final awayLogo = ApiConstants.getImageUrl(match.awayTeamLogo);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildSmallTeamLogo(homeLogo),
                  const SizedBox(height: 4),
                  Text(match.homeTeamName,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text('$homeScore - $awayScore',
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack)),
                  if (match.matchDate != null && match.matchDate!.isNotEmpty)
                    Text(match.matchDate!,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _buildSmallTeamLogo(awayLogo),
                  const SizedBox(height: 4),
                  Text(match.awayTeamName,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.socaBlack),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
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
          shape: BoxShape.circle, color: AppColors.socaGrey),
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

  // ── Players ───────────────────────────────────────────────────────────────────

  Widget _buildPlayersSection(List<ClubPlayerModel> players) {
    return Container(
      color: AppColors.socaGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: AppStrings.featuredPlayers),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: players.length,
            itemBuilder: (_, i) => _buildPlayerCard(players[i]),
          ),
        ],
      ),
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
                  shape: BoxShape.circle, color: AppColors.socaGrey),
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
            Text(player.fullName,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            if (player.position != null && player.position!.isNotEmpty)
              Text(player.position!,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            if (player.jersey != 0)
              Text('#${player.jersey}',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  // ── Error ─────────────────────────────────────────────────────────────────────

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(message,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: AppColors.socaBlack)),
        ],
      ),
    );
  }

  // ── NPS Survey dialog ─────────────────────────────────────────────────────────

  void _showNpsSurveyDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: SizedBox(
          width: 305,
          height: 190,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Text(
                      '${AppStrings.rateYourExperience} ${AppStrings.yourInputMakesADifference}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(height: 1, color: Colors.grey.shade400),
              SizedBox(
                height: 86,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _NpsDialogButton(
                      label: AppStrings.no.toUpperCase(),
                      filled: false,
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    const SizedBox(width: 14),
                    _NpsDialogButton(
                      label: AppStrings.ok.toUpperCase(),
                      filled: true,
                      onTap: () {
                        Navigator.of(dialogContext).pop();

                        Future.microtask(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NpsSurveyScreen(),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────────

  void _handleFollowTap() async {
    setState(() => _isFollowing = !_isFollowing);
    try {
      await ref.read(followClubProvider(widget.clubId).future);
    } catch (e) {
      setState(() => _isFollowing = !_isFollowing);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.failedToUpdateFollowStatus(e))),
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

class _NpsDialogButton extends StatelessWidget {
  const _NpsDialogButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 116,
      height: 40,
      child: Material(
        color: filled ? AppColors.socaBlack : Colors.white,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.socaBlack, width: 1),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: filled ? AppColors.socaYellow : AppColors.socaBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Section Header (identical to admin _SectionHeader) ───────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        const Divider(thickness: .8, color: AppColors.socaBlack, height: 0),
      ],
    );
  }
}

// ── Kit Card (identical to admin _KitCard) ────────────────────────────────────

class _KitCard extends StatelessWidget {
  const _KitCard({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    final fullUrl = ApiConstants.getImageUrl(url);
    return Expanded(
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: fullUrl.isNotEmpty
            ? CachedNetworkImage(imageUrl: fullUrl, fit: BoxFit.contain)
            : Image.asset('assets/images/kit.png'),
      ),
    );
  }
}
