import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/core/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_news_model.dart';
import '../data/models/sponsor_charity_bio_models.dart';
import '../providers/charity_bio_provider.dart';
import '../widgets/club_bio_info_row.dart';
import '../widgets/club_bio_section_header.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class CharityBioScreen extends ConsumerStatefulWidget {
  final String charityId;

  CharityBioScreen({super.key, required this.charityId});

  @override
  ConsumerState<CharityBioScreen> createState() => _CharityBioScreenState();
}

class _CharityBioScreenState extends ConsumerState<CharityBioScreen> {
  bool _isFollowing = false;
  bool _followInitialized = false;

  @override
  Widget build(BuildContext context) {
    final bioAsync = ref.watch(charityBioProvider(widget.charityId));

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: bioAsync.when(
        data: (bio) {
          if (bio == null) return _buildError(AppStrings.charityNotFound);

          if (!_followInitialized) {
            _isFollowing = bio.details.following;
            _followInitialized = true;
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(bio.details),
                    SizedBox(height: 4),
                    _buildNameBox(bio.details.charityName),
                    _buildBasicInfo(bio.details),
                    if (bio.bioArea != null &&
                        ((bio.bioArea!.bio != null &&
                                bio.bioArea!.bio!.isNotEmpty) ||
                            bio.bioArea!.imageUrl != null)) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildBioAreaSection(bio.bioArea!),
                    ],
                    if (bio.newsList.isNotEmpty) ...[
                      SizedBox(height: 12),
                      _buildDivider(),
                      _buildNewsSection(bio.newsList),
                    ],
                    SizedBox(height: 40),
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

  // ─── Top bar ──────────────────────────────────────────────────────────────

  Widget _buildTopBar(CharityInfoModel info) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: Text(
              info.charityName,
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                height: 30,
                child: VerticalDivider(
                    color: AppColors.socaBlack, thickness: 1, width: 20),
              ),
              _buildBadgeIcon(info.partnerType),
              IconButton(
                icon: Image.asset(
                  "assets/images/ic_gallery.png",
                  width: 28,
                  height: 28,
                ),
                onPressed: () {
                  context.push(
                    AppRoutes.myPosts,
                    extra: {
                      'userId': info.charityId,
                      'isOwnProfile': false,
                    },
                  );
                },
              ),
              if (info.website != null && info.website!.trim().isNotEmpty)
                IconButton(
                  icon: Image.asset('assets/icons/ic_website.png',
                      width: 28, height: 28),
                  onPressed: () => _launchUrl(info.website!),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon(String? partnerType) {
    final t = partnerType?.toLowerCase();
    if (t == 'platinum') {
      return Image.asset('assets/icons/ic_platinum_badge.png',
          width: 28, height: 28);
    } else if (t == 'gold') {
      return Image.asset('assets/icons/ic_gold_badge.png',
          width: 28, height: 28);
    } else if (t == 'silver') {
      return Image.asset('assets/icons/ic_silver_badge.png',
          width: 28, height: 28);
    }
    return SizedBox.shrink();
  }

  // ─── Name box ────────────────────────────────────────────────────────────

  Widget _buildNameBox(String name) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  // ─── Basic info ───────────────────────────────────────────────────────────

  Widget _buildBasicInfo(CharityInfoModel info) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildEntityImage(info.fullImageUrl),
              SizedBox(height: 8),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: _handleFollowTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
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
                AppStrings.followersCount(info.followCount),
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: AppColors.socaBlack),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (info.formedYear != null && info.formedYear!.isNotEmpty)
                ClubBioInfoRow(
                    label: AppStrings.founded, value: info.formedYear ?? ''),
                // if (info.country != null && info.country!.isNotEmpty)
                ClubBioInfoRow(
                    label: AppStrings.country, value: info.country ?? ''),
                // if (info.president != null && info.president!.isNotEmpty)
                ClubBioInfoRow(
                    label: AppStrings.president, value: info.president ?? ''),
                // if (info.chairman != null && info.chairman!.isNotEmpty)
                ClubBioInfoRow(
                    label: AppStrings.chairman, value: info.chairman ?? ''),
                // if (info.ceo != null && info.ceo!.isNotEmpty)
                ClubBioInfoRow(label: AppStrings.ceo, value: info.ceo ?? ''),
                // if (info.funders != null && info.funders!.isNotEmpty)
                ClubBioInfoRow(
                    label: AppStrings.fundingPartners,
                    value: info.funders ?? ''),
                // if (info.partnerType != null &&
                //     info.partnerType!.isNotEmpty &&
                //     info.partnerType!.toLowerCase() != 'nopartner') ...[
                //   SizedBox(height: 8),
                //   Text(
                //     info.displayPartnerLabel,
                //     style: TextStyle(
                //         fontFamily: 'Poppins',
                //         fontSize: 12,
                //         fontWeight: FontWeight.w700,
                //         color: AppColors.socaBlack),
                //   ),
                // ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntityImage(String imageUrl) {
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
        child: Icon(Icons.volunteer_activism,
            color: AppColors.socaBlack, size: 40),
      );

  Widget _buildDivider() => Container(height: 8, color: AppColors.socaPageBg);

  // ─── Bio Area ─────────────────────────────────────────────────────────────

  Widget _buildBioAreaSection(CharityBioAreaModel bioArea) {
    final imageUrl = bioArea.fullImageUrl;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClubBioSectionHeader(title: AppStrings.about),
          Divider(color: AppColors.socaBlack, thickness: .7),
          if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(height: 180, color: AppColors.socaGrey),
              ),
            ),
          if (imageUrl.isNotEmpty) SizedBox(height: 12),
          if (bioArea.bio != null && bioArea.bio!.isNotEmpty)
            Text(
              bioArea.bio!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
        ],
      ),
    );
  }

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
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: AppColors.socaBlack, thickness: .7),
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
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                      width: 80, height: 80, color: AppColors.socaGrey),
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
                          color: AppColors.textSecondary),
                    ),
                  if (news.title != null && news.title!.isNotEmpty)
                    Text(
                      news.title!,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.socaBlack),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (news.description != null && news.description!.isNotEmpty)
                    Text(
                      news.description!,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: AppColors.socaBlack),
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

  // ─── Error ────────────────────────────────────────────────────────────────

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          SizedBox(height: 16),
          Text(message,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: AppColors.socaBlack)),
        ],
      ),
    );
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  void _handleFollowTap() {
    final userId = StorageService.userId ?? '';
    final newFollowing = !_isFollowing;
    setState(() => _isFollowing = newFollowing);
    ApiClient.instance.post(
      ApiConstants.followCharity,
      body: {'userId': userId, 'charityId': widget.charityId},
    ).catchError((_) {
      if (mounted) setState(() => _isFollowing = !newFollowing);
      return <String, dynamic>{};
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
