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
  bool _isLoadingDetails = false;
  Map<String, dynamic> _liveRecord = {};
  List<_LivePlayer> _teamAPlayers = const [];
  List<_LivePlayer> _teamBPlayers = const [];

  final _goalATime = TextEditingController();
  final _goalBTime = TextEditingController();
  final _cardATime = TextEditingController();
  final _cardBTime = TextEditingController();
  final _subATime = TextEditingController();
  final _subBTime = TextEditingController();

  bool _goalAOwn = false;
  bool _goalBOwn = false;
  bool _goalAPenalty = false;
  bool _goalBPenalty = false;
  bool _goalAPenaltyMissed = false;
  bool _goalBPenaltyMissed = false;
  String _cardAType = '';
  String _cardBType = '';
  _LivePlayer? _goalAScorer;
  _LivePlayer? _goalBScorer;
  _LivePlayer? _goalAAssist;
  _LivePlayer? _goalBAssist;
  _LivePlayer? _cardAPlayer;
  _LivePlayer? _cardBPlayer;
  _LivePlayer? _subAIn;
  _LivePlayer? _subBIn;
  _LivePlayer? _subAOut;
  _LivePlayer? _subBOut;

  @override
  void initState() {
    super.initState();
    final match = widget.match;
    _state = _normalizeState(match?.liveState);
    _scoreA = int.tryParse(match?.teamAScore ?? '0') ?? 0;
    _scoreB = int.tryParse(match?.teamBScore ?? '0') ?? 0;
    _applyState(_state);
    _loadLiveDetails();
  }

  @override
  void dispose() {
    _goalATime.dispose();
    _goalBTime.dispose();
    _cardATime.dispose();
    _cardBTime.dispose();
    _subATime.dispose();
    _subBTime.dispose();
    super.dispose();
  }

  String get _teamA => widget.match?.teamA ?? 'Team A';
  String get _teamB => widget.match?.teamB ?? 'Team B';
  String get _tournamentId => widget.match?.tournamentId ?? '';
  bool get _isTerminal =>
      _state == 'FINISH' || _state == 'POSTPONED' || _state == 'ABANDONED';
  bool get _isEditable => !_isTerminal && _state != 'INIT';
  bool get _isPenaltyMode => _state == 'PENALTY';
  bool get _showStartControls =>
      _state == 'INIT' ||
      _state == 'FIRST_HALF_END' ||
      _state == 'SECOND_HALF_END' ||
      _state == 'EXTRA_TIME_FH_END' ||
      _state == 'EXTRA_TIME_SH_END';

  Future<void> _loadLiveDetails() async {
    if (_tournamentId.isEmpty || widget.matchId.isEmpty) return;
    setState(() => _isLoadingDetails = true);
    final data = await ref.read(refereeRepositoryProvider).getLiveMatchData(
          matchId: widget.matchId,
          tournamentId: _tournamentId,
        );
    if (!mounted) return;
    setState(() {
      _isLoadingDetails = false;
      if (data == null) return;
      _liveRecord = _asMap(data['liveRecord']);
      _teamAPlayers = _extractPlayers(data, widget.match?.teamAId);
      _teamBPlayers = _extractPlayers(data, widget.match?.teamBId);
      final serverState = _liveRecord['state']?.toString();
      if (serverState != null && serverState.isNotEmpty) {
        _state = _normalizeState(serverState);
        _applyState(_state);
      }
      _syncScoresFromLiveRecord();
    });
  }

  void _syncScoresFromLiveRecord() {
    final myGoals = _intVal(_liveRecord['myGoals']);
    final oppGoals = _intVal(_liveRecord['opponentGoals']);
    final myExtra = _intVal(_liveRecord['myExtraTime']);
    final oppExtra = _intVal(_liveRecord['opponentExtraTime']);
    final myPenalty = _intVal(_liveRecord['myPenalty']);
    final oppPenalty = _intVal(_liveRecord['opponentPenalty']);
    if (_isPenaltyMode) {
      _scoreA = myPenalty;
      _scoreB = oppPenalty;
    } else if (_state == 'ABANDONED' || _state == 'POSTPONED') {
      _scoreA = 0;
      _scoreB = 0;
    } else {
      _scoreA = myGoals + myExtra;
      _scoreB = oppGoals + oppExtra;
    }
  }

  Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return {};
  }

  int _intVal(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  List<_LivePlayer> _extractPlayers(Map<String, dynamic> data, String? teamId) {
    if (teamId == null || teamId.isEmpty) return const [];
    final found = <String, _LivePlayer>{};

    void walk(Object? value) {
      if (value is List) {
        for (final item in value) {
          walk(item);
        }
        return;
      }
      if (value is! Map) return;
      final map = _asMap(value);
      final playerId =
          (map['playerId'] ?? map['userId'] ?? map['_id'] ?? map['id'])
              ?.toString();
      final mapTeamId = (map['teamId'] ?? map['teamID'])?.toString();
      final name = (map['shortNameAfterJersey'] ??
              map['playerName'] ??
              map['name'] ??
              map['shortName'] ??
              map['profileName'])
          ?.toString();
      if (playerId != null &&
          playerId.isNotEmpty &&
          mapTeamId == teamId &&
          name != null &&
          name.isNotEmpty) {
        found[playerId] = _LivePlayer(
          id: playerId,
          name: name.replaceAll('#', ''),
          teamId: teamId,
        );
      }
      for (final child in map.values) {
        walk(child);
      }
    }

    walk(data['matchDetails'] ?? data);
    return found.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

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
      backgroundColor: Colors.grey.shade50,
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
          Center(
            child: SizedBox(
              width: 220,
              child: _WideButton(
                label: _startButtonLabel,
                filled: true,
                onTap: () => _saveState(_startNextState()),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: _WideButton(
              label: AppStrings.abandonMatch.toUpperCase(),
              filled: false,
              onTap: () => _saveState('ABANDONED'),
            ),
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
            title,
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
            teamALogo: widget.match?.teamALogo,
            teamBLogo: widget.match?.teamBLogo,
            scoreA: _scoreA,
            scoreB: _scoreB,
          ),
          const SizedBox(height: 18),
          _LiveEntryPanel(tab: penalty ? 'Penalty' : _tab),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: 230,
                  child: _InlineButton(
                      label: AppStrings.saveAndPublish.toUpperCase(),
                      filled: true,
                      onTap: () => _saveState(_state)),
                ),
                const SizedBox(width: 10),
                const SizedBox(height: 12),
                SizedBox(
                  width: 230,
                  child: _InlineButton(
                    label: AppStrings.matchStatus.toUpperCase(),
                    filled: false,
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
          color: Colors.white,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 20, bottom: 20, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: const BoxDecoration(
                            color: AppColors.socaBlack,
                          ),
                          child: const Text(
                            'Live Match Updates',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.socaYellow,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'CAUTION',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint(
                            'Never close the app while the match is live'),
                        const SizedBox(height: 8),
                        _buildBulletPoint(
                            'Tap "SAVE & PUBLISH" only when you are sure'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.grey.shade400,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SCORE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$scoreA : $scoreB',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            color: AppColors.socaBlack,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'TIME',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/icons/ic_clock_old.png",
                              width: 28,
                              height: 28,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '00:00',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stateTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 54,
          color: AppColors.playedGray,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      match?.tournamentName ?? 'Tournament Name',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 1, color: AppColors.socaBlack),
              Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      (match?.matchDate ?? '') + (match?.matchTime ?? ''),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.adjust, size: 14, color: AppColors.socaBlack),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
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
    required this.teamALogo,
    required this.teamBLogo,
    required this.scoreA,
    required this.scoreB,
  });

  final String teamA;
  final String teamB;
  final String? teamALogo;
  final String? teamBLogo;
  final int scoreA;
  final int scoreB;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _TeamScore(name: teamA, logoUrl: teamALogo)),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              '$scoreA:$scoreB',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          Expanded(child: _TeamScore(name: teamB, logoUrl: teamBLogo)),
        ],
      ),
    );
  }
}

class _TeamScore extends StatelessWidget {
  const _TeamScore({
    required this.name,
    required this.logoUrl,
  });

  final String name;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final displayName = name.trim().isEmpty ? AppStrings.na : name.trim();
    final parts = displayName.split(' ');
    final shortName = parts.length > 1 ? parts.last : displayName;

    return Column(
      children: [
        _TeamLogo(logoUrl: logoUrl),
        const SizedBox(height: 8),
        Text(
          displayName,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.socaBlack,
          ),
        ),
        Text(
          '($shortName)',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({required this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final hasLogo = logoUrl != null && logoUrl!.trim().isNotEmpty;
    return Container(
      width: 66,
      height: 66,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      child: hasLogo
          ? Image.network(
              logoUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const _TeamLogoFallback(),
            )
          : const _TeamLogoFallback(),
    );
  }
}

class _TeamLogoFallback extends StatelessWidget {
  const _TeamLogoFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.socaBlack,
      child: const Icon(Icons.shield, color: AppColors.socaYellow, size: 30),
    );
  }
}

class _LiveEntryPanel extends StatefulWidget {
  const _LiveEntryPanel({required this.tab});

  final String tab;

  @override
  State<_LiveEntryPanel> createState() => _LiveEntryPanelState();
}

class _LiveEntryPanelState extends State<_LiveEntryPanel> {
  bool _leftOwnGoal = false;
  bool _leftPenalty = false;
  bool _rightOwnGoal = false;
  bool _rightPenalty = false;
  String _leftCard = '';
  String _rightCard = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildSide(isLeft: true)),
            Container(
              width: 1,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color(0xFF312E2E),
            ),
            Expanded(child: _buildSide(isLeft: false)),
          ],
        ),
      ),
    );
  }

  Widget _buildSide({required bool isLeft}) {
    switch (widget.tab) {
      case 'Cards':
        return _CardsFields(
          selected: isLeft ? _leftCard : _rightCard,
          onSelected: (value) => setState(
            () => isLeft ? _leftCard = value : _rightCard = value,
          ),
        );
      case 'Substitution':
        return const _SubstitutionFields();
      default:
        return _GoalFields(
          ownGoal: isLeft ? _leftOwnGoal : _rightOwnGoal,
          penalty: isLeft ? _leftPenalty : _rightPenalty,
          onOwnGoal: (value) => setState(
            () => isLeft ? _leftOwnGoal = value : _rightOwnGoal = value,
          ),
          onPenalty: (value) => setState(
            () => isLeft ? _leftPenalty = value : _rightPenalty = value,
          ),
        );
    }
  }
}

class _GoalFields extends StatelessWidget {
  const _GoalFields({
    required this.ownGoal,
    required this.penalty,
    required this.onOwnGoal,
    required this.onPenalty,
  });

  final bool ownGoal;
  final bool penalty;
  final ValueChanged<bool> onOwnGoal;
  final ValueChanged<bool> onPenalty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CheckRow(
          label: AppStrings.ownGoal,
          value: ownGoal,
          onChanged: onOwnGoal,
        ),
        const SizedBox(height: 8),
        _CheckRow(
          label: AppStrings.penalty,
          value: penalty,
          onChanged: onPenalty,
        ),
        const SizedBox(height: 12),
        const _TimeField(),
        const SizedBox(height: 10),
        _DropdownBox(label: AppStrings.selectScorer),
        const SizedBox(height: 10),
        _DropdownBox(label: AppStrings.selectAssist),
      ],
    );
  }
}

class _CardsFields extends StatelessWidget {
  const _CardsFields({
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _CardChoice(
              label: AppStrings.firstCard,
              value: 'first',
              selected: selected == 'first',
              color: AppColors.socaYellow,
              textColor: AppColors.socaBlack,
              onSelected: onSelected,
            ),
            const SizedBox(width: 2),
            _CardChoice(
              label: AppStrings.secondCard,
              value: 'second',
              selected: selected == 'second',
              color: AppColors.socaYellow,
              textColor: AppColors.socaBlack,
              onSelected: onSelected,
            ),
            const SizedBox(width: 2),
            _CardChoice(
              label: AppStrings.redCardShort,
              value: 'red',
              selected: selected == 'red',
              color: Colors.red,
              textColor: Colors.white,
              onSelected: onSelected,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const _TimeField(),
        const SizedBox(height: 12),
        _DropdownBox(label: AppStrings.selectPlayer),
      ],
    );
  }
}

class _CardChoice extends StatelessWidget {
  const _CardChoice({
    required this.label,
    required this.value,
    required this.selected,
    required this.color,
    required this.textColor,
    required this.onSelected,
  });

  final String label;
  final String value;
  final bool selected;
  final Color color;
  final Color textColor;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onSelected(value),
            child: Container(
              height: 34,
              alignment: Alignment.center,
              color: color,
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: textColor,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onSelected(value),
            child: SizedBox(
              height: 34,
              child: Center(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade700, width: 1.5),
                  ),
                  child: selected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubstitutionFields extends StatelessWidget {
  const _SubstitutionFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TimeField(),
        const SizedBox(height: 12),
        _DirectionalLabel(label: AppStrings.playerIn, up: false),
        const SizedBox(height: 8),
        _DropdownBox(label: AppStrings.selectInPlayer),
        const SizedBox(height: 12),
        _DirectionalLabel(label: AppStrings.playerOut, up: true),
        const SizedBox(height: 8),
        _DropdownBox(label: AppStrings.selectOutPlayer),
      ],
    );
  }
}

class _DirectionalLabel extends StatelessWidget {
  const _DirectionalLabel({required this.label, required this.up});

  final String label;
  final bool up;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: AppColors.socaBlack,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Icon(
          up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: AppColors.socaBlack,
          size: 24,
        ),
      ],
    );
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              activeColor: AppColors.socaBlack,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (next) => onChanged(next ?? false),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: _InputBox(hint: 'Time')),
        const SizedBox(width: 8),
        Text(
          AppStrings.minutesShort,
          maxLines: 1,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: AppColors.socaBlack,
          ),
        ),
      ],
    );
  }
}

class _InputBox extends StatelessWidget {
  const _InputBox({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: AppStrings.literal(hint),
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.grey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: AppColors.socaBlack),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide:
                const BorderSide(color: AppColors.socaBlack, width: 1.2),
          ),
        ),
      ),
    );
  }
}

class _DropdownBox extends StatelessWidget {
  const _DropdownBox({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.socaBlack),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 30),
        ],
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
  const _InlineButton({
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
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: filled ? AppColors.socaBlack : Colors.white,
          foregroundColor: filled ? AppColors.socaYellow : AppColors.socaBlack,
          side: filled
              ? BorderSide.none
              : const BorderSide(color: AppColors.socaBlack),
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
