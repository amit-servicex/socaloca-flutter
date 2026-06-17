import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/features/social_feed/widgets/tag_chip_card.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/widgets/full_screen_post_show.dart';
import '../../player_bio/data/models/player_post_model.dart';
import '../../player_bio/data/models/player_bio_model.dart';
import '../../player_bio/data/repositories/player_bio_repository.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import 'package:socaloca/shared/widgets/app_snackbar.dart';

/// Vertical list of a user's posts — mirrors Android MyGalleryNewFragment.
/// limit=10, paginates on scroll.
class MyPostsScreen extends ConsumerStatefulWidget {
  final String userId;
  final bool isOwnProfile;

  const MyPostsScreen({
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playerBioProvider(widget.userId).notifier).load();
    });
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
      _posts.clear();
      _start = 0;
      _hasMore = true;
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
          _hasMore = newPosts.length == _limit;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _handlePostDeleted(String postId) {
    setState(() => _posts.removeWhere((p) => p.postId == postId));
  }

  Future<void> _handleEditRequested(PlayerPostModel post) async {
    await context.push(AppRoutes.createPost, extra: post);
    if (mounted) _loadPosts(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final bioState = ref.watch(playerBioProvider(widget.userId));
    final playerBio = bioState.playerBio;

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      floatingActionButton: _isOwn
          ? FloatingActionButton(
              backgroundColor: AppColors.socaBlack,
              onPressed: () => context.push(AppRoutes.createPost),
              child: const Icon(Icons.add, color: AppColors.socaYellow),
            )
          : null,
      body: _buildBody(playerBio, bioState),
    );
  }

  Widget _buildProfileHeader(
      PlayerBioModel playerBio, PlayerBioState bioState) {
    final name =
        '${playerBio.firstName ?? ''} ${playerBio.lastName ?? ''}'.trim();
    final imageUrl = ApiConstants.getImageUrl(playerBio.imageUrl ?? '');

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Profile avatar
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.socaGrey,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Name + follow button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!_isOwn) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => ref
                        .read(playerBioProvider(widget.userId).notifier)
                        .toggleFollow(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                        color: bioState.isFollowing
                            ? AppColors.socaYellow
                            : AppColors.socaBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        bioState.isFollowing ? 'FOLLOWING' : 'FOLLOW',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: bioState.isFollowing
                              ? AppColors.socaBlack
                              : Colors.white,
                        ),
                      ),
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

  Widget _buildBody(PlayerBioModel? playerBio, PlayerBioState bioState) {
    return Column(
      children: [
        // Profile header
        if (playerBio != null) _buildProfileHeader(playerBio, bioState),

        // Posts list
        Expanded(
          child: _loading && _posts.isEmpty
              ? const AppLoader()
              : !_loading && _posts.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.noPostsFound,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _loadPosts(refresh: true),
                      color: AppColors.socaYellow,
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: _posts.length + (_loading ? 1 : 0),
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          if (index == _posts.length) {
                            return const AppLoader();
                          }
                          return _PostCard(
                            post: _posts[index],
                            playerBio: playerBio,
                            isOwn: _isOwn,
                            onDeleted: () =>
                                _handlePostDeleted(_posts[index].postId ?? ''),
                            onEditRequested: () =>
                                _handleEditRequested(_posts[index]),
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }
}

class _PostCard extends StatefulWidget {
  final PlayerPostModel post;
  final PlayerBioModel? playerBio;
  final bool isOwn;
  final VoidCallback onDeleted;
  final VoidCallback onEditRequested;

  const _PostCard({
    required this.post,
    required this.isOwn,
    required this.onDeleted,
    required this.onEditRequested,
    this.playerBio,
  });

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  String? _mediaUrl() {
    if (widget.post.sources?.isNotEmpty != true) return null;
    final source = widget.post.sources!.first;
    final raw = source.imageUrl ?? source.thumbnail;
    if (raw == null || raw.isEmpty || raw.startsWith('file:///')) return null;
    return ApiConstants.getImageUrl(raw);
  }

  bool _isVideo() {
    if (widget.post.sources?.isNotEmpty != true) return false;
    return widget.post.sources!.first.videoUrl != null;
  }

  String? _videoUrl() {
    if (widget.post.sources?.isNotEmpty != true) return null;
    final source = widget.post.sources!.first;
    final raw = source.videoUrl;
    if (raw == null || raw.isEmpty) return null;
    return raw.startsWith('http') ? raw : ApiConstants.getImageUrl(raw);
  }

  String? _thumbnailUrl() {
    if (widget.post.sources?.isNotEmpty != true) return null;
    final raw = widget.post.sources!.first.thumbnail;
    if (raw == null || raw.isEmpty) return null;
    return raw.startsWith('http') ? raw : ApiConstants.getImageUrl(raw);
  }

  void _openFullScreen(BuildContext context) {
    final videoUrl = _videoUrl();
    if (videoUrl != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => FullScreenVideoScreen(
          videoUrl: videoUrl,
          thumbnail: _thumbnailUrl(),
        ),
      ));
    } else {
      final url = _mediaUrl();
      if (url == null) return;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => FullScreenImageScreen(imageUrl: url),
      ));
    }
  }

  // ── Options bottom sheet ────────────────────────────────────────────────────

  void _showPostOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit option
              ListTile(
                leading: const Icon(Icons.edit_outlined,
                    color: AppColors.socaBlack, size: 22),
                title: Text(
                  AppStrings.editPost,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: AppColors.socaBlack,
                  ),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  widget.onEditRequested();
                },
              ),
              const Divider(
                  height: 1, thickness: 0.5, color: Color(0xFFE0E0E0)),
              // Delete option
              ListTile(
                leading: const Icon(Icons.delete_outline,
                    color: Colors.red, size: 22),
                title: Text(
                  AppStrings.deletePost,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _showDeleteConfirm();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ── Delete confirmation ─────────────────────────────────────────────────────

  void _showDeleteConfirm() {
    bool isDeleting = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            Future<void> handleDelete() async {
              setSheetState(() => isDeleting = true);
              try {
                final userId = StorageService.userId ?? '';
                await ApiClient.instance.post(
                  ApiConstants.deletePost,
                  body: {
                    'userId': userId,
                    'postId': widget.post.postId ?? '',
                  },
                );
                if (ctx.mounted) Navigator.of(ctx).pop();
                if (mounted) {
                  AppSnackBar.showSuccess(context, AppStrings.postDeleted);
                  widget.onDeleted();
                }
              } catch (_) {
                setSheetState(() => isDeleting = false);
                if (mounted) {
                  AppSnackBar.showError(context, AppStrings.couldNotDeletePost);
                }
              }
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.deletePostConfirm,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.socaBlack,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isDeleting
                                ? null
                                : () => Navigator.of(ctx).pop(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.socaBlack, width: 1.5),
                              foregroundColor: AppColors.socaBlack,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            child: Text(
                              AppStrings.cancel.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isDeleting ? null : handleDelete,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            child: isDeleting
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    AppStrings.delete.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaUrl = _mediaUrl();
    final isVideo = _isVideo();

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Avatar + Name + Role)
          if (widget.playerBio != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: ApiConstants.getImageUrl(
                          widget.playerBio!.imageUrl ?? ''),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.socaGrey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.playerBio!.firstName ?? ''} ${widget.playerBio!.lastName ?? ''}'
                              .trim(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        if ((widget.playerBio!.playPosition ?? '').isNotEmpty)
                          Text(
                            '${widget.playerBio!.playPosition} | ${widget.playerBio!.playPositionType ?? ''}'
                                .trim(),
                            style: const TextStyle(
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
          if (widget.post.tagged != null && widget.post.tagged!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: widget.post.tagged!.map((tag) {
                  final t = tag as Map<String, dynamic>;
                  final tagType = t['tagType'] as String? ?? 'user';
                  final tagId = t['tagId'] as String? ?? '';
                  final imageUrl =
                      ApiConstants.getImageUrl(t['imageUrl'] as String?);

                  // Academy tags use 'name'; user tags use 'firstName'+'lastName'
                  final String name;
                  if (tagType == 'academy') {
                    name = t['name'] as String? ?? '';
                  } else {
                    final first = t['firstName'] as String? ?? '';
                    final last = t['lastName'] as String? ?? '';
                    name = '$first $last'.trim();
                  }

                  return TagChip(
                    name: name,
                    imageUrl: imageUrl,
                    id: tagId,
                    tagType: tagType,
                    isPlayer: t['isPlayer'] as bool? ?? false,
                    isCoach: t['isCoach'] as bool? ?? false,
                    isAdmin: t['isAdmin'] as bool? ?? false,
                  );
                }).toList(),
              ),
            ),
          // Title / Top Text
          if (widget.post.title?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                widget.post.title!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.socaBlack,
                ),
              ),
            ),

          // Media
          if (mediaUrl != null)
            GestureDetector(
              onTap: () => _openFullScreen(context),
              child: Stack(
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
                      child: const AppLoader(),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      height: 350,
                      color: AppColors.socaBlack,
                    ),
                  ),

                  // Double Tap to Cheer Text
                  Text(
                    AppStrings.doubleTapToCheer,
                    style: const TextStyle(
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

                  // Top right menu — only visible for own posts
                  if (widget.isOwn)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: _showPostOptions,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.more_vert,
                              color: AppColors.socaBlack, size: 20),
                        ),
                      ),
                    ),
                ],
              ), // Stack
            ) // GestureDetector (mediaUrl != null)
          else
            GestureDetector(
              onTap: () => _openFullScreen(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    color: AppColors.socaBlack,
                  ),
                  Text(
                    AppStrings.doubleTapToCheer,
                    style: const TextStyle(
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
                  if (widget.isOwn)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: _showPostOptions,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.more_vert,
                              color: AppColors.socaBlack, size: 20),
                        ),
                      ),
                    ),
                ],
              ), // Stack
            ), // GestureDetector (mediaUrl == null)

          // Cheer Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.pan_tool_alt_outlined,
                    size: 20, color: AppColors.socaBlack),
                const SizedBox(width: 8),
                Text(
                  AppStrings.cheerCount(widget.post.likeCount ?? 0),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

          // Share Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.ios_share,
                    size: 20, color: AppColors.socaBlack),
                const SizedBox(width: 8),
                Text(
                  AppStrings.shareUpper,
                  style: const TextStyle(
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
