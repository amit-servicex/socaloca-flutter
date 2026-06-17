import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/club_news_model.dart';
import '../data/models/confed_bio_model.dart';
import '../providers/confed_bio_provider.dart';
import '../data/repositories/partners_repository.dart';
import '../widgets/club_bio_info_row.dart';
import '../widgets/club_bio_section_header.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class ConfedBioScreen extends ConsumerStatefulWidget {
  final String confedId;

  ConfedBioScreen({super.key, required this.confedId});

  @override
  ConsumerState<ConfedBioScreen> createState() => _ConfedBioScreenState();
}

class _ConfedBioScreenState extends ConsumerState<ConfedBioScreen> {
  bool _isFollowing = false;
  bool _followInitialized = false;

  @override
  Widget build(BuildContext context) {
    final bioAsync = ref.watch(confedBioProvider(widget.confedId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: bioAsync.when(
        data: (bio) {
          if (bio == null) return _buildError(AppStrings.confedNotFound);

          if (!_followInitialized) {
            _isFollowing = bio.confedDetails.following;
            _followInitialized = true;
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Top bar: confedName + badge + gallery + website ──────
                    _buildTopBar(bio),

                    SizedBox(height: 4),

                    // ── Large confed name ────────────────────────────────────
                    _buildNameBox(bio.confedDetails.confedName),

                    // ── Basic info: image + follow | info rows ───────────────
                    _buildBasicInfo(bio),

                    // ── News & Announcements ─────────────────────────────────
                    if (bio.newsList.isNotEmpty) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildNewsSection(bio.newsList),
                    ],

                    // ── Competitions ─────────────────────────────────────────
                    if (bio.compList.isNotEmpty) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildCompetitionsSection(
                          bio.confedDetails.confedName, bio.compList),
                    ],

                    // ── Featured FAs ─────────────────────────────────────────
                    if (bio.fasList.isNotEmpty) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildFAsSection(
                          bio.confedDetails.confedName, bio.fasList),
                    ],

                    // ── Official Merchandise ─────────────────────────────────
                    if (bio.merchandises.isNotEmpty) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildMerchandiseSection(bio.merchandises),
                    ],

                    // ── Sponsors ─────────────────────────────────────────────
                    if (bio.sponsorList.isNotEmpty) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildSponsorsSection(bio.sponsorList),
                    ],

                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => AppLoader(),
        error: (e, _) => _buildError(e.toString()),
      ),
    );
  }

  // ─── Top bar ─────────────────────────────────────────────────────────────

  Widget _buildTopBar(ConfedBioModel bio) {
    final confed = bio.confedDetails;
    final partnerType = confed.partnerType?.toLowerCase();
    final hasBadge = partnerType != null &&
        partnerType.isNotEmpty &&
        partnerType != 'nopartner';

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    confed.confedName,
                    maxLines: 2,
                    style: TextStyle(
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
              if (hasBadge) ...[
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    color: AppColors.socaBlack,
                    thickness: 1,
                    width: 20,
                  ),
                ),
                _buildBadgeIcon(partnerType),
              ],
              IconButton(
                icon: Image.asset(
                  'assets/images/ic_gallery.png',
                  width: 28,
                  height: 28,
                ),
                onPressed: () {
                  context.push(
                    AppRoutes.myPosts,
                    extra: {
                      'userId': confed.confedId,
                      'isOwnProfile': false,
                    },
                  );
                },
              ),
              if (confed.website != null && confed.website!.isNotEmpty)
                IconButton(
                  icon: Image.asset(
                    'assets/icons/ic_website.png',
                    width: 28,
                    height: 28,
                  ),
                  onPressed: () => _launchUrl(confed.website ?? ''),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon(String? partnerType) {
    String assetPath;
    switch (partnerType) {
      case 'platinum':
        assetPath = 'assets/icons/ic_platinum_badge.png';
        break;
      case 'gold':
        assetPath = 'assets/icons/ic_gold_badge.png';
        break;
      case 'silver':
        assetPath = 'assets/icons/ic_silver_badge.png';
        break;
      default:
        return SizedBox.shrink();
    }
    return Image.asset(assetPath, width: 28, height: 28);
  }

  // ─── Large name box ───────────────────────────────────────────────────────

  Widget _buildNameBox(String confedName) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        confedName,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  // ─── Basic Info ──────────────────────────────────────────────────────────

  Widget _buildBasicInfo(ConfedBioModel bio) {
    final confed = bio.confedDetails;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: image + follow button + follower count
          Column(
            children: [
              _buildConfedImage(confed.fullImageUrl),
              SizedBox(height: 8),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: _handleFollowTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6),
                    elevation: 0,
                  ),
                  child: Text(
                    _isFollowing
                        ? AppStrings.following.toUpperCase()
                        : AppStrings.follow.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.socaYellow,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                AppStrings.followersCount(confed.followCount),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(width: 16),

          // Right: info rows
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (confed.formedYear != null && confed.formedYear!.isNotEmpty)
                ClubBioInfoRow(
                  label: AppStrings.foundation,
                  value: confed.formedYear ?? '',
                ),
                // if (confed.president != null && confed.president!.isNotEmpty)
                ClubBioInfoRow(
                  label: AppStrings.president,
                  value: confed.president ?? '',
                ),
                // if (confed.genSecretary != null &&
                // confed.genSecretary!.isNotEmpty)
                ClubBioInfoRow(
                  label: AppStrings.generalSecretary,
                  value: confed.genSecretary ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfedImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.socaGrey,
        border: Border.all(color: AppColors.socaGrey, width: 2),
      ),
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.socaGrey),
              errorWidget: (_, __, ___) => _imageFallback(),
            )
          : _imageFallback(),
    );
  }

  Widget _imageFallback() => Container(
        color: AppColors.socaGrey,
        child: Icon(Icons.public, color: AppColors.socaBlack, size: 40),
      );

  Widget _buildDivider() => Container(height: 8, color: AppColors.socaPageBg);

  // ─── News & Announcements ─────────────────────────────────────────────────

  Widget _buildNewsSection(List<ClubNewsModel> newsList) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClubBioSectionHeader(title: AppStrings.newsAnnouncements),
          Divider(color: AppColors.socaBlack, thickness: .7),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: newsList.length,
            separatorBuilder: (_, __) => Divider(
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
    final tapUrl = (news.link != null && news.link!.trim().isNotEmpty)
        ? news.link!
        : (news.isVideo && news.videoUrl != null && news.videoUrl!.isNotEmpty)
            ? news.videoUrl!
            : null;
    return GestureDetector(
      onTap: tapUrl != null ? () => _launchUrl(tapUrl) : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.socaGrey,
                  ),
                ),
              ),
            if (imageUrl.isNotEmpty) SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (news.newsDate != null && news.newsDate!.isNotEmpty)
                    Text(
                      news.newsDate!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  if (news.title != null && news.title!.isNotEmpty)
                    Text(
                      news.title!,
                      style: TextStyle(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Competitions ─────────────────────────────────────────────────────────

  Widget _buildCompetitionsSection(
      String confedName, List<ConfedCompItemModel> comps) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.competitions,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Sub-screen stub — to be implemented in a future phase
                  },
                  child: Text(
                    AppStrings.viewAllCompetitions,
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
          SizedBox(height: 5),
          Divider(color: AppColors.socaBlack, thickness: .7, height: 0),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: comps.length,
              itemBuilder: (context, i) => _buildCompCard(comps[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompCard(ConfedCompItemModel comp) {
    final imageUrl = comp.fullImageUrl;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.socaBlack)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => Icon(Icons.emoji_events,
                  size: 40, color: AppColors.socaBlack),
            )
          else
            Icon(Icons.emoji_events, size: 40, color: AppColors.socaBlack),
        ],
      ),
    );
  }

  // ─── Featured FAs ─────────────────────────────────────────────────────────

  Widget _buildFAsSection(String confedName, List<ConfedFAItemModel> fas) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.featuredFAs,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Sub-screen stub — to be implemented in a future phase
                  },
                  child: Text(
                    AppStrings.viewAllFAs,
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
          SizedBox(height: 5),
          Divider(color: AppColors.socaBlack, thickness: .7, height: 0),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: fas.length,
              itemBuilder: (context, i) => _buildFACard(fas[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFACard(ConfedFAItemModel fa) {
    final imageUrl = fa.fullImageUrl;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.socaBlack)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => Icon(
                Icons.sports_soccer,
                size: 40,
                color: AppColors.socaBlack,
              ),
            )
          else
            Icon(Icons.sports_soccer, size: 40, color: AppColors.socaBlack),
        ],
      ),
    );
  }

  // ─── Official Merchandise ─────────────────────────────────────────────────

  Widget _buildMerchandiseSection(List<ConfedMerchandiseModel> items) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClubBioSectionHeader(title: AppStrings.officialMerchandise),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              itemCount: items.length,
              itemBuilder: (context, i) => _buildMerchandiseItem(items[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMerchandiseItem(ConfedMerchandiseModel item) {
    final imageUrl = item.fullImageUrl;
    return Container(
      width: 90,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
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
                      errorWidget: (_, __, ___) => Icon(
                        Icons.shopping_bag_outlined,
                        size: 32,
                        color: AppColors.socaBlack,
                      ),
                    )
                  : Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: AppColors.socaBlack,
                    ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            item.prodName,
            style: TextStyle(
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

  // ─── Sponsors ─────────────────────────────────────────────────────────────

  Widget _buildSponsorsSection(List<ConfedSponsorModel> sponsors) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClubBioSectionHeader(title: AppStrings.sponsors),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              itemCount: sponsors.length,
              itemBuilder: (context, i) => _buildSponsorItem(sponsors[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorItem(ConfedSponsorModel sponsor) {
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
                      errorWidget: (_, __, ___) => Icon(
                        Icons.business,
                        size: 32,
                        color: AppColors.socaBlack,
                      ),
                    )
                  : Icon(Icons.business, size: 32, color: AppColors.socaBlack),
            ),
          ),
          SizedBox(height: 4),
          Text(
            sponsor.name ?? '',
            style: TextStyle(
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

  // ─── Error ────────────────────────────────────────────────────────────────

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

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _handleFollowTap() {
    setState(() => _isFollowing = !_isFollowing);
    ref.read(partnersRepositoryProvider).followConfed(
          confedId: widget.confedId,
        );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
