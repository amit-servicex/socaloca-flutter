import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../data/repositories/match_management_repository.dart';
import '../../../data/models/match_management_models.dart';

/// Goal Entry Tab
/// Allows recording goal scorers with player and minute
/// Matches Android goal management functionality
class GoalEntryTab extends ConsumerStatefulWidget {
  final String matchId;
  final TournamentMatchModel match;
  final String tournamentId;

  const GoalEntryTab({
    super.key,
    required this.matchId,
    required this.match,
    required this.tournamentId,
  });

  @override
  ConsumerState<GoalEntryTab> createState() => _GoalEntryTabState();
}

class _GoalEntryTabState extends ConsumerState<GoalEntryTab> {
  final List<MatchGoalModel> _goals = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Goals List
        Expanded(
          child: _goals.isEmpty
              ? _buildEmptyView()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    return _buildGoalCard(_goals[index], index);
                  },
                ),
        ),

        // Add Goal Button
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _showAddGoalDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Goal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaYellow,
                foregroundColor: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyView() {
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
            'No Goals Recorded',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to add goals',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(MatchGoalModel goal, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Goal Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.socaYellow.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sports_soccer,
                color: AppColors.socaYellow,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            // Goal Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.playerName ?? 'Unknown Player',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        goal.teamName ?? 'Unknown Team',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.socaYellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${goal.minute}'",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delete Button
            IconButton(
              onPressed: () => _deleteGoal(index),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddGoalDialog() {
    final playerNameController = TextEditingController();
    final minuteController = TextEditingController();
    String selectedTeam = 'home';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'Add Goal',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Team Selection
                const Text(
                  'Team',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          widget.match.homeTeamName ?? 'Home',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                        value: 'home',
                        groupValue: selectedTeam,
                        onChanged: (value) {
                          setState(() => selectedTeam = value!);
                        },
                        activeColor: AppColors.socaYellow,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(
                          widget.match.awayTeamName ?? 'Away',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                        value: 'away',
                        groupValue: selectedTeam,
                        onChanged: (value) {
                          setState(() => selectedTeam = value!);
                        },
                        activeColor: AppColors.socaYellow,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Player Name
                TextField(
                  controller: playerNameController,
                  decoration: InputDecoration(
                    labelText: 'Player Name',
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.socaYellow,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Minute
                TextField(
                  controller: minuteController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Minute',
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    hintText: 'e.g., 23',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.socaYellow,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (playerNameController.text.isNotEmpty &&
                    minuteController.text.isNotEmpty) {
                  _addGoal(
                    playerName: playerNameController.text,
                    minute: int.parse(minuteController.text),
                    teamType: selectedTeam,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaYellow,
                foregroundColor: AppColors.socaBlack,
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addGoal({
    required String playerName,
    required int minute,
    required String teamType,
  }) async {
    setState(() => _isLoading = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) throw Exception('User not logged in');

      final teamName = teamType == 'home'
          ? widget.match.homeTeamName
          : widget.match.awayTeamName;
      final teamId = teamType == 'home'
          ? widget.match.homeTeamId
          : widget.match.awayTeamId;

      final goal = MatchGoalModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        matchId: widget.matchId,
        playerId: '', // Would need player selection
        playerName: playerName,
        teamId: teamId ?? '',
        teamName: teamName ?? '',
        minute: minute,
        // goalType: 'REGULAR',
      );

      final repository = ref.read(matchManagementRepositoryProvider);
      final success = await repository.saveMatchGoalDetails(
        userId: user.id,
        matchId: widget.matchId,
        goals: [goal],
        tournamentId: widget.tournamentId,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (success) {
            _goals.add(goal);
          }
        });

        if (!success) {
          _showErrorDialog('Failed to add goal');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorDialog('Error: ${e.toString()}');
      }
    }
  }

  void _deleteGoal(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Goal',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to delete this goal?',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _goals.removeAt(index));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
