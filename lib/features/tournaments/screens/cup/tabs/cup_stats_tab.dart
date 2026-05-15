import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../providers/cup_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Cup Stats Tab
/// Shows tournament statistics for both Group Mode and Match Mode
/// Matches Android Cup Stats fragments
class CupStatsTab extends ConsumerStatefulWidget {
  final String tournamentId;
  final TournamentCupModel cup;

  const CupStatsTab({
    super.key,
    required this.tournamentId,
    required this.cup,
  });

  @override
  ConsumerState<CupStatsTab> createState() => _CupStatsTabState();
}

class _CupStatsTabState extends ConsumerState<CupStatsTab>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _modeTabController;
  late TabController _groupStatsTabController;
  late TabController _knockoutStatsTabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _modeTabController = TabController(length: 2, vsync: this);
    _groupStatsTabController = TabController(length: 4, vsync: this);
    _knockoutStatsTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _modeTabController.dispose();
    _groupStatsTabController.dispose();
    _knockoutStatsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        // Mode Selector (Group / Knockout)
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _modeTabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 2,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'GROUP STAGE'),
              Tab(text: 'KNOCKOUT'),
            ],
          ),
        ),

        // Stats Content
        Expanded(
          child: TabBarView(
            controller: _modeTabController,
            children: [
              // Group Stage Stats
              _buildGroupStageStats(),
              
              // Knockout Stats
              _buildKnockoutStats(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupStageStats() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _groupStatsTabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 2,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'GOALS'),
              Tab(text: 'ASSISTS'),
              Tab(text: 'CARDS'),
              Tab(text: 'MAN OF MATCH'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _groupStatsTabController,
            children: [
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'goals',
                isGroupMode: true,
              ),
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'assists',
                isGroupMode: true,
              ),
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'cards',
                isGroupMode: true,
              ),
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'mom',
                isGroupMode: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKnockoutStats() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _knockoutStatsTabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 2,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'GOALS'),
              Tab(text: 'ASSISTS'),
              Tab(text: 'CARDS'),
              Tab(text: 'MAN OF MATCH'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _knockoutStatsTabController,
            children: [
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'goals',
                isGroupMode: false,
              ),
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'assists',
                isGroupMode: false,
              ),
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'cards',
                isGroupMode: false,
              ),
              _CupStatsList(
                tournamentId: widget.tournamentId,
                statType: 'mom',
                isGroupMode: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CupStatsList extends ConsumerWidget {
  final String tournamentId;
  final String statType;
  final bool isGroupMode;

  const _CupStatsList({
    required this.tournamentId,
    required this.statType,
    required this.isGroupMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = isGroupMode
        ? ref.watch(cupGroupStatsProvider(CupGroupStatsParams(
            tournamentId: tournamentId,
            statType: statType,
          )))
        : ref.watch(cupMatchStatsProvider(CupMatchStatsParams(
            tournamentId: tournamentId,
            statType: statType,
          )));

    return statsAsync.when(
      data: (stats) {
        if (stats.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getIconForStatType(),
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No ${_getStatTypeLabel()} yet',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (isGroupMode) {
              ref.invalidate(cupGroupStatsProvider(CupGroupStatsParams(
                tournamentId: tournamentId,
                statType: statType,
              )));
            } else {
              ref.invalidate(cupMatchStatsProvider(CupMatchStatsParams(
                tournamentId: tournamentId,
                statType: statType,
              )));
            }
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              final stat = stats[index];
              return _buildStatCard(stat, index + 1);
            },
          ),
        );
      },
      loading: () => const AppLoader(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading stats: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (isGroupMode) {
                  ref.invalidate(cupGroupStatsProvider(CupGroupStatsParams(
                    tournamentId: tournamentId,
                    statType: statType,
                  )));
                } else {
                  ref.invalidate(cupMatchStatsProvider(CupMatchStatsParams(
                    tournamentId: tournamentId,
                    statType: statType,
                  )));
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(CupPlayerStatEntry stat, int position) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Position
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: position <= 3 ? AppColors.socaYellow : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$position',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: position <= 3 ? AppColors.socaBlack : Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Player Photo
            ClipOval(
              child: _buildPlayerPhoto(stat.playerImage, 48),
            ),
          ],
        ),
        title: Text(
          stat.playerName ?? 'Unknown',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.socaBlack,
          ),
        ),
        subtitle: Text(
          stat.teamName ?? 'Unknown Team',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        trailing: _buildStatValue(stat),
      ),
    );
  }

  Widget _buildPlayerPhoto(String? photoUrl, double size) {
    if (photoUrl == null || photoUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(photoUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: fullImageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        color: Colors.grey[200],
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildStatValue(CupPlayerStatEntry stat) {
    if (statType == 'cards') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (stat.yellowCards > 0)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 20,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          if (stat.redCards > 0)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16,
                  height: 20,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.socaYellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '${stat.count}',
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }

  IconData _getIconForStatType() {
    switch (statType) {
      case 'goals':
        return Icons.sports_soccer;
      case 'assists':
        return Icons.sports_handball;
      case 'cards':
        return Icons.style;
      case 'mom':
        return Icons.emoji_events;
      default:
        return Icons.bar_chart;
    }
  }

  String _getStatTypeLabel() {
    switch (statType) {
      case 'goals':
        return 'goals';
      case 'assists':
        return 'assists';
      case 'cards':
        return 'cards';
      case 'mom':
        return 'man of the match awards';
      default:
        return 'stats';
    }
  }
}
