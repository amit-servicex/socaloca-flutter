import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../data/tournament_models.dart';
import '../../data/tournament_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Stats tab — mirrors Android LeagueStatsFragment with sub-tabs:
/// Goals | Assists | Cards | MOM
class TournamentStatsTab extends ConsumerStatefulWidget {
  const TournamentStatsTab({super.key, required this.tournamentId});
  final String tournamentId;

  @override
  ConsumerState<TournamentStatsTab> createState() => _TournamentStatsTabState();
}

class _TournamentStatsTabState extends ConsumerState<TournamentStatsTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  final Map<String, List<PlayerStatEntry>> _statsCache = {};
  final Map<String, bool> _loading = {
    'goals': false,
    'assists': false,
    'cards': false,
    'mom': false,
  };

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _loadTab(_tabController.index);
      }
    });
    _loadTab(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTab(int index) async {
    final types = ['goals', 'assists', 'cards', 'mom'];
    final type = types[index];
    if (_statsCache.containsKey(type)) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _loading[type] = true);

    final data = await ref.read(tournamentRepositoryProvider).getTournamentStats(
          userId: user.id,
          tournamentId: widget.tournamentId,
          statType: type,
        );

    if (mounted) {
      setState(() {
        _statsCache[type] = data;
        _loading[type] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        // Sub-tabs: Goals, Assists, Cards, MOM
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.4),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            tabs: const [
              Tab(text: 'Goals'),
              Tab(text: 'Assists'),
              Tab(text: 'Cards'),
              Tab(text: 'MOM'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _StatsList(
                type: 'goals',
                stats: _statsCache['goals'] ?? [],
                loading: _loading['goals'] ?? false,
              ),
              _StatsList(
                type: 'assists',
                stats: _statsCache['assists'] ?? [],
                loading: _loading['assists'] ?? false,
              ),
              _StatsList(
                type: 'cards',
                stats: _statsCache['cards'] ?? [],
                loading: _loading['cards'] ?? false,
                isCards: true,
              ),
              _StatsList(
                type: 'mom',
                stats: _statsCache['mom'] ?? [],
                loading: _loading['mom'] ?? false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsList extends StatelessWidget {
  const _StatsList({
    required this.type,
    required this.stats,
    required this.loading,
    this.isCards = false,
  });

  final String type;
  final List<PlayerStatEntry> stats;
  final bool loading;
  final bool isCards;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const AppLoader();
    }

    if (stats.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: AppColors.socaBlack.withOpacity(0.4),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return _StatCard(
          stat: stat,
          position: index + 1,
          isCards: isCards,
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.stat,
    required this.position,
    this.isCards = false,
  });

  final PlayerStatEntry stat;
  final int position;
  final bool isCards;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(stat.playerImage);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          // Position
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

          // Player photo
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.person,
                        color: AppColors.socaBlack,
                        size: 22,
                      ),
                    )
                  : const Icon(Icons.person,
                      color: AppColors.socaBlack, size: 22),
            ),
          ),
          const SizedBox(width: 12),

          // Name + team
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
                      color: AppColors.socaBlack.withOpacity(0.6),
                    ),
                  ),
              ],
            ),
          ),

          // Count / cards
          if (isCards)
            Row(
              children: [
                if (stat.yellowCards > 0) ...[
                  Container(
                    width: 16,
                    height: 22,
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
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                if (stat.redCards > 0) ...[
                  Container(
                    width: 16,
                    height: 22,
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
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ],
              ],
            )
          else
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
