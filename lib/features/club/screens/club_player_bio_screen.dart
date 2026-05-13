import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_player_model.dart';
import '../data/models/club_player_stats_model.dart';
import '../data/repositories/club_repository.dart';
import 'club_home_screen.dart';

class _BioState {
  final ClubPlayerModel? player;
  final ClubPlayerStatsModel? football;
  final ClubPlayerStatsModel? futsal;
  const _BioState({this.player, this.football, this.futsal});
}

/// Club Player Bio Screen — Screen 3 of the Club shell.
class ClubPlayerBioScreen extends ConsumerStatefulWidget {
  const ClubPlayerBioScreen({super.key, required this.playerId});
  final String playerId;
  @override
  ConsumerState<ClubPlayerBioScreen> createState() =>
      _ClubPlayerBioScreenState();
}

class _ClubPlayerBioScreenState extends ConsumerState<ClubPlayerBioScreen> {
  _BioState? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final clubId = StorageService.clubId ?? '';
    final year = DateTime.now().year;

    // Parallel API calls
    final results = await Future.wait([
      ref.read(clubRepositoryProvider).getClubPlayerDetails(
          playerId: widget.playerId, clubId: clubId),
      ref.read(clubRepositoryProvider).getPlayerStats(
          playerId: widget.playerId, year: year),
    ]);

    final player = results[0] as ClubPlayerModel?;
    final statsMap = results[1] as Map<String, dynamic>;

    ClubPlayerStatsModel? football;
    ClubPlayerStatsModel? futsal;

    if (statsMap['stats'] != null) {
      football = ClubPlayerStatsModel.fromJson(
          statsMap['stats'] as Map<String, dynamic>);
    }
    if (statsMap['statsFutsal'] != null) {
      futsal = ClubPlayerStatsModel.fromJson(
          statsMap['statsFutsal'] as Map<String, dynamic>);
    }

    if (!mounted) return;

    final name =
        '${player?.firstName ?? ''} ${player?.lastName ?? ''}'.trim();
    ref.read(clubAppBarTitleProvider.notifier).state =
        name.isNotEmpty ? name : 'Player';

    setState(() {
      _data = _BioState(player: player, football: football, futsal: futsal);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.socaYellow));
    }
    final d = _data;
    if (d == null || d.player == null) {
      return const Center(child: Text('Player not found'));
    }
    final p = d.player!;
    final url = ApiConstants.getImageUrl(p.imageUrl);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile image + badges
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundColor: AppColors.socaGrey,
                  child: url.isNotEmpty
                      ? ClipOval(
                          child: CachedNetworkImage(
                              imageUrl: url,
                              width: 112,
                              height: 112,
                              fit: BoxFit.cover))
                      : const Icon(Icons.person, size: 56),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Basic info section
          _SectionHeader('Basic Info'),
          _InfoRow('Position', p.position ?? '—'),
          _InfoRow('Jersey', '#${p.jersey}'),

          const SizedBox(height: 16),

          // Football stats
          if (d.football != null && d.football!.matchCount > 0) ...[
            _SectionHeader('Football Stats (${DateTime.now().year})'),
            _StatsGrid(stats: d.football!),
            const SizedBox(height: 16),
          ],

          // Futsal stats
          if (d.futsal != null && d.futsal!.matchCount > 0) ...[
            _SectionHeader('Futsal Stats (${DateTime.now().year})'),
            _StatsGrid(stats: d.futsal!),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaBlack)),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: Text('$label:',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: AppColors.socaBlack.withOpacity(0.6))),
            ),
            Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 13)),
            ),
          ],
        ),
      );
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});
  final ClubPlayerStatsModel stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              _StatCell('Matches', '${stats.matchCount}'),
              _StatCell('Goals', '${stats.goalCount}'),
              _StatCell('Assists', '${stats.assistCount}'),
              _StatCell('MVP', '${stats.mvpCount}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.square, color: Colors.yellow, size: 16),
              const SizedBox(width: 4),
              Text('${stats.yellowCardCount}',
                  style: const TextStyle(fontFamily: 'Poppins')),
              const SizedBox(width: 16),
              const Icon(Icons.square, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Text('${stats.redCardCount}',
                  style: const TextStyle(fontFamily: 'Poppins')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                    fontSize: 18)),
            Text(label,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: AppColors.socaBlack.withOpacity(0.6))),
          ],
        ),
      );
}
