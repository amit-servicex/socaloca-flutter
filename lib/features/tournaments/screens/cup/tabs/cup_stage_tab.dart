import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/cup_models.dart';
import '../widgets/cup_group_stage_view.dart';
import '../widgets/cup_knockout_bracket_view.dart';

/// Cup Stage Tab
/// Shows either Group Stage or Knockout Bracket based on tournament structure
/// Matches Android Cup Stage tab
class CupStageTab extends ConsumerStatefulWidget {
  final String tournamentId;
  final TournamentCupModel cup;

  CupStageTab({
    super.key,
    required this.tournamentId,
    required this.cup,
  });

  @override
  ConsumerState<CupStageTab> createState() => _CupStageTabState();
}

class _CupStageTabState extends ConsumerState<CupStageTab>
    with AutomaticKeepAliveClientMixin {
  String? _selectedRoundId;
  String _currentMode = 'GROUP'; // 'GROUP' or 'KNOCKOUT'

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeRound();
  }

  void _initializeRound() {
    if (widget.cup.roundsList != null && widget.cup.roundsList!.isNotEmpty) {
      // Find first round
      final firstRound = widget.cup.roundsList!.first;
      _selectedRoundId = firstRound.roundId;
      _currentMode = firstRound.mode ?? 'GROUP';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.cup.roundsList == null || widget.cup.roundsList!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No rounds available'.tr,
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
        // Round Selector
        if (widget.cup.roundsList!.length > 1)
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: AppColors.socaBlack,
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedRoundId,
                    decoration: InputDecoration(
                      labelText: 'Select Round'.tr,
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
                    items: widget.cup.roundsList!.map((round) {
                      return DropdownMenuItem<String>(
                        value: round.roundId,
                        child: Text(
                          round.roundName ?? 'Round ${round.seq}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedRoundId = value;
                          final selectedRound = widget.cup.roundsList!
                              .firstWhere((r) => r.roundId == value);
                          _currentMode = selectedRound.mode ?? 'GROUP';
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

        // Stage View
        Expanded(
          child: _currentMode == 'GROUP'
              ? CupGroupStageView(
                  tournamentId: widget.tournamentId,
                  roundId: _selectedRoundId ?? '',
                  cup: widget.cup,
                )
              : CupKnockoutBracketView(
                  tournamentId: widget.tournamentId,
                  roundId: _selectedRoundId ?? '',
                  cup: widget.cup,
                ),
        ),
      ],
    );
  }
}
