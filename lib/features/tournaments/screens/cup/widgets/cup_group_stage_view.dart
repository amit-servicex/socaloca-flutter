import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../providers/cup_providers.dart';
import '../../../widgets/match_card.dart';
import '../../../data/tournament_models.dart';
import 'cup_group_point_table_dialog.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../../../shared/widgets/searchable_dropdown.dart';

/// Cup Group Stage View
/// Shows matches for selected group with point table access
/// Matches Android TournamentCupGroupModeFragment
class CupGroupStageView extends ConsumerStatefulWidget {
  final String tournamentId;
  final String roundId;
  final TournamentCupModel cup;

  CupGroupStageView({
    super.key,
    required this.tournamentId,
    required this.roundId,
    required this.cup,
  });

  @override
  ConsumerState<CupGroupStageView> createState() => _CupGroupStageViewState();
}

class _CupGroupStageViewState extends ConsumerState<CupGroupStageView>
    with AutomaticKeepAliveClientMixin {
  String? _selectedGroupId;
  List<CupGroupModel> _groups = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  void _loadGroups() {
    // Get groups from the selected round
    final round = widget.cup.roundsList?.firstWhere(
      (r) => r.roundId == widget.roundId,
      orElse: () => CupRoundModel(),
    );

    if (round?.groups != null && round!.groups!.isNotEmpty) {
      setState(() {
        _groups = round.groups!;
        _selectedGroupId = _groups.first.groupId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_work_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No groups available'.tr,
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

    return Column(
      children: [
        // Group Selector
        if (_groups.length > 1)
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.group_work,
                  color: AppColors.socaBlack,
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SearchableDropdownButton(
                    hint: 'Select Group'.tr,
                    value: _selectedGroupId,
                    items: _groups.map((g) => g.groupName ?? 'Group').toList(),
                    values: _groups.map((g) => g.groupId ?? '').toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedGroupId = v);
                    },
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

        // Matches List
        Expanded(
          child: _selectedGroupId != null
              ? _buildGroupMatches(_selectedGroupId!)
              : SizedBox.shrink(),
        ),

        // View Standings Button
        if (_selectedGroupId != null)
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPointTable(_selectedGroupId!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'View Group Standings'.tr,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGroupMatches(String groupId) {
    final params = CupGroupMatchesParams(
      tournamentId: widget.tournamentId,
      roundId: widget.roundId,
      groupId: groupId,
    );

    final groupAsync = ref.watch(cupGroupMatchesProvider(params));

    return groupAsync.when(
      data: (group) {
        if (group == null) {
          return Center(child: Text('Group not found'.tr));
        }

        final allMatches = [...group.leg1, ...group.leg2];

        if (allMatches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_soccer,
                  size: 64,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'No matches in this group'.tr,
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
            ref.invalidate(cupGroupMatchesProvider(params));
          },
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: allMatches.length,
            itemBuilder: (context, index) {
              final match = allMatches[index];
              return MatchCard(
                match: TournamentMatchModel(
                  id: match.id,
                  matchId: match.matchId,
                  homeTeamId: match.homeTeamId,
                  homeTeamName: match.homeTeamName,
                  homeTeamLogo: match.homeTeamLogo,
                  awayTeamId: match.awayTeamId,
                  awayTeamName: match.awayTeamName,
                  awayTeamLogo: match.awayTeamLogo,
                  homeScore: match.homeScore,
                  awayScore: match.awayScore,
                  status: match.status,
                  matchDate: match.matchDate,
                  matchDateMs: match.matchDateMs,
                  venue: match.venue,
                  gameType: match.gameType,
                  ageGroup: match.ageGroup,
                ),
                onTap: () {
                  final matchId = match.effectiveId;
                  if (matchId.isEmpty) return;
                  context.push(
                    AppRoutes.liveMatchDetails
                        .replaceFirst(':matchId', matchId),
                    extra: {
                      'tournamentId': widget.tournamentId,
                      'preferMatchData': true,
                    },
                  );
                },
              );
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
            Text('Error loading matches: $error'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(cupGroupMatchesProvider(params));
              },
              child: Text('Retry'.tr),
            ),
          ],
        ),
      ),
    );
  }

  void _showPointTable(String groupId) {
    showDialog(
      context: context,
      builder: (context) => CupGroupPointTableDialog(
        tournamentId: widget.tournamentId,
        roundId: widget.roundId,
        groupId: groupId,
      ),
    );
  }
}
