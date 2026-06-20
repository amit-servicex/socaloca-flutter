import 'package:cached_network_image/cached_network_image.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../providers/cup_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';

/// Cup Group Point Table Dialog
/// Shows standings for a specific group
/// Matches Android TournamentCupGroupPointTableFragment
class CupGroupPointTableDialog extends ConsumerWidget {
  final String tournamentId;
  final String roundId;
  final String groupId;

  const CupGroupPointTableDialog({
    super.key,
    required this.tournamentId,
    required this.roundId,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = CupGroupTableParams(
      tournamentId: tournamentId,
      roundId: roundId,
      groupId: groupId,
    );

    final tableAsync = ref.watch(cupGroupPointTableProvider(params));

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.socaBlack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.table_chart,
                    color: AppColors.socaYellow,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppStrings.groupStandings,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.socaYellow,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.socaYellow),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: tableAsync.when(
                data: (table) {
                  if (table.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          AppStrings.noStandingsAvailable,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            Colors.grey[100],
                          ),
                          headingTextStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                          dataTextStyle: const TextStyle(
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
                                label: Text(AppStrings.pointsPlayed),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.pointsWon),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.pointsDrawn),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.pointsLost),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.goalsFor),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.goalsAgainst),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.goalDifference),
                                numeric: true),
                            DataColumn(
                                label: Text(AppStrings.pointsShort),
                                numeric: true),
                          ],
                          rows: table.asMap().entries.map((entry) {
                            final index = entry.key;
                            final team = entry.value;
                            final isEven = index % 2 == 0;

                            return DataRow(
                              color: WidgetStateProperty.all(
                                isEven ? Colors.white : Colors.grey[50],
                              ),
                              cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(
                                  Row(
                                    children: [
                                      _buildTeamLogo(team.teamLogo, 24),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          team.teamName ?? 'Unknown',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
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
                                    style: const TextStyle(
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
                  );
                },
                loading: () => const AppLoader(),
                error: (error, stack) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.errorLoadingStandings,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
        child: Icon(
          Icons.shield,
          size: size * 0.6,
          color: Colors.grey[400],
        ),
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
        child: Icon(
          Icons.shield,
          size: size * 0.6,
          color: Colors.grey[400],
        ),
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
          child: Icon(
            Icons.shield,
            size: size * 0.6,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
