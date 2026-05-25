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
                  // here need to update the design
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

        final showGoalsHeader = statType == 'goals';
        final showCardsHeader = statType == 'cards';
        final hasHeader = showGoalsHeader || showCardsHeader;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: stats.length + (hasHeader ? 1 : 0),
          itemBuilder: (_, index) {
            if (showGoalsHeader && index == 0) return const _CupGoalsTableHeader();
            if (showCardsHeader && index == 0) return const _CupCardsTableHeader();

            final i = hasHeader ? index - 1 : index;
            if (showGoalsHeader) return _CupGoalStatRow(stat: stats[i]);
            if (showCardsHeader) return _CupCardStatRow(stat: stats[i]);
            return _CupStatCard(stat: stats[i], position: i + 1);
          },
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

// ── Shared avatar helper ──────────────────────────────────────────────────────

Widget _buildAvatar(String? url, double size) {
  final full = ApiConstants.getImageUrl(url);
  if (full.isEmpty) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: Icon(Icons.person, size: size * 0.5, color: Colors.grey[400]),
    );
  }
  return CachedNetworkImage(
    imageUrl: full,
    width: size,
    height: size,
    fit: BoxFit.cover,
    placeholder: (_, __) =>
        Container(width: size, height: size, color: Colors.grey[200]),
    errorWidget: (_, __, ___) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: Icon(Icons.person, size: size * 0.5, color: Colors.grey[400]),
    ),
  );
}

// ── Goals header + row ────────────────────────────────────────────────────────

class _CupGoalsTableHeader extends StatelessWidget {
  const _CupGoalsTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'PLAYERS',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          SizedBox(
            width: 52,
            child: Text(
              'GOALS',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CupGoalStatRow extends StatelessWidget {
  const _CupGoalStatRow({required this.stat});
  final CupPlayerStatEntry stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 11, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.socaGrey,
                  border: Border.all(color: AppColors.socaBlack, width: 1.2),
                ),
                child: ClipOval(child: _buildAvatar(stat.playerImage, 48)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (stat.playerName ?? '').toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      stat.teamName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack.withValues(alpha: 0.76),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 36,
                child: Text(
                  '${stat.count}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 0.8,
            color: AppColors.socaBlack.withValues(alpha: 0.35),
          ),
        ],
      ),
    );
  }
}

// ── Cards header + row ────────────────────────────────────────────────────────

class _CupCardsTableHeader extends StatelessWidget {
  const _CupCardsTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'PLAYERS',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          _CardHeaderBox(color: Colors.red),
          SizedBox(width: 16),
          _CardHeaderBox(color: AppColors.socaYellow),
        ],
      ),
    );
  }
}

class _CardHeaderBox extends StatelessWidget {
  const _CardHeaderBox({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _CupCardStatRow extends StatelessWidget {
  const _CupCardStatRow({required this.stat});
  final CupPlayerStatEntry stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 11, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.socaGrey,
                  border: Border.all(color: AppColors.socaBlack, width: 1.2),
                ),
                child: ClipOval(child: _buildAvatar(stat.playerImage, 48)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (stat.playerName ?? '').toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      stat.teamName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack.withValues(alpha: 0.76),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _CardCount('${stat.redCards}'),
              const SizedBox(width: 16),
              _CardCount('${stat.yellowCards}'),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 0.8,
            color: AppColors.socaBlack.withValues(alpha: 0.35),
          ),
        ],
      ),
    );
  }
}

class _CardCount extends StatelessWidget {
  const _CardCount(this.value);
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

// ── Assists / POM stat card ───────────────────────────────────────────────────

class _CupStatCard extends StatelessWidget {
  const _CupStatCard({required this.stat, required this.position});
  final CupPlayerStatEntry stat;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$position',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(child: _buildAvatar(stat.playerImage, 44)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.playerName ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
                if (stat.teamName != null)
                  Text(
                    stat.teamName!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.socaBlack.withValues(alpha: 0.6),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaBlack,
            ),
            child: Center(
              child: Text(
                '${stat.count}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.socaYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
