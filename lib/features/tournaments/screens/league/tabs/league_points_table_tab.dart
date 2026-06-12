import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../providers/tournament_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// League Points Table Tab
/// Displays tournament standings
/// Matches Android TournamentsPointTableFragment
class LeaguePointsTableTab extends ConsumerWidget {
  final String tournamentId;

  LeaguePointsTableTab({
    super.key,
    required this.tournamentId,
  });

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
                Icon(
                  Icons.table_chart,
                  size: 64,
                  color: Colors.grey[400],
                ),
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
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(AppColors.socaBlack),
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
                      color: MaterialStateProperty.all(
                        isEven ? Colors.grey[50] : Colors.white,
                      ),
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(
                          Row(
                            children: [
                              _buildTeamLogo(team.teamLogo, 30),
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
    log("this is the team logo url table point ${logoUrl}");
    if (logoUrl == null || logoUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.6,
          color: Colors.grey[400],
        ),
      );
    }

    final fullImageUrl = ApiConstants.getImageUrl(logoUrl);
    log("this is the team logo url ${fullImageUrl}");
    if (fullImageUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shield,
          size: size * 0.6,
          color: Colors.grey[400],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          border: Border.all(color: AppColors.socaBlack)),
      child: ClipOval(
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
            child: Icon(
              Icons.shield,
              size: size * 0.6,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
