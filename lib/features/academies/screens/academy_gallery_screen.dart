import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/academy_bio_models.dart';
import '../providers/academies_provider.dart';

class AcademyGalleryScreen extends ConsumerStatefulWidget {
  final String academyId;
  final String academyName;

  const AcademyGalleryScreen({
    super.key,
    required this.academyId,
    required this.academyName,
  });

  @override
  ConsumerState<AcademyGalleryScreen> createState() =>
      _AcademyGalleryScreenState();
}

class _AcademyGalleryScreenState extends ConsumerState<AcademyGalleryScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<AcademyPostModel> _posts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _start = 0;
  static const int _limit = 10;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _load() async {
    final userId = StorageService.userId ?? '';
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final posts = await ref.read(academiesRepositoryProvider).getAcademyPostList(
            userId: userId,
            academyId: widget.academyId,
            start: 0,
            limit: _limit,
          );
      if (mounted) {
        setState(() {
          _posts
            ..clear()
            ..addAll(posts);
          _start = _limit;
          _hasMore = posts.length == _limit;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (!_hasMore || _isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    final userId = StorageService.userId ?? '';
    try {
      final posts = await ref.read(academiesRepositoryProvider).getAcademyPostList(
            userId: userId,
            academyId: widget.academyId,
            start: _start,
            limit: _limit,
          );
      if (mounted) {
        setState(() {
          _posts.addAll(posts);
          _start += _limit;
          _hasMore = posts.length == _limit;
          _isLoadingMore = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        title: Text(
          widget.academyName.isNotEmpty ? widget.academyName : 'Gallery',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.socaBlack,
        foregroundColor: AppColors.socaYellow,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.socaYellow))
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!,
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 14)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _load,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _posts.isEmpty
                  ? const Center(
                      child: Text('No posts yet.',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: AppColors.socaBlack)))
                  : GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: _posts.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (_, i) {
                        if (i == _posts.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(
                                  color: AppColors.socaYellow),
                            ),
                          );
                        }
                        final post = _posts[i];
                        final imgUrl = ApiConstants.getImageUrl(
                            post.imageUrl ?? post.effectiveImageUrl);
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.socaGrey.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
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
                              : const Icon(Icons.image,
                                  color: AppColors.socaBlack),
                        );
                      },
                    ),
    );
  }
}
