import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import 'referee_live_matches_screen.dart';

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
  String _state = 'INIT';
  String _matchHalf = 'FIRST_HALF';
  String _tab = 'Goals';
  int _scoreA = 0;
  int _scoreB = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final match = widget.match;
    _state = _normalizeState(match?.liveState);
    _scoreA = int.tryParse(match?.teamAScore ?? '0') ?? 0;
    _scoreB = int.tryParse(match?.teamBScore ?? '0') ?? 0;
    _applyState(_state);
  }

  String get _teamA => widget.match?.teamA ?? 'Team A';
  String get _teamB => widget.match?.teamB ?? 'Team B';
  String get _tournamentId => widget.match?.tournamentId ?? '';
  bool get _isTerminal =>
      _state == 'FINISH' || _state == 'POSTPONED' || _state == 'ABANDONED';
  bool get _isEditable => !_isTerminal && _state != 'INIT';
  bool get _showStartControls =>
      _state == 'INIT' ||
      _state == 'FIRST_HALF_END' ||
      _state == 'SECOND_HALF_END' ||
      _state == 'EXTRA_TIME_FH_END' ||
      _state == 'EXTRA_TIME_SH_END';

  String _normalizeState(String? value) {
    if (value == null || value.isEmpty || value == 'upcoming') return 'INIT';
    return value;
  }

  void _applyState(String state) {
    switch (state) {
      case 'FIRST_HALF_START':
        _matchHalf = 'FIRST_HALF';
        break;
      case 'FIRST_HALF_END':
        _matchHalf = 'SECOND_HALF';
        break;
      case 'SECOND_HALF_START':
        _matchHalf = 'SECOND_HALF';
        break;
      case 'SECOND_HALF_END':
        _matchHalf = 'START_EXTRA_TIME';
        break;
      case 'EXTRA_TIME_FH_START':
        _matchHalf = 'START_EXTRA_TIME';
        break;
      case 'EXTRA_TIME_FH_END':
        _matchHalf = 'SECOND_HALF_EXTRA_TIME';
        break;
      case 'EXTRA_TIME_SH_START':
        _matchHalf = 'SECOND_HALF_EXTRA_TIME';
        break;
      case 'EXTRA_TIME_SH_END':
        _matchHalf = 'PENALTY_SHOOTOUT';
        break;
      case 'PENALTY':
        _matchHalf = 'PENALTY_SHOOTOUT';
        _tab = 'Goals';
        break;
      case 'FINISH':
        _matchHalf = 'FINISH';
        break;
      default:
        _matchHalf = 'FIRST_HALF';
    }
  }

  String get _startButtonLabel {
    switch (_matchHalf) {
      case 'SECOND_HALF':
      case 'SECOND_HALF_EXTRA_TIME':
        return 'START SECOND HALF';
      case 'START_EXTRA_TIME':
        return 'START EXTRA TIME';
      case 'PENALTY_SHOOTOUT':
        return 'START PENALTY';
      default:
        return AppStrings.startMatch.toUpperCase();
    }
  }

  String _startNextState() {
    switch (_matchHalf) {
      case 'SECOND_HALF':
        return 'SECOND_HALF_START';
      case 'START_EXTRA_TIME':
        return 'EXTRA_TIME_FH_START';
      case 'SECOND_HALF_EXTRA_TIME':
        return 'EXTRA_TIME_SH_START';
      case 'PENALTY_SHOOTOUT':
        return 'PENALTY';
      default:
        return 'FIRST_HALF_START';
    }
  }

  Map<String, dynamic> _timestampKeyVals(String state) {
    final now = DateTime.now().millisecondsSinceEpoch;
    switch (state) {
      case 'FIRST_HALF_START':
        return {'firstHalfStartTime': now, 'startTimeGmt': now};
      case 'FIRST_HALF_END':
        return {'firstHalfEndTime': now};
      case 'SECOND_HALF_START':
        return {'secondHalfStartTime': now};
      case 'SECOND_HALF_END':
        return {'secondHalfEndTime': now};
      case 'EXTRA_TIME_FH_START':
        return {'extraTimeFhStartTime': now};
      case 'EXTRA_TIME_FH_END':
        return {'extraTimeFhEndTime': now};
      case 'EXTRA_TIME_SH_START':
        return {'extraTimeShStartTime': now};
      case 'EXTRA_TIME_SH_END':
        return {'extraTimeShEndTime': now};
      case 'PENALTY':
        return {'penaltyStartTime': now};
      case 'FINISH':
        return {'finishTime': now};
      case 'POSTPONED':
        return {'postponedTime': now};
      case 'ABANDONED':
        return {'abandonedTime': now};
      default:
        return {};
    }
  }

  Future<void> _saveState(String nextState) async {
    if (_tournamentId.isEmpty || widget.matchId.isEmpty) return;
    setState(() => _isSaving = true);
    final ok = await ref.read(refereeRepositoryProvider).saveLiveMatchState(
          matchId: widget.matchId,
          tournamentId: _tournamentId,
          state: nextState,
          keyVals: _timestampKeyVals(nextState),
        );
    if (!mounted) return;
    setState(() {
      _isSaving = false;
      if (ok) {
        _state = nextState;
        _applyState(nextState);
        if (nextState == 'POSTPONED' || nextState == 'ABANDONED') {
          _scoreA = 0;
          _scoreB = 0;
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Match updated successfully' : 'Update failed'),
        backgroundColor: ok ? AppColors.socaBlack : Colors.red,
      ),
    );
  }

  void _openStatusSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_matchHalf == 'FIRST_HALF' ||
                  _matchHalf == 'START_EXTRA_TIME')
                _StatusOption(
                  label: 'Half Time',
                  onTap: () {
                    context.pop();
                    _saveState(_matchHalf == 'START_EXTRA_TIME'
                        ? 'EXTRA_TIME_FH_END'
                        : 'FIRST_HALF_END');
                  },
                ),
              if (_matchHalf == 'SECOND_HALF')
                _StatusOption(
                  label: 'End Second Half',
                  onTap: () {
                    context.pop();
                    _saveState('SECOND_HALF_END');
                  },
                ),
              if (_matchHalf == 'SECOND_HALF_EXTRA_TIME')
                _StatusOption(
                  label: 'End Extra Time',
                  onTap: () {
                    context.pop();
                    _saveState('EXTRA_TIME_SH_END');
                  },
                ),
              if (_matchHalf == 'SECOND_HALF' || _state == 'PENALTY')
                _StatusOption(
                  label: 'End Match',
                  onTap: () {
                    context.pop();
                    _confirmEndMatch();
                  },
                ),
              _StatusOption(
                label: 'Postponed',
                onTap: () {
                  context.pop();
                  _saveState('POSTPONED');
                },
              ),
              _StatusOption(
                label: 'Abandoned',
                onTap: () {
                  context.pop();
                  _saveState('ABANDONED');
                },
              ),
              _StatusOption(label: AppStrings.cancel, onTap: context.pop),
            ],
          ),
        );
      },
    );
  }

  void _confirmEndMatch() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text('Are you sure you want to end this match?'),
        actions: [
          TextButton(onPressed: context.pop, child: Text(AppStrings.no)),
          TextButton(
            onPressed: () {
              context.pop();
              _saveState('FINISH');
            },
            child: Text(AppStrings.yes),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = liveMatchStateLabel(_state);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.socaBlack),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.liveMatches,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            top: false,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  _MatchSummary(
                    match: widget.match,
                    scoreA: _scoreA,
                    scoreB: _scoreB,
                    stateTitle: title,
                  ),
                  if (_showStartControls) _buildStartControls(),
                  if (_isTerminal) _TerminalState(label: _terminalLabel()),
                  if (_isEditable) _buildEditSection(title),
                ],
              ),
            ),
          ),
          if (_isSaving)
            const Positioned.fill(
              child: AbsorbPointer(
                child: ColoredBox(
                  color: Color(0x14000000),
                  child: AppLoader(size: 120),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStartControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
      child: Column(
        children: [
          _WideButton(
            label: _startButtonLabel,
            filled: true,
            onTap: () => _saveState(_startNextState()),
          ),
          const SizedBox(height: 20),
          _WideButton(
            label: AppStrings.abandonMatch.toUpperCase(),
            filled: false,
            onTap: () => _saveState('ABANDONED'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditSection(String title) {
    final penalty = _state == 'PENALTY';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.socaBlack,
            ),
          ),
          Container(
            width: 40,
            height: 2,
            margin: const EdgeInsets.only(top: 4, bottom: 16),
            color: AppColors.socaBlack,
          ),
          if (!penalty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _TabButton(
                    label: AppStrings.goals.toUpperCase(),
                    selected: _tab == 'Goals',
                    onTap: () => setState(() => _tab = 'Goals'),
                  ),
                  const SizedBox(width: 4),
                  _TabButton(
                    label: AppStrings.cards.toUpperCase(),
                    selected: _tab == 'Cards',
                    onTap: () => setState(() => _tab = 'Cards'),
                  ),
                  const SizedBox(width: 4),
                  _TabButton(
                    label: AppStrings.substitution.toUpperCase(),
                    selected: _tab == 'Substitution',
                    flex: 2,
                    onTap: () => setState(() => _tab = 'Substitution'),
                  ),
                ],
              ),
            ),
          Container(
            height: 2,
            margin: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            color: AppColors.socaBlack,
          ),
          _ScoreRow(
            teamA: _teamA,
            teamB: _teamB,
            scoreA: _scoreA,
            scoreB: _scoreB,
            onScoreA: (v) => setState(() => _scoreA = v),
            onScoreB: (v) => setState(() => _scoreB = v),
          ),
          const SizedBox(height: 24),
          _LiveEntryPanel(tab: penalty ? 'Penalty' : _tab),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _InlineButton(
                    label: AppStrings.saveAndPublish.toUpperCase(),
                    onTap: () => _saveState(_state),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InlineButton(
                    label: AppStrings.matchStatus.toUpperCase(),
                    onTap: _openStatusSheet,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }

  String _terminalLabel() {
    switch (_state) {
      case 'POSTPONED':
        return 'POSTPONED';
      case 'ABANDONED':
        return 'ABANDONED';
      default:
        return 'MATCH END';
    }
  }
}

class _MatchSummary extends StatelessWidget {
  const _MatchSummary({
    required this.match,
    required this.scoreA,
    required this.scoreB,
    required this.stateTitle,
  });

  final RefereeMatchModel? match;
  final int scoreA;
  final int scoreB;
  final String stateTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 54,
          color: const Color(0xFF767070),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Center(
                  child: Text(
                    match?.tournamentName ?? 'Tournament Name',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ),
              Container(width: 1, color: AppColors.socaBlack),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    match?.matchDate ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.socaBlack,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          stateTitle,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$scoreA : $scoreB',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: 30,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.teamA,
    required this.teamB,
    required this.scoreA,
    required this.scoreB,
    required this.onScoreA,
    required this.onScoreB,
  });

  final String teamA;
  final String teamB;
  final int scoreA;
  final int scoreB;
  final ValueChanged<int> onScoreA;
  final ValueChanged<int> onScoreB;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _TeamScore(name: teamA, score: scoreA, onChanged: onScoreA)),
        const Text(
          '-',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
            child: _TeamScore(name: teamB, score: scoreB, onChanged: onScoreB)),
      ],
    );
  }
}

class _TeamScore extends StatelessWidget {
  const _TeamScore({
    required this.name,
    required this.score,
    required this.onChanged,
  });

  final String name;
  final int score;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SmallButton(
              label: '-',
              onTap: () => onChanged((score - 1).clamp(0, 99)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '$score',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            _SmallButton(
              label: '+',
              onTap: () => onChanged((score + 1).clamp(0, 99)),
            ),
          ],
        ),
      ],
    );
  }
}

class _LiveEntryPanel extends StatelessWidget {
  const _LiveEntryPanel({required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.socaBlack),
          color: Colors.white,
        ),
        child: Text(
          tab == 'Penalty'
              ? 'PENALTY'
              : tab == 'Cards'
                  ? 'CARDS'
                  : tab == 'Substitution'
                      ? 'SUBSTITUTION'
                      : 'GOALS',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.socaBlack,
          ),
        ),
      ),
    );
  }
}

class _TerminalState extends StatelessWidget {
  const _TerminalState({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.socaBlack,
          ),
        ),
      ),
    );
  }
}

class _WideButton extends StatelessWidget {
  const _WideButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: filled ? 56 : 65,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: filled ? AppColors.socaBlack : Colors.white,
          foregroundColor: filled ? AppColors.socaYellow : AppColors.socaBlack,
          side: filled
              ? BorderSide.none
              : const BorderSide(color: AppColors.socaBlack),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class _InlineButton extends StatelessWidget {
  const _InlineButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.socaBlack,
          foregroundColor: AppColors.socaYellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
    this.flex = 1,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.socaBlack,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: selected ? AppColors.socaYellow : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  const _SmallButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.socaBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.socaYellow,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          color: AppColors.socaBlack,
        ),
      ),
      onTap: onTap,
    );
  }
}
