import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_player_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Club Players List — Screen 2 of the Club shell.
class ClubPlayersScreen extends ConsumerStatefulWidget {
  const ClubPlayersScreen({super.key});
  @override
  ConsumerState<ClubPlayersScreen> createState() => _ClubPlayersScreenState();
}

class _ClubPlayersScreenState extends ConsumerState<ClubPlayersScreen> {
  final _scroll = ScrollController();
  final _players = <ClubPlayerModel>[];
  bool _loading = false;
  final bool _hasMore = true;
  int _start = 0;
  static const _limit = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clubAppBarTitleProvider.notifier).state =
          AppStrings.playersTitle;
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
    final result = await ref
        .read(clubRepositoryProvider)
        .getClubPlayerList(clubId: clubId, start: _start, limit: _limit);
    setState(() {
      _players.addAll(result);
      final hasMore = result.length >= _limit;
      const loading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _players.clear();
      const start = 0;
      const hasMore = true;
    });
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_players.isEmpty && _loading) {
      return const AppLoader();
    }
    if (_players.isEmpty) {
      return Center(
          child: Text(AppStrings.noPlayers,
              style: const TextStyle(fontFamily: 'Poppins')));
    }
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scroll,
        padding: const EdgeInsets.all(12),
        itemCount: _players.length + (_loading ? 1 : 0),
        itemBuilder: (_, i) {
          if (i >= _players.length) {
            return const AppLoader();
          }
          final p = _players[i];
          return _PlayerRow(
            player: p,
            onTap: () => context.push('/club/players/${p.userId}'),
          );
        },
      ),
    );
  }
}

class _PlayerRow extends StatelessWidget {
  const _PlayerRow({required this.player, required this.onTap});
  final ClubPlayerModel player;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final url = ApiConstants.getImageUrl(player.imageUrl);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.socaGrey,
              child: url.isNotEmpty
                  ? ClipOval(
                      child: CachedNetworkImage(
                          imageUrl: url,
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover))
                  : const Icon(Icons.person,
                      color: AppColors.socaBlack, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${player.firstName ?? ''} ${player.lastName ?? ''}'.trim(),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  Text(
                    '${player.position ?? '—'} • #${player.jersey}',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
