import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/player_social_models.dart';
import '../providers/player_bio_provider.dart';

class PlayerLikesScreen extends ConsumerStatefulWidget {
  const PlayerLikesScreen({super.key, required this.userId});

  final String userId;

  @override
  ConsumerState<PlayerLikesScreen> createState() => _PlayerLikesScreenState();
}

class _PlayerLikesScreenState extends ConsumerState<PlayerLikesScreen> {
  final _scroll = ScrollController();
  final _likes = <PlayerLikeModel>[];
  bool _loading = false;
  bool _hasMore = true;
  int _start = 0;
  static const _limit = 20;

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(() {
      if (!_scroll.hasClients || _loading || !_hasMore) return;
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 250) {
        _load();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load({bool refresh = false}) async {
    if (_loading) return;
    if (refresh) {
      _likes.clear();
      _start = 0;
      _hasMore = true;
    }
    setState(() => _loading = true);
    try {
      final next = await ref.read(playerBioRepositoryProvider).getLikes(
            userId: widget.userId,
            myUserId: StorageService.userId ?? '',
            start: _start,
            limit: _limit,
          );
      if (!mounted) return;
      setState(() {
        _likes.addAll(next);
        _start += next.length;
        _hasMore = next.length == _limit;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: _buildBody());
  }

  Widget _buildBody() {
    if (_loading && _likes.isEmpty) return const AppLoader();
    if (!_loading && _likes.isEmpty) {
      return Center(
        child: Text(
          'No likes yet'.tr,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _load(refresh: true),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _likes.length + (_loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _likes.length) return const AppLoader();
          return _LikeTile(like: _likes[index]);
        },
      ),
    );
  }
}

class _LikeTile extends StatelessWidget {
  const _LikeTile({required this.like});

  final PlayerLikeModel like;

  @override
  Widget build(BuildContext context) {
    final name = like.fullName;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => _openUser(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatar(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: ' ${_message().tr}'),
                      ],
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(spacing: 4, children: _roleLabels()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatar() {
    final url = ApiConstants.getImageUrl(like.imageUrl);
    return CircleAvatar(
      radius: 26,
      backgroundColor: AppColors.socaGrey,
      child: url.isEmpty
          ? const Icon(Icons.person, color: Colors.grey)
          : ClipOval(
              child: CachedNetworkImage(
                imageUrl: url,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.person, color: Colors.grey),
              ),
            ),
    );
  }

  List<Widget> _roleLabels() {
    final roles = <Widget>[];

    if (like.isPlayer) {
      roles.add(_roleIcon('assets/icons/ic_player_icon.png'));
    }

    if (like.isCoach) {
      roles.add(_roleIcon('assets/icons/ic_coach_icon.png'));
    }

    if (like.isAdmin) {
      roles.add(_roleIcon('assets/icons/ic_admin_icon.png'));
    }

    if (like.isFan) {
      roles.add(_roleIcon('assets/icons/ic_fan_icon.png'));
    }

    return roles;
  }

  Widget _roleIcon(String path) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Image.asset(
        path,
        width: 20,
        height: 20,
        fit: BoxFit.contain,
      ),
    );
  }

  String _message() {
    switch (like.likeType.toLowerCase()) {
      case 'image':
        return 'likes an image you shared';
      case 'video':
        return 'likes a video you shared';
      case 'profile':
      default:
        return 'likes your profile';
    }
  }

  void _openUser(BuildContext context) {
    if (like.isFan) return;
    if (like.isPlayer) {
      context.push(AppRoutes.playerBio.replaceFirst(':userId', like.userId));
      return;
    }
    context.push(
      AppRoutes.coachAdminBio.replaceFirst(':userId', like.userId),
    );
  }
}
