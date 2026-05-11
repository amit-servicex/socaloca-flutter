import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../../../providers/cup_providers.dart';
import '../../../widgets/match_card.dart';
import '../../../data/tournament_models.dart';
import 'cup_group_point_table_dialog.dart';

/// Cup Group Stage View
/// Shows matches for selected group with point table access
/// Matches Android TournamentCupGroupModeFragment
class CupGroupStageView extends ConsumerStatefulWidget {
  final String tournamentId;
  final String roundId;
  final TournamentCupModel cup;

  const CupGroupStageView({
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
            const SizedBox(height: 16),
            Text(
              'No groups available',
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.group_work,
                  color: AppColors.socaBlack,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedGroupId,
                    decoration: const InputDecoration(
                      labelText: 'Select Group',
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: _groups.map((group) {
                      return DropdownMenuItem<String>(
                        value: group.groupId,
                        child: Text(
                          group.groupName ?? 'Group',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedGroupId = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

        // Matches List
        Expanded(
          child: _selectedGroupId != null
              ? _buildGroupMatches(_selectedGroupId!)
              : const SizedBox.shrink(),
        ),

        // View Standings Button
        if (_selectedGroupId != null)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPointTable(_selectedGroupId!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'View Group Standings',
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
          return const Center(child: Text('Group not found'));
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
                const SizedBox(height: 16),
                Text(
                  'No matches in this group',
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
            padding: const EdgeInsets.all(12),
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
                  // TODO: Navigate to match details
                },
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.socaYellow),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading matches: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(cupGroupMatchesProvider(params));
              },
              child: const Text('Retry'),
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
        groupId: groupId,
      ),
    );
  }
}
