import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../player_bio/data/models/player_post_model.dart';
import '../../player_bio/data/models/player_bio_model.dart';
import '../../player_bio/data/repositories/player_bio_repository.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Vertical list of a user's posts — mirrors Android MyGalleryNewFragment.
/// limit=10, paginates on scroll.
class MyPostsScreen extends ConsumerStatefulWidget {
  final String userId;
  final bool isOwnProfile;

  MyPostsScreen({
    super.key,
    required this.userId,
    this.isOwnProfile = false,
  });

  @override
  ConsumerState<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends ConsumerState<MyPostsScreen> {
  final _scrollController = ScrollController();
  final _repository = PlayerBioRepository();

  final _posts = <PlayerPostModel>[];
  bool _loading = false;
  bool _hasMore = true;
  int _start = 0;
  static const _limit = 10;

  bool get _isOwn =>
      widget.isOwnProfile || StorageService.userId == widget.userId;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 300 && !_loading && _hasMore) {
      _loadPosts();
    }
  }

  Future<void> _loadPosts({bool refresh = false}) async {
    if (_loading) return;
    if (refresh) {
      final _start = 0;
      final _hasMore = true;
      _posts.clear();
    }

    setState(() => _loading = true);

    try {
      final myId = StorageService.userId ?? '';
      final newPosts = await _repository.getUserPosts(
        userId: widget.userId,
        myId: myId,
        start: _start,
        limit: _limit,
      );

      if (mounted) {
        setState(() {
          _posts.addAll(newPosts);
          _start += newPosts.length;
          final _hasMore = newPosts.length == _limit;
          final _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerBio = ref.watch(playerBioProvider(widget.userId)).playerBio;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      floatingActionButton: _isOwn
          ? FloatingActionButton(
              backgroundColor: AppColors.socaBlack,
              onPressed: () => context.push(AppRoutes.createPost),
              child: Icon(Icons.add, color: AppColors.socaYellow),
            )
          : null,
      body: _buildBody(playerBio),
    );
  }

  Widget _buildBody(PlayerBioModel? playerBio) {
    if (_loading && _posts.isEmpty) {
      return AppLoader();
    }

    if (!_loading && _posts.isEmpty) {
      return Center(
        child: Text(
          'No posts found'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.socaGrey,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadPosts(refresh: true),
      color: AppColors.socaYellow,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: _posts.length + (_loading ? 1 : 0),
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return AppLoader();
          }
          return _PostCard(post: _posts[index], playerBio: playerBio);
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final PlayerPostModel post;
  final PlayerBioModel? playerBio;

  _PostCard({required this.post, this.playerBio});

  String? _mediaUrl() {
    if (post.sources?.isNotEmpty != true) return null;
    final source = post.sources!.first;
    final raw = source.imageUrl ?? source.thumbnail;
    if (raw == null || raw.isEmpty || raw.startsWith('file:///')) return null;
    return ApiConstants.getImageUrl(raw);
  }

  bool _isVideo() {
    if (post.sources?.isNotEmpty != true) return false;
    return post.sources!.first.videoUrl != null;
  }

  String _formatDate(int? addedOn) {
    if (addedOn == null) return '';
    final dt = DateTime.fromMillisecondsSinceEpoch(addedOn).toLocal();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dt.hour == 0 || dt.hour == 12 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '${months[dt.month - 1]} ${dt.day}, $hour:$minute$period';
  }

  @override
  Widget build(BuildContext context) {
    final mediaUrl = _mediaUrl();
    final isVideo = _isVideo();

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Avatar + Name + Role)
          if (playerBio != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          ApiConstants.getImageUrl(playerBio!.imageUrl ?? ''),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.socaGrey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${playerBio!.firstName ?? ''} ${playerBio!.lastName ?? ''}'
                              .trim(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        if ((playerBio!.playPosition ?? '').isNotEmpty)
                          Text(
                            '${playerBio!.playPosition} | ${playerBio!.playPositionType ?? ''}'
                                .trim(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: AppColors.socaBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Title / Top Text
          if (post.title?.isNotEmpty == true)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                post.title!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

          // Media
          if (mediaUrl != null)
            Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: mediaUrl,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 350,
                    color: AppColors.socaGrey.withValues(alpha: 0.15),
                    child: AppLoader(),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    height: 350,
                    color: AppColors.socaBlack,
                  ),
                ),

                // Double Tap to Cheer Text
                Text(
                  'Double Tap to Cheer'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                // Play Icon overlay
                if (isVideo)
                  Icon(
                    Icons.play_circle_outline,
                    size: 72,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),

                // Top right menu
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.more_vert,
                        color: AppColors.socaBlack, size: 20),
                  ),
                ),
              ],
            )
          else
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  color: AppColors.socaBlack,
                ),
                Text(
                  'Double Tap to Cheer'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                if (isVideo)
                  Icon(
                    Icons.play_circle_outline,
                    size: 72,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.more_vert,
                        color: AppColors.socaBlack, size: 20),
                  ),
                ),
              ],
            ),

          // Cheer Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.pan_tool_alt_outlined,
                    size: 20, color: AppColors.socaBlack),
                SizedBox(width: 8),
                Text(
                  '${post.likeCount ?? 0} cheer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

          // Share Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.ios_share, size: 20, color: AppColors.socaBlack),
                SizedBox(width: 8),
                Text(
                  'SHARE'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
