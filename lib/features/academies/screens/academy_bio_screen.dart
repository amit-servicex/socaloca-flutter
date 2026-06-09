import 'dart:developer';
import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/academy_bio_models.dart';
import '../providers/academy_bio_provider.dart';
import '../providers/academies_provider.dart';
import 'academy_gallery_screen.dart';
import 'academy_trial_register_dialog.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class AcademyBioScreen extends ConsumerStatefulWidget {
  final String academyId;

  AcademyBioScreen({super.key, required this.academyId});

  @override
  ConsumerState<AcademyBioScreen> createState() => _AcademyBioScreenState();
}

class _AcademyBioScreenState extends ConsumerState<AcademyBioScreen> {
  final PageController _bannerController = PageController();
  int _currentBanner = 0;
  bool _isFollowing = false;
  bool _followInitialized = false;
  String? _joinedStatus;
  bool _joinInitialized = false;
  bool _isJoining = false;

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  String _imageUrl(String? path) => ApiConstants.getImageUrl(path);

  bool get _isPlayer => StorageService.currentUser?['isPlayer'] == true;
  bool get _isCoach => StorageService.currentUser?['isCoach'] == true;
  bool get _isAdmin => StorageService.currentUser?['isAdmin'] == true;
  bool get _isFan => StorageService.currentUser?['isFan'] == true;
  bool get _isReferee => StorageService.currentUser?['isReferee'] == true;

  bool get _canJoin =>
      (_isPlayer || _isCoach || _isAdmin) && !_isFan && !_isReferee;

  Future<void> _handleFollow(AcademyBioData bio) async {
    final userId = StorageService.userId ?? '';
    final currentUser = StorageService.currentUser ?? {};
    final firstName = currentUser['firstName'] as String? ?? '';
    final lastName = currentUser['lastName'] as String? ?? '';
    final myName = '$firstName $lastName'.trim();
    final myImageUrl = currentUser['imageUrl'] as String? ?? '';
    final country = currentUser['country'] as String? ?? '';
    final gender = currentUser['gender'] as String? ?? '';
    int birthYear = 0;
    final yob = currentUser['yearOfBirth'];
    if (yob is int) birthYear = yob;

    final success = await ref.read(academiesRepositoryProvider).followAcademy(
          userId: userId,
          academyId: widget.academyId,
          myName: myName,
          myImageUrl: myImageUrl,
          country: country,
          gender: gender,
          birthYear: birthYear,
          isPlayer: _isPlayer,
          isCoach: _isCoach,
          isAdmin: _isAdmin,
          isFan: _isFan,
        );

    if (success && mounted) {
      setState(() => _isFollowing = !_isFollowing);
    }
  }

  Future<void> _handleJoin(bool request) async {
    if (_isJoining) return;
    setState(() => _isJoining = true);
    final userId = StorageService.userId ?? '';
    final result = await ref.read(academiesRepositoryProvider).joinAcademy(
          userId: userId,
          academyId: widget.academyId,
          request: request,
        );
    if (mounted) {
      setState(() => _isJoining = false);
      if (result != null) {
        setState(() => _joinedStatus = result['joined'] as String?);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            request ? AppStrings.joiningRequestSent : AppStrings.requestCancelled,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: AppColors.socaBlack,
        ));
      }
    }
  }

  Future<void> _handleTrialRegister(AcademyBioData bio) async {
    final academyName = bio.academyDetails?.name ?? '';
    final academyEmail = bio.academyDetails?.email ?? '';
    await showDialog(
      context: context,
      builder: (_) => AcademyTrialRegisterDialog(
        academyId: widget.academyId,
        academyName: academyName,
        academyEmail: academyEmail,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bioAsync = ref.watch(academyBioProvider(widget.academyId));

    return Scaffold(
      backgroundColor: Colors.white,
      body: bioAsync.when(
        data: (bio) {
          if (bio == null) {
            return _buildError(AppStrings.academyNotFound);
          }
          if (!_followInitialized) {
            _isFollowing = bio.academyDetails?.following ?? false;
            _followInitialized = true;
          }
          if (!_joinInitialized) {
            _joinedStatus = bio.joinedStatus;
            _joinInitialized = true;
          }
          return _buildContent(bio);
        },
        loading: () => AppLoader(),
        error: (e, _) => _buildError(e.toString()),
      ),
    );
  }

  Widget _buildError(String msg) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      // appBar: AppBar(
      //   backgroundColor: AppColors.socaBlack,
      //   foregroundColor: AppColors.socaYellow,
      //   elevation: 0,
      // ),
      body: Center(
        child: Text(msg, style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
      ),
    );
  }

  Widget _buildContent(AcademyBioData bio) {
    final details = bio.academyDetails;
    return CustomScrollView(
      slivers: [
        // _buildAppBar(details?.name ?? 'Academy'),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Slider
              if (bio.banners.isNotEmpty) ...[
                _buildBannerSlider(bio.banners),
              ] else ...[
                SizedBox(
                  height: 180,
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
                              "assets/images/academy_defalut_banner.jpg",
                              fit: BoxFit.cover)),
                    ],
                  ),
                )
              ],

              // Header: image, name, follow, country, category, year
              _buildHeader(bio, details),
              Divider(
                color: AppColors.socaBlack,
                thickness: .8,
                height: 1,
              ),
              // About
              if (details?.about != null && details!.about!.isNotEmpty)
                _buildAboutSection(details.about!),

              // Bio details: director, manager, contact
              if (_hasBioDetails(details)) _buildBioDetails(details!),

              // Sponsors
              if (bio.sponsorList.isNotEmpty)
                _buildSponsorsSection(bio.sponsorList),

              // Teams
              if (bio.teams.isNotEmpty) _buildTeamsSection(bio.teams),

              // Skill Videos
              if (bio.skillVdos.isNotEmpty)
                _buildVideosSection(AppStrings.skillVideos, bio.skillVdos),

              // Match Videos
              if (bio.matchVdos.isNotEmpty)
                _buildVideosSection(AppStrings.matchVideos, bio.matchVdos),

              // Posts (max 3 + View All)
              if (bio.postList.isNotEmpty) _buildPostsSection(bio),

              // News
              if (bio.newsList.isNotEmpty) _buildNewsSection(bio.newsList),

              // Trial badge + Register button
              if (bio.trialDetails?.trialBadge == true) _buildTrialSection(bio),

              SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildAppBar(String title) {
    return SliverAppBar(
      backgroundColor: AppColors.socaBlack,
      foregroundColor: AppColors.socaYellow,
      elevation: 0,
      pinned: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.socaYellow,
        ),
      ),
    );
  }

  Widget _buildBannerSlider(List<AcademyBannerModel> banners) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemBuilder: (_, i) {
              final url = _imageUrl(banners[i].imageUrl);
              return url.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          Container(color: AppColors.socaGrey),
                      errorWidget: (_, __, ___) =>
                          Container(color: AppColors.socaGrey),
                    )
                  : Container(color: AppColors.socaGrey);
            },
          ),
          if (banners.length > 1)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (i) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: i == _currentBanner ? 12 : 6,
                    height: 6,
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: i == _currentBanner
                          ? AppColors.socaYellow
                          : Colors.white54,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(AcademyBioData bio, AcademyDetailModel? details) {
    final imageUrl = _imageUrl(details?.imageUrl);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Academy name at top
          Text(
            details?.name ?? '',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.socaBlack,
            ),
          ),
          SizedBox(height: 12),
          // Image | Info rows | CAT badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.socaBlack, width: 2),
                  shape: BoxShape.circle,
                  color: AppColors.socaGrey.withValues(alpha: 0.3),
                ),
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => AppLoader(),
                          errorWidget: (_, __, ___) => Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset('assets/images/logo.png',
                          fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (details?.country != null &&
                        details!.country!.isNotEmpty)
                      _infoLabelValue(AppStrings.country, details.country!),
                    if (details?.director != null &&
                        details!.director!.isNotEmpty)
                      _infoLabelValue(AppStrings.director, details.director!),
                    if (details?.formedYear != null &&
                        details!.formedYear!.isNotEmpty)
                      _infoLabelValue(AppStrings.foundedYear, details.formedYear!),
                  ],
                ),
              ),
              if (details?.category != null &&
                  details!.category!.isNotEmpty) ...[
                SizedBox(width: 8),
                _buildCatBadge(details.category!),
              ],
            ],
          ),
          SizedBox(height: 12),
          // Follow + Join buttons row
          Row(
            children: [
              _buildFollowButton(bio),
              if (_canJoin) ...[
                SizedBox(width: 8),
                _buildInlineJoinButton(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFollowButton(AcademyBioData bio) {
    return GestureDetector(
      onTap: () => _handleFollow(bio),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: !_isFollowing ? AppColors.socaBlack : Colors.white,
          border: Border.all(color: AppColors.socaBlack),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          _isFollowing ? AppStrings.following.toUpperCase() : AppStrings.follow.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: !_isFollowing ? AppColors.socaYellow : AppColors.socaBlack,
          ),
        ),
      ),
    );
  }

  Widget _buildInlineJoinButton() {
    if (_isJoining) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
            strokeWidth: 2, color: AppColors.socaBlack),
      );
    }
    if (_joinedStatus == 'ACCEPTED') {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          AppStrings.academyJoined.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.socaYellow,
          ),
        ),
      );
    }
    if (_joinedStatus == 'PENDING') {
      return GestureDetector(
        onTap: () => _handleJoin(false),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.socaBlack,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            AppStrings.cancelRequest.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.socaYellow,
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () => _handleJoin(true),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          AppStrings.sendRequest.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.socaYellow,
          ),
        ),
      ),
    );
  }

  Widget _buildCatBadge(String category) {
    return Container(
      width: 80,
      height: 85,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.socaBlack,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.cat,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.socaYellow,
            ),
          ),
          Text(
            category,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 28,
              color: AppColors.socaYellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoLabelValue(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 12, color: AppColors.socaBlack),
          children: [
            TextSpan(
                text: '$label - ',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(String about) {
    return Container(
      // color: AppColors.socaPageBg,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.socaPageBg,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              about,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                AppStrings.about.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasBioDetails(AcademyDetailModel? d) {
    if (d == null) return false;
    return (d.director?.isNotEmpty == true) ||
        (d.manager?.isNotEmpty == true) ||
        (d.mobile?.isNotEmpty == true) ||
        (d.email?.isNotEmpty == true);
  }

  Widget _buildBioDetails(AcademyDetailModel d) {
    return Container(
      // color: AppColors.socaPageBg,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.socaPageBg,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (d.director?.isNotEmpty == true)
                          _bioCell(AppStrings.academyDirector, d.director!),
                        if (d.director?.isNotEmpty == true &&
                            d.manager?.isNotEmpty == true)
                          SizedBox(height: 12),
                        if (d.manager?.isNotEmpty == true)
                          _bioCell(AppStrings.academyManager, d.manager!),
                      ],
                    ),
                  ),
                  if ((d.mobile?.isNotEmpty == true) ||
                      (d.email?.isNotEmpty == true)) ...[
                    VerticalDivider(
                        color: AppColors.socaBlack, thickness: 1, width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (d.mobile?.isNotEmpty == true)
                            _bioCell(AppStrings.academyContactNumber, d.mobile!),
                          if (d.mobile?.isNotEmpty == true &&
                              d.email?.isNotEmpty == true)
                            SizedBox(height: 12),
                          if (d.email?.isNotEmpty == true)
                            _bioCell(AppStrings.academyContactEmail, d.email!),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                AppStrings.bio.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bioCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.socaBlack,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildSponsorsSection(List<AcademySponsorModel> sponsors) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.socaPageBg,
            ),
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: sponsors.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (_, i) {
                final s = sponsors[i];
                final logoUrl = _imageUrl(s.logo);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.socaGrey.withValues(alpha: 0.2),
                      ),
                      child: ClipOval(
                        child: logoUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: logoUrl,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => Icon(
                                    Icons.business,
                                    color: AppColors.socaBlack),
                              )
                            : Icon(Icons.business, color: AppColors.socaBlack),
                      ),
                    ),
                    if (s.name?.isNotEmpty == true)
                      SizedBox(
                        width: 64,
                        child: Text(
                          s.name!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            color: AppColors.socaBlack,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: -20,
            left: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: _sectionTitle(AppStrings.sponsors),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsSection(List<AcademyTeamModel> teams) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: AppColors.socaPageBg,
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: teams.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, i) {
                final t = teams[i];
                final imgUrl = _imageUrl(t.imageUrl);
                return GestureDetector(
                  onTap: t.teamId?.isNotEmpty == true
                      ? () => context.push('${AppRoutes.teams}/${t.teamId}')
                      : null,
                  child: SizedBox(
                    width: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.socaGrey.withValues(alpha: 0.3),
                          ),
                          child: ClipOval(
                            child: imgUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: imgUrl,
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) => const Icon(
                                        Icons.group,
                                        color: AppColors.socaBlack),
                                  )
                                : const Icon(Icons.group,
                                    color: AppColors.socaBlack),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          t.name ?? '',
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
                );
              },
            ),
          ),
          Positioned(
            top: -20,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                AppStrings.teams.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosSection(String title, List<AcademyPostModel> videos) {
    return Container(
      // color: Colors.white,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
                color: AppColors.socaPageBg,
                borderRadius: BorderRadius.circular(8)),
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: videos.length,
              separatorBuilder: (_, __) => SizedBox(width: 10),
              itemBuilder: (_, i) {
                final v = videos[i];
                // thumbnail is a full URL; imageUrl may be a relative path
                final imgUrl = v.thumbnail?.isNotEmpty == true
                    ? v.thumbnail!
                    : _imageUrl(v.imageUrl ?? v.effectiveImageUrl);

                return InkWell(
                  onTap: () {
                    context.push(AppRoutes.fullScreenVideo, extra: {
                      'videoUrl': v.videoUrl ?? '',
                      'thumbnail': imgUrl,
                    });
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.socaGrey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (imgUrl.isNotEmpty)
                          CachedNetworkImage(
                            imageUrl: imgUrl,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => Icon(Icons.videocam,
                                color: AppColors.socaBlack),
                          )
                        else
                          Icon(Icons.videocam, color: AppColors.socaBlack),
                        Container(color: Colors.black26),
                        Center(
                          child: Icon(Icons.play_circle_outline,
                              color: Colors.white, size: 36),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: -20,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _sectionTitle(title),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsSection(AcademyBioData bio) {
    final displayPosts = bio.postList.take(3).toList();
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.socaPageBg,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: displayPosts.length,
              itemBuilder: (_, i) {
                final post = displayPosts[i];
                final imgUrl =
                    _imageUrl(post.imageUrl ?? post.effectiveImageUrl);
                log("this is the post image url : $imgUrl");
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.socaGrey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: imgUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imgUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                              Icon(Icons.image, color: AppColors.socaBlack),
                        )
                      : Icon(Icons.image, color: AppColors.socaBlack),
                );
              },
            ),
          ),
          Positioned(
            top: -20,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionTitle(AppStrings.posts),
                if (bio.postList.length > 3)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AcademyGalleryScreen(
                          academyId: widget.academyId,
                          academyName: bio.academyDetails?.name ?? '',
                        ),
                      ),
                    ),
                    child: Text(
                      'View All'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection(List<AcademyNewsModel> newsList) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.socaPageBg,
            ),
            child: Column(
              children: [
                ...newsList.map((n) => _buildNewsItem(n)),
              ],
            ),
          ),
          Positioned(
            top: -20,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                AppStrings.academyNews.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(AcademyNewsModel news) {
    final imgUrl = _imageUrl(news.imageUrl);
    final hasLink = news.link != null && news.link!.isNotEmpty;
    return InkWell(
      onTap: hasLink
          ? () async {
              final uri = Uri.tryParse(news.link!);
              if (uri != null && await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        // color: Colors.white,
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imgUrl.isNotEmpty) ...[
              ClipRRect(
                // borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                      width: 90, height: 90, color: AppColors.socaGrey),
                ),
              ),
              SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (news.newsDate?.isNotEmpty == true)
                    Text(
                      news.newsDate!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  if (news.title?.isNotEmpty == true)
                    Text(
                      news.title!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (news.description?.isNotEmpty == true)
                    Text(
                      news.description!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: AppColors.socaBlack,
                      ),
                      maxLines: 50,
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

  Widget _buildTrialSection(AcademyBioData bio) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Live Trial'.tr,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () => _handleTrialRegister(bio),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Register'.tr,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.socaBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.socaYellow,
        ),
      ),
    );
  }
}
