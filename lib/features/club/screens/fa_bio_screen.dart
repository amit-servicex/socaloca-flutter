import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/club_news_model.dart';
import '../data/models/club_sponsor_model.dart';
import '../data/models/fa_bio_model.dart';
import '../providers/fa_bio_provider.dart';
import '../widgets/club_bio_info_row.dart';
import '../widgets/club_bio_section_header.dart';
import 'fa_all_competitions_screen.dart';
import 'fa_all_teams_screen.dart';

class FaBioScreen extends ConsumerStatefulWidget {
  final String faId;

  const FaBioScreen({super.key, required this.faId});

  @override
  ConsumerState<FaBioScreen> createState() => _FaBioScreenState();
}

class _FaBioScreenState extends ConsumerState<FaBioScreen> {
  bool _isFollowing = false;
  bool _followInitialized = false;

  @override
  Widget build(BuildContext context) {
    final bioAsync = ref.watch(faBioProvider(widget.faId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: bioAsync.when(
        data: (bio) {
          if (bio == null) return _buildError('FA not found');

          if (!_followInitialized) {
            _isFollowing = bio.faDetails.following;
            _followInitialized = true;
          }

          return CustomScrollView(
            slivers: [
              // _buildAppBar(bio.faDetails.faName, bio.faDetails.website),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    bio.faDetails.faName,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.socaBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const VerticalDivider(
                                color: AppColors.socaBlack,
                                thickness: 1,
                                width: 20,
                              ),
                              IconButton(
                                icon: Image.asset(
                                  "assets/images/ic_gallery.png",
                                  width: 24,
                                  height: 24,
                                ),
                                onPressed: () {},
                              ),
                              if (bio.faDetails.website != null)
                                IconButton(
                                  icon: const Icon(Icons.language,
                                      size: 25, color: AppColors.socaBlack),
                                  onPressed: () =>
                                      _launchUrl(bio.faDetails.website ?? ''),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    // White box: large FA name again (matches faName2 in XML)
                    _buildNameBox(bio.faDetails.faName),

                    // Basic info: image + follow | info rows
                    _buildBasicInfo(bio),

                    // News & Announcements
                    if (bio.newsList.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDivider(),
                      _buildNewsSection(bio.newsList),
                    ],

                    // Competitions
                    if (bio.compList.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDivider(),
                      _buildCompetitionsSection(
                          bio.faDetails.faName, bio.compList),
                    ],

                    // Featured Teams
                    if (bio.teamList.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDivider(),
                      _buildTeamsSection(bio.faDetails.faName, bio.teamList),
                    ],

                    // Sponsors
                    if (bio.sponsorList.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDivider(),
                      _buildSponsorsSection(bio.sponsorList),
                    ],

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _buildError(e.toString()),
      ),
    );
  }

  // ─── App Bar ─────────────────────────────────────────────────────────────

  Widget _buildAppBar(String faName, String? website) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      pinned: true,
      title: Text(
        faName,
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

  // ─── Large name text (faName2 in XML, white bg) ───────────────────────────

  Widget _buildNameBox(String faName) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        faName,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  // ─── Basic Info ──────────────────────────────────────────────────────────

  Widget _buildBasicInfo(FaBioModel bio) {
    final fa = bio.faDetails;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: image + follow button + follower count
          Column(
            children: [
              _buildFaImage(fa.fullImageUrl),
              const SizedBox(height: 8),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: _handleFollowTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 0,
                  ),
                  child: Text(
                    _isFollowing ? 'FOLLOWING' : 'FOLLOW',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${fa.followCount} ${fa.followCount == 1 ? "Follower" : "Followers"}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Right: info rows
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (fa.confed != null && fa.confed!.isNotEmpty)
                  ClubBioInfoRow(label: 'Confederation', value: fa.confed!),
                if (fa.formedYear != null && fa.formedYear!.isNotEmpty)
                  ClubBioInfoRow(label: 'Foundation', value: fa.formedYear!),
                if (fa.country != null && fa.country!.isNotEmpty)
                  ClubBioInfoRow(label: 'Country', value: fa.country!),
                if (fa.stadium != null && fa.stadium!.isNotEmpty)
                  ClubBioInfoRow(label: 'Stadium', value: fa.stadium!),
                if (fa.president != null && fa.president!.isNotEmpty)
                  ClubBioInfoRow(label: 'President', value: fa.president!),
                if (fa.genSecretary != null && fa.genSecretary!.isNotEmpty)
                  ClubBioInfoRow(
                      label: 'General Secretary', value: fa.genSecretary!),

                // Partnership badge
                if (fa.partnerType != null &&
                    fa.partnerType!.isNotEmpty &&
                    fa.partnerType!.toLowerCase() != 'nopartner') ...[
                  const SizedBox(height: 8),
                  Text(
                    fa.displayPartnerLabel,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaImage(String imageUrl) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.socaGrey,
        border: Border.all(color: AppColors.socaGrey, width: 2),
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

  Widget _buildDivider() => Container(height: 8, color: AppColors.socaPageBg);

  // ─── News & Announcements ────────────────────────────────────────────────

  Widget _buildNewsSection(List<ClubNewsModel> newsList) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClubBioSectionHeader(title: 'News & Announcements'),
          Divider(
            color: AppColors.socaBlack,
            thickness: .7,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: newsList.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: AppColors.socaBlack,
              thickness: .7,
            ),
            itemBuilder: (context, i) => _buildNewsRow(newsList[i]),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsRow(ClubNewsModel news) {
    final imageUrl = news.fullImageUrl;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(width: 80, height: 80, color: AppColors.socaGrey),
              ),
            ),
          if (imageUrl.isNotEmpty) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news.newsDate != null && news.newsDate!.isNotEmpty)
                  Text(
                    news.newsDate!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                if (news.title != null && news.title!.isNotEmpty)
                  Text(
                    news.title!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (news.description != null && news.description!.isNotEmpty)
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
            ),
          ),
        ],
      ),
    );
  }

  // ─── Competitions ────────────────────────────────────────────────────────

  Widget _buildCompetitionsSection(String faName, List<FaCompModel> comps) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Competitions',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FaAllCompetitionsScreen(
                        faName: faName,
                        competitions: comps,
                      ),
                    ),
                  ),
                  child: const Text(
                    'view all competitions',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: AppColors.socaBlack,
            thickness: .7,
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: ProviderScope(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: comps.length,
                itemBuilder: (context, i) => _buildCompCard(comps[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompCard(FaCompModel comp) {
    final imageUrl = comp.fullImageUrl;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.socaBlack)),
      ),
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => const Icon(Icons.emoji_events,
                  size: 40, color: AppColors.socaBlack),
            )
          else
            const Icon(Icons.emoji_events,
                size: 40, color: AppColors.socaBlack),
          // const SizedBox(height: 6),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8),
          //   child: Text(
          //     comp.compName,
          //     style: const TextStyle(
          //       fontFamily: 'Poppins',
          //       fontSize: 11,
          //       fontWeight: FontWeight.w600,
          //       color: AppColors.socaBlack,
          //     ),
          //     textAlign: TextAlign.center,
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
        ],
      ),
    );
  }

  // ─── Featured Teams ──────────────────────────────────────────────────────

  Widget _buildTeamsSection(String faName, List<FaTeamModel> teams) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Teams',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FaAllTeamsScreen(
                        faName: faName,
                        teams: teams,
                      ),
                    ),
                  ),
                  child: const Text(
                    'view all teams',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.socaBlack,
            thickness: .7,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: teams.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: AppColors.socaGrey),
            itemBuilder: (context, i) => _buildTeamRow(teams[i]),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTeamRow(FaTeamModel team) {
    final imageUrl = team.fullImageUrl;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
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
                      errorWidget: (_, __, ___) => const Icon(Icons.group,
                          size: 24, color: AppColors.socaBlack),
                    )
                  : const Icon(Icons.group,
                      size: 24, color: AppColors.socaBlack),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.teamName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (team.teamTypeLabel.isNotEmpty)
                  Text(
                    team.teamTypeLabel,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sponsors ────────────────────────────────────────────────────────────

  Widget _buildSponsorsSection(List<ClubSponsorModel> sponsors) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClubBioSectionHeader(title: 'Sponsors'),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              itemCount: sponsors.length,
              itemBuilder: (context, i) => _buildSponsorItem(sponsors[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorItem(ClubSponsorModel sponsor) {
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
          const SizedBox(height: 4),
          Text(
            sponsor.name ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
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

  void _handleFollowTap() {
    setState(() => _isFollowing = !_isFollowing);
    // TODO: call followFA API
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
