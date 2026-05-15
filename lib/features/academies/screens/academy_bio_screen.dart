import 'package:cached_network_image/cached_network_image.dart';
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

  const AcademyBioScreen({super.key, required this.academyId});

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

  bool get _isPlayer =>
      StorageService.currentUser?['isPlayer'] == true;
  bool get _isCoach =>
      StorageService.currentUser?['isCoach'] == true;
  bool get _isAdmin =>
      StorageService.currentUser?['isAdmin'] == true;
  bool get _isFan =>
      StorageService.currentUser?['isFan'] == true;
  bool get _isReferee =>
      StorageService.currentUser?['isReferee'] == true;

  bool get _canJoin => (_isPlayer || _isCoach || _isAdmin) && !_isFan && !_isReferee;

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
            request ? 'Joining request sent' : 'Request cancelled',
            style: const TextStyle(fontFamily: 'Poppins'),
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
      backgroundColor: AppColors.socaPageBg,
      body: bioAsync.when(
        data: (bio) {
          if (bio == null) {
            return _buildError('Academy not found');
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
        loading: () => const AppLoader(),
        error: (e, _) => _buildError(e.toString()),
      ),
    );
  }

  Widget _buildError(String msg) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: Center(
        child: Text(msg,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
      ),
    );
  }

  Widget _buildContent(AcademyBioData bio) {
    final details = bio.academyDetails;
    return CustomScrollView(
      slivers: [
        _buildAppBar(details?.name ?? 'Academy'),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Slider
              if (bio.banners.isNotEmpty) _buildBannerSlider(bio.banners),

              // Header: image, name, follow, country, category, year
              _buildHeader(bio, details),

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
                _buildVideosSection('Skill Videos', bio.skillVdos),

              // Match Videos
              if (bio.matchVdos.isNotEmpty)
                _buildVideosSection('Match Videos', bio.matchVdos),

              // Posts (max 3 + View All)
              if (bio.postList.isNotEmpty) _buildPostsSection(bio),

              // News
              if (bio.newsList.isNotEmpty) _buildNewsSection(bio.newsList),

              // Trial badge + Register button
              if (bio.trialDetails?.trialBadge == true)
                _buildTrialSection(bio),

              const SizedBox(height: 40),
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
        style: const TextStyle(
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
                      placeholder: (_, __) => Container(color: AppColors.socaGrey),
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
                    duration: const Duration(milliseconds: 300),
                    width: i == _currentBanner ? 12 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Academy image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.socaGrey.withValues(alpha: 0.3),
                ),
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const AppLoader(),
                          errorWidget: (_, __, ___) => Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset('assets/images/logo.png',
                          fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details?.name ?? '',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Follow button
                    GestureDetector(
                      onTap: () => _handleFollow(bio),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: _isFollowing
                              ? AppColors.socaBlack
                              : Colors.white,
                          border: Border.all(color: AppColors.socaBlack),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: _isFollowing
                                ? AppColors.socaYellow
                                : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (details?.country != null && details!.country!.isNotEmpty)
            _infoRow(Icons.location_on, details.country!),
          if (details?.category != null && details!.category!.isNotEmpty)
            _infoRow(Icons.category, 'Category ${details.category}'),
          if (details?.formedYear != null && details!.formedYear!.isNotEmpty)
            _infoRow(Icons.calendar_today, 'Founded ${details.formedYear}'),

          // Join buttons (non-fan roles only)
          if (_canJoin) ...[
            const SizedBox(height: 12),
            _buildJoinButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildJoinButtons() {
    if (_isJoining) {
      return const AppLoader();
    }
    if (_joinedStatus == 'ACCEPTED') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.green),
        ),
        child: const Text(
          'Academy Joined',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.green,
          ),
        ),
      );
    }
    if (_joinedStatus == 'PENDING') {
      return GestureDetector(
        onTap: () => _handleJoin(false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            'Cancel Request',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    // CANCEL or null → show Send Request
    return GestureDetector(
      onTap: () => _handleJoin(true),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
          'Send Request',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppColors.socaYellow,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.socaBlack),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(String about) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('About'),
          const SizedBox(height: 8),
          Text(
            about,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: AppColors.socaBlack,
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
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Details'),
          const SizedBox(height: 8),
          if (d.director?.isNotEmpty == true)
            _detailRow('Director', d.director!),
          if (d.manager?.isNotEmpty == true)
            _detailRow('Manager', d.manager!),
          if (d.mobile?.isNotEmpty == true)
            _detailRow('Contact', d.mobile!),
          if (d.email?.isNotEmpty == true)
            _detailRow('Email', d.email!),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorsSection(List<AcademySponsorModel> sponsors) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _sectionTitle('Sponsors'),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sponsors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
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
                                errorWidget: (_, __, ___) => const Icon(
                                    Icons.business,
                                    color: AppColors.socaBlack),
                              )
                            : const Icon(Icons.business,
                                color: AppColors.socaBlack),
                      ),
                    ),
                    if (s.name?.isNotEmpty == true)
                      SizedBox(
                        width: 64,
                        child: Text(
                          s.name!,
                          style: const TextStyle(
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
        ],
      ),
    );
  }

  Widget _buildTeamsSection(List<AcademyTeamModel> teams) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _sectionTitle('Teams'),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: teams.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final t = teams[i];
                final imgUrl = _imageUrl(t.imageUrl);
                return GestureDetector(
                  onTap: t.teamId?.isNotEmpty == true
                      ? () => context.push('${AppRoutes.teams}/${t.teamId}')
                      : null,
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.socaGrey.withValues(alpha: 0.2),
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
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 68,
                        child: Text(
                          t.name ?? '',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: AppColors.socaBlack,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosSection(String title, List<AcademyPostModel> videos) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _sectionTitle(title),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: videos.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final v = videos[i];
                final imgUrl = _imageUrl(v.imageUrl ?? v.effectiveImageUrl);
                return Container(
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
                          errorWidget: (_, __, ___) => const Icon(
                              Icons.videocam,
                              color: AppColors.socaBlack),
                        )
                      else
                        const Icon(Icons.videocam, color: AppColors.socaBlack),
                      Container(color: Colors.black26),
                      const Center(
                        child: Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 36),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsSection(AcademyBioData bio) {
    final displayPosts = bio.postList.take(3).toList();
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _sectionTitle('Posts'),
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
                  child: const Text(
                    'View All',
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
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: displayPosts.length,
            itemBuilder: (_, i) {
              final post = displayPosts[i];
              final imgUrl = _imageUrl(post.imageUrl ?? post.effectiveImageUrl);
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
                        errorWidget: (_, __, ___) => const Icon(
                            Icons.image,
                            color: AppColors.socaBlack),
                      )
                    : const Icon(Icons.image, color: AppColors.socaBlack),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection(List<AcademyNewsModel> newsList) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('News'),
          const SizedBox(height: 8),
          ...newsList.map((n) => _buildNewsItem(n)),
        ],
      ),
    );
  }

  Widget _buildNewsItem(AcademyNewsModel news) {
    final imgUrl = _imageUrl(news.imageUrl);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imgUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(width: 60, height: 60, color: AppColors.socaGrey),
              ),
            ),
          if (imgUrl.isNotEmpty) const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news.title?.isNotEmpty == true)
                  Text(
                    news.title!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (news.description?.isNotEmpty == true)
                  Text(
                    news.description!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: AppColors.socaBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (news.newsDate?.isNotEmpty == true)
                  Text(
                    news.newsDate!,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrialSection(AcademyBioData bio) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Live Trial',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _handleTrialRegister(bio),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Register',
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
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: AppColors.socaBlack,
      ),
    );
  }
}
