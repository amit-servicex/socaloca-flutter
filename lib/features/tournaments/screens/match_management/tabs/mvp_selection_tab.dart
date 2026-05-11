import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../data/repositories/match_management_repository.dart';
import '../../../data/models/match_management_models.dart';

/// MVP Selection Tab
/// Allows selecting Man of the Match from participants
class MvpSelectionTab extends ConsumerStatefulWidget {
  final String matchId;
  final TournamentMatchModel match;
  final String tournamentId;

  const MvpSelectionTab({
    super.key,
    required this.matchId,
    required this.match,
    required this.tournamentId,
  });

  @override
  ConsumerState<MvpSelectionTab> createState() => _MvpSelectionTabState();
}

class _MvpSelectionTabState extends ConsumerState<MvpSelectionTab> {
  MatchMVPModel? _currentMVP;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.socaYellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.socaYellow.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events,
                    color: AppColors.socaYellow, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Select the Man of the Match from the participating players.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Current MVP Display
          if (_currentMVP != null) ...[
            const Text(
              'Current Man of the Match',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.socaYellow.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.emoji_events,
                          color: AppColors.socaYellow, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentMVP!.playerName ?? 'Unknown Player',
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _currentMVP!.teamName ?? 'Unknown Team',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _clearMVP,
                      icon: const Icon(Icons.close, color: Colors.red),
                      tooltip: 'Clear MVP',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ] else ...[
            Center(
              child: Column(
                children: [
                  Icon(Icons.emoji_events, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No MVP Selected',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the button below to select MVP',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],

          // Select/Change MVP Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _showSelectMVPDialog,
              icon: Icon(_currentMVP == null ? Icons.add : Icons.edit),
              label: Text(_currentMVP == null ? 'Select MVP' : 'Change MVP'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaYellow,
                foregroundColor: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectMVPDialog() {
    final playerNameController = TextEditingController();
    String selectedTeam = 'home';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select Man of the Match',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Team',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(widget.match.homeTeamName ?? 'Home',
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 13)),
                        value: 'home',
                        groupValue: selectedTeam,
                        onChanged: (value) =>
                            setState(() => selectedTeam = value!),
                        activeColor: AppColors.socaYellow,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text(widget.match.awayTeamName ?? 'Away',
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 13)),
                        value: 'away',
                        groupValue: selectedTeam,
                        onChanged: (value) =>
                            setState(() => selectedTeam = value!),
                        activeColor: AppColors.socaYellow,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: playerNameController,
                  decoration: InputDecoration(
                    labelText: 'Player Name',
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.socaYellow, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (playerNameController.text.isNotEmpty) {
                  _selectMVP(
                      playerName: playerNameController.text,
                      teamType: selectedTeam);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaYellow,
                  foregroundColor: AppColors.socaBlack),
              child: const Text('Select'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectMVP(
      {required String playerName, required String teamType}) async {
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

      final mvp = MatchMVPModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        matchId: widget.matchId,
        playerId: '',
        playerName: playerName,
        teamId: teamId ?? '',
        teamName: teamName ?? '',
      );

      final repository = ref.read(matchManagementRepositoryProvider);
      final success = await repository.saveMatchMvp(
        userId: user.id,
        matchId: widget.matchId,
        tournamentId: widget.tournamentId,
        playerId: mvp.playerId ?? '',
        playerName: mvp.playerName ?? '',
        playerImage: mvp.playerImage,
        teamId: mvp.teamId ?? '',
        teamName: mvp.teamName ?? '',
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (success) _currentMVP = mvp;
        });
        if (!success) _showErrorDialog('Failed to select MVP');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorDialog('Error: ${e.toString()}');
      }
    }
  }

  void _clearMVP() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear MVP',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: const Text(
            'Are you sure you want to clear the Man of the Match?',
            style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _currentMVP = null);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Text(message, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }
}
