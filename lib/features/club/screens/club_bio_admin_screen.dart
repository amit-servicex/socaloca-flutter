import 'dart:developer';
import 'package:socaloca/core/constants/app_strings.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/club/data/models/club_model.dart';
import 'package:socaloca/features/club/data/models/club_news_model.dart';
import 'package:socaloca/features/club/data/models/club_player_model.dart';
import 'package:socaloca/shared/models/match_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_bio_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

// ── Provider ──────────────────────────────────────────────────────────────────
final _clubBioAdminProvider =
    FutureProvider.autoDispose<ClubBioModel?>((ref) async {
  final clubId = StorageService.clubId ?? '';
  log("this is the club id from storage $clubId");
  if (clubId.isEmpty) {
    throw Exception(
      'Club ID not found in storage. '
      'Club user data: ${StorageService.clubUser}',
    );
  }
  return ref.read(clubRepositoryProvider).getClubBioAdmin(clubId: clubId);
});

/// Club Bio Admin Dashboard — Screen 1 of the Club shell.
class ClubBioAdminScreen extends ConsumerStatefulWidget {
  const ClubBioAdminScreen({super.key});

  @override
  ConsumerState<ClubBioAdminScreen> createState() => _ClubBioAdminScreenState();
}

class _ClubBioAdminScreenState extends ConsumerState<ClubBioAdminScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final name =
          StorageService.clubUser?['clubName'] as String? ?? AppStrings.club;
      ref.read(clubAppBarTitleProvider.notifier).state = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(_clubBioAdminProvider);

    return async.when(
      loading: () => const AppLoader(),
      error: (e, _) => Center(child: Text(AppStrings.errorMessage(e))),
      data: (bio) {
        if (bio == null) {
          return Center(child: Text(AppStrings.couldNotLoadClubData));
        }
        return _BioBody(
            bio: bio, onRefresh: () => ref.invalidate(_clubBioAdminProvider));
      },
    );
  }
}

class _BioBody extends ConsumerWidget {
  const _BioBody({required this.bio, required this.onRefresh});
  final ClubBioModel bio;
  final VoidCallback onRefresh;

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
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final club = bio.clubDetails;
    final logoUrl = ApiConstants.getImageUrl(club.imageUrl);

    // ── FIX 4: resolve badge asset from partnerType ──────────────────────────
    String? badgeAsset;
    final pt = club.partnerType;
    if (pt == 'platinum') {
      badgeAsset = 'assets/icons/ic_platinum_badge.png';
    } else if (pt == 'gold') {
      badgeAsset = 'assets/icons/ic_gold_badge.png';
    } else if (pt == 'silver') {
      badgeAsset = 'assets/icons/ic_silver_badge.png';
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Bar ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        width: 1.5, height: 24, color: AppColors.socaBlack),
                    const SizedBox(width: 12),
                    Image.asset(badgeAsset, width: 28, height: 28),
                  ],
                  const Spacer(),
                  IconButton(
                    icon: Image.asset("assets/icons/ic_gallery_new.png",
                        width: 28, height: 28),
                    onPressed: () => context.push(AppRoutes.clubGallery),
                  ),
                  if (club.website != null && club.website!.isNotEmpty)
                    IconButton(
                      icon: Image.asset("assets/icons/ic_website.png",
                          width: 28, height: 28),
                      onPressed: () => launchUrl(Uri.parse(club.website!)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Club info ─────────────────────────────────────────────────
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
                      // Logo Column
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.black,
                            padding: const EdgeInsets.all(4),
                            child: logoUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: logoUrl, fit: BoxFit.contain)
                                : const Icon(Icons.shield,
                                    color: AppColors.socaYellow, size: 48),
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
                      // Info Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                AppStrings.nickname, club.nickName ?? ''),
                            _buildInfoRow(
                                AppStrings.formedIn, club.formedYear ?? ''),
                            _buildInfoRow(
                                AppStrings.country, club.country ?? ''),
                            _buildInfoRow(AppStrings.city, club.city ?? ''),
                            _buildInfoRow(
                                AppStrings.stadium, club.stadiumsAsStr),
                            _buildInfoRow(
                                AppStrings.manager, club.manager ?? ''),
                            const SizedBox(height: 4),
                            Text(AppStrings.league,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            if (club.league != null && club.league!.isNotEmpty)
                              Text(club.league!,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(AppStrings.otherCompetitions,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13)),
                            if (club.confed != null && club.confed!.isNotEmpty)
                              Text(club.confed!,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            if (club.comps.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(AppStrings.competitions,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 13)),
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

                  // ── FIX 5: Upgrade button when not a partner ─────────────
                  if (!(club.isPartner)) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final clubId = StorageService.clubId ?? '';
                          final repo = ref.read(clubRepositoryProvider);
                          final ok = await repo.upgradeClubPlan(clubId: clubId);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(ok
                                    ? AppStrings.upgradationRequestSent
                                    : AppStrings.somethingWentWrong),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          AppStrings.upgrade,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── FIX 6: News section ───────────────────────────────────────
            if (bio.newsList.isNotEmpty) ...[
              _buildNewsSection(bio.newsList),
              const SizedBox(height: 12),
            ],

            // ── FIX 6: Matches section ────────────────────────────────────
            if (bio.matchList.isNotEmpty) ...[
              _buildMatchesSection(bio.matchList),
              const SizedBox(height: 12),
            ],

            // ── FIX 6: Players section ────────────────────────────────────
            if (bio.playerList.isNotEmpty) ...[
              _buildPlayersSection(bio.playerList),
              const SizedBox(height: 12),
            ],

            Container(
                color: AppColors.socaGrey,
                child: Column(children: [
                  // ── Club Teams ────────────────────────────────────────────────
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
                          if (t.ageGroup != null && t.ageGroup!.isNotEmpty) {
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
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            );
                          }
                          return Text(t.teamName ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600));
                        }).toList(),
                      ),
                    ),
                ])),

            const SizedBox(height: 12),
            Container(
              color: AppColors.socaGrey,
              child: Column(
                children: [
                  // ── Kits ───────────────────────────────────────────────────
                  _SectionHeader(title: AppStrings.homeAwayThirdKit),
                  Container(
                    color: Colors.grey.shade200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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

            Container(
              color: AppColors.socaGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ── Club Sponsors ──────────────────────────────────────────────────
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
                                    child: Text(s.name ?? '',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))),
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
      ),
    );
  }

  // ── FIX 6: News section ───────────────────────────────────────────────────

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
    return Card(
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
    );
  }

  // ── FIX 6: Matches section ────────────────────────────────────────────────

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildTeamLogo(homeLogo),
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
              child: Text('$homeScore - $awayScore',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack)),
            ),
            Expanded(
              child: Column(
                children: [
                  _buildTeamLogo(awayLogo),
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

  Widget _buildTeamLogo(String imageUrl) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.socaGrey),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const Icon(Icons.sports_soccer,
                    size: 22, color: AppColors.socaBlack),
              )
            : const Icon(Icons.sports_soccer,
                size: 22, color: AppColors.socaBlack),
      ),
    );
  }

  // ── FIX 6: Players section ────────────────────────────────────────────────

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.socaGrey),
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(Icons.person,
                            size: 28, color: AppColors.socaBlack),
                      )
                    : const Icon(Icons.person,
                        size: 28, color: AppColors.socaBlack),
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
                      color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ── Small helper widgets ──────────────────────────────────────────────────────

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
        const Divider(
          thickness: .8,
          color: AppColors.socaBlack,
          height: 0,
        )
      ],
    );
  }
}

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
            : Image.asset("assets/images/kit.png"),
      ),
    );
  }
}
