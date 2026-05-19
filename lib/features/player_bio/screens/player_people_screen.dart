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

class PlayerPeopleScreen extends StatelessWidget {
  const PlayerPeopleScreen({
    super.key,
    required this.userId,
    this.initialTab = 0,
  });

  final String userId;
  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialTab.clamp(0, 1),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.socaBlack,
              labelColor: AppColors.socaBlack,
              unselectedLabelColor: AppColors.socaBlack,
              tabs: [
                Tab(text: 'Followers'.tr),
                Tab(text: 'Following'.tr),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _PeopleList(userId: userId, type: _PeopleListType.followers),
                  _PeopleList(userId: userId, type: _PeopleListType.following),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PeopleListType { followers, following }

class _PeopleList extends ConsumerStatefulWidget {
  const _PeopleList({required this.userId, required this.type});

  final String userId;
  final _PeopleListType type;

  @override
  ConsumerState<_PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends ConsumerState<_PeopleList> {
  final _scroll = ScrollController();
  final _items = <PlayerSocialUserModel>[];
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
      _items.clear();
      _start = 0;
      _hasMore = true;
    }
    setState(() => _loading = true);
    try {
      final myUserId = StorageService.userId ?? '';
      final repo = ref.read(playerBioRepositoryProvider);
      final next = widget.type == _PeopleListType.followers
          ? await repo.getFollowers(
              userId: widget.userId,
              myUserId: myUserId,
              start: _start,
              limit: _limit,
            )
          : await repo.getFollowings(
              userId: widget.userId,
              myUserId: myUserId,
              start: _start,
              limit: _limit,
            );
      if (!mounted) return;
      setState(() {
        _items.addAll(next);
        _start += next.length;
        _hasMore = next.length == _limit;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleFollow(int index) async {
    final item = _items[index];
    final current = StorageService.currentUser ?? {};
    final myUserId = StorageService.userId ?? '';
    if (myUserId.isEmpty || item.userId == myUserId || item.isFan) return;
    final response = await ref.read(playerBioRepositoryProvider).followUser(
          userId: myUserId,
          toUserId: item.userId,
          myName: '${current['firstName'] ?? ''} ${current['lastName'] ?? ''}'
              .trim(),
          myImageUrl: current['imageUrl']?.toString() ?? '',
          isPlayer: current['isPlayer'] == true,
          isCoach: current['isCoach'] == true,
          isAdmin: current['isAdmin'] == true,
          isFan: current['isFan'] == true,
        );
    final data = response['response'] as Map<String, dynamic>? ?? response;
    if (!mounted || data['status'] != 1 || data['isFollow'] == null) return;
    setState(() {
      _items[index] = item.copyWith(followedByMe: data['isFollow'] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading && _items.isEmpty) return const AppLoader();
    if (!_loading && _items.isEmpty) {
      final isOwn = StorageService.userId == widget.userId;
      final text = widget.type == _PeopleListType.followers
          ? 'No followers yet'.tr
          : isOwn
              ? "You don't follow anyone".tr
              : 'No following yet'.tr;
      return Center(child: Text(text, style: _emptyStyle));
    }
    return RefreshIndicator(
      onRefresh: () => _load(refresh: true),
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _items.length + (_loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _items.length) return const AppLoader();
          return _SocialUserTile(
            user: _items[index],
            showFollowButton: widget.type == _PeopleListType.followers,
            onFollowTap: () => _toggleFollow(index),
          );
        },
      ),
    );
  }

  TextStyle get _emptyStyle => const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 12,
        color: AppColors.socaBlack,
      );
}

class _SocialUserTile extends StatelessWidget {
  const _SocialUserTile({
    required this.user,
    required this.showFollowButton,
    required this.onFollowTap,
  });

  final PlayerSocialUserModel user;
  final bool showFollowButton;
  final VoidCallback onFollowTap;

  @override
  Widget build(BuildContext context) {
    final currentUserId = StorageService.userId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => _openUser(context),
        child: Row(
          children: [
            _avatar(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(spacing: 4, children: _roleLabels()),
                ],
              ),
            ),
            if (showFollowButton && currentUserId != user.userId && !user.isFan)
              GestureDetector(
                onTap: user.followedByMe ? null : onFollowTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: user.followedByMe
                        ? AppColors.socaYellow
                        : AppColors.socaBlack,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    user.followedByMe ? 'FOLLOWING'.tr : 'FOLLOW'.tr,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: user.followedByMe
                          ? AppColors.socaBlack
                          : AppColors.socaYellow,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _avatar() {
    final url = ApiConstants.getImageUrl(user.imageUrl);
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

    if (user.isPlayer) {
      roles.add(_roleIcon("assets/icons/ic_player_icon.png"));
    }

    if (user.isCoach) {
      roles.add(_roleIcon("assets/icons/ic_coach_icon.png"));
    }

    if (user.isAdmin) {
      roles.add(_roleIcon("assets/icons/ic_admin_icon.png"));
    }

    if (user.isFan) {
      roles.add(_roleIcon("assets/icons/ic_fan_icon.png"));
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

  void _openUser(BuildContext context) {
    if (user.isFan) return;
    if (user.isPlayer) {
      context.push(AppRoutes.playerBio.replaceFirst(':userId', user.userId));
      return;
    }
    context.push(
      AppRoutes.coachAdminBio.replaceFirst(':userId', user.userId),
    );
  }
}
