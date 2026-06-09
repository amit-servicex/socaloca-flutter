import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../data/tournament_models.dart';
import '../../data/tournament_repository.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

const _kLimit = 10;

/// Stats tab — mirrors Android LeagueStatsFragment with sub-tabs:
/// Goals | Assists | Cards | MOM
class TournamentStatsTab extends ConsumerStatefulWidget {
  TournamentStatsTab({super.key, required this.tournamentId});
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
  final Map<String, bool> _loadingMore = {
    'goals': false,
    'assists': false,
    'cards': false,
    'mom': false,
  };
  final Map<String, bool> _hasMore = {
    'goals': true,
    'assists': true,
    'cards': true,
    'mom': true,
  };
  final Map<String, int> _start = {
    'goals': 0,
    'assists': 0,
    'cards': 0,
    'mom': 0,
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

  String _typeForIndex(int index) =>
      const ['goals', 'assists', 'cards', 'mom'][index];

  Future<void> _loadTab(int index) async {
    final type = _typeForIndex(index);
    if (_statsCache.containsKey(type)) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _loading[type] = true);

    final data =
        await ref.read(tournamentRepositoryProvider).getTournamentStats(
              userId: user.id,
              tournamentId: widget.tournamentId,
              statType: type,
              start: 0,
              limit: _kLimit,
            );

    if (mounted) {
      setState(() {
        _statsCache[type] = data;
        _start[type] = data.length;
        _hasMore[type] = data.length >= _kLimit;
        _loading[type] = false;
      });
    }
  }

  Future<void> _loadMore(String type) async {
    if (_loadingMore[type] == true || _hasMore[type] == false) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _loadingMore[type] = true);

    final data =
        await ref.read(tournamentRepositoryProvider).getTournamentStats(
              userId: user.id,
              tournamentId: widget.tournamentId,
              statType: type,
              start: _start[type]!,
              limit: _kLimit,
            );

    if (mounted) {
      setState(() {
        _statsCache[type] = [...(_statsCache[type] ?? []), ...data];
        _start[type] = _start[type]! + data.length;
        _hasMore[type] = data.length >= _kLimit;
        _loadingMore[type] = false;
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
          color: Color(0xFFF3F3F3),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack,
            indicatorColor: AppColors.socaBlack,
            indicatorWeight: 2,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: AppStrings.goals),
              Tab(text: AppStrings.assists),
              Tab(text: AppStrings.cards),
              Tab(text: AppStrings.pom),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: ['goals', 'assists', 'cards', 'mom'].map((type) {
              return _StatsList(
                type: type,
                stats: _statsCache[type] ?? [],
                loading: _loading[type] ?? false,
                loadingMore: _loadingMore[type] ?? false,
                hasMore: _hasMore[type] ?? true,
                isCards: type == 'cards',
                onLoadMore: () => _loadMore(type),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _StatsList extends StatefulWidget {
  const _StatsList({
    required this.type,
    required this.stats,
    required this.loading,
    required this.loadingMore,
    required this.hasMore,
    required this.onLoadMore,
    this.isCards = false,
  });

  final String type;
  final List<PlayerStatEntry> stats;
  final bool loading;
  final bool loadingMore;
  final bool hasMore;
  final bool isCards;
  final VoidCallback onLoadMore;

  @override
  State<_StatsList> createState() => _StatsListState();
}

class _StatsListState extends State<_StatsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200 && widget.hasMore) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading) return AppLoader();

    if (widget.stats.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noDataAvailable,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: AppColors.socaBlack.withOpacity(0.4),
          ),
        ),
      );
    }

    final showGoalsHeader = widget.type == 'goals';
    final showCardsHeader = widget.type == 'cards';

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: widget.stats.length +
          (widget.loadingMore ? 1 : 0) +
          ((showGoalsHeader || showCardsHeader) ? 1 : 0),
      itemBuilder: (context, index) {
        if (showGoalsHeader && index == 0) {
          return _GoalsTableHeader();
        }
        if (showCardsHeader && index == 0) {
          return _CardsTableHeader();
        }

        final statIndex =
            (showGoalsHeader || showCardsHeader) ? index - 1 : index;
        if (statIndex == widget.stats.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }

        if (showGoalsHeader) {
          return _GoalStatRow(stat: widget.stats[statIndex]);
        }
        if (showCardsHeader) {
          return _CardStatRow(stat: widget.stats[statIndex]);
        }

        return _StatCard(
          stat: widget.stats[statIndex],
          position: statIndex + 1,
          isCards: widget.isCards,
        );
      },
    );
  }
}

class _CardsTableHeader extends StatelessWidget {
  const _CardsTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
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
          _CardHeaderIcon(color: Colors.red),
          SizedBox(width: 16),
          _CardHeaderIcon(color: AppColors.socaYellow),
        ],
      ),
    );
  }
}

class _CardHeaderIcon extends StatelessWidget {
  const _CardHeaderIcon({required this.color});

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
            color: Colors.black.withOpacity(0.18),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _CardStatRow extends StatelessWidget {
  const _CardStatRow({required this.stat});

  final PlayerStatEntry stat;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(stat.playerImage);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 11, 16, 0),
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
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Icon(
                            Icons.person,
                            color: AppColors.socaBlack,
                            size: 24,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: AppColors.socaBlack,
                          size: 24,
                        ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (stat.playerName ?? '').toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      stat.teamName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack.withOpacity(0.76),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              _CardCountText('${stat.redCards}'),
              SizedBox(width: 16),
              _CardCountText('${stat.yellowCards}'),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 0.8,
            color: AppColors.socaBlack.withOpacity(0.35),
          ),
        ],
      ),
    );
  }
}

class _CardCountText extends StatelessWidget {
  const _CardCountText(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.socaBlack,
        ),
      ),
    );
  }
}

class _GoalsTableHeader extends StatelessWidget {
  const _GoalsTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
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

class _GoalStatRow extends StatelessWidget {
  const _GoalStatRow({required this.stat});

  final PlayerStatEntry stat;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiConstants.getImageUrl(stat.playerImage);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 11, 16, 0),
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
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Icon(
                            Icons.person,
                            color: AppColors.socaBlack,
                            size: 24,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: AppColors.socaBlack,
                          size: 24,
                        ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (stat.playerName ?? '').toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      stat.teamName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.socaBlack.withOpacity(0.76),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 36,
                child: Text(
                  '${stat.count}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 0.8,
            color: AppColors.socaBlack.withOpacity(0.35),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  _StatCard({
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
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
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
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.socaBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),

          // Player photo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.socaGrey,
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(
                        Icons.person,
                        color: AppColors.socaBlack,
                        size: 22,
                      ),
                    )
                  : Icon(Icons.person, color: AppColors.socaBlack, size: 22),
            ),
          ),
          SizedBox(width: 12),

          // Name + team
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.playerName ?? '',
                  style: TextStyle(
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
                  SizedBox(width: 4),
                  Text(
                    '${stat.yellowCards}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.socaBlack,
                    ),
                  ),
                  SizedBox(width: 10),
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
                  SizedBox(width: 4),
                  Text(
                    '${stat.redCards}',
                    style: TextStyle(
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.socaBlack,
              ),
              child: Center(
                child: Text(
                  '${stat.count}',
                  style: TextStyle(
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
