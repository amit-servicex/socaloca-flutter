import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socaloca/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/referee_match_model.dart';
import '../providers/referee_providers.dart';
import 'package:socaloca/shared/widgets/app_loader.dart';
import '../../../shared/widgets/app_toast.dart';

class RefereeManageMatchScreen extends ConsumerStatefulWidget {
  const RefereeManageMatchScreen({
    super.key,
    required this.matchId,
    required this.match,
  });

  final String matchId;
  final RefereeMatchModel? match;

  @override
  ConsumerState<RefereeManageMatchScreen> createState() =>
      _RefereeManageMatchScreenState();
}

class _RefereeManageMatchScreenState
    extends ConsumerState<RefereeManageMatchScreen> {
  bool _isLoadingDetails = true;
  String? _detailsError;
  Map<String, dynamic>? _details;
  bool _isSavingScore = false;
  bool _isSavingGoals = false;
  bool _isSavingCards = false;
  bool _isSavingMvp = false;
  bool _isSavingCleanSheet = false;
  bool _isSavingCoachManager = false;
  bool _isSavingOfficials = false;
  bool _isSavingSquad = false;
  bool _isSavingSubstitutes = false;
  bool _isSavingIncident = false;
  bool _isUploadingMedia = false;
  bool _isSavingPhotos = false;
  bool _isSavingHighlights = false;
  bool _isSavingMatchVideos = false;
  bool _isPublishingVideos = false;
  String _mediaStatus = '';

  // Score controllers
  final _scoreACtrl = TextEditingController();
  final _scoreBCtrl = TextEditingController();
  final _extraACtrl = TextEditingController(text: '0');
  final _extraBCtrl = TextEditingController(text: '0');
  final _penaltyACtrl = TextEditingController(text: '0');
  final _penaltyBCtrl = TextEditingController(text: '0');
  final _mySubsCountCtrl = TextEditingController();
  final _opponentSubsCountCtrl = TextEditingController();
  final _matchIncidentCtrl = TextEditingController();
  final _commissionerReportCtrl = TextEditingController();
  bool _showExtra = true;
  bool _showPenalty = true;

  // Goals/Cards/Penalty state
  final List<_GoalEntry> _goals = [];
  final List<_CardEntry> _cards = [];
  int _myCardCount = 0;
  int _opponentCardCount = 0;
  final List<_PenaltyEntry> _penalties = [];
  bool _isSavingPenalties = false;

  // Android manage-match detail state
  List<_ManageMember> _myPlayers = [];
  List<_ManageMember> _opponentPlayers = [];
  List<_ManageMember> _myAdmins = [];
  List<_ManageMember> _opponentAdmins = [];
  List<_MatchOfficial> _myOfficialOptions = [];
  List<_MatchOfficial> _opponentOfficialOptions = [];
  final Set<String> _selectedMyOfficials = {};
  final Set<String> _selectedOpponentOfficials = {};
  final Set<String> _selectedMySquad = {};
  final Set<String> _selectedOpponentSquad = {};
  List<_SubEntry> _mySubstitutes = [];
  List<_SubEntry> _opponentSubstitutes = [];
  List<_ManageMember> _mySubInPlayers = [];
  List<_ManageMember> _opponentSubInPlayers = [];
  final ImagePicker _imagePicker = ImagePicker();
  List<_MatchPhoto> _photos = [];
  List<_MatchVideoFile> _highlightVideos = [];
  List<_MatchVideoFile> _matchVideos = [];
  String? _detailTeamAName;
  String? _detailTeamBName;
  String? _detailTeamAShortName;
  String? _detailTeamBShortName;
  String? _detailMatchDate;
  String? _detailMatchTime;
  String? _detailVenue;
  String? _detailFieldName;

  String _mvpTeam = 'my';
  String? _selectedMvpPlayerId;
  String? _selectedMyCleanSheetPlayerId;
  String? _selectedOpponentCleanSheetPlayerId;
  String? _selectedMyCoachId;
  String? _selectedMyManagerId;
  String? _selectedOpponentCoachId;
  String? _selectedOpponentManagerId;

  @override
  void initState() {
    super.initState();
    final m = widget.match;
    if (m != null) {
      _scoreACtrl.text = m.teamAScore ?? '0';
      _scoreBCtrl.text = m.teamBScore ?? '0';
    }
    _loadDetails();
  }

  @override
  void dispose() {
    _scoreACtrl.dispose();
    _scoreBCtrl.dispose();
    _extraACtrl.dispose();
    _extraBCtrl.dispose();
    _penaltyACtrl.dispose();
    _penaltyBCtrl.dispose();
    _mySubsCountCtrl.dispose();
    _opponentSubsCountCtrl.dispose();
    _matchIncidentCtrl.dispose();
    _commissionerReportCtrl.dispose();
    for (final sub in [..._mySubstitutes, ..._opponentSubstitutes]) {
      sub.dispose();
    }
    for (final goal in _goals) {
      goal.dispose();
    }
    super.dispose();
  }

  Future<void> _loadDetails() async {
    setState(() {
      _isLoadingDetails = true;
      _detailsError = null;
    });
    try {
      final repo = ref.read(refereeRepositoryProvider);
      final details = await repo.getManageMatchDetails(
        matchId: widget.matchId,
        tournamentId: widget.match?.tournamentId ?? '',
      );
      if (!mounted) return;
      if (details == null) {
        setState(() {
          _isLoadingDetails = false;
          _detailsError = AppStrings.failedToLoadMatchDetails;
        });
        return;
      }
      setState(() {
        _details = details;
        _applyDetails(details);
        _isLoadingDetails = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingDetails = false;
        _detailsError = e.toString();
      });
    }
  }

  void _applyDetails(Map<String, dynamic> details) {
    final matchDetails =
        (details['matchDetails'] as Map?)?.cast<String, dynamic>() ?? details;
    final source = (details['source'] as Map?)?.cast<String, dynamic>() ?? {};
    final matchShort =
        (source['matchShort'] as Map?)?.cast<String, dynamic>() ??
            (details['matchShort'] as Map?)?.cast<String, dynamic>() ??
            {};
    final score = (details['score'] as Map?)?.cast<String, dynamic>() ??
        (matchDetails['score'] as Map?)?.cast<String, dynamic>() ??
        {};

    _applyBasicMatchInfo(matchDetails, source, matchShort, score);

    _myPlayers = _parseMembers(_firstList(
      source['myPlayerSet'],
      matchDetails['myPlayerSet'],
      source['myTeamPlayers'],
      matchDetails['myTeamPlayers'],
    ));
    _opponentPlayers = _parseMembers(_firstList(
      source['opponentTeamPlayers'],
      source['oppoPlayerSet'],
      matchDetails['opponentTeamPlayers'],
      matchDetails['oppoPlayerSet'],
    ));
    _myAdmins =
        _parseMembers(_firstList(source['myAdmins'], matchDetails['myAdmins']));
    _opponentAdmins = _parseMembers(
        _firstList(source['oppoAdmins'], matchDetails['oppoAdmins']));
    _mySubInPlayers =
        _parseMembers(_firstList(source['mySubs'], matchDetails['mySubs']));
    _opponentSubInPlayers =
        _parseMembers(_firstList(source['oppoSubs'], matchDetails['oppoSubs']));
    if (_mySubInPlayers.isEmpty) _mySubInPlayers = _myPlayers;
    if (_opponentSubInPlayers.isEmpty) _opponentSubInPlayers = _opponentPlayers;

    _selectedMyCoachId = _idFromObject(matchDetails['myCoach']);
    _selectedMyManagerId = _idFromObject(matchDetails['myManager']);
    _selectedOpponentCoachId = _idFromObject(matchDetails['oppoCoach']);
    _selectedOpponentManagerId = _idFromObject(matchDetails['oppoManager']);

    _myOfficialOptions = _parseOfficials(_firstList(
      source['myTeamOfficials'],
      matchDetails['myTeamOfficials'],
    ));
    _opponentOfficialOptions = _parseOfficials(_firstList(
      source['oppoTeamOfficials'],
      matchDetails['oppoTeamOfficials'],
    ));
    _selectedMyOfficials
      ..clear()
      ..addAll(_parseOfficials(matchDetails['myOfficials']).map((e) => e.key));
    _selectedOpponentOfficials
      ..clear()
      ..addAll(
          _parseOfficials(matchDetails['oppoOfficials']).map((e) => e.key));
    _selectedMySquad
      ..clear()
      ..addAll(_parseSavedSquadIds(matchDetails['myPlayers']));
    _selectedOpponentSquad
      ..clear()
      ..addAll(_parseSavedSquadIds(matchDetails['opponentPlayers']));

    for (final sub in [..._mySubstitutes, ..._opponentSubstitutes]) {
      sub.dispose();
    }
    final parsedSubs = _parseSubstitutes(details, matchDetails, source);
    _mySubstitutes = parsedSubs.$1;
    _opponentSubstitutes = parsedSubs.$2;
    _mySubsCountCtrl.text =
        _mySubstitutes.isEmpty ? '' : _mySubstitutes.length.toString();
    _opponentSubsCountCtrl.text = _opponentSubstitutes.isEmpty
        ? ''
        : _opponentSubstitutes.length.toString();

    final mvpTeamId = _stringValue(matchDetails['mvpTeamId']);
    final myTeamId = _myTeamId;
    if (mvpTeamId.isNotEmpty && mvpTeamId != myTeamId) {
      _mvpTeam = 'opponent';
    }
    _selectedMvpPlayerId = _stringValue(matchDetails['mvpPlayerId']);
    _selectedMyCleanSheetPlayerId =
        _stringValue(matchDetails['myTeamCleanSheet']);
    _selectedOpponentCleanSheetPlayerId =
        _stringValue(matchDetails['oppoTeamCleanSheet']);

    final refIncident =
        (matchDetails['refIncident'] as Map?)?.cast<String, dynamic>() ?? {};
    _matchIncidentCtrl.text = _stringValue(refIncident['desc']);
    _commissionerReportCtrl.text = _stringValue(matchDetails['commIncident']);

    final gallery = (source['gallery'] as Map?)?.cast<String, dynamic>() ??
        (matchDetails['gallery'] as Map?)?.cast<String, dynamic>() ??
        {};
    _photos = _parsePhotos(gallery['photos']);
    _highlightVideos = _parseVideos(gallery['videos']);
    _matchVideos = _parseVideos(gallery['largeVideos']);
    _syncGoalCountsToScore();
    _syncPenaltyCountsToScore();
  }

  void _applyBasicMatchInfo(
    Map<String, dynamic> matchDetails,
    Map<String, dynamic> source,
    Map<String, dynamic> matchShort,
    Map<String, dynamic> score,
  ) {
    _scoreACtrl.text = _stringValue(score['myGoals']).isNotEmpty
        ? _stringValue(score['myGoals'])
        : _scoreACtrl.text;
    _scoreBCtrl.text = _stringValue(score['opponentGoals']).isNotEmpty
        ? _stringValue(score['opponentGoals'])
        : _scoreBCtrl.text;
    _extraACtrl.text = _stringValue(score['myExtraTime']).isNotEmpty
        ? _stringValue(score['myExtraTime'])
        : _extraACtrl.text;
    _extraBCtrl.text = _stringValue(score['opponentExtraTime']).isNotEmpty
        ? _stringValue(score['opponentExtraTime'])
        : _extraBCtrl.text;
    _penaltyACtrl.text = _stringValue(score['myPenalty']).isNotEmpty
        ? _stringValue(score['myPenalty'])
        : _penaltyACtrl.text;
    _penaltyBCtrl.text = _stringValue(score['opponentPenalty']).isNotEmpty
        ? _stringValue(score['opponentPenalty'])
        : _penaltyBCtrl.text;

    _detailTeamAName = _nonEmpty(
      matchDetails['myTeamName'],
      _teamNameFromSource(source, _myTeamId),
      widget.match?.myTeam?.teamName,
      matchDetails['myTeamShortName'],
    );
    _detailTeamAShortName = _nonEmpty(
      matchDetails['myTeamShortName'],
      matchShort['myTeamShortName'],
      widget.match?.myTeam?.teamShortName,
    );
    _detailTeamBName = _nonEmpty(
      matchDetails['opponentTeamName'],
      _teamNameFromSource(source, _opponentTeamId),
      widget.match?.opponentTeam?.teamName,
      matchDetails['opponentTeamShortName'],
    );
    _detailTeamBShortName = _nonEmpty(
      matchDetails['opponentTeamShortName'],
      matchShort['opponentTeamShortName'],
      widget.match?.opponentTeam?.teamShortName,
    );
    _detailMatchDate = _nonEmpty(matchDetails['matchDate'],
        matchShort['matchDate'], widget.match?.matchDate);
    _detailMatchTime = _nonEmpty(matchDetails['matchTime'],
        matchShort['matchTime'], widget.match?.matchTime);
    _detailVenue = _nonEmpty(
      matchDetails['stadiumName'],
      matchShort['stadiumName'],
      matchDetails['locationName'],
      widget.match?.venue,
    );
    _detailFieldName = _nonEmpty(
      matchDetails['fieldName'],
      matchShort['fieldName'],
      widget.match?.fieldName,
    );

    for (final g in _goals) {
      g.dispose();
    }
    _goals
      ..clear()
      ..addAll(_parseGoalEntries(score['goals']));
    _cards
      ..clear()
      ..addAll(_parseCardEntries(score['cards']));
    _myCardCount = _cards.where((c) => c.team == _displayTeamA).length;
    _opponentCardCount = _cards.where((c) => c.team == _displayTeamB).length;
    _penalties
      ..clear()
      ..addAll(_parsePenaltyEntries(score['penalty']));
  }

  Set<String> _parseSavedSquadIds(dynamic raw) {
    if (raw is! List) return {};
    return raw
        .whereType<Map>()
        .map((item) => _stringValue(item['playerId']))
        .where((id) => id.isNotEmpty)
        .toSet();
  }

  (List<_SubEntry>, List<_SubEntry>) _parseSubstitutes(
    Map<String, dynamic> details,
    Map<String, dynamic> matchDetails,
    Map<String, dynamic> source,
  ) {
    final my = <_SubEntry>[];
    final opponent = <_SubEntry>[];

    void addFromList(dynamic raw, String fallbackTeamId) {
      if (raw is! List) return;
      for (final item in raw.whereType<Map>()) {
        final sub = _SubEntry.fromMap(
          item.cast<String, dynamic>(),
          fallbackTeamId: fallbackTeamId,
        );
        if (sub.teamId == _myTeamId) {
          my.add(sub);
        } else {
          opponent.add(sub);
        }
      }
    }

    final score = (details['score'] as Map?)?.cast<String, dynamic>() ??
        (matchDetails['score'] as Map?)?.cast<String, dynamic>() ??
        {};
    addFromList(score['subs'], '');
    if (opponent.isEmpty) {
      addFromList(matchDetails['oppoSubs'], _opponentTeamId);
    }

    my.sort((a, b) => a.seq.compareTo(b.seq));
    opponent.sort((a, b) => a.seq.compareTo(b.seq));
    return (my, opponent);
  }

  List<dynamic> _firstList(Object? first,
      [Object? second, Object? third, Object? fourth]) {
    for (final value in [first, second, third, fourth]) {
      if (value is List && value.isNotEmpty) return value;
    }
    return const [];
  }

  String? _nonEmpty(Object? first,
      [Object? second, Object? third, Object? fourth]) {
    for (final value in [first, second, third, fourth]) {
      final text = _stringValue(value);
      if (text.isNotEmpty) return text;
    }
    return null;
  }

  String? _teamNameFromSource(Map<String, dynamic> source, String teamId) {
    final teams = source['teams'];
    if (teams is! List) return null;
    for (final item in teams.whereType<Map>()) {
      final team = item.cast<String, dynamic>();
      if (_stringValue(team['teamId']) == teamId) {
        return _nonEmpty(team['teamName'], team['teamShortName']);
      }
    }
    return null;
  }

  List<_GoalEntry> _parseGoalEntries(dynamic raw) {
    if (raw is! List) return [];
    return raw.whereType<Map>().map((item) {
      final goal = item.cast<String, dynamic>();
      final teamId = _stringValue(goal['teamId']);
      final isOwnGoal = goal['ownGoal'] == true;
      final isPenaltyGoal = goal['isPenalty'] == true;
      final player = _nonEmpty(goal['playerName']) ?? '';
      return _GoalEntry(
        team: _teamLabelById(teamId),
        player: player,
        playerId: _stringValue(goal['playerId']),
        assistPlayerId: _stringValue(goal['assistPlayerId']),
        assistPlayerName: _stringValue(goal['assistPlayerName']),
        ownGoal: isOwnGoal,
        isPenalty: isPenaltyGoal,
        videoId: _stringValue(goal['videoId']),
        videoUrl: _stringValue(goal['videoUrl']),
        minute: _stringValue(goal['goalTime']),
      );
    }).toList();
  }

  void _syncGoalCountsToScore() {
    final scoreA = int.tryParse(_scoreACtrl.text) ?? 0;
    final scoreB = int.tryParse(_scoreBCtrl.text) ?? 0;
    final teamA = _displayTeamA;
    final teamB = _displayTeamB;
    final myCount = _goals.where((g) => g.team == teamA).length;
    final oppCount = _goals.where((g) => g.team == teamB).length;
    for (int i = myCount; i < scoreA; i++) {
      _goals.add(_GoalEntry(team: teamA));
    }
    for (int i = oppCount; i < scoreB; i++) {
      _goals.add(_GoalEntry(team: teamB));
    }
  }

  List<_PenaltyEntry> _parsePenaltyEntries(dynamic raw) {
    if (raw is! List) return [];
    return raw.whereType<Map>().map((item) {
      final p = item.cast<String, dynamic>();
      final teamId = _stringValue(p['teamId']);
      return _PenaltyEntry(
        team: _teamLabelById(teamId),
        playerId: _stringValue(p['playerId']),
        playerName: _nonEmpty(p['playerName']) ?? '',
        missed: p['missed'] == true,
        videoId: _stringValue(p['videoId']),
        videoUrl: _stringValue(p['videoUrl']),
      );
    }).toList();
  }

  void _syncPenaltyCountsToScore() {
    final countA = int.tryParse(_penaltyACtrl.text) ?? 0;
    final countB = int.tryParse(_penaltyBCtrl.text) ?? 0;
    final teamA = _displayTeamA;
    final teamB = _displayTeamB;
    final myCount = _penalties.where((p) => p.team == teamA).length;
    final oppCount = _penalties.where((p) => p.team == teamB).length;
    for (int i = myCount; i < countA; i++) {
      _penalties.add(_PenaltyEntry(team: teamA));
    }
    for (int i = oppCount; i < countB; i++) {
      _penalties.add(_PenaltyEntry(team: teamB));
    }
  }

  List<_CardEntry> _parseCardEntries(dynamic raw) {
    if (raw is! List) return [];
    return raw.whereType<Map>().map((item) {
      final card = item.cast<String, dynamic>();
      final teamId = _stringValue(card['teamId']);
      final isRed = card['redCard'] == true;
      return _CardEntry(
        team: _teamLabelById(teamId),
        player:
            _nonEmpty(card['playerName'], card['name']) ?? AppStrings.player,
        playerId: _stringValue(card['playerId']),
        type: isRed
            ? 'red'
            : card['secondYellowCard'] == true
                ? 'secondYellow'
                : 'firstYellow',
      );
    }).toList();
  }

  String _teamLabelById(String teamId) {
    if (teamId.isNotEmpty && teamId == _opponentTeamId) {
      return _displayTeamB;
    }
    return _displayTeamA;
  }

  String _teamIdForLabel(String teamLabel) {
    if (teamLabel == _displayTeamB) return _opponentTeamId;
    return _myTeamId;
  }

  List<_MatchPhoto> _parsePhotos(dynamic raw) {
    if (raw is! List) return [];
    final photos = raw
        .whereType<Map>()
        .map((item) => _MatchPhoto.fromMap(item.cast<String, dynamic>()))
        .where((photo) => photo.imageUrl.isNotEmpty)
        .toList();
    photos.sort((a, b) => a.seq.compareTo(b.seq));
    return photos;
  }

  List<_MatchVideoFile> _parseVideos(dynamic raw) {
    if (raw is! List) return [];
    final videos = raw
        .whereType<Map>()
        .map((item) => _MatchVideoFile.fromMap(item.cast<String, dynamic>()))
        .where((video) => video.videoUrl.isNotEmpty)
        .toList();
    videos.sort((a, b) => a.seq.compareTo(b.seq));
    return videos;
  }

  List<_ManageMember> _parseMembers(dynamic raw) {
    if (raw is! List) return [];
    final members = raw
        .whereType<Map>()
        .map((item) => _ManageMember.fromMap(item.cast<String, dynamic>()))
        .where((item) => item.id.isNotEmpty)
        .toList();
    members.sort((a, b) {
      final jerseyA = int.tryParse(a.jersey);
      final jerseyB = int.tryParse(b.jersey);
      if (jerseyA != null && jerseyB != null) return jerseyA.compareTo(jerseyB);
      return a.label.compareTo(b.label);
    });
    return members;
  }

  List<_MatchOfficial> _parseOfficials(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => _MatchOfficial.fromMap(item.cast<String, dynamic>()))
        .where((item) => item.name.isNotEmpty || item.role.isNotEmpty)
        .toList();
  }

  String? _idFromObject(dynamic raw) {
    if (raw is! Map) return null;
    final data = raw.cast<String, dynamic>();
    final id = _stringValue(data['userId']);
    return id.isEmpty ? null : id;
  }

  String _stringValue(dynamic value) => value?.toString() ?? '';

  String get _matchType {
    final matchDetails =
        (_details?['matchDetails'] as Map?)?.cast<String, dynamic>() ?? {};
    final matchShort = ((_details?['source'] as Map?)?['matchShort'] as Map?)
            ?.cast<String, dynamic>() ??
        (_details?['matchShort'] as Map?)?.cast<String, dynamic>() ??
        {};
    final detailType = _stringValue(matchDetails['matchType']);
    if (detailType.isNotEmpty) return detailType;
    final shortType = _stringValue(matchShort['matchType']);
    if (shortType.isNotEmpty) return shortType;
    return _stringValue(_details?['matchType']);
  }

  String get _parentId {
    final matchDetails =
        (_details?['matchDetails'] as Map?)?.cast<String, dynamic>() ?? {};
    final detailParent = _stringValue(matchDetails['parentId']);
    if (detailParent.isNotEmpty) return detailParent;
    final score = (_details?['score'] as Map?)?.cast<String, dynamic>() ?? {};
    final scoreParent = _stringValue(score['parentId']);
    if (scoreParent.isNotEmpty) return scoreParent;
    final responseParent = _stringValue(_details?['parentId']);
    if (responseParent.isNotEmpty) return responseParent;
    return _stringValue(matchDetails['_id']);
  }

  String get _myTeamId {
    final matchDetails =
        (_details?['matchDetails'] as Map?)?.cast<String, dynamic>() ?? {};
    final matchShort = ((_details?['source'] as Map?)?['matchShort'] as Map?)
            ?.cast<String, dynamic>() ??
        {};
    return _nonEmpty(
          matchDetails['myTeamId'],
          matchShort['myTeamId'],
          widget.match?.teamAId,
          widget.match?.myTeamId,
        ) ??
        '';
  }

  String get _opponentTeamId {
    final matchDetails =
        (_details?['matchDetails'] as Map?)?.cast<String, dynamic>() ?? {};
    final matchShort = ((_details?['source'] as Map?)?['matchShort'] as Map?)
            ?.cast<String, dynamic>() ??
        {};
    return _nonEmpty(
          matchDetails['opponentTeamId'],
          matchShort['opponentTeamId'],
          widget.match?.teamBId,
          widget.match?.opponentTeamId,
        ) ??
        '';
  }

  String _formatWithShort(String? full, String? short) {
    final f = full ?? '';
    final s = short ?? '';
    if (f.isEmpty) return s.isEmpty ? '' : s;
    if (s.isEmpty || s == f) return f;
    return '$f ($s)';
  }

  String get _displayTeamA {
    final full = _detailTeamAName ??
        widget.match?.myTeam?.teamName ??
        widget.match?.teamA ??
        AppStrings.teamA;
    final short = _detailTeamAShortName ?? widget.match?.myTeam?.teamShortName;
    return _formatWithShort(full, short);
  }

  String get _displayTeamB {
    final full = _detailTeamBName ??
        widget.match?.opponentTeam?.teamName ??
        widget.match?.teamB ??
        AppStrings.teamB;
    final short =
        _detailTeamBShortName ?? widget.match?.opponentTeam?.teamShortName;
    return _formatWithShort(full, short);
  }

  Future<void> _saveScore() async {
    final a = _scoreValue(_scoreACtrl);
    final b = _scoreValue(_scoreBCtrl);
    final eA = _scoreValue(_extraACtrl);
    final eB = _scoreValue(_extraBCtrl);
    final pA = _scoreValue(_penaltyACtrl);
    final pB = _scoreValue(_penaltyBCtrl);
    if (a == null || b == null) {
      _showSnack(AppStrings.pleaseEnterScoreProperly, success: false);
      return;
    }
    if (_showExtra && (eA == null || eB == null)) {
      _showSnack(AppStrings.pleaseEnterExtraTimeDetails, success: false);
      return;
    }
    if (_showPenalty && (pA == null || pB == null)) {
      _showSnack(AppStrings.pleaseEnterPenaltyDetails, success: false);
      return;
    }

    setState(() => _isSavingScore = true);
    final repo = ref.read(refereeRepositoryProvider);
    var ok = await repo.saveMatchScore(
      matchId: widget.matchId,
      tournamentId: widget.match?.tournamentId ?? '',
      teamAScore: a,
      teamBScore: b,
      penaltyScore: _showPenalty,
      extraTimeScore: _showExtra,
    );
    if (ok && _showExtra) {
      ok = await repo.saveExtraTimeScore(
        matchId: widget.matchId,
        teamAScore: eA!,
        teamBScore: eB!,
      );
    }
    if (ok && _showPenalty) {
      ok = await repo.savePenaltyScore(
        matchId: widget.matchId,
        teamAScore: pA!,
        teamBScore: pB!,
      );
    }
    if (!mounted) return;
    setState(() => _isSavingScore = false);
    if (ok) {
      _showSnack(AppStrings.matchScoreSaved, success: true);
      _loadDetails();
    }
  }

  int? _scoreValue(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty || text.length > 2) return null;
    final value = int.tryParse(text);
    if (value == null || value < 0 || value > 99) return null;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.match;
    final teamA = _displayTeamA;
    final teamB = _displayTeamB;
    final isCompleted = m?.matchStatus == 'completed';

    return Scaffold(
      backgroundColor: AppColors.socaPageBg,
      body: _isLoadingDetails
          ? const AppLoader()
          : _detailsError != null
              ? _buildErrorState()
              : _buildManageReport(teamA, teamB, isCompleted),
    );
  }

  Widget _buildManageReport(String teamA, String teamB, bool isCompleted) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          _MatchHeader(
            match: widget.match,
            teamA: teamA,
            teamB: teamB,
            teamAScore: _scoreACtrl.text,
            teamBScore: _scoreBCtrl.text,
            matchDate: _detailMatchDate,
            matchTime: _detailMatchTime,
            venue: _detailVenue,
            fieldName: _detailFieldName,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildScoreTab(teamA, teamB, isCompleted),
                _sectionGap(),
                _buildGoalsTab(teamA, teamB),
                _sectionGap(),

                // Extra time toggle
                _expandableSection(
                  title: AppStrings.extraTime,
                  expanded: _showExtra,
                  onTap: () => setState(() => _showExtra = !_showExtra),
                  child: Row(
                    children: [
                      Expanded(
                          child: _scoreInput(
                              label: teamA, controller: _extraACtrl)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('–'.tr,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack)),
                      ),
                      Expanded(
                          child: _scoreInput(
                              label: teamB, controller: _extraBCtrl)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Penalty toggle
                _expandableSection(
                  title: AppStrings.penalty,
                  expanded: _showPenalty,
                  onTap: () => setState(() => _showPenalty = !_showPenalty),
                  child: Row(
                    children: [
                      Expanded(
                          child: _scoreInput(
                              label: teamA, controller: _penaltyACtrl)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('–'.tr,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.socaBlack)),
                      ),
                      Expanded(
                          child: _scoreInput(
                              label: teamB, controller: _penaltyBCtrl)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                if (_showPenalty) ...[
                  _buildPenaltyShootoutSection(teamA, teamB),
                  _sectionGap(),
                ],

                SizedBox(
                  // width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSavingScore ? null : _saveScore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: _isSavingScore
                        ? const AppLoader(size: 24, centered: false)
                        : Text('SAVE SCORE'.tr,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 13)),
                  ),
                ),
                _sectionGap(),

                _buildAwardsTab(teamA, teamB),
                _sectionGap(),
                _buildCardsTab(teamA, teamB),
                _sectionGap(),
                _buildSquadTab(teamA, teamB),
                _sectionGap(),
                _buildSubstitutesTab(teamA, teamB),
                _sectionGap(),
                _buildStaffTab(teamA, teamB),
                _sectionGap(),
                _buildOfficialsTab(teamA, teamB),
                _sectionGap(),

                _buildMediaTab(),
                _buildIncidentsTab(),
                _sectionGap(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionGap() => const SizedBox(height: 16);

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _detailsError ?? AppStrings.failedToLoadMatchDetails,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
              ),
              child: Text('Retry'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreTab(String teamA, String teamB, bool isCompleted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
              // color: Colors.white,
              // borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'SCORE'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            teamA,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _scoreBox(_scoreACtrl),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                        _scoreBox(_scoreBCtrl),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: Text(
                            teamB,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        _scoreACtrl.clear();
                        _scoreBCtrl.clear();
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.socaBlack,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'RESET'.tr,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: AppColors.socaYellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _scoreBox(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.socaBlack),
          borderRadius: BorderRadius.circular(6)),
      width: 50,
      height: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.socaBlack,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.socaBlack),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalsTab(String teamA, String teamB) {
    final teamAGoals = _goals.where((g) => g.team == teamA).toList();
    final teamBGoals = _goals.where((g) => g.team == teamB).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.socaBlack),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'GOALS'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              _buildTeamGoalSection(
                teamName: teamA,
                teamId: _myTeamId,
                opponentTeamId: _opponentTeamId,
                goals: teamAGoals,
                players: _myPlayers,
              ),
              _buildTeamGoalSection(
                teamName: teamB,
                teamId: _opponentTeamId,
                opponentTeamId: _myTeamId,
                goals: teamBGoals,
                players: _opponentPlayers,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSavingGoals ? null : _saveGoals,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: _isSavingGoals
                        ? const AppLoader(size: 24, centered: false)
                        : Text(
                            'SAVE ALL GOALS'.tr,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
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

  Widget _buildTeamGoalSection({
    required String teamName,
    required String teamId,
    required String opponentTeamId,
    required List<_GoalEntry> goals,
    required List<_ManageMember> players,
  }) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            teamName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        if (players.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: width * 0.55, // change as needed
                child: ElevatedButton(
                  onPressed: () async {
                    final ok = await ref
                        .read(refereeRepositoryProvider)
                        .matchSquadAlert(
                          teamId: teamId,
                          opponentTeamId: opponentTeamId,
                          tournamentId: widget.match?.tournamentId ?? '',
                          matchId: widget.matchId,
                        );

                    if (!mounted) return;

                    _showSnack(
                      ok
                          ? 'Team Manager is notified to update Match Squad'.tr
                          : AppStrings.somethingWentWrong,
                      success: ok,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.socaBlack,
                    foregroundColor: AppColors.socaYellow,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MATCH SQUAD ALERT'.tr,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.info_outline, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (goals.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'No goals — set the score first'.tr,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.socaBlack),
            ),
          )
        else
          ...goals.asMap().entries.map((e) => _buildGoalCard(
              index: e.key + 1, goal: e.value, players: players)),
      ],
    );
  }

  Widget _buildGoalCard({
    required int index,
    required _GoalEntry goal,
    required List<_ManageMember> players,
  }) {
    // Build ordinal with superscript suffix (e.g. "1ˢᵗ Goal")
    final num = index.toString();
    final suffix = _ordinalSuffix(index);

    const labelStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13,
      color: AppColors.socaBlack,
    );
    const rowHeight = 44.0;

    Widget labelCell(String text) => SizedBox(
          width: 70,
          child: Text(text, style: labelStyle),
        );

    Widget rowDivider() =>
        const Divider(height: 1, thickness: 0.8, color: AppColors.socaBlack);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(color: const Color(0xFFDDDDDD)),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row: "1st Goal"  |  Own Goal □  |  Penalty □ ──────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: num,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Text(
                          suffix,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: '  ${'Goal'.tr}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                _goalCheckbox(
                  label: 'Own Goal'.tr,
                  value: goal.ownGoal,
                  onChanged: (v) => setState(() {
                    goal.ownGoal = v ?? false;
                    if (goal.ownGoal) goal.isPenalty = false;
                  }),
                ),
                const SizedBox(width: 10),
                _goalCheckbox(
                  label: 'penalty'.tr,
                  value: goal.isPenalty,
                  onChanged: (v) => setState(() {
                    goal.isPenalty = v ?? false;
                    if (goal.isPenalty) goal.ownGoal = false;
                  }),
                ),
              ],
            ),
          ),
          // rowDivider(),

          // ── Time row ────────────────────────────────────────────────────
          SizedBox(
            height: rowHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  labelCell('Time'.tr),
                  SizedBox(
                    width: 60,
                    height: 50,
                    child: TextField(
                      controller: goal.minuteCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 6),
                        filled: true,
                        fillColor: AppColors.socaGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: AppColors.socaBlack, width: 0.8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: AppColors.socaBlack, width: 0.8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: AppColors.socaBlack, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '(Mins.)',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.socaBlack),
                  ),
                ],
              ),
            ),
          ),

          if (!goal.ownGoal) ...[
            // rowDivider(),
            // ── Scorer row ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(
                children: [
                  labelCell('Scorer'.tr),
                  Expanded(
                    child: _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: players,
                      value: goal.playerId.isEmpty ? null : goal.playerId,
                      onChanged: (id) {
                        final m = players.where((p) => p.id == id).firstOrNull;
                        setState(() {
                          goal.playerId = id ?? '';
                          goal.player = m?.shortName ?? '';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // rowDivider(),
            // ── Assist row ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(
                children: [
                  labelCell('Assist'.tr),
                  Expanded(
                    child: _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: players,
                      value: goal.assistPlayerId.isEmpty
                          ? null
                          : goal.assistPlayerId,
                      includeNone: true,
                      onChanged: (id) {
                        final m = id == null
                            ? null
                            : players.where((p) => p.id == id).firstOrNull;
                        setState(() {
                          goal.assistPlayerId = id ?? '';
                          goal.assistPlayerName = m?.shortName ?? '';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Upload video button ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: goal.videoUrl.isEmpty
                    ? () => _pickAndUploadGoalVideo(goal)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
                child: Text(
                  goal.videoUrl.isEmpty
                      ? 'UPLOAD VIDEO (MAX 50 MB)'.tr
                      : 'VIDEO UPLOADED'.tr,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),

          rowDivider(),
        ],
      ),
    );
  }

  String _ordinalSuffix(int n) {
    if (n % 100 >= 11 && n % 100 <= 13) return 'th';
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Widget _goalCheckbox({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.socaBlack,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack)),
      ],
    );
  }

  Future<void> _pickAndUploadGoalVideo(_GoalEntry goal) async {
    final picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return;
    if (!_isAllowedVideo(picked.path)) {
      _showSnack(AppStrings.pleaseSelectMp4OrMov, success: false);
      return;
    }
    final size = File(picked.path).lengthSync();
    if (_sizeInMb(size) > 50) {
      _showSnack('Video must be under 50 MB'.tr, success: false);
      return;
    }
    await _runMediaUpload(AppStrings.uploadingVideo, () async {
      final formData = FormData.fromMap({
        'metadata': '',
        'video': await MultipartFile.fromFile(
          picked.path,
          filename: picked.name,
          contentType: DioMediaType('application', 'octet-stream'),
        ),
      });
      final resp = await ApiClient.instance
          .uploadFile(ApiConstants.uploadVdo, formData: formData);
      final response =
          (resp['response'] as Map?)?.cast<String, dynamic>() ?? {};
      final videoUrl = response['videoUrl']?.toString() ?? '';
      final videoId = response['videoId']?.toString() ?? '';
      if (videoUrl.isEmpty || videoId.isEmpty) {
        throw Exception('Video not uploaded');
      }
      setState(() {
        goal.videoUrl = videoUrl;
        goal.videoId = videoId;
      });
    });
  }

  Future<void> _saveGoals() async {
    final goals = <Map<String, dynamic>>[];
    int seq = 1;
    for (final goal in _goals) {
      final goalTime = int.tryParse(goal.minuteCtrl.text.trim()) ?? 0;
      if (goalTime <= 0 && !goal.ownGoal) {
        _showSnack(
          'Please enter goal $seq details for ${goal.team}',
          success: false,
        );
        return;
      }
      if (!goal.ownGoal && goal.playerId.isEmpty) {
        _showSnack(
          'Please select scorer for goal $seq of ${goal.team}',
          success: false,
        );
        return;
      }
      final entry = <String, dynamic>{
        'goalSequence': seq,
        'teamId': _teamIdForLabel(goal.team),
        'ownGoal': goal.ownGoal,
        'isPenalty': goal.isPenalty,
        'goalTime': goalTime,
        'addedBy': StorageService.userId ?? '',
        'videoId': goal.videoId,
        'videoUrl': goal.videoUrl,
      };
      if (!goal.ownGoal) {
        entry['playerId'] = goal.playerId;
        entry['playerName'] = goal.player;
        entry['assistPlayerId'] = goal.assistPlayerId;
        entry['assistPlayerName'] = goal.assistPlayerName;
      }
      goals.add(entry);
      seq++;
    }

    setState(() => _isSavingGoals = true);
    final ok = await ref.read(refereeRepositoryProvider).saveMatchGoals(
          matchId: widget.matchId,
          tournamentId: widget.match?.tournamentId ?? '',
          matchType: _matchType,
          goals: goals,
        );
    if (!mounted) return;
    setState(() => _isSavingGoals = false);
    if (ok) _loadDetails();
  }

  Future<void> _savePenaltyAttempts() async {
    final entries = <Map<String, dynamic>>[];
    int seq = 1;
    for (final p in _penalties) {
      if (!p.missed && p.playerId.isEmpty) {
        _showSnack(
          'Please select a player for attempt $seq of ${p.team}',
          success: false,
        );
        return;
      }
      final entry = <String, dynamic>{
        'goalSequence': seq,
        'teamId': _teamIdForLabel(p.team),
        'ownGoal': false,
        'missed': p.missed,
        'goalTime': 0,
        'addedBy': StorageService.userId ?? '',
        'videoId': p.videoId,
        'videoUrl': p.videoUrl,
      };
      if (!p.missed) {
        entry['playerId'] = p.playerId;
        entry['playerName'] = p.playerName;
        entry['assistPlayerId'] = '';
        entry['assistPlayerName'] = '';
      }
      entries.add(entry);
      seq++;
    }

    setState(() => _isSavingPenalties = true);
    final ok = await ref.read(refereeRepositoryProvider).savePenaltyAttempts(
          matchId: widget.matchId,
          tournamentId: widget.match?.tournamentId ?? '',
          matchType: _matchType,
          goals: entries,
        );
    if (!mounted) return;
    setState(() => _isSavingPenalties = false);
    if (ok) _loadDetails();
  }

  // ── Penalty Shootout UI ───────────────────────────────────────────────────

  Widget _buildPenaltyShootoutSection(String teamA, String teamB) {
    final teamAAttempts = _penalties.where((p) => p.team == teamA).toList();
    final teamBAttempts = _penalties.where((p) => p.team == teamB).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.socaBlack),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                color: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'PENALTY SHOOTOUT'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              // Mini score row
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        teamA,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                    _scoreBox(_penaltyACtrl),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                    _scoreBox(_penaltyBCtrl),
                    Expanded(
                      child: Text(
                        teamB,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                  height: 1, thickness: 0.8, color: AppColors.socaBlack),
              const SizedBox(height: 8),
              // Team A attempts
              _buildPenaltyTeamSection(
                teamName: teamA,
                attempts: teamAAttempts,
                players: _myPlayers,
              ),
              // Team B attempts
              _buildPenaltyTeamSection(
                teamName: teamB,
                attempts: teamBAttempts,
                players: _opponentPlayers,
              ),
              // Buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            _isSavingPenalties ? null : _savePenaltyAttempts,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: _isSavingPenalties
                            ? const AppLoader(size: 22, centered: false)
                            : Text(
                                'SAVE ALL ATTEMPTS'.tr,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _penalties.clear();
                            _syncPenaltyCountsToScore();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socaBlack,
                          foregroundColor: AppColors.socaYellow,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          'RESET'.tr,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPenaltyTeamSection({
    required String teamName,
    required List<_PenaltyEntry> attempts,
    required List<_ManageMember> players,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            teamName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        if (attempts.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'No attempts — set the penalty score first'.tr,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: AppColors.socaBlack),
            ),
          )
        else
          ...attempts.asMap().entries.map((e) => _buildPenaltyAttemptCard(
              index: e.key + 1, attempt: e.value, players: players)),
      ],
    );
  }

  Widget _buildPenaltyAttemptCard({
    required int index,
    required _PenaltyEntry attempt,
    required List<_ManageMember> players,
  }) {
    final num = index.toString();
    final suffix = _ordinalSuffix(index);

    const labelStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13,
      color: AppColors.socaBlack,
    );

    Widget rowDivider() =>
        const Divider(height: 1, thickness: 0.8, color: AppColors.socaBlack);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: "1st Attempts"  |  penalty Missed □
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: num,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Text(
                          suffix,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: '  ${'Attempts'.tr}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                _goalCheckbox(
                  label: 'penalty Missed'.tr,
                  value: attempt.missed,
                  onChanged: (v) => setState(() {
                    attempt.missed = v ?? false;
                  }),
                ),
              ],
            ),
          ),
          // Attempt By row (hidden when missed)
          if (!attempt.missed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text('Attempt By'.tr, style: labelStyle),
                  ),
                  Expanded(
                    child: _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: players,
                      value: attempt.playerId.isEmpty ? null : attempt.playerId,
                      onChanged: (id) {
                        final m = players.where((p) => p.id == id).firstOrNull;
                        setState(() {
                          attempt.playerId = id ?? '';
                          attempt.playerName = m?.shortName ?? '';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          // Upload video button
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: attempt.videoUrl.isEmpty
                    ? () => _pickAndUploadPenaltyVideo(attempt)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socaBlack,
                  foregroundColor: AppColors.socaYellow,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
                child: Text(
                  attempt.videoUrl.isEmpty
                      ? 'UPLOAD VIDEO (MAX 50 MB)'.tr
                      : 'VIDEO UPLOADED'.tr,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          rowDivider(),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadPenaltyVideo(_PenaltyEntry attempt) async {
    final picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return;
    if (!_isAllowedVideo(picked.path)) {
      _showSnack(AppStrings.pleaseSelectMp4OrMov, success: false);
      return;
    }
    final size = File(picked.path).lengthSync();
    if (_sizeInMb(size) > 50) {
      _showSnack('Video must be under 50 MB'.tr, success: false);
      return;
    }
    await _runMediaUpload(AppStrings.uploadingVideo, () async {
      final formData = FormData.fromMap({
        'metadata': '',
        'video': await MultipartFile.fromFile(
          picked.path,
          filename: picked.name,
          contentType: DioMediaType('application', 'octet-stream'),
        ),
      });
      final resp = await ApiClient.instance
          .uploadFile(ApiConstants.uploadVdo, formData: formData);
      final response =
          (resp['response'] as Map?)?.cast<String, dynamic>() ?? {};
      final videoUrl = response['videoUrl']?.toString() ?? '';
      final videoId = response['videoId']?.toString() ?? '';
      if (videoUrl.isEmpty || videoId.isEmpty) {
        throw Exception('Video not uploaded');
      }
      setState(() {
        attempt.videoUrl = videoUrl;
        attempt.videoId = videoId;
      });
    });
  }

  Widget _buildCardsTab(String teamA, String teamB) {
    final teamACards = _cards.where((c) => c.team == teamA).toList();
    final teamBCards = _cards.where((c) => c.team == teamB).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.socaBlack),
          ),
          // clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'CARDS'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildTeamCardSection(
                teamName: teamA,
                cards: teamACards,
                count: _myCardCount,
                players: _myPlayers,
                onCountChanged: (n) => setState(() {
                  _myCardCount = n;
                  _cards.removeWhere((c) => c.team == teamA);
                  for (int i = 0; i < n; i++) {
                    _cards.add(_CardEntry(team: teamA));
                  }
                }),
              ),
              const SizedBox(height: 8),
              _buildTeamCardSection(
                teamName: teamB,
                cards: teamBCards,
                count: _opponentCardCount,
                players: _opponentPlayers,
                onCountChanged: (n) => setState(() {
                  _opponentCardCount = n;
                  _cards.removeWhere((c) => c.team == teamB);
                  for (int i = 0; i < n; i++) {
                    _cards.add(_CardEntry(team: teamB));
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSavingCards ? null : _saveCards,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: _isSavingCards
                        ? const AppLoader(size: 24, centered: false)
                        : Text(
                            'SAVE ALL CARDS'.tr,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
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

  Widget _buildTeamCardSection({
    required String teamName,
    required List<_CardEntry> cards,
    required int count,
    required List<_ManageMember> players,
    required ValueChanged<int> onCountChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            teamName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          // padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // "No of cards" row — 0-10 dropdown
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'No of cards',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.socaBlack),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: count,
                            isExpanded: true,
                            icon: Image.asset(
                              "assets/images/dropdown.png",
                              width: 16,
                              height: 16,
                            ),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: AppColors.socaBlack,
                            ),
                            items: List.generate(
                              11,
                              (i) => DropdownMenuItem(
                                value: i,
                                child: Text('$i'),
                              ),
                            ),
                            onChanged: (v) {
                              if (v != null) onCountChanged(v);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Text(
                        'Player',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                              child: _buildCardTypeButton(
                                  AppStrings.firstCard, true)),
                          const SizedBox(width: 2),
                          Expanded(
                              child: _buildCardTypeButton(
                                  AppStrings.secondCard, true)),
                          const SizedBox(width: 2),
                          Expanded(
                              child: _buildCardTypeButton(
                                  AppStrings.redCardShort, false)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColors.socaBlack,
                height: 1,
                thickness: .6,
              ),
              const SizedBox(height: 8),

              if (cards.isNotEmpty) ...[
                const SizedBox(height: 16),
                // Column header: Player | 1st | 2nd | Red
                // One row per card entry
                ...cards.map((card) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 8, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: _memberDropdown(
                                  hint: 'Select the player'.tr,
                                  members: players,
                                  value: card.playerId.isEmpty
                                      ? null
                                      : card.playerId,
                                  onChanged: (id) {
                                    final m = players
                                        .where((p) => p.id == id)
                                        .firstOrNull;
                                    setState(() {
                                      card.playerId = id ?? '';
                                      card.player = m?.shortName ?? '';
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                flex: 4,
                                child: RadioGroup<String>(
                                  groupValue: card.type,
                                  onChanged: (v) => setState(
                                      () => card.type = v ?? card.type),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                          child: Radio<String>(
                                        value: 'firstYellow',
                                        activeColor: AppColors.socaBlack,
                                      )),
                                      Expanded(
                                          child: Radio<String>(
                                        value: 'secondYellow',
                                        activeColor: AppColors.socaBlack,
                                      )),
                                      Expanded(
                                          child: Radio<String>(
                                        value: 'red',
                                        activeColor: AppColors.socaBlack,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColors.socaBlack,
                          height: .6,
                          thickness: .6,
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    )),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _saveCards() async {
    final cards = <Map<String, dynamic>>[];
    for (final card in _cards) {
      if (card.playerId.isEmpty) {
        _showSnack('${AppStrings.pleaseEnterCardDetails} for ${card.team}',
            success: false);
        return;
      }
      cards.add({
        'teamId': _teamIdForLabel(card.team),
        'playerId': card.playerId,
        'playerName': card.player,
        'firstYellowCard': card.type == 'firstYellow',
        'secondYellowCard': card.type == 'secondYellow',
        'redCard': card.type == 'red',
      });
    }

    setState(() => _isSavingCards = true);
    final ok = await ref.read(refereeRepositoryProvider).saveMatchCards(
          matchId: widget.matchId,
          tournamentId: widget.match?.tournamentId ?? '',
          matchType: _matchType,
          cards: cards,
        );
    if (!mounted) return;
    setState(() => _isSavingCards = false);
    if (ok) _loadDetails();
  }

  Widget _buildCardTypeButton(String label, bool isYellow) {
    return Container(
      height: 40,
      width: 65,
      // padding: const EdgeInsets.symmetric(
      //   vertical: 16,
      // ),
      color: isYellow ? AppColors.socaYellow : AppColors.liveRed,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: isYellow ? AppColors.socaBlack : Colors.white,
        ),
      ),
    );
  }

  Widget _buildAwardsTab(String teamA, String teamB) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'CLEAN SHEET'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teamA,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: _myPlayers,
                      value: _selectedMyCleanSheetPlayerId,
                      includeNone: true,
                      onChanged: (value) =>
                          setState(() => _selectedMyCleanSheetPlayerId = value),
                      backgroundColor: const Color(0xFFEAEAEA),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      teamB,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: _opponentPlayers,
                      value: _selectedOpponentCleanSheetPlayerId,
                      includeNone: true,
                      onChanged: (value) => setState(
                          () => _selectedOpponentCleanSheetPlayerId = value),
                      backgroundColor: const Color(0xFFEAEAEA),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: InkWell(
                        onTap: _isSavingCleanSheet ? null : _saveCleanSheet,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _isSavingCleanSheet
                              ? const AppLoader(size: 20, centered: false)
                              : Text(
                                  'SAVE CLEAN SHEET'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          // clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.socaBlack,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'PLAYER OF THE MATCH'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Team A
                    InkWell(
                      onTap: () {
                        setState(() {
                          _mvpTeam = 'my';
                          _selectedMvpPlayerId = null;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            _mvpTeam == 'my'
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: AppColors.socaBlack,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              teamA,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: _myPlayers,
                      value: _mvpTeam == 'my' ? _selectedMvpPlayerId : null,
                      onChanged: (value) {
                        setState(() {
                          _mvpTeam = 'my';
                          _selectedMvpPlayerId = value;
                        });
                      },
                      backgroundColor: const Color(0xFFEAEAEA),
                    ),
                    const SizedBox(height: 24),
                    // Team B
                    InkWell(
                      onTap: () {
                        setState(() {
                          _mvpTeam = 'opponent';
                          _selectedMvpPlayerId = null;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            _mvpTeam == 'opponent'
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: AppColors.socaBlack,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              teamB,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.socaBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _memberDropdown(
                      hint: 'Select the player'.tr,
                      members: _opponentPlayers,
                      value:
                          _mvpTeam == 'opponent' ? _selectedMvpPlayerId : null,
                      onChanged: (value) {
                        setState(() {
                          _mvpTeam = 'opponent';
                          _selectedMvpPlayerId = value;
                        });
                      },
                      backgroundColor: const Color(0xFFEAEAEA),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: InkWell(
                        onTap: _isSavingMvp ? null : _saveMvp,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _isSavingMvp
                              ? const AppLoader(size: 20, centered: false)
                              : Text(
                                  'SAVE POM'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _saveMvp() async {
    final players = _mvpTeam == 'my' ? _myPlayers : _opponentPlayers;
    _ManageMember? player;
    for (final item in players) {
      if (item.id == _selectedMvpPlayerId) {
        player = item;
        break;
      }
    }
    if (player == null) {
      _showSnack(AppStrings.pleaseSelectPom, success: false);
      return;
    }
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingMvp = true);
    final ok = await repo.savePlayerOfTheMatch(
      matchId: widget.matchId,
      tournamentId: widget.match?.tournamentId ?? '',
      matchType: _matchType,
      mvpTeamId: _mvpTeam == 'my' ? _myTeamId : _opponentTeamId,
      mvpPlayerId: player.id,
      mvpPlayerName: player.shortName,
    );
    if (!mounted) return;
    setState(() => _isSavingMvp = false);
    if (ok) _loadDetails();
  }

  Widget _buildStaffTab(String teamA, String teamB) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'COACH/MANAGER'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.socaBlack),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  _buildStaffTeamSection(
                    teamName: teamA,
                    coachValue: _selectedMyCoachId,
                    managerValue: _selectedMyManagerId,
                    admins: _myAdmins,
                    onCoachChanged: (value) =>
                        setState(() => _selectedMyCoachId = value),
                    onManagerChanged: (value) =>
                        setState(() => _selectedMyManagerId = value),
                  ),
                  _buildStaffTeamSection(
                    teamName: teamB,
                    coachValue: _selectedOpponentCoachId,
                    managerValue: _selectedOpponentManagerId,
                    admins: _opponentAdmins,
                    onCoachChanged: (value) =>
                        setState(() => _selectedOpponentCoachId = value),
                    onManagerChanged: (value) =>
                        setState(() => _selectedOpponentManagerId = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: InkWell(
                        onTap: _isSavingCoachManager ? null : _saveCoachManager,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _isSavingCoachManager
                              ? const AppLoader(size: 20, centered: false)
                              : Text(
                                  'SAVE ALL COACH/MANAGER'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildStaffTeamSection({
    required String teamName,
    required String? coachValue,
    required String? managerValue,
    required List<_ManageMember> admins,
    required ValueChanged<String?> onCoachChanged,
    required ValueChanged<String?> onManagerChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            teamName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          color: const Color(0xFFF8F8F8),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.coach,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _memberDropdown(
                      hint: 'Select the coach'.tr,
                      members: admins,
                      value: coachValue,
                      includeNone: true,
                      onChanged: onCoachChanged,
                      backgroundColor: const Color(0xFFEAEAEA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.manager,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.socaBlack,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _memberDropdown(
                      hint: 'Select the manager'.tr,
                      members: admins,
                      value: managerValue,
                      includeNone: true,
                      onChanged: onManagerChanged,
                      backgroundColor: const Color(0xFFEAEAEA),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _saveCoachManager() async {
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingCoachManager = true);
    final ok = await repo.saveCoachManager(
      matchId: widget.matchId,
      myCoach: _selectedPayload(_myAdmins, _selectedMyCoachId),
      myManager: _selectedPayload(_myAdmins, _selectedMyManagerId),
      oppoCoach: _selectedPayload(_opponentAdmins, _selectedOpponentCoachId),
      oppoManager: _selectedPayload(
        _opponentAdmins,
        _selectedOpponentManagerId,
      ),
    );
    if (!mounted) return;
    setState(() => _isSavingCoachManager = false);
    if (ok) _loadDetails();
  }

  Map<String, dynamic>? _selectedPayload(
    List<_ManageMember> members,
    String? selectedId,
  ) {
    if (selectedId == null || selectedId.isEmpty) return null;
    for (final member in members) {
      if (member.id == selectedId) {
        return {'userId': member.userId, 'name': member.shortName};
      }
    }
    return null;
  }

  Widget _buildOfficialsTab(String teamA, String teamB) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'CLUB & TEAM OFFICIALS'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.socaBlack),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  _buildOfficialTeamSection(
                    teamName: teamA,
                    officials: _myOfficialOptions,
                    selected: _selectedMyOfficials,
                    onChanged: (key, checked) => setState(() {
                      checked
                          ? _selectedMyOfficials.add(key)
                          : _selectedMyOfficials.remove(key);
                    }),
                  ),
                  _buildOfficialTeamSection(
                    teamName: teamB,
                    officials: _opponentOfficialOptions,
                    selected: _selectedOpponentOfficials,
                    onChanged: (key, checked) => setState(() {
                      checked
                          ? _selectedOpponentOfficials.add(key)
                          : _selectedOpponentOfficials.remove(key);
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: InkWell(
                        onTap: _isSavingOfficials ? null : _saveOfficials,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _isSavingOfficials
                              ? const AppLoader(size: 20, centered: false)
                              : Text(
                                  'SAVE'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOfficialTeamSection({
    required String teamName,
    required List<_MatchOfficial> officials,
    required Set<String> selected,
    required void Function(String key, bool checked) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            teamName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        _officialsList(
          officials: officials,
          selected: selected,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _officialsList({
    required List<_MatchOfficial> officials,
    required Set<String> selected,
    required void Function(String key, bool checked) onChanged,
  }) {
    if (officials.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No officials available'.tr,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: AppColors.socaBlack),
        ),
      );
    }
    return Column(
      children: officials.map((official) {
        final label = official.role.isEmpty
            ? official.name
            : '${official.name} (${official.role})';
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: selected.contains(official.key),
                  onChanged: (checked) =>
                      onChanged(official.key, checked ?? false),
                  activeColor: AppColors.socaBlack,
                  checkColor: AppColors.socaYellow,
                  side: const BorderSide(color: AppColors.socaBlack),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> _saveOfficials() async {
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingOfficials = true);
    final ok = await repo.saveMatchOfficials(
      matchId: widget.matchId,
      myOfficials: _myOfficialOptions
          .where((official) => _selectedMyOfficials.contains(official.key))
          .map((official) => official.toPayload())
          .toList(),
      oppoOfficials: _opponentOfficialOptions
          .where(
              (official) => _selectedOpponentOfficials.contains(official.key))
          .map((official) => official.toPayload())
          .toList(),
    );
    if (!mounted) return;
    setState(() => _isSavingOfficials = false);
    if (ok) _showSnack(AppStrings.officialsProgressSaved, success: true);
  }

  Widget _buildSquadTab(String teamA, String teamB) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'SQUAD SELECTION'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.socaBlack)),
              child: Column(
                children: [
                  _buildSquadTeamSection(
                    teamName: teamA,
                    players: _myPlayers,
                    selected: _selectedMySquad,
                    onChanged: (id, checked) => setState(() {
                      checked
                          ? _selectedMySquad.add(id)
                          : _selectedMySquad.remove(id);
                    }),
                  ),
                  _buildSquadTeamSection(
                    teamName: teamB,
                    players: _opponentPlayers,
                    selected: _selectedOpponentSquad,
                    onChanged: (id, checked) => setState(() {
                      checked
                          ? _selectedOpponentSquad.add(id)
                          : _selectedOpponentSquad.remove(id);
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: InkWell(
                        onTap: _isSavingSquad ? null : _saveSquad,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.socaBlack,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _isSavingSquad
                              ? const AppLoader(size: 20, centered: false)
                              : Text(
                                  'SAVE SQUAD'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: AppColors.socaYellow,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildSquadTeamSection({
    required String teamName,
    required List<_ManageMember> players,
    required Set<String> selected,
    required void Function(String id, bool checked) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            teamName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        _squadList(
          players: players,
          selected: selected,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _squadList({
    required List<_ManageMember> players,
    required Set<String> selected,
    required void Function(String id, bool checked) onChanged,
  }) {
    if (players.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No players available'.tr,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 13, color: AppColors.socaBlack),
        ),
      );
    }
    return Column(
      children: players.map((player) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: selected.contains(player.playerId),
                  onChanged: (checked) =>
                      onChanged(player.playerId, checked ?? false),
                  activeColor: AppColors.socaBlack,
                  checkColor: AppColors.socaYellow,
                  side: const BorderSide(color: AppColors.socaBlack),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  player.label.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.socaBlack,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> _saveSquad() async {
    if (_selectedMySquad.isEmpty || _selectedOpponentSquad.isEmpty) {
      _showSnack(AppStrings.pleaseSelectPlayersFromBothTeams, success: false);
      return;
    }
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingSquad = true);
    final ok = await repo.saveMatchSquad(
      matchId: widget.matchId,
      tournamentId: widget.match?.tournamentId ?? '',
      myPlayers: _myPlayers
          .where((player) => _selectedMySquad.contains(player.playerId))
          .map((player) => player.toSquadPayload())
          .toList(),
      opponentPlayers: _opponentPlayers
          .where((player) => _selectedOpponentSquad.contains(player.playerId))
          .map((player) => player.toSquadPayload())
          .toList(),
    );
    if (!mounted) return;
    setState(() => _isSavingSquad = false);
    if (ok) _loadDetails();
  }

  Widget _buildSubstitutesTab(String teamA, String teamB) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'SUBSTITUTE'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          teamA,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: TextField(
                          controller: _mySubsCountCtrl,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.socaBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.socaBlack),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: TextField(
                          controller: _opponentSubsCountCtrl,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.socaBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.socaBlack),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          teamB,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.socaBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _generateSubstituteRows,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      'ADD SUBSTITUTE'.tr,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_mySubstitutes.isNotEmpty ||
                _opponentSubstitutes.isNotEmpty) ...[
              if (_mySubstitutes.isNotEmpty) ...[
                Container(
                  color: AppColors.socaBlack,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    teamA,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _substituteList(
                    entries: _mySubstitutes,
                    inPlayers: _mySubInPlayers,
                    outPlayers: _myPlayers,
                    teamId: _myTeamId,
                  ),
                ),
              ],
              if (_opponentSubstitutes.isNotEmpty) ...[
                Container(
                  color: AppColors.socaBlack,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    teamB,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _substituteList(
                    entries: _opponentSubstitutes,
                    inPlayers: _opponentSubInPlayers,
                    outPlayers: _opponentPlayers,
                    teamId: _opponentTeamId,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _isSavingSubstitutes ? null : _saveSubstitutes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socaBlack,
                      foregroundColor: AppColors.socaYellow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: _isSavingSubstitutes
                        ? const AppLoader(size: 20, centered: false)
                        : Text('SAVE SUBSTITUTES'.tr,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _substituteList({
    required List<_SubEntry> entries,
    required List<_ManageMember> inPlayers,
    required List<_ManageMember> outPlayers,
    required String teamId,
  }) {
    if (entries.isEmpty) {
      return Text(
        'No substitutes recorded'.tr,
        style: const TextStyle(
            fontFamily: 'Poppins', fontSize: 13, color: AppColors.socaBlack),
      );
    }
    return Column(
      children: entries
          .map((entry) => _substituteRow(
                entry: entry,
                inPlayers: inPlayers,
                outPlayers: outPlayers,
                teamId: teamId,
              ))
          .toList(),
    );
  }

  Widget _substituteRow({
    required _SubEntry entry,
    required List<_ManageMember> inPlayers,
    required List<_ManageMember> outPlayers,
    required String teamId,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_ordinal(entry.seq)} Substitute'.tr,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _memberDropdown(
                  hint: AppStrings.playerIn,
                  members: inPlayers,
                  value: entry.playerId,
                  onChanged: (value) => setState(() {
                    entry.playerId = value;
                    entry.playerName = _memberName(inPlayers, value);
                    entry.teamId = teamId;
                  }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _memberDropdown(
                  hint: AppStrings.playerOut,
                  members: outPlayers,
                  value: entry.playerOutId,
                  onChanged: (value) => setState(() {
                    entry.playerOutId = value;
                    entry.playerOutName = _memberName(outPlayers, value);
                    entry.teamId = teamId;
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: entry.timeCtrl,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(hint: AppStrings.minute),
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _generateSubstituteRows() {
    final myCount = int.tryParse(_mySubsCountCtrl.text.trim());
    final opponentCount = int.tryParse(_opponentSubsCountCtrl.text.trim());
    if (myCount == null || opponentCount == null) {
      _showSnack(AppStrings.pleaseEnterSubstituteDetails, success: false);
      return;
    }
    setState(() {
      _mySubstitutes = _resizeSubstitutes(_mySubstitutes, myCount, _myTeamId);
      _opponentSubstitutes = _resizeSubstitutes(
        _opponentSubstitutes,
        opponentCount,
        _opponentTeamId,
      );
    });
  }

  List<_SubEntry> _resizeSubstitutes(
    List<_SubEntry> current,
    int count,
    String teamId,
  ) {
    final next = <_SubEntry>[];
    for (var i = 0; i < count; i++) {
      if (i < current.length) {
        current[i].seq = i + 1;
        current[i].teamId = teamId;
        next.add(current[i]);
      } else {
        next.add(_SubEntry(seq: i + 1, teamId: teamId));
      }
    }
    for (var i = count; i < current.length; i++) {
      current[i].dispose();
    }
    return next;
  }

  Future<void> _saveSubstitutes() async {
    final payload = <Map<String, dynamic>>[];
    final invalid = _validateSubstitutes(_mySubstitutes, widget.match?.teamA);
    if (invalid != null) {
      _showSnack(invalid, success: false);
      return;
    }
    final opponentInvalid =
        _validateSubstitutes(_opponentSubstitutes, widget.match?.teamB);
    if (opponentInvalid != null) {
      _showSnack(opponentInvalid, success: false);
      return;
    }
    payload
      ..addAll(_mySubstitutes.map((entry) => entry.toPayload()))
      ..addAll(_opponentSubstitutes.map((entry) => entry.toPayload()));
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingSubstitutes = true);
    final ok = await repo.saveSubstitutes(
      matchId: widget.matchId,
      players: payload,
    );
    if (!mounted) return;
    setState(() => _isSavingSubstitutes = false);
    if (ok) _loadDetails();
  }

  Widget _buildIncidentsTab() {
    return Column(
      children: [
        _sectionCard(
          title: AppStrings.matchIncidents,
          child: _multilineField(
            controller: _matchIncidentCtrl,
            hint: AppStrings.enterTextMax200,
          ),
        ),
        if (_showCommissionerReport) ...[
          const SizedBox(height: 12),
          _sectionCard(
            title: AppStrings.matchCommissionerReport,
            child: _multilineField(
              controller: _commissionerReportCtrl,
              hint: AppStrings.enterTextMax300,
            ),
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          // width: double.infinity,
          child: ElevatedButton(
            onPressed: _isSavingIncident ? null : _saveIncident,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.socaBlack,
              foregroundColor: AppColors.socaYellow,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: _isSavingIncident
                ? const AppLoader(size: 24, centered: false)
                : Text('SAVE'.tr,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
          ),
        ),
      ],
    );
  }

  Widget _multilineField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      minLines: 6,
      maxLines: 6,
      maxLength: 1000,
      textCapitalization: TextCapitalization.sentences,
      decoration: _inputDecoration(hint: hint),
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: AppColors.socaBlack,
      ),
    );
  }

  bool get _showCommissionerReport {
    final currentUserId = StorageService.userId ?? '';
    final matchDetails =
        (_details?['matchDetails'] as Map?)?.cast<String, dynamic>() ?? {};
    final matchShort = ((_details?['source'] as Map?)?['matchShort'] as Map?)
            ?.cast<String, dynamic>() ??
        (_details?['matchShort'] as Map?)?.cast<String, dynamic>() ??
        {};
    final commissionerId = _nonEmpty(
          matchShort['matchCommis'],
          matchDetails['matchCommis'],
          widget.match?.matchCommis,
        ) ??
        '';
    return currentUserId.isNotEmpty &&
        commissionerId.isNotEmpty &&
        currentUserId.toLowerCase() == commissionerId.toLowerCase();
  }

  Future<void> _saveIncident() async {
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingIncident = true);
    final ok = await repo.saveMatchIncident(
      matchId: widget.matchId,
      desc: _matchIncidentCtrl.text.trim(),
      commIncident:
          _showCommissionerReport ? _commissionerReportCtrl.text.trim() : '',
    );
    if (!mounted) return;
    setState(() => _isSavingIncident = false);
    if (ok) {
      _showSnack(AppStrings.commissionerReportSaved, success: true);
      _loadDetails();
    }
  }

  Widget _buildMediaTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_mediaStatus.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _mediaStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
          ),
        _buildMediaGridSection(
          title: AppStrings.uploadMatchPhotos.toUpperCase(),
          items:
              _photos.map((p) => ApiConstants.getImageUrl(p.imageUrl)).toList(),
          onUpload: _isUploadingMedia ? null : _pickAndUploadPhoto,
          onSave: _isSavingPhotos ? null : _savePhotos,
          saving: _isSavingPhotos,
          onRemove: (idx) => setState(() => _photos.removeAt(idx)),
          saveLabel: AppStrings.savePhotos.toUpperCase(),
        ),
        const SizedBox(height: 12),
        _buildMediaGridSection(
          title: AppStrings.uploadMatchHighlights.toUpperCase(),
          items: _highlightVideos
              .map((v) => v.thumbnail.isNotEmpty ? v.thumbnail : v.videoUrl)
              .toList(),
          onUpload: _isUploadingMedia ? null : _pickAndUploadHighlight,
          onSave: _isSavingHighlights ? null : _saveHighlights,
          saving: _isSavingHighlights,
          onRemove: (idx) => setState(() => _highlightVideos.removeAt(idx)),
          saveLabel: AppStrings.saveHighlights.toUpperCase(),
        ),
        const SizedBox(height: 12),
        _buildMediaGridSection(
          title: AppStrings.uploadMatchVideos.toUpperCase(),
          maxItems: 2,
          items: _matchVideos
              .map((v) => v.thumbnail.isNotEmpty ? v.thumbnail : v.videoUrl)
              .toList(),
          onUpload: _isUploadingMedia ? null : _pickAndUploadMatchVideo,
          onSave: _isSavingMatchVideos ? null : _saveMatchVideos,
          saving: _isSavingMatchVideos,
          onRemove: (idx) => setState(() => _matchVideos.removeAt(idx)),
          saveLabel: AppStrings.saveVideos.toUpperCase(),
          extraButton: Expanded(
            child: ElevatedButton(
              onPressed: _isPublishingVideos ? null : _publishMatchVideos,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.socaBlack,
                foregroundColor: AppColors.socaYellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
              child: _isPublishingVideos
                  ? const AppLoader(size: 20, centered: false)
                  : Text(
                      'PUBLISH'.tr,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMediaGridSection({
    required String title,
    required List<String> items,
    required String saveLabel,
    required VoidCallback? onUpload,
    required VoidCallback? onSave,
    required bool saving,
    required Function(int) onRemove,
    Widget? extraButton,
    int maxItems = 5,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(maxItems, (index) {
                    final hasItem = index < items.length;
                    return Padding(
                      padding: EdgeInsets.only(
                          right: index == maxItems - 1 ? 0 : 12),
                      child: hasItem
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFE0E0E0)),
                                    image: items[index].isNotEmpty &&
                                            (items[index].startsWith('http') ||
                                                items[index]
                                                    .startsWith('https'))
                                        ? DecorationImage(
                                            image: NetworkImage(items[index]),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: items[index].isEmpty ||
                                          !(items[index].startsWith('http') ||
                                              items[index].startsWith('https'))
                                      ? const Center(
                                          child: Icon(Icons.image,
                                              color: AppColors.socaBlack))
                                      : null,
                                ),
                                Positioned(
                                  top: -6,
                                  right: -6,
                                  child: InkWell(
                                    onTap: () => onRemove(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.close,
                                          size: 14, color: AppColors.socaBlack),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: onUpload,
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: AppColors.socaBlack,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.add_photo_alternate,
                                        size: 26, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.socaBlack,
                        foregroundColor: AppColors.socaYellow,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: saving
                          ? const AppLoader(size: 20, centered: false)
                          : Text(
                              saveLabel,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                    ),
                  ),
                  if (extraButton != null) ...[
                    const SizedBox(width: 12),
                    extraButton,
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickAndUploadPhoto() async {
    if (_photos.length >= 5) {
      _showSnack(AppStrings.maxPhotosUpload, success: false);
      return;
    }
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    await _runMediaUpload(AppStrings.uploadingPhoto, () async {
      final formData = FormData.fromMap({
        'metadata': '',
        'image': await MultipartFile.fromFile(
          picked.path,
          filename: picked.name,
          contentType: DioMediaType('application', 'octet-stream'),
        ),
      });
      final resp = await ApiClient.instance
          .uploadFile(ApiConstants.uploadImage, formData: formData);
      final imageUrl = resp['response']?['image']?.toString() ?? '';
      if (imageUrl.isEmpty) throw Exception('Image not uploaded');
      _photos.add(_MatchPhoto(
        seq: _photos.length + 1,
        imageUrl: imageUrl,
        addedBy: StorageService.userId ?? '',
      ));
    });
  }

  Future<void> _pickAndUploadHighlight() async {
    final picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return;
    if (!_isAllowedVideo(picked.path)) {
      _showSnack(AppStrings.pleaseSelectMp4OrMov, success: false);
      return;
    }
    final size = File(picked.path).lengthSync();
    if (_sizeInMb(size) > 15) {
      _showSnack(AppStrings.maxVideoSizeUpload, success: false);
      return;
    }
    await _uploadVideoFile(
      picked,
      status: AppStrings.uploadingHighlight,
      target: _highlightVideos,
      endpoint: ApiConstants.uploadVdo,
      fieldName: 'video',
    );
  }

  Future<void> _pickAndUploadMatchVideo() async {
    if (_matchVideos.length >= 2) {
      _showSnack(AppStrings.maxVideosUpload, success: false);
      return;
    }
    final picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return;
    if (!_isAllowedVideo(picked.path)) {
      _showSnack(AppStrings.pleaseSelectMp4OrMov, success: false);
      return;
    }
    await _uploadVideoFile(
      picked,
      status: AppStrings.uploadingVideo,
      target: _matchVideos,
      endpoint: ApiConstants.uploadLargeFileUrl,
      fieldName: 'file',
    );
  }

  Future<void> _uploadVideoFile(
    XFile picked, {
    required String status,
    required List<_MatchVideoFile> target,
    required String endpoint,
    required String fieldName,
  }) async {
    await _runMediaUpload(status, () async {
      final size = File(picked.path).lengthSync();
      final resp = endpoint == ApiConstants.uploadLargeFileUrl
          ? await _uploadLargeVideoRaw(picked.path)
          : await _uploadMultipartVideo(picked, endpoint, fieldName);
      final response =
          (resp['response'] as Map?)?.cast<String, dynamic>() ?? {};
      final videoUrl = response['videoUrl']?.toString() ?? '';
      final videoId = response['videoId']?.toString() ?? '';
      final thumbnail = response['thumbnail']?.toString() ?? '';
      if (videoUrl.isEmpty || videoId.isEmpty) {
        throw Exception('Video not uploaded');
      }
      target.add(_MatchVideoFile(
        seq: target.length + 1,
        videoId: videoId,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        size: size,
        uploading: endpoint == ApiConstants.uploadLargeFileUrl,
      ));
    });
  }

  Future<Map<String, dynamic>> _uploadMultipartVideo(
    XFile picked,
    String endpoint,
    String fieldName,
  ) async {
    final formData = FormData.fromMap({
      'metadata': '',
      fieldName: await MultipartFile.fromFile(
        picked.path,
        filename: picked.name,
        contentType: DioMediaType('application', 'octet-stream'),
      ),
    });
    return ApiClient.instance.uploadFile(endpoint, formData: formData);
  }

  Future<Map<String, dynamic>> _uploadLargeVideoRaw(String path) async {
    final file = File(path);
    final response = await Dio().post<dynamic>(
      ApiConstants.uploadLargeFileUrl,
      data: file.openRead(),
      options: Options(
        headers: {'Authorization': null},
        contentType: 'text/x-markdown; charset=utf-8',
        responseType: ResponseType.json,
        sendTimeout: const Duration(minutes: 10),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
    final data = response.data;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return data.cast<String, dynamic>();
    throw Exception('Video not uploaded');
  }

  Future<void> _runMediaUpload(
    String status,
    Future<void> Function() upload,
  ) async {
    setState(() {
      _isUploadingMedia = true;
      _mediaStatus = status;
    });
    try {
      await upload();
      if (!mounted) return;
      setState(() => _mediaStatus = AppStrings.uploadComplete);
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), success: false);
      setState(() => _mediaStatus = '');
    } finally {
      if (mounted) setState(() => _isUploadingMedia = false);
    }
  }

  Future<void> _savePhotos() async {
    setState(() => _isSavingPhotos = true);
    final ok = await ref.read(refereeRepositoryProvider).saveMatchPhotos(
          matchId: widget.matchId,
          parentId: _parentId,
          photos: _photos.asMap().entries.map((entry) {
            entry.value.seq = entry.key + 1;
            return entry.value.toPayload();
          }).toList(),
        );
    if (!mounted) return;
    setState(() => _isSavingPhotos = false);
    if (ok) _loadDetails();
  }

  Future<void> _saveHighlights() async {
    setState(() => _isSavingHighlights = true);
    final ok = await ref.read(refereeRepositoryProvider).saveMatchHighlights(
          matchId: widget.matchId,
          parentId: _parentId,
          matchType: _matchType,
          videos: _videoPayload(_highlightVideos),
        );
    if (!mounted) return;
    setState(() => _isSavingHighlights = false);
    if (ok) _loadDetails();
  }

  Future<void> _saveMatchVideos() async {
    setState(() => _isSavingMatchVideos = true);
    final ok = await ref.read(refereeRepositoryProvider).saveMatchVideos(
          matchId: widget.matchId,
          parentId: _parentId,
          matchType: _matchType,
          videos: _videoPayload(_matchVideos),
        );
    if (!mounted) return;
    setState(() => _isSavingMatchVideos = false);
    if (ok) _loadDetails();
  }

  Future<void> _publishMatchVideos() async {
    setState(() => _isPublishingVideos = true);
    final ok = await ref.read(refereeRepositoryProvider).publishMatchVideos(
          matchId: widget.matchId,
          parentId: _parentId,
          matchType: _matchType,
          videos: _videoPayload(_matchVideos),
        );
    if (!mounted) return;
    setState(() => _isPublishingVideos = false);
    if (ok) {
      _showSnack(AppStrings.videoPublishedToFeed, success: true, long: true);
      _loadDetails();
    }
  }

  List<Map<String, dynamic>> _videoPayload(List<_MatchVideoFile> videos) {
    return videos.asMap().entries.map((entry) {
      entry.value.seq = entry.key + 1;
      return entry.value.toPayload();
    }).toList();
  }

  bool _isAllowedVideo(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.mp4') || lower.endsWith('.mov');
  }

  double _sizeInMb(int bytes) => bytes / (1024 * 1024);

  String? _validateSubstitutes(List<_SubEntry> entries, String? teamName) {
    for (final entry in entries) {
      final time = int.tryParse(entry.timeCtrl.text.trim()) ?? 0;
      if (time <= 0 ||
          entry.playerId == null ||
          entry.playerId!.isEmpty ||
          entry.playerOutId == null ||
          entry.playerOutId!.isEmpty ||
          entry.playerOutName.isEmpty) {
        return 'Please enter ${_ordinal(entry.seq)} substitute details for ${teamName ?? 'team'}';
      }
    }
    return null;
  }

  String _memberName(List<_ManageMember> players, String? id) {
    if (id == null) return '';
    for (final player in players) {
      if (player.id == id || player.playerId == id) return player.label;
    }
    return '';
  }

  String _ordinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) return '${number}th';
    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  Future<void> _saveCleanSheet() async {
    final repo = ref.read(refereeRepositoryProvider);
    setState(() => _isSavingCleanSheet = true);
    final ok = await repo.saveCleanSheet(
      matchId: widget.matchId,
      tournamentId: widget.match?.tournamentId ?? '',
      myTeamCleanSheet: _selectedMyCleanSheetPlayerId,
      oppoTeamCleanSheet: _selectedOpponentCleanSheetPlayerId,
    );
    if (!mounted) return;
    setState(() => _isSavingCleanSheet = false);
    if (ok) _loadDetails();
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  Widget _sectionCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.socaBlack,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(title.toUpperCase(),
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _expandableSection({
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Container(
      decoration: const BoxDecoration(),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              color: AppColors.socaBlack,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Icon(
                  //   expanded
                  //       ? Icons.keyboard_arrow_up
                  //       : Icons.keyboard_arrow_down,
                  //   color: Colors.white,
                  // ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
        ],
      ),
    );
  }

  Widget _scoreInput(
      {required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Lato', fontSize: 11, color: AppColors.socaBlack)),
        const SizedBox(height: 6),
        SizedBox(
          width: 60,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: AppColors.socaBlack),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      const BorderSide(color: AppColors.socaBlack, width: 1.5)),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      fillColor: AppColors.socaGrey,
      hintText: hint,
      hintStyle: const TextStyle(
          fontFamily: 'Poppins', fontSize: 13, color: AppColors.socaBlack),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.socaBlack)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.socaBlack)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: AppColors.socaBlack, width: 1.5)),
    );
  }

  Widget _memberDropdown({
    required String hint,
    required List<_ManageMember> members,
    required String? value,
    required ValueChanged<String?> onChanged,
    bool includeNone = false,
    Color backgroundColor = Colors.white,
  }) {
    final isEmpty = members.isEmpty && !includeNone;
    final effectiveHint = isEmpty ? AppStrings.noMembersAvailable : hint;

    // Ensure the value exists in the list to prevent DropdownButton errors
    String? dropdownValue;
    if (value != null && value.isNotEmpty) {
      if (members.any((m) => m.id == value)) {
        dropdownValue = value;
      }
    } else if (value == '' && includeNone) {
      dropdownValue = '';
    }

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.socaBlack)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          hint: Text(
            effectiveHint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack),
          ),
          icon: Image.asset(
            'assets/images/dropdown.png',
            width: 14,
            height: 14,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey),
          ),
          items: [
            if (includeNone)
              const DropdownMenuItem<String>(
                value: '',
                child: Text('None',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.socaBlack)),
              ),
            ...members.map((m) {
              return DropdownMenuItem<String>(
                value: m.id,
                child: Text(
                  m.label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.socaBlack),
                ),
              );
            }),
          ],
          onChanged: isEmpty
              ? null
              : (val) {
                  onChanged(val == '' ? null : val);
                },
        ),
      ),
    );
  }

  void _showSnack(String message, {required bool success, bool long = false}) {
    AppToast.show(context, message.tr, long: long);
  }
}

// ─── Match header ─────────────────────────────────────────────────────────────

class _MatchHeader extends StatelessWidget {
  const _MatchHeader({
    required this.match,
    this.teamA,
    this.teamB,
    this.teamAScore,
    this.teamBScore,
    this.matchDate,
    this.matchTime,
    this.venue,
    this.fieldName,
  });

  final RefereeMatchModel? match;
  final String? teamA;
  final String? teamB;
  final String? teamAScore;
  final String? teamBScore;
  final String? matchDate;
  final String? matchTime;
  final String? venue;
  final String? fieldName;

  @override
  Widget build(BuildContext context) {
    final leftTeam = teamA ?? match?.teamA ?? '';
    final rightTeam = teamB ?? match?.teamB ?? '';
    final displayDate = matchDate ?? match?.matchDate;
    final displayTime = matchTime ?? match?.matchTime;
    final displayVenue = venue ?? match?.stadiumName;
    final displayFieldName = fieldName ?? match?.fieldName;
    final round = match?.roundName;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.matchDetails,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: AppColors.socaBlack,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team A
              Expanded(
                flex: 1,
                child: _buildTeamColumn(leftTeam, match?.teamALogo),
              ),
              // Match Info
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    if (round != null && round.isNotEmpty) ...[
                      Text(
                        '${AppStrings.round.toUpperCase()} : $round',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      AppStrings.matchDate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayDate ?? AppStrings.tbd,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.matchTime,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayTime ?? AppStrings.tbd,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.socaBlack,
                      ),
                    ),
                    if (displayFieldName != null &&
                        displayFieldName.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      // const Text(
                      //   'Field Name',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 12,
                      //     color: AppColors.socaBlack,
                      //   ),
                      // ),
                      // const SizedBox(height: 4),
                      Text(
                        displayFieldName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                    if (displayVenue != null && displayVenue.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      // const Text(
                      //   'Stadium',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 12,
                      //     color: AppColors.socaBlack,
                      //   ),
                      // ),
                      // const SizedBox(height: 4),
                      Text(
                        displayVenue,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.socaBlack,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Team B
              Expanded(
                flex: 1,
                child: _buildTeamColumn(rightTeam, match?.teamBLogo),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamColumn(String name, String? logoUrl) {
    final url = logoUrl != null ? ApiConstants.getImageUrl(logoUrl) : '';
    final fallback = name.isEmpty
        ? 'TEAM'
        : name.substring(0, name.length > 4 ? 4 : name.length).toUpperCase();
    // log("this is te team name and url $name $url");
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.socaBlack,
          backgroundImage:
              url.isNotEmpty && url != "${ApiConstants.imageBaseUrl}logo.png"
                  ? NetworkImage(url)
                  : null,
          child: url.isEmpty || url == "${ApiConstants.imageBaseUrl}logo.png"
              ? Text(
                  fallback,
                  style: const TextStyle(
                    color: AppColors.socaYellow,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.socaBlack,
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

// ─── Data classes ─────────────────────────────────────────────────────────────

class _ManageMember {
  _ManageMember({
    required this.id,
    required this.userId,
    required this.playerId,
    required this.shortName,
    required this.jersey,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.playPosition,
    required this.playPositionType,
  });

  factory _ManageMember.fromMap(Map<String, dynamic> json) {
    final userId = json['userId']?.toString() ?? '';
    final playerId = json['playerId']?.toString() ?? '';
    final firstName = json['firstName']?.toString() ?? '';
    final lastName = json['lastName']?.toString() ?? '';
    final name = json['name']?.toString() ?? '';
    final imageUrl = json['imageUrl']?.toString() ?? '';
    final playPosition = json['playPosition']?.toString() ?? '';
    final playPositionType = json['playPositionType']?.toString() ?? '';
    final jersey =
        (json['teamJerseyNo'] ?? json['playerJersey'] ?? json['jerseyNo'])
                ?.toString() ??
            '';
    final shortName = name.isNotEmpty
        ? name
        : [firstName, lastName].where((part) => part.isNotEmpty).join(' ');
    return _ManageMember(
      id: playerId.isNotEmpty ? playerId : userId,
      userId: userId.isNotEmpty ? userId : playerId,
      playerId: playerId,
      shortName: shortName.isNotEmpty ? shortName : 'Unknown',
      jersey: jersey,
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
      playPosition: playPosition,
      playPositionType: playPositionType,
    );
  }

  final String id;
  final String userId;
  final String playerId;
  final String shortName;
  final String jersey;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String playPosition;
  final String playPositionType;

  String get label => jersey.isEmpty ? shortName : '#$jersey $shortName';

  String get positionLabel {
    final parts = [playPosition, playPositionType]
        .where((part) => part.isNotEmpty)
        .toList();
    return parts.join(' / ');
  }

  Map<String, dynamic> toSquadPayload() => {
        'playerId': playerId,
        'playerJersey': jersey,
        'firstName': firstName,
        'lastName': lastName,
        'imageUrl': imageUrl,
        'playPosition': playPosition,
        'playPositionType': playPositionType,
      };
}

class _MatchOfficial {
  _MatchOfficial({required this.name, required this.role});

  factory _MatchOfficial.fromMap(Map<String, dynamic> json) {
    return _MatchOfficial(
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
    );
  }

  final String name;
  final String role;

  String get key => '$name::$role';

  Map<String, dynamic> toPayload() => {'name': name, 'role': role};
}

class _SubEntry {
  _SubEntry({
    required this.seq,
    required this.teamId,
    String? playerId,
    String playerName = '',
    String? playerOutId,
    String playerOutName = '',
    String time = '',
  })  : playerId = playerId?.isEmpty == true ? null : playerId,
        playerName = playerName,
        playerOutId = playerOutId?.isEmpty == true ? null : playerOutId,
        playerOutName = playerOutName,
        timeCtrl = TextEditingController(text: time);

  factory _SubEntry.fromMap(
    Map<String, dynamic> json, {
    required String fallbackTeamId,
  }) {
    final seq =
        int.tryParse((json['seq'] ?? json['goalSequence'] ?? 1).toString()) ??
            1;
    return _SubEntry(
      seq: seq,
      teamId: json['teamId']?.toString() ?? fallbackTeamId,
      playerId: json['playerId']?.toString(),
      playerName: json['playerName']?.toString() ?? '',
      playerOutId: json['playerOutId']?.toString(),
      playerOutName: json['playerOutName']?.toString() ?? '',
      time: (json['time'] ?? json['goalTime'] ?? '').toString(),
    );
  }

  int seq;
  String teamId;
  String? playerId;
  String playerName;
  String? playerOutId;
  String playerOutName;
  final TextEditingController timeCtrl;

  Map<String, dynamic> toPayload() => {
        'seq': seq,
        'teamId': teamId,
        'playerId': playerId,
        'playerName': playerName,
        'playerOutId': playerOutId,
        'playerOutName': playerOutName,
        'time': int.tryParse(timeCtrl.text.trim()) ?? 0,
      };

  void dispose() {
    timeCtrl.dispose();
  }
}

class _MatchPhoto {
  _MatchPhoto({
    required this.seq,
    required this.imageUrl,
    required this.addedBy,
  });

  factory _MatchPhoto.fromMap(Map<String, dynamic> json) {
    return _MatchPhoto(
      seq: int.tryParse((json['seq'] ?? 0).toString()) ?? 0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      addedBy: json['addedBy']?.toString() ?? '',
    );
  }

  int seq;
  final String imageUrl;
  final String addedBy;

  Map<String, dynamic> toPayload() => {
        'seq': seq,
        'imageUrl': imageUrl,
        'addedBy': addedBy,
      };
}

class _MatchVideoFile {
  _MatchVideoFile({
    required this.seq,
    required this.videoId,
    required this.videoUrl,
    required this.thumbnail,
    required this.size,
    this.uploading = false,
  });

  factory _MatchVideoFile.fromMap(Map<String, dynamic> json) {
    return _MatchVideoFile(
      seq: int.tryParse((json['seq'] ?? 0).toString()) ?? 0,
      videoId: json['videoId']?.toString() ?? '',
      videoUrl: json['videoUrl']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      size: int.tryParse((json['size'] ?? 0).toString()) ?? 0,
      uploading: json['uploading'] == true,
    );
  }

  int seq;
  final String videoId;
  final String videoUrl;
  final String thumbnail;
  final int size;
  final bool uploading;

  Map<String, dynamic> toPayload() => {
        'seq': seq,
        'videoId': videoId,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail,
        'thumbSet': true,
        'size': size,
      };
}

class _GoalEntry {
  final String team;
  String player;
  String playerId;
  String assistPlayerId;
  String assistPlayerName;
  bool ownGoal;
  bool isPenalty;
  String videoId;
  String videoUrl;
  final TextEditingController minuteCtrl;

  _GoalEntry({
    required this.team,
    this.player = '',
    this.playerId = '',
    this.assistPlayerId = '',
    this.assistPlayerName = '',
    this.ownGoal = false,
    this.isPenalty = false,
    this.videoId = '',
    this.videoUrl = '',
    String minute = '',
  }) : minuteCtrl = TextEditingController(text: minute);

  void dispose() => minuteCtrl.dispose();
}

class _CardEntry {
  final String team;
  String player;
  String playerId;
  String type; // 'firstYellow' | 'secondYellow' | 'red'
  _CardEntry({
    required this.team,
    this.player = '',
    this.playerId = '',
    this.type = 'firstYellow',
  });
}

// ─── Penalty Attempt data model ─────────────────────────────────────────────
class _PenaltyEntry {
  final String team;
  String playerId;
  String playerName;
  bool missed;
  String videoId;
  String videoUrl;

  _PenaltyEntry({
    required this.team,
    this.playerId = '',
    this.playerName = '',
    this.missed = false,
    this.videoId = '',
    this.videoUrl = '',
  });
}
