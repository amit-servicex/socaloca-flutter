import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../providers/cup_providers.dart';

/// Bottom sheet showing Goals / Assists / Cards / POM stats for a cup tournament.
/// Detects the round mode from cup.roundsList and calls the right provider.
class CupStatsBottomSheet extends ConsumerStatefulWidget {
  final String tournamentId;
  final TournamentCupModel cup;

  const CupStatsBottomSheet({
    super.key,
    required this.tournamentId,
    required this.cup,
  });

  @override
  ConsumerState<CupStatsBottomSheet> createState() =>
      _CupStatsBottomSheetState();
}

class _CupStatsBottomSheetState extends ConsumerState<CupStatsBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['GOALS', 'ASSISTS', 'CARDS', 'POM'];
  static const _statTypes = ['goals', 'assists', 'cards', 'mom'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Returns the first available roundId, preferring the group round if exists.
  String? get _roundId {
    final rounds = widget.cup.roundsList ?? [];
    if (rounds.isEmpty) return null;
    for (final r in rounds) {
      if (r.roundId?.isNotEmpty == true) return r.roundId;
    }
    return null;
  }

  /// True when the first available round is a group-stage round.
  bool get _isGroupMode {
    final rounds = widget.cup.roundsList ?? [];
    if (rounds.isEmpty) return false;
    return (rounds.first.mode ?? '').toLowerCase() == 'group';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 4),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.bar_chart,
                      color: AppColors.socaBlack, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Tournament Stats'.tr,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.socaBlack),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Stat type tabs
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.socaBlack,
                unselectedLabelColor:
                    AppColors.socaBlack.withValues(alpha: 0.45),
                indicatorColor: AppColors.socaYellow,
                indicatorWeight: 3,
                isScrollable: false,
                labelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                tabs: _tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),

            // Stats content
            Expanded(
              child: _roundId == null
                  ? Center(
                      child: Text(
                        'No rounds available'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: _statTypes
                          .map((type) => _StatsPage(
                                tournamentId: widget.tournamentId,
                                roundId: _roundId!,
                                statType: type,
                                isGroupMode: _isGroupMode,
                              ))
                          .toList(),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _StatsPage extends ConsumerWidget {
  final String tournamentId;
  final String roundId;
  final String statType;
  final bool isGroupMode;

  const _StatsPage({
    required this.tournamentId,
    required this.roundId,
    required this.statType,
    required this.isGroupMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = isGroupMode
        ? ref.watch(cupGroupStatsProvider(CupGroupStatsParams(
            tournamentId: tournamentId,
            roundId: roundId,
            statType: statType,
            start: 0,
            limit: 20,
          )))
        : ref.watch(cupMatchStatsProvider(CupMatchStatsParams(
            tournamentId: tournamentId,
            roundId: roundId,
            statType: statType,
            start: 0,
            limit: 20,
          )));

    return statsAsync.when(
      data: (stats) {
        if (stats.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_iconFor(statType), size: 56, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  'No ${_labelFor(statType)} recorded yet'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: stats.length,
          itemBuilder: (_, i) => _StatRow(
            stat: stats[i],
            position: i + 1,
            statType: statType,
          ),
        );
      },
      loading: () => const AppLoader(),
      error: (e, _) => Center(
        child: Text(
          'Error: $e',
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.red),
        ),
      ),
    );
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'goals':
        return Icons.sports_soccer;
      case 'assists':
        return Icons.sports_handball;
      case 'cards':
        return Icons.style;
      default:
        return Icons.emoji_events;
    }
  }

  String _labelFor(String type) {
    switch (type) {
      case 'goals':
        return 'goals';
      case 'assists':
        return 'assists';
      case 'cards':
        return 'cards';
      default:
        return 'POM awards';
    }
  }
}

class _StatRow extends StatelessWidget {
  final CupPlayerStatEntry stat;
  final int position;
  final String statType;

  const _StatRow({
    required this.stat,
    required this.position,
    required this.statType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Rank badge
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: position <= 3
                    ? AppColors.socaYellow
                    : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$position',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: position <= 3
                        ? AppColors.socaBlack
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Avatar
            ClipOval(child: _avatar(stat.playerImage, 40)),
          ],
        ),
        title: Text(
          stat.playerName ?? 'Unknown',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
        subtitle: Text(
          stat.teamName ?? '',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: _trailingValue(),
      ),
    );
  }

  Widget _trailingValue() {
    if (statType == 'cards') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (stat.yellowCards > 0) ...[
            Container(
              width: 14,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${stat.yellowCards}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (stat.redCards > 0) ...[
            Container(
              width: 14,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${stat.redCards}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.socaYellow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        '${stat.count}',
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  Widget _avatar(String? url, double size) {
    final full = ApiConstants.getImageUrl(url);
    if (full.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Colors.grey[200], shape: BoxShape.circle),
        child: Icon(Icons.person, size: size * 0.5, color: Colors.grey[400]),
      );
    }
    return CachedNetworkImage(
      imageUrl: full,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (_, __) => Container(
          width: size, height: size, color: Colors.grey[200]),
      errorWidget: (_, __, ___) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Colors.grey[200], shape: BoxShape.circle),
        child: Icon(Icons.person, size: size * 0.5, color: Colors.grey[400]),
      ),
    );
  }
}
