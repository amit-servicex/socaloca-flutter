import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_post_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Club Gallery / Posts — Screen 4 of the Club shell.
class ClubGalleryScreen extends ConsumerStatefulWidget {
  ClubGalleryScreen({super.key});
  @override
  ConsumerState<ClubGalleryScreen> createState() => _ClubGalleryScreenState();
}

class _ClubGalleryScreenState extends ConsumerState<ClubGalleryScreen> {
  final _scroll = ScrollController();
  final _posts = <ClubPostModel>[];
  bool _loading = false;
  bool _hasMore = true;
  int _start = 0;
  static const _limit = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clubAppBarTitleProvider.notifier).state = 'Gallery';
    });
    _load();
    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent * 0.8 &&
          !_loading &&
          _hasMore) {
        _start += _limit;
        _load();
      }
    });
  }

  Future<void> _load() async {
    if (_loading) return;
    setState(() => _loading = true);
    final clubId = StorageService.clubId ?? '';
    final raw = await ref
        .read(clubRepositoryProvider)
        .getClubPostList(clubId: clubId, start: _start, limit: _limit);
    final parsed = raw.map((e) => ClubPostModel.fromJson(e)).toList();
    setState(() {
      _posts.addAll(parsed);
      final _hasMore = parsed.length >= _limit;
      final _loading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _posts.clear();
      final _start = 0;
      final _hasMore = true;
    });
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_posts.isEmpty && _loading) {
      return AppLoader();
    }
    if (_posts.isEmpty) {
      return Center(
          child: Text('No Posts'.tr, style: TextStyle(fontFamily: 'Poppins')));
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scroll,
        itemCount: _posts.length + (_loading ? 1 : 0),
        itemBuilder: (_, i) {
          if (i >= _posts.length) {
            return AppLoader();
          }
          return _PostCard(post: _posts[i]);
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  _PostCard({required this.post});
  final ClubPostModel post;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(post.imageUrl);
    final ts = post.timestamp != null
        ? DateFormat('MMM d, yyyy · HH:mm')
            .format(DateTime.fromMillisecondsSinceEpoch(post.timestamp!))
        : '';

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image / video thumbnail
          if (imageUrl.isNotEmpty)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.socaGrey),
              ),
            )
          else
            Container(
              height: 200,
              color: AppColors.socaGrey,
              child: Center(child: Icon(Icons.image_not_supported, size: 48)),
            ),

          Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.postCaption != null && post.postCaption!.isNotEmpty)
                  Text(post.postCaption!,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 15, color: Colors.grey),
                    SizedBox(width: 4),
                    Text('${post.likeCount ?? 0}',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
                    Spacer(),
                    Text(ts,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.socaBlack.withOpacity(0.5))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
