import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socaloca/core/constants/api_constants.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_loader.dart';
import '../../../shared/widgets/app_toast.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import 'referee_live_matches_screen.dart';

class _LivePlayer {
  const _LivePlayer({
    required this.id,
    required this.name,
    required this.teamId,
  });

  final String id;
  final String name;
  final String teamId;
}

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

  String get _teamA => widget.match?.teamA ?? AppStrings.teamA;
  String get _teamB => widget.match?.teamB ?? AppStrings.teamB;
  String get _tournamentId => widget.match?.tournamentId ?? '';
  String get _currentUserId => StorageService.userId ?? '';
  bool get _isTerminal =>
      _state == 'FINISH' || _state == 'POSTPONED' || _state == 'ABANDONED';
  bool get _isEditable =>
      _state == 'FIRST_HALF_START' ||
      _state == 'SECOND_HALF_START' ||
      _state == 'EXTRA_TIME_FH_START' ||
      _state == 'EXTRA_TIME_SH_START' ||
      _state == 'PENALTY';
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
      String? name = (map['shortNameAfterJersey'] ??
              map['playerName'] ??
              map['name'] ??
              map['shortName'] ??
              map['profileName'])
          ?.toString();
      if (name == null || name.isEmpty) {
        final first = map['firstName']?.toString() ?? '';
        final last = map['lastName']?.toString() ?? '';
        final combined = '$first $last'.trim();
        if (combined.isNotEmpty) name = combined;
      }
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
        return AppStrings.startSecondHalf.toUpperCase();
      case 'START_EXTRA_TIME':
        return AppStrings.startExtraTime.toUpperCase();
      case 'PENALTY_SHOOTOUT':
        return AppStrings.startPenalty.toUpperCase();
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

  Map<String, dynamic> _scoreKeyVals() => {
        'myGoals': _intVal(_liveRecord['myGoals']),
        'opponentGoals': _intVal(_liveRecord['opponentGoals']),
        'myPenalty': _intVal(_liveRecord['myPenalty']),
        'opponentPenalty': _intVal(_liveRecord['opponentPenalty']),
        'myExtraTime': _intVal(_liveRecord['myExtraTime']),
        'opponentExtraTime': _intVal(_liveRecord['opponentExtraTime']),
      };

  Future<void> _saveState(String nextState) async {
    if (_tournamentId.isEmpty || widget.matchId.isEmpty) return;
    if (_isStartState(nextState) &&
        (_teamAPlayers.isEmpty || _teamBPlayers.isEmpty)) {
      _showError(_teamAPlayers.isEmpty
          ? '$_teamA has no team players'
          : '$_teamB has no team players');
      return;
    }
    setState(() => _isSaving = true);
    final ok = await ref.read(refereeRepositoryProvider).saveLiveMatchState(
      matchId: widget.matchId,
      tournamentId: _tournamentId,
      state: nextState,
      keyVals: {..._scoreKeyVals(), ..._timestampKeyVals(nextState)},
    );
    if (!mounted) return;
    setState(() {
      _isSaving = false;
      if (ok) {
        _state = nextState;
        _liveRecord = {..._liveRecord, 'state': nextState};
        _applyState(nextState);
        if (nextState == 'POSTPONED' || nextState == 'ABANDONED') {
          _scoreA = 0;
          _scoreB = 0;
        }
      }
    });
    if (ok && nextState == 'FINISH') {
      AppToast.show(context, AppStrings.matchEndedSuccessfully);
    }
  }

  bool _isStartState(String state) =>
      state == 'FIRST_HALF_START' ||
      state == 'SECOND_HALF_START' ||
      state == 'EXTRA_TIME_FH_START' ||
      state == 'EXTRA_TIME_SH_START' ||
      state == 'PENALTY';

  Future<void> _saveCurrentEntry() async {
    if (_isPenaltyMode) {
      await _savePenalty();
    } else if (_tab == 'Cards') {
      await _saveCard();
    } else if (_tab == 'Substitution') {
      await _saveSubstitution();
    } else {
      await _saveGoal();
    }
  }

  Future<void> _saveGoal() async {
    final leftSelected = _goalAOwn || _goalAScorer != null;
    final rightSelected = _goalBOwn || _goalBScorer != null;
    if (leftSelected == rightSelected) {
      _showError(leftSelected
          ? AppStrings.selectScorerFromOneTeam
          : AppStrings.pleaseSelectScorer);
      return;
    }
    final isLeft = leftSelected;
    final time = _parseRequiredMinute(
        isLeft ? _goalATime : _goalBTime, 'Please select scoring time');
    if (time == null) return;
    if (!_validateEventMinute(time)) return;

    final isExtra =
        _state == 'EXTRA_TIME_FH_START' || _state == 'EXTRA_TIME_SH_START';
    final ownGoal = isLeft ? _goalAOwn : _goalBOwn;
    final scorer = isLeft ? _goalAScorer : _goalBScorer;
    final assist = isLeft ? _goalAAssist : _goalBAssist;
    final missed = isLeft ? _goalAPenaltyMissed : _goalBPenaltyMissed;
    final isPenalty = isLeft ? _goalAPenalty : _goalBPenalty;
    final creditedTeamId = ownGoal
        ? (isLeft ? widget.match?.teamBId : widget.match?.teamAId)
        : (isLeft ? widget.match?.teamAId : widget.match?.teamBId);
    if (creditedTeamId == null || creditedTeamId.isEmpty) {
      _showError(AppStrings.somethingWentWrong);
      return;
    }

    final keyVals = _scoreKeyVals();
    if (!missed) {
      final key = isExtra
          ? (creditedTeamId == widget.match?.teamAId
              ? 'myExtraTime'
              : 'opponentExtraTime')
          : (creditedTeamId == widget.match?.teamAId
              ? 'myGoals'
              : 'opponentGoals');
      keyVals[key] = _intVal(keyVals[key]) + 1;
    }
    final listVal = {
      'teamId': creditedTeamId,
      'goalTime': time,
      'ownGoal': ownGoal,
      'isPenalty': isPenalty,
      'missed': missed,
      'goalSequence':
          _nextSequence(isExtra ? 'extraTime' : 'goals', creditedTeamId),
      'addedBy': _currentUserId,
      'absoluteTime': DateTime.now().millisecondsSinceEpoch,
      if (!ownGoal) ...{
        'playerId': scorer?.id ?? '',
        'playerName': scorer?.name ?? '',
        'assistPlayerId': assist?.id ?? '',
        'assistPlayerName': assist?.name ?? '',
      },
    };
    await _saveEntry(
      entry: isExtra ? 'extratime' : 'goal',
      listKey: isExtra ? 'extraTime' : 'goals',
      keyVals: keyVals,
      listVal: listVal,
      afterSuccess: _clearGoalForm,
    );
  }

  Future<void> _savePenalty() async {
    final leftSelected = _goalAScorer != null;
    final rightSelected = _goalBScorer != null;
    if (leftSelected == rightSelected) {
      _showError(leftSelected
          ? AppStrings.selectScorerFromOneTeam
          : AppStrings.pleaseSelectScorer);
      return;
    }
    final player = leftSelected ? _goalAScorer! : _goalBScorer!;
    final missed = leftSelected ? _goalAPenaltyMissed : _goalBPenaltyMissed;
    final keyVals = {
      'myPenalty': _intVal(_liveRecord['myPenalty']),
      'opponentPenalty': _intVal(_liveRecord['opponentPenalty']),
    };
    if (!missed) {
      keyVals[leftSelected ? 'myPenalty' : 'opponentPenalty'] =
          _intVal(keyVals[leftSelected ? 'myPenalty' : 'opponentPenalty']) + 1;
    }
    await _saveEntry(
      entry: 'penalty',
      listKey: 'penalty',
      keyVals: keyVals,
      listVal: {
        'teamId': player.teamId,
        'playerId': player.id,
        'playerName': player.name,
        'isPenalty': true,
        'missed': missed,
        'goalSequence': _nextSequence('penalty', player.teamId),
        'addedBy': _currentUserId,
        'absoluteTime': DateTime.now().millisecondsSinceEpoch,
      },
      afterSuccess: _clearGoalForm,
    );
  }

  Future<void> _saveCard() async {
    final leftSelected = _cardAPlayer != null;
    final rightSelected = _cardBPlayer != null;
    if (leftSelected == rightSelected) {
      _showError(leftSelected
          ? AppStrings.selectCardHolderFromOneTeam
          : AppStrings.pleaseSelectCardHolder);
      return;
    }
    final type = leftSelected ? _cardAType : _cardBType;
    if (type.isEmpty) {
      _showError(AppStrings.pleaseSelectCardType);
      return;
    }
    final time = _parseRequiredMinute(
        leftSelected ? _cardATime : _cardBTime, AppStrings.pleaseSelectCardTime);
    if (time == null) return;
    if (!_validateEventMinute(time)) return;
    final player = leftSelected ? _cardAPlayer! : _cardBPlayer!;
    final validation = _validateCard(player, type);
    if (validation != null) {
      _showError(validation);
      return;
    }
    await _saveEntry(
      entry: 'card',
      listKey: 'cards',
      keyVals: _scoreKeyVals(),
      listVal: {
        'matchId': widget.matchId,
        'teamId': player.teamId,
        'playerId': player.id,
        'playerName': player.name,
        'cardTime': time,
        'firstYellowCard': type == 'first',
        'secondYellowCard': type == 'second',
        'redCard': type == 'red',
        'addedBy': _currentUserId,
        'absoluteTime': DateTime.now().millisecondsSinceEpoch,
      },
      afterSuccess: () {
        _clearCardForm();
        _loadLiveDetails();
      },
    );
  }

  Future<void> _saveSubstitution() async {
    final leftSelected = _subAIn != null || _subAOut != null;
    final rightSelected = _subBIn != null || _subBOut != null;
    if (leftSelected == rightSelected) {
      _showError(leftSelected
          ? AppStrings.selectSubstitutionFromOneTeam
          : AppStrings.pleaseSelectPlayersForSubstitution);
      return;
    }
    final playerIn = leftSelected ? _subAIn : _subBIn;
    final playerOut = leftSelected ? _subAOut : _subBOut;
    if (playerIn == null) {
      _showError(leftSelected
          ? AppStrings.pleaseSelectPlayerInForMyTeam
          : AppStrings.pleaseSelectPlayerInForOpponent);
      return;
    }
    if (playerOut == null) {
      _showError(leftSelected
          ? AppStrings.pleaseSelectPlayerOutForMyTeam
          : AppStrings.pleaseSelectPlayerOutForOpponent);
      return;
    }
    if (playerIn.id == playerOut.id) {
      _showError(AppStrings.playerInAndOutSame);
      return;
    }
    final time = _parseRequiredMinute(
        leftSelected ? _subATime : _subBTime, AppStrings.pleaseEnterSubstitutionTime);
    if (time == null) return;
    if (!_validateEventMinute(time)) return;
    await _saveEntry(
      entry: 'substitution',
      listKey: 'subs',
      keyVals: _scoreKeyVals(),
      listVal: {
        'teamId': playerIn.teamId,
        'time': time,
        'playerId': playerIn.id,
        'playerName': playerIn.name,
        'playerOutId': playerOut.id,
        'playerOutName': playerOut.name,
        'absoluteTime': DateTime.now().millisecondsSinceEpoch,
      },
      afterSuccess: _clearSubstitutionForm,
    );
  }

  Future<void> _saveEntry({
    required String entry,
    required String listKey,
    required Map<String, dynamic> keyVals,
    required Map<String, dynamic> listVal,
    required VoidCallback afterSuccess,
  }) async {
    if (_tournamentId.isEmpty || widget.matchId.isEmpty) return;
    setState(() => _isSaving = true);
    final ok = await ref.read(refereeRepositoryProvider).saveLiveMatchData(
      matchId: widget.matchId,
      tournamentId: _tournamentId,
      entry: entry,
      state: _state,
      keyVals: keyVals,
      listKey: listKey,
      listVal: [listVal],
    );
    if (!mounted) return;
    setState(() {
      _isSaving = false;
      if (ok) {
        _liveRecord = {..._liveRecord, ...keyVals};
        _syncScoresFromLiveRecord();
        afterSuccess();
      }
    });
  }

  int? _parseRequiredMinute(TextEditingController controller, String message) {
    final value = int.tryParse(controller.text.trim());
    if (value == null || value <= 0) {
      _showError(message);
      return null;
    }
    return value;
  }

  bool _validateEventMinute(int minute) {
    final current = int.tryParse(widget.match?.currentMinute ?? '') ?? 0;
    if (current > 0 && minute > current) {
      _showError(AppStrings.eventTimeTooLarge);
      return false;
    }
    return true;
  }

  int _nextSequence(String listKey, String teamId) {
    final list = _liveRecord[listKey];
    if (list is! List) return 1;
    return list.where((item) {
          final map = _asMap(item);
          return map['teamId']?.toString() == teamId;
        }).length +
        1;
  }

  String? _validateCard(_LivePlayer player, String type) {
    final cards = _liveRecord['cards'];
    if (cards is! List) return null;
    var hasFirst = false;
    var hasSecond = false;
    var hasRed = false;
    for (final item in cards) {
      final card = _asMap(item);
      final samePlayer = card['playerId']?.toString() == player.id ||
          card['playerName']?.toString().toLowerCase() ==
              player.name.toLowerCase();
      if (!samePlayer) continue;
      hasFirst = hasFirst || card['firstYellowCard'] == true;
      hasSecond = hasSecond || card['secondYellowCard'] == true;
      hasRed = hasRed || card['redCard'] == true;
    }
    if (hasRed) return '${player.name} already has a red card';
    if (hasSecond) return '${player.name} already has 2 yellow cards';
    if (type == 'second' && !hasFirst) {
      return 'Cannot give 2nd yellow without 1st yellow';
    }
    if (type == 'first' && hasFirst) {
      return '${player.name} already has 1st yellow card';
    }
    return null;
  }

  void _showError(String message) {
    AppToast.show(context, message);
  }

  void _clearGoalForm() {
    _goalATime.clear();
    _goalBTime.clear();
    _goalAOwn = false;
    _goalBOwn = false;
    _goalAPenalty = false;
    _goalBPenalty = false;
    _goalAPenaltyMissed = false;
    _goalBPenaltyMissed = false;
    _goalAScorer = null;
    _goalBScorer = null;
    _goalAAssist = null;
    _goalBAssist = null;
  }

  void _clearCardForm() {
    _cardATime.clear();
    _cardBTime.clear();
    _cardAType = '';
    _cardBType = '';
    _cardAPlayer = null;
    _cardBPlayer = null;
  }

  void _clearSubstitutionForm() {
    _subATime.clear();
    _subBTime.clear();
    _subAIn = null;
    _subBIn = null;
    _subAOut = null;
    _subBOut = null;
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
                  label: AppStrings.halfTime,
                  onTap: () {
                    context.pop();
                    _saveState(_matchHalf == 'START_EXTRA_TIME'
                        ? 'EXTRA_TIME_FH_END'
                        : 'FIRST_HALF_END');
                  },
                ),
              if (_matchHalf == 'SECOND_HALF')
                _StatusOption(
                  label: AppStrings.endSecondHalf,
                  onTap: () {
                    context.pop();
                    _saveState('SECOND_HALF_END');
                  },
                ),
              if (_matchHalf == 'SECOND_HALF_EXTRA_TIME')
                _StatusOption(
                  label: AppStrings.endExtraTime,
                  onTap: () {
                    context.pop();
                    _saveState('EXTRA_TIME_SH_END');
                  },
                ),
              if (_matchHalf == 'SECOND_HALF' || _state == 'PENALTY')
                _StatusOption(
                  label: AppStrings.endMatch,
                  onTap: () {
                    context.pop();
                    _confirmEndMatch();
                  },
                ),
              _StatusOption(
                label: AppStrings.postponed,
                onTap: () {
                  context.pop();
                  _saveState('POSTPONED');
                },
              ),
              _StatusOption(
                label: AppStrings.abandoned,
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
        title: Text(AppStrings.warning),
        content: Text(AppStrings.confirmEndMatch),
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
          if (_isSaving || _isLoadingDetails)
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
          _LiveEntryPanel(
            tab: penalty ? 'Penalty' : _tab,
            leftPlayers: _teamAPlayers,
            rightPlayers: _teamBPlayers,
            goalATime: _goalATime,
            goalBTime: _goalBTime,
            cardATime: _cardATime,
            cardBTime: _cardBTime,
            subATime: _subATime,
            subBTime: _subBTime,
            goalAOwn: _goalAOwn,
            goalBOwn: _goalBOwn,
            goalAPenalty: _goalAPenalty,
            goalBPenalty: _goalBPenalty,
            goalAPenaltyMissed: _goalAPenaltyMissed,
            goalBPenaltyMissed: _goalBPenaltyMissed,
            cardAType: _cardAType,
            cardBType: _cardBType,
            goalAScorer: _goalAScorer,
            goalBScorer: _goalBScorer,
            goalAAssist: _goalAAssist,
            goalBAssist: _goalBAssist,
            cardAPlayer: _cardAPlayer,
            cardBPlayer: _cardBPlayer,
            subAIn: _subAIn,
            subBIn: _subBIn,
            subAOut: _subAOut,
            subBOut: _subBOut,
            onGoalAOwn: (value) => setState(() => _goalAOwn = value),
            onGoalBOwn: (value) => setState(() => _goalBOwn = value),
            onGoalAPenalty: (value) => setState(() => _goalAPenalty = value),
            onGoalBPenalty: (value) => setState(() => _goalBPenalty = value),
            onGoalAPenaltyMissed: (value) =>
                setState(() => _goalAPenaltyMissed = value),
            onGoalBPenaltyMissed: (value) =>
                setState(() => _goalBPenaltyMissed = value),
            onGoalAScorer: (value) => setState(() => _goalAScorer = value),
            onGoalBScorer: (value) => setState(() => _goalBScorer = value),
            onGoalAAssist: (value) => setState(() => _goalAAssist = value),
            onGoalBAssist: (value) => setState(() => _goalBAssist = value),
            onCardAType: (value) => setState(() => _cardAType = value),
            onCardBType: (value) => setState(() => _cardBType = value),
            onCardAPlayer: (value) => setState(() => _cardAPlayer = value),
            onCardBPlayer: (value) => setState(() => _cardBPlayer = value),
            onSubAIn: (value) => setState(() => _subAIn = value),
            onSubBIn: (value) => setState(() => _subBIn = value),
            onSubAOut: (value) => setState(() => _subAOut = value),
            onSubBOut: (value) => setState(() => _subBOut = value),
          ),
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
                      onTap: _saveCurrentEntry),
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
        return AppStrings.postponed.toUpperCase();
      case 'ABANDONED':
        return AppStrings.abandoned.toUpperCase();
      default:
        return AppStrings.matchEnd.toUpperCase();
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
                          child: Text(
                            AppStrings.liveMatchUpdates,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.socaYellow,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.caution.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint(AppStrings.neverCloseAppDuringMatch),
                        const SizedBox(height: 8),
                        _buildBulletPoint(AppStrings.tapSaveAndPublishWhenSure),
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
                        Text(
                          AppStrings.score.toUpperCase(),
                          style: const TextStyle(
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
                        Text(
                          AppStrings.time.toUpperCase(),
                          style: const TextStyle(
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
      width: 80,
      height: 80,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      child: hasLogo
          ? Image.network(
              ApiConstants.getImageUrl(logoUrl)!,
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

class _LiveEntryPanel extends StatelessWidget {
  const _LiveEntryPanel({
    required this.tab,
    required this.leftPlayers,
    required this.rightPlayers,
    required this.goalATime,
    required this.goalBTime,
    required this.cardATime,
    required this.cardBTime,
    required this.subATime,
    required this.subBTime,
    required this.goalAOwn,
    required this.goalBOwn,
    required this.goalAPenalty,
    required this.goalBPenalty,
    required this.goalAPenaltyMissed,
    required this.goalBPenaltyMissed,
    required this.cardAType,
    required this.cardBType,
    required this.goalAScorer,
    required this.goalBScorer,
    required this.goalAAssist,
    required this.goalBAssist,
    required this.cardAPlayer,
    required this.cardBPlayer,
    required this.subAIn,
    required this.subBIn,
    required this.subAOut,
    required this.subBOut,
    required this.onGoalAOwn,
    required this.onGoalBOwn,
    required this.onGoalAPenalty,
    required this.onGoalBPenalty,
    required this.onGoalAPenaltyMissed,
    required this.onGoalBPenaltyMissed,
    required this.onGoalAScorer,
    required this.onGoalBScorer,
    required this.onGoalAAssist,
    required this.onGoalBAssist,
    required this.onCardAType,
    required this.onCardBType,
    required this.onCardAPlayer,
    required this.onCardBPlayer,
    required this.onSubAIn,
    required this.onSubBIn,
    required this.onSubAOut,
    required this.onSubBOut,
  });

  final String tab;
  final List<_LivePlayer> leftPlayers;
  final List<_LivePlayer> rightPlayers;
  final TextEditingController goalATime;
  final TextEditingController goalBTime;
  final TextEditingController cardATime;
  final TextEditingController cardBTime;
  final TextEditingController subATime;
  final TextEditingController subBTime;
  final bool goalAOwn;
  final bool goalBOwn;
  final bool goalAPenalty;
  final bool goalBPenalty;
  final bool goalAPenaltyMissed;
  final bool goalBPenaltyMissed;
  final String cardAType;
  final String cardBType;
  final _LivePlayer? goalAScorer;
  final _LivePlayer? goalBScorer;
  final _LivePlayer? goalAAssist;
  final _LivePlayer? goalBAssist;
  final _LivePlayer? cardAPlayer;
  final _LivePlayer? cardBPlayer;
  final _LivePlayer? subAIn;
  final _LivePlayer? subBIn;
  final _LivePlayer? subAOut;
  final _LivePlayer? subBOut;
  final ValueChanged<bool> onGoalAOwn;
  final ValueChanged<bool> onGoalBOwn;
  final ValueChanged<bool> onGoalAPenalty;
  final ValueChanged<bool> onGoalBPenalty;
  final ValueChanged<bool> onGoalAPenaltyMissed;
  final ValueChanged<bool> onGoalBPenaltyMissed;
  final ValueChanged<_LivePlayer?> onGoalAScorer;
  final ValueChanged<_LivePlayer?> onGoalBScorer;
  final ValueChanged<_LivePlayer?> onGoalAAssist;
  final ValueChanged<_LivePlayer?> onGoalBAssist;
  final ValueChanged<String> onCardAType;
  final ValueChanged<String> onCardBType;
  final ValueChanged<_LivePlayer?> onCardAPlayer;
  final ValueChanged<_LivePlayer?> onCardBPlayer;
  final ValueChanged<_LivePlayer?> onSubAIn;
  final ValueChanged<_LivePlayer?> onSubBIn;
  final ValueChanged<_LivePlayer?> onSubAOut;
  final ValueChanged<_LivePlayer?> onSubBOut;

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
    final players = isLeft ? leftPlayers : rightPlayers;
    switch (tab) {
      case 'Cards':
        return _CardsFields(
          selected: isLeft ? cardAType : cardBType,
          timeController: isLeft ? cardATime : cardBTime,
          players: players,
          selectedPlayer: isLeft ? cardAPlayer : cardBPlayer,
          onTypeSelected: isLeft ? onCardAType : onCardBType,
          onPlayerSelected: isLeft ? onCardAPlayer : onCardBPlayer,
        );
      case 'Substitution':
        return _SubstitutionFields(
          timeController: isLeft ? subATime : subBTime,
          players: players,
          playerIn: isLeft ? subAIn : subBIn,
          playerOut: isLeft ? subAOut : subBOut,
          onPlayerIn: isLeft ? onSubAIn : onSubBIn,
          onPlayerOut: isLeft ? onSubAOut : onSubBOut,
        );
      default:
        return _GoalFields(
          isPenaltyMode: tab == 'Penalty',
          players: players,
          timeController: isLeft ? goalATime : goalBTime,
          ownGoal: isLeft ? goalAOwn : goalBOwn,
          penalty: isLeft ? goalAPenalty : goalBPenalty,
          penaltyMissed: isLeft ? goalAPenaltyMissed : goalBPenaltyMissed,
          scorer: isLeft ? goalAScorer : goalBScorer,
          assist: isLeft ? goalAAssist : goalBAssist,
          onOwnGoal: isLeft ? onGoalAOwn : onGoalBOwn,
          onPenalty: isLeft ? onGoalAPenalty : onGoalBPenalty,
          onPenaltyMissed: isLeft ? onGoalAPenaltyMissed : onGoalBPenaltyMissed,
          onScorer: isLeft ? onGoalAScorer : onGoalBScorer,
          onAssist: isLeft ? onGoalAAssist : onGoalBAssist,
        );
    }
  }
}

class _GoalFields extends StatelessWidget {
  const _GoalFields({
    required this.isPenaltyMode,
    required this.players,
    required this.timeController,
    required this.ownGoal,
    required this.penalty,
    required this.penaltyMissed,
    required this.scorer,
    required this.assist,
    required this.onOwnGoal,
    required this.onPenalty,
    required this.onPenaltyMissed,
    required this.onScorer,
    required this.onAssist,
  });

  final bool isPenaltyMode;
  final List<_LivePlayer> players;
  final TextEditingController timeController;
  final bool ownGoal;
  final bool penalty;
  final bool penaltyMissed;
  final _LivePlayer? scorer;
  final _LivePlayer? assist;
  final ValueChanged<bool> onOwnGoal;
  final ValueChanged<bool> onPenalty;
  final ValueChanged<bool> onPenaltyMissed;
  final ValueChanged<_LivePlayer?> onScorer;
  final ValueChanged<_LivePlayer?> onAssist;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isPenaltyMode) ...[
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
          _TimeField(controller: timeController),
          const SizedBox(height: 10),
        ],
        if (penalty || isPenaltyMode) ...[
          _CheckRow(
            label: AppStrings.penaltyMissed,
            value: penaltyMissed,
            onChanged: onPenaltyMissed,
          ),
          const SizedBox(height: 10),
        ],
        if (!ownGoal)
          _DropdownBox(
            label: penalty || isPenaltyMode
                ? AppStrings.selectPlayer
                : AppStrings.selectScorer,
            players: players,
            selected: scorer,
            onChanged: onScorer,
          ),
        if (!ownGoal) const SizedBox(height: 10),
        if (!ownGoal && !penalty && !isPenaltyMode)
          _DropdownBox(
            label: AppStrings.selectAssist,
            players: players,
            selected: assist,
            onChanged: onAssist,
          ),
      ],
    );
  }
}

class _CardsFields extends StatelessWidget {
  const _CardsFields({
    required this.selected,
    required this.timeController,
    required this.players,
    required this.selectedPlayer,
    required this.onTypeSelected,
    required this.onPlayerSelected,
  });

  final String selected;
  final TextEditingController timeController;
  final List<_LivePlayer> players;
  final _LivePlayer? selectedPlayer;
  final ValueChanged<String> onTypeSelected;
  final ValueChanged<_LivePlayer?> onPlayerSelected;

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
              onSelected: onTypeSelected,
            ),
            const SizedBox(width: 2),
            _CardChoice(
              label: AppStrings.secondCard,
              value: 'second',
              selected: selected == 'second',
              color: AppColors.socaYellow,
              textColor: AppColors.socaBlack,
              onSelected: onTypeSelected,
            ),
            const SizedBox(width: 2),
            _CardChoice(
              label: AppStrings.redCardShort,
              value: 'red',
              selected: selected == 'red',
              color: Colors.red,
              textColor: Colors.white,
              onSelected: onTypeSelected,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _TimeField(controller: timeController),
        const SizedBox(height: 12),
        _DropdownBox(
          label: AppStrings.selectPlayer,
          players: players,
          selected: selectedPlayer,
          onChanged: onPlayerSelected,
        ),
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
  const _SubstitutionFields({
    required this.timeController,
    required this.players,
    required this.playerIn,
    required this.playerOut,
    required this.onPlayerIn,
    required this.onPlayerOut,
  });

  final TextEditingController timeController;
  final List<_LivePlayer> players;
  final _LivePlayer? playerIn;
  final _LivePlayer? playerOut;
  final ValueChanged<_LivePlayer?> onPlayerIn;
  final ValueChanged<_LivePlayer?> onPlayerOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TimeField(controller: timeController),
        const SizedBox(height: 12),
        _DirectionalLabel(label: AppStrings.playerIn, up: false),
        const SizedBox(height: 8),
        _DropdownBox(
          label: AppStrings.selectInPlayer,
          players: players,
          selected: playerIn,
          onChanged: onPlayerIn,
        ),
        const SizedBox(height: 12),
        _DirectionalLabel(label: AppStrings.playerOut, up: true),
        const SizedBox(height: 8),
        _DropdownBox(
          label: AppStrings.selectOutPlayer,
          players: players,
          selected: playerOut,
          onChanged: onPlayerOut,
        ),
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
        Image.asset(
          !up
              ? "assets/icons/ic_match_downarrow.png"
              : "assets/icons/ic_match_uparrow.png",
          width: 20,
          height: 20,
        )
        // Icon(
        //   up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        //   color: AppColors.socaBlack,
        //   size: 24,
        // ),
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
  const _TimeField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _InputBox(hint: 'Time', controller: controller)),
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
  const _InputBox({required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
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
  const _DropdownBox({
    required this.label,
    this.players = const [],
    this.selected,
    this.onChanged,
  });

  final String label;
  final List<_LivePlayer> players;
  final _LivePlayer? selected;
  final ValueChanged<_LivePlayer?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final display = selected?.name ?? label;
    return PopupMenuButton<_LivePlayer?>(
      enabled: players.isNotEmpty && onChanged != null,
      onSelected: onChanged,
      itemBuilder: (context) => [
        PopupMenuItem<_LivePlayer?>(
          value: null,
          child: Text(label),
        ),
        ...players.map(
          (player) => PopupMenuItem<_LivePlayer?>(
            value: player,
            child: Text(player.name),
          ),
        ),
      ],
      child: Container(
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
                display,
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
            Image.asset(
              "assets/images/dropdown.png",
              width: 16,
              height: 16,
            ),
          ],
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
