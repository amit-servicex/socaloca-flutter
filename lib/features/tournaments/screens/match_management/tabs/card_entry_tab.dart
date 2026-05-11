import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/tournament_models.dart';
import '../../../data/repositories/match_management_repository.dart';
import '../../../data/models/match_management_models.dart';

/// Card Entry Tab
/// Allows recording yellow and red cards with player and minute
class CardEntryTab extends ConsumerStatefulWidget {
  final String matchId;
  final TournamentMatchModel match;
  final String tournamentId;

  const CardEntryTab({
    super.key,
    required this.matchId,
    required this.match,
    required this.tournamentId,
  });

  @override
  ConsumerState<CardEntryTab> createState() => _CardEntryTabState();
}

class _CardEntryTabState extends ConsumerState<CardEntryTab> {
  final List<MatchCardModel> _cards = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _cards.isEmpty
              ? _buildEmptyView()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    return _buildCardCard(_cards[index], index);
                  },
                ),
        ),
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
              onPressed: _isLoading ? null : _showAddCardDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Card'),
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
          Icon(Icons.style, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Cards Recorded',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to add cards',
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

  Widget _buildCardCard(MatchCardModel card, int index) {
    final isRed = card.cardType == 'RED';
    final cardColor = isRed ? Colors.red : Colors.yellow[700]!;

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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.style, color: cardColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.playerName ?? 'Unknown Player',
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
                        card.teamName ?? 'Unknown Team',
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
                          color: cardColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${card.minute}'",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isRed ? Colors.white : AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _deleteCard(index),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCardDialog() {
    final playerNameController = TextEditingController();
    final minuteController = TextEditingController();
    String selectedTeam = 'home';
    String cardType = 'YELLOW';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'Add Card',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Card Type',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Yellow',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                        value: 'YELLOW',
                        groupValue: cardType,
                        onChanged: (value) => setState(() => cardType = value!),
                        activeColor: Colors.yellow[700],
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Red',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                        value: 'RED',
                        groupValue: cardType,
                        onChanged: (value) => setState(() => cardType = value!),
                        activeColor: Colors.red,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                TextField(
                  controller: minuteController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ],
                  decoration: InputDecoration(
                    labelText: 'Minute',
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    hintText: 'e.g., 45',
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
                if (playerNameController.text.isNotEmpty &&
                    minuteController.text.isNotEmpty) {
                  _addCard(
                    playerName: playerNameController.text,
                    minute: int.parse(minuteController.text),
                    teamType: selectedTeam,
                    cardType: cardType,
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

  Future<void> _addCard({
    required String playerName,
    required int minute,
    required String teamType,
    required String cardType,
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

      final card = MatchCardModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        matchId: widget.matchId,
        playerId: '',
        playerName: playerName,
        teamId: teamId ?? "",
        teamName: teamName ?? '',
        minute: minute,
        cardType: cardType,
      );

      final repository = ref.read(matchManagementRepositoryProvider);
      final success = await repository.saveMatchCardDetails(
        userId: user.id,
        matchId: widget.matchId,
        cards: [card],
        tournamentId: widget.tournamentId,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (success) _cards.add(card);
        });
        if (!success) _showErrorDialog('Failed to add card');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorDialog('Error: ${e.toString()}');
      }
    }
  }

  void _deleteCard(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Card',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to delete this card?',
            style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _cards.removeAt(index));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
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
