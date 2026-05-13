import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';

class RefereeLiveMatchUpdateScreen extends ConsumerStatefulWidget {
  const RefereeLiveMatchUpdateScreen({
    super.key,
    required this.matchId,
    required this.match,
  });

  final String matchId;
  final RefereeMatchModel? match;

  @override
  ConsumerState<RefereeLiveMatchUpdateScreen> createState() =>
      _RefereeLiveMatchUpdateScreenState();
}

class _RefereeLiveMatchUpdateScreenState
    extends ConsumerState<RefereeLiveMatchUpdateScreen> {
  int _scoreA = 0;
  int _scoreB = 0;
  String _matchState = 'NOT_STARTED';
  bool _isSaving = false;

  static const _states = [
    'NOT_STARTED',
    'FIRST_HALF_START',
    'FIRST_HALF_END',
    'SECOND_HALF_START',
    'FINISH',
  ];

  static const _stateLabels = {
    'NOT_STARTED': 'Not Started',
    'FIRST_HALF_START': '1st Half',
    'FIRST_HALF_END': 'Half Time',
    'SECOND_HALF_START': '2nd Half',
    'FINISH': 'Full Time',
  };

  @override
  void initState() {
    super.initState();
    final m = widget.match;
    if (m != null) {
      _scoreA = int.tryParse(m.teamAScore ?? '0') ?? 0;
      _scoreB = int.tryParse(m.teamBScore ?? '0') ?? 0;
    }
  }

  String get _teamA => widget.match?.teamA ?? 'Team A';
  String get _teamB => widget.match?.teamB ?? 'Team B';
  String get _tournamentId => widget.match?.tournamentId ?? '';

  Future<void> _saveUpdate() async {
    setState(() => _isSaving = true);
    final repo = ref.read(refereeRepositoryProvider);
    final ok = await repo.saveLiveMatchData(
      matchId: widget.matchId,
      tournamentId: _tournamentId,
      entry: 'state',
      state: _matchState,
      keyVals: {
        'myGoals': _scoreA,
        'opponentGoals': _scoreB,
      },
    );
    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? 'Match updated successfully' : 'Update failed. Try again.'),
      backgroundColor: ok ? AppColors.socaBlack : Colors.red,
    ));
    if (ok && _matchState == 'FINISH') {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Live Match Update',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 7, color: Colors.white),
                SizedBox(width: 4),
                Text('LIVE',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match info header
            if (widget.match?.tournamentName != null)
              _infoText(
                '${widget.match!.tournamentName}${widget.match!.roundName != null ? ' — ${widget.match!.roundName}' : ''}',
              ),
            const SizedBox(height: 16),

            // Score controls
            _card(
              child: Column(
                children: [
                  Row(
                    children: [
                      // Team A
                      Expanded(
                        child: Column(
                          children: [
                            Text(_teamA,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: AppColors.socaBlack)),
                            const SizedBox(height: 12),
                            _scoreStepper(
                              value: _scoreA,
                              onInc: () => setState(() => _scoreA++),
                              onDec: () =>
                                  setState(() => _scoreA = (_scoreA - 1).clamp(0, 99)),
                            ),
                          ],
                        ),
                      ),

                      // Divider
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('–',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                color: Colors.red)),
                      ),

                      // Team B
                      Expanded(
                        child: Column(
                          children: [
                            Text(_teamB,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: AppColors.socaBlack)),
                            const SizedBox(height: 12),
                            _scoreStepper(
                              value: _scoreB,
                              onInc: () => setState(() => _scoreB++),
                              onDec: () =>
                                  setState(() => _scoreB = (_scoreB - 1).clamp(0, 99)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Match state selector
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Match State',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.socaBlack)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _states.map((s) {
                      final selected = s == _matchState;
                      return GestureDetector(
                        onTap: () => setState(() => _matchState = s),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected
                                ? (s == 'FINISH' ? Colors.red : AppColors.socaBlack)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: selected
                                  ? (s == 'FINISH' ? Colors.red : AppColors.socaBlack)
                                  : const Color(0xFFE0E0E0),
                            ),
                          ),
                          child: Text(
                            _stateLabels[s] ?? s,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: selected ? AppColors.socaYellow : AppColors.socaBlack,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Meta info
            if (widget.match != null) ...[
              _card(
                child: Wrap(
                  spacing: 14,
                  runSpacing: 6,
                  children: [
                    if (widget.match!.matchDate != null)
                      _metaChip(Icons.calendar_today, widget.match!.matchDate!),
                    if (widget.match!.matchTime != null)
                      _metaChip(Icons.access_time, widget.match!.matchTime!),
                    if (widget.match!.venue != null)
                      _metaChip(Icons.location_on, widget.match!.venue!),
                    if (widget.match!.ageGroup != null)
                      _metaChip(Icons.group, widget.match!.ageGroup!),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveUpdate,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _matchState == 'FINISH' ? Colors.red : AppColors.socaBlack,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: _isSaving
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : Text(
                        _matchState == 'FINISH' ? 'FINISH MATCH' : 'SAVE UPDATE',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreStepper({
    required int value,
    required VoidCallback onInc,
    required VoidCallback onDec,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stepBtn(Icons.remove, onDec),
        const SizedBox(width: 12),
        Text(
          '$value',
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: 32,
              color: Colors.red),
        ),
        const SizedBox(width: 12),
        _stepBtn(Icons.add, onInc),
      ],
    );
  }

  Widget _stepBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: AppColors.socaYellow, size: 20),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: child,
    );
  }

  Widget _infoText(String text) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Poppins', fontSize: 12, color: Colors.grey),
      );

  Widget _metaChip(IconData icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey),
          const SizedBox(width: 4),
          Text(text,
              style: const TextStyle(
                  fontFamily: 'Lato', fontSize: 12, color: Colors.grey)),
        ],
      );
}
