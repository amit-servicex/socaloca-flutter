import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../data/repositories/match_management_repository.dart';
import '../../../data/models/match_management_models.dart';

/// Squad Management Tab
/// Allows managing team lineups (starting XI + substitutes)
class SquadManagementTab extends ConsumerStatefulWidget {
  final String matchId;
  final TournamentMatchModel match;
  final String tournamentId;

  SquadManagementTab({
    super.key,
    required this.matchId,
    required this.match,
    required this.tournamentId,
  });

  @override
  ConsumerState<SquadManagementTab> createState() => _SquadManagementTabState();
}

class _SquadManagementTabState extends ConsumerState<SquadManagementTab>
    with SingleTickerProviderStateMixin {
  late TabController _teamTabController;
  final List<String> _homeStarting = [];
  final List<String> _homeSubstitutes = [];
  final List<String> _awayStarting = [];
  final List<String> _awaySubstitutes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _teamTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _teamTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Team Tabs
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _teamTabController,
            labelColor: AppColors.socaBlack,
            unselectedLabelColor: AppColors.socaBlack.withOpacity(0.5),
            indicatorColor: AppColors.socaYellow,
            indicatorWeight: 3,
            labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14),
            unselectedLabelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14),
            tabs: [
              Tab(text: widget.match.homeTeamName ?? 'HOME'),
              Tab(text: widget.match.awayTeamName ?? 'AWAY'),
            ],
          ),
        ),

        // Team Squad Views
        Expanded(
          child: TabBarView(
            controller: _teamTabController,
            children: [
              _buildSquadView(isHome: true),
              _buildSquadView(isHome: false),
            ],
          ),
        ),

        // Save Button
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -2))
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveSquad,
              icon: Icon(Icons.save),
              label: Text(AppStrings.saveSquad),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaYellow,
                foregroundColor: AppColors.socaBlack,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSquadView({required bool isHome}) {
    final starting = isHome ? _homeStarting : _awayStarting;
    final substitutes = isHome ? _homeSubstitutes : _awaySubstitutes;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Starting XI
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.startingXi,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Text('${starting.length}/11',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey[600])),
            ],
          ),
          SizedBox(height: 12),
          if (starting.isEmpty)
            _buildEmptySection('No starting players added')
          else
            ...starting.asMap().entries.map((entry) =>
                _buildPlayerCard(entry.value, entry.key, isHome, true)),
          SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed:
                starting.length >= 11 ? null : () => _addPlayer(isHome, true),
            icon: Icon(Icons.add, size: 18),
            label: Text(AppStrings.addStartingPlayer),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.socaBlack,
              side: BorderSide(color: AppColors.socaYellow),
            ),
          ),

          SizedBox(height: 24),

          // Substitutes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.substitutes,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Text('${substitutes.length}/7',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey[600])),
            ],
          ),
          SizedBox(height: 12),
          if (substitutes.isEmpty)
            _buildEmptySection('No substitute players added')
          else
            ...substitutes.asMap().entries.map((entry) =>
                _buildPlayerCard(entry.value, entry.key, isHome, false)),
          SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: substitutes.length >= 7
                ? null
                : () => _addPlayer(isHome, false),
            icon: Icon(Icons.add, size: 18),
            label: Text(AppStrings.addSubstitute),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.socaBlack,
              side: BorderSide(color: AppColors.socaYellow),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySection(String message) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Text(message,
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 14, color: Colors.grey[600])),
      ),
    );
  }

  Widget _buildPlayerCard(
      String playerName, int index, bool isHome, bool isStarting) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.socaYellow.withOpacity(0.2),
          child: Text('${index + 1}',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: AppColors.socaBlack)),
        ),
        title: Text(playerName,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600)),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
          onPressed: () => _removePlayer(isHome, isStarting, index),
        ),
      ),
    );
  }

  void _addPlayer(bool isHome, bool isStarting) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.addStartingOrSubstitutePlayer(isStarting),
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: AppStrings.playerName,
            labelStyle: TextStyle(fontFamily: 'Poppins'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.socaYellow, width: 2)),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.cancel)),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  if (isHome) {
                    if (isStarting) {
                      _homeStarting.add(controller.text);
                    } else {
                      _homeSubstitutes.add(controller.text);
                    }
                  } else {
                    if (isStarting) {
                      _awayStarting.add(controller.text);
                    } else {
                      _awaySubstitutes.add(controller.text);
                    }
                  }
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaYellow,
                foregroundColor: AppColors.socaBlack),
            child: Text(AppStrings.add),
          ),
        ],
      ),
    );
  }

  void _removePlayer(bool isHome, bool isStarting, int index) {
    setState(() {
      if (isHome) {
        if (isStarting) {
          _homeStarting.removeAt(index);
        } else {
          _homeSubstitutes.removeAt(index);
        }
      } else {
        if (isStarting) {
          _awayStarting.removeAt(index);
        } else {
          _awaySubstitutes.removeAt(index);
        }
      }
    });
  }

  Future<void> _saveSquad() async {
    setState(() => _isLoading = true);

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) throw Exception('User not logged in');

      final repository = ref.read(matchManagementRepositoryProvider);

      // Save home team squad
      final homePlayersData = [
        ..._homeStarting.asMap().entries.map((entry) => MatchPlayerModel(
              playerId: '',
              playerName: entry.value,
              position: '',
              jerseyNumber: (entry.key + 1).toString(),
              isStarting: true,
              isPlaying: true,
              teamId: '${widget.match.homeTeamId ?? ''}',
            )),
        ..._homeSubstitutes.asMap().entries.map((entry) => MatchPlayerModel(
              playerId: '',
              playerName: entry.value,
              position: '',
              jerseyNumber: (_homeStarting.length + entry.key + 1).toString(),
              isStarting: false,
              isPlaying: false,
              teamId: '${widget.match.homeTeamId ?? ''}',
            )),
      ];

      final homeSuccess = await repository.updateMatchPlayers(
        userId: user.id,
        matchId: widget.matchId,
        tournamentId: widget.tournamentId,
        teamId: widget.match.homeTeamId ?? '',
        players: homePlayersData,
      );

      // Save away team squad
      final awayPlayersData = [
        ..._awayStarting.asMap().entries.map((entry) => MatchPlayerModel(
              playerId: '',
              playerName: entry.value,
              position: '',
              jerseyNumber: (entry.key + 1).toString(),
              isStarting: true,
              isPlaying: true,
              teamId: '${widget.match.awayTeamId ?? ''}',
            )),
        ..._awaySubstitutes.asMap().entries.map((entry) => MatchPlayerModel(
              playerId: '',
              playerName: entry.value,
              position: '',
              jerseyNumber: (_awayStarting.length + entry.key + 1).toString(),
              isStarting: false,
              isPlaying: false,
              teamId: '${widget.match.awayTeamId ?? ''}',
            )),
      ];

      final awaySuccess = await repository.updateMatchPlayers(
        userId: user.id,
        matchId: widget.matchId,
        tournamentId: widget.tournamentId,
        teamId: widget.match.awayTeamId ?? '',
        players: awayPlayersData,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (homeSuccess && awaySuccess) {
          _showSuccessDialog('Squad saved successfully!');
        } else {
          _showErrorDialog('Failed to save squad');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorDialog('Error: ${e.toString()}');
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.success,
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Text(message, style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.ok))
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.error,
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Text(message, style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.ok))
        ],
      ),
    );
  }
}
