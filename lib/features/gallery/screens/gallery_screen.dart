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
import '../../player_bio/data/repositories/player_bio_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// 3-column photo/video grid — mirrors Android HomeFeedGalleryFragment.
/// limit=30, paginates on scroll.
class GalleryScreen extends ConsumerStatefulWidget {
  final String userId;
  final bool isOwnProfile;

  const GalleryScreen({
    super.key,
    required this.userId,
    this.isOwnProfile = false,
  });

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  final _scrollController = ScrollController();
  final _repository = PlayerBioRepository();

  final _posts = <PlayerPostModel>[];
  bool _loading = false;
  final bool _hasMore = true;
  int _start = 0;
  static const _limit = 30;

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
      const start = 0;
      const hasMore = true;
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
          final hasMore = newPosts.length == _limit;
          const loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      floatingActionButton: _isOwn
          ? FloatingActionButton(
              backgroundColor: AppColors.socaBlack,
              onPressed: () => context.push(AppRoutes.createPost),
              child: const Icon(Icons.add, color: AppColors.socaYellow),
            )
          : null,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading && _posts.isEmpty) {
      return const AppLoader();
    }

    if (!_loading && _posts.isEmpty) {
      return Center(
        child: Text(
          'No posts found'.tr,
          style: const TextStyle(
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
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: _posts.length + (_loading ? 3 : 0),
        itemBuilder: (context, index) {
          if (index >= _posts.length) {
            return Container(color: AppColors.socaGrey.withValues(alpha: 0.1));
          }
          return _GalleryCell(post: _posts[index]);
        },
      ),
    );
  }
}

class _GalleryCell extends StatelessWidget {
  final PlayerPostModel post;

  const _GalleryCell({required this.post});

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
    return '${months[dt.month - 1]} ${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    final mediaUrl = _mediaUrl();
    final isVideo = _isVideo();

    return GestureDetector(
      onTap: () {
        // TODO: open post detail
      },
      child: Container(
        color: AppColors.socaGrey.withValues(alpha: 0.15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (mediaUrl != null)
              CachedNetworkImage(
                imageUrl: mediaUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(color: AppColors.socaGrey.withValues(alpha: 0.1)),
                errorWidget: (_, __, ___) => const Icon(
                  Icons.image,
                  color: AppColors.socaGrey,
                  size: 32,
                ),
              )
            else
              const Center(
                child: Icon(Icons.article_outlined,
                    color: AppColors.socaGrey, size: 32),
              ),

            if (isVideo)
              const Center(
                child: Icon(Icons.play_circle_outline,
                    color: Colors.white, size: 28),
              ),

            // Date overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.55),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  _formatDate(post.addedOn),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
