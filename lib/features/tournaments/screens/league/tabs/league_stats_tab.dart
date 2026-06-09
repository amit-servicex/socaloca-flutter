import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../providers/tournament_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// League Stats Tab
/// Shows tournament statistics (goals, assists, cards, MOM)
/// Matches Android League Stats fragments
class LeagueStatsTab extends ConsumerStatefulWidget {
  final String tournamentId;

  LeagueStatsTab({
    super.key,
    required this.tournamentId,
  });

  @override
  ConsumerState<LeagueStatsTab> createState() => _LeagueStatsTabState();
}

class _LeagueStatsTabState extends ConsumerState<LeagueStatsTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        Container(
          color: Color(0xFFF3F3F3),
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack,
            indicatorColor: AppColors.socaBlack,
            indicatorWeight: 2,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              // Tab(text: 'TABLE'),
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
            children: [
              // _PointsTableView(tournamentId: widget.tournamentId),
              _StatsList(tournamentId: widget.tournamentId, statType: 'goals'),
              _StatsList(
                  tournamentId: widget.tournamentId, statType: 'assists'),
              _StatsList(tournamentId: widget.tournamentId, statType: 'cards'),
              _StatsList(tournamentId: widget.tournamentId, statType: 'mom'),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsList extends ConsumerWidget {
  final String tournamentId;
  final String statType;

  _StatsList({
    required this.tournamentId,
    required this.statType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = TournamentStatsParams(
      tournamentId: tournamentId,
      statType: statType,
    );

    final statsAsync = ref.watch(tournamentStatsProvider(params));

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
                SizedBox(height: 16),
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
            ref.invalidate(tournamentStatsProvider(params));
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: stats.length +
                (statType == 'goals' || statType == 'cards' ? 1 : 0),
            itemBuilder: (context, index) {
              if (statType == 'goals' && index == 0) {
                return _buildGoalsHeader();
              }
              if (statType == 'cards' && index == 0) {
                return _buildCardsHeader();
              }

              final statIndex = (statType == 'goals' || statType == 'cards')
                  ? index - 1
                  : index;
              final stat = stats[statIndex];

              if (statType == 'goals') {
                return _buildFlatStatRow(
                  stat,
                  valueWidgets: [_buildPlainCount('${stat.count}')],
                );
              }
              if (statType == 'cards') {
                return _buildFlatStatRow(
                  stat,
                  valueWidgets: [
                    _buildPlainCount('${stat.redCards}'),
                    SizedBox(width: 16),
                    _buildPlainCount('${stat.yellowCards}'),
                  ],
                );
              }

              return _buildStatCard(stat, index + 1);
            },
          ),
        );
      },
      loading: () => AppLoader(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(AppStrings.errorLoadingStats(error)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(tournamentStatsProvider(params));
              },
              child: Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsHeader() {
    return Container(
      height: 44,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildHeaderText(AppStrings.players.toUpperCase()),
          ),
          SizedBox(
            width: 52,
            child: _buildHeaderText(AppStrings.goals.toUpperCase(),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsHeader() {
    return Container(
      height: 44,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildHeaderText(AppStrings.players.toUpperCase())),
          _buildCardHeaderIcon(Colors.red),
          SizedBox(width: 16),
          _buildCardHeaderIcon(AppColors.socaYellow),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text, {TextAlign textAlign = TextAlign.left}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.socaBlack,
      ),
    );
  }

  Widget _buildCardHeaderIcon(Color color) {
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

  Widget _buildFlatStatRow(
    dynamic stat, {
    required List<Widget> valueWidgets,
  }) {
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
                  child: _buildPlayerPhoto(stat.playerImage, 48),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (stat.playerName ?? 'Unknown').toString().toUpperCase(),
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
                      stat.teamName ?? 'Unknown Team',
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
              ...valueWidgets,
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

  Widget _buildPlainCount(String value) {
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

  Widget _buildStatCard(dynamic stat, int position) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
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
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    color:
                        position <= 3 ? AppColors.socaBlack : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            // Player Photo
            ClipOval(
              child: _buildPlayerPhoto(stat.playerImage, 48),
            ),
          ],
        ),
        title: Text(
          stat.playerName ?? 'Unknown',
          style: TextStyle(
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

  Widget _buildStatValue(dynamic stat) {
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
                SizedBox(width: 4),
                Text(
                  '${stat.yellowCards}',
                  style: TextStyle(
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
                SizedBox(width: 4),
                Text(
                  '${stat.redCards}',
                  style: TextStyle(
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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.socaYellow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '${stat.count}',
        style: TextStyle(
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

/// Points table sub-tab embedded inside the stats tab
class _PointsTableView extends ConsumerWidget {
  final String tournamentId;

  _PointsTableView({required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableAsync = ref.watch(pointsTableProvider(tournamentId));

    return tableAsync.when(
      data: (table) {
        if (table.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.table_chart, size: 64, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  AppStrings.noStandingsAvailable,
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
            ref.invalidate(pointsTableProvider(tournamentId));
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(AppColors.socaBlack),
                  headingTextStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.socaYellow,
                  ),
                  dataTextStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: AppColors.socaBlack,
                  ),
                  columnSpacing: 16,
                  horizontalMargin: 12,
                  columns: [
                    DataColumn(label: Text(AppStrings.pointsHash)),
                    DataColumn(label: Text(AppStrings.teamFallback)),
                    DataColumn(
                        label: Text(AppStrings.pointsPlayed), numeric: true),
                    DataColumn(
                        label: Text(AppStrings.pointsWon), numeric: true),
                    DataColumn(
                        label: Text(AppStrings.pointsDrawn), numeric: true),
                    DataColumn(
                        label: Text(AppStrings.pointsLost), numeric: true),
                    DataColumn(label: Text(AppStrings.goalsFor), numeric: true),
                    DataColumn(
                        label: Text(AppStrings.goalsAgainst), numeric: true),
                    DataColumn(
                        label: Text(AppStrings.goalDifference), numeric: true),
                    DataColumn(
                        label: Text(AppStrings.pointsShort), numeric: true),
                  ],
                  rows: table.asMap().entries.map((entry) {
                    final index = entry.key;
                    final team = entry.value;
                    final isEven = index % 2 == 0;

                    return DataRow(
                      color: WidgetStateProperty.all(
                        isEven ? Colors.grey[50] : Colors.white,
                      ),
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(
                          Row(
                            children: [
                              _buildTeamLogo(team.teamLogo, 24),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  team.teamName ?? 'Unknown',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text('${team.played}')),
                        DataCell(Text('${team.won}')),
                        DataCell(Text('${team.drawn}')),
                        DataCell(Text('${team.lost}')),
                        DataCell(Text('${team.goalsFor}')),
                        DataCell(Text('${team.goalsAgainst}')),
                        DataCell(
                          Text(
                            '${team.goalDifference}',
                            style: TextStyle(
                              color: team.goalDifference > 0
                                  ? Colors.green
                                  : team.goalDifference < 0
                                      ? Colors.red
                                      : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${team.points}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
      loading: () => AppLoader(),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(AppStrings.errorLoadingStandingsWithError(error)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(pointsTableProvider(tournamentId));
              },
              child: Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamLogo(String? logoUrl, double size) {
    if (logoUrl == null || logoUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.shield, size: size * 0.6, color: Colors.grey[400]),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(logoUrl);

    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.shield, size: size * 0.6, color: Colors.grey[400]),
      );
    }

    return ClipOval(
      child: CachedNetworkImage(
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
          child: Icon(Icons.shield, size: size * 0.6, color: Colors.grey[400]),
        ),
      ),
    );
  }
}
