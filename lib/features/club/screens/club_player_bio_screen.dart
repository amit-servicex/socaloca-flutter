import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/club_player_model.dart';
import '../data/models/club_player_stats_model.dart';
import '../data/repositories/club_repository.dart';
import '../../player_bio/data/models/player_post_model.dart';
import '../../player_bio/providers/player_bio_provider.dart';
import '../../player_bio/widgets/player_posts_section.dart';
import 'club_home_screen.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

class _BioState {
  final ClubPlayerModel? player;
  final ClubPlayerStatsModel? football;
  final ClubPlayerStatsModel? futsal;
  final List<PlayerPostModel> posts;
  _BioState({this.player, this.football, this.futsal, this.posts = const []});
}

/// Club Player Bio Screen — Screen 3 of the Club shell.
class ClubPlayerBioScreen extends ConsumerStatefulWidget {
  ClubPlayerBioScreen({super.key, required this.playerId});
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
    final myId = StorageService.userId ?? '';
    final year = DateTime.now().year;

    // Parallel API calls
    final results = await Future.wait<dynamic>([
      ref
          .read(clubRepositoryProvider)
          .getClubPlayerDetails(playerId: widget.playerId, clubId: clubId),
      ref
          .read(clubRepositoryProvider)
          .getPlayerStats(playerId: widget.playerId, year: year),
      ref
          .read(playerBioRepositoryProvider)
          .getUserPosts(userId: widget.playerId, myId: myId),
    ]);

    final player = results[0] as ClubPlayerModel?;
    final statsMap = results[1] as Map<String, dynamic>;
    final posts = (results[2] as List).cast<PlayerPostModel>();

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

    final name = '${player?.firstName ?? ''} ${player?.lastName ?? ''}'.trim();
    ref.read(clubAppBarTitleProvider.notifier).state =
        name.isNotEmpty ? name : AppStrings.player;

    setState(() {
      _data = _BioState(
          player: player, football: football, futsal: futsal, posts: posts);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return AppLoader();
    }
    final d = _data;
    if (d == null || d.player == null) {
      return Center(child: Text(AppStrings.playerNotFound));
    }
    final p = d.player!;
    final url = ApiConstants.getImageUrl(p.imageUrl);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
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
                      : Icon(Icons.person, size: 56),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Basic info section
          _SectionHeader(AppStrings.basicInfo),
          _InfoRow(AppStrings.position, p.position ?? '—'),
          _InfoRow(AppStrings.jersey, '#${p.jersey}'),

          SizedBox(height: 16),

          // Football stats
          if (d.football != null && d.football!.matchCount > 0) ...[
            _SectionHeader(AppStrings.footballStatsYear(DateTime.now().year)),
            _StatsGrid(stats: d.football!),
            SizedBox(height: 16),
          ],

          // Futsal stats
          if (d.futsal != null && d.futsal!.matchCount > 0) ...[
            _SectionHeader(AppStrings.futsalStatsYear(DateTime.now().year)),
            _StatsGrid(stats: d.futsal!),
          ],

          // Posts
          PlayerPostsSection(
            posts: d.posts,
            isLoadingPosts: false,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(title,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaBlack)),
      );
}

class _InfoRow extends StatelessWidget {
  _InfoRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 6),
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
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 13)),
            ),
          ],
        ),
      );
}

class _StatsGrid extends StatelessWidget {
  _StatsGrid({required this.stats});
  final ClubPlayerStatsModel stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: Offset(0, 2))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              _StatCell(AppStrings.matchCountLabel, '${stats.matchCount}'),
              _StatCell(AppStrings.goals, '${stats.goalCount}'),
              _StatCell(AppStrings.assists, '${stats.assistCount}'),
              _StatCell(AppStrings.mvp, '${stats.mvpCount}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.square, color: Colors.yellow, size: 16),
              SizedBox(width: 4),
              Text('${stats.yellowCardCount}',
                  style: TextStyle(fontFamily: 'Poppins')),
              SizedBox(width: 16),
              Icon(Icons.square, color: Colors.red, size: 16),
              SizedBox(width: 4),
              Text('${stats.redCardCount}',
                  style: TextStyle(fontFamily: 'Poppins')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  _StatCell(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
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
