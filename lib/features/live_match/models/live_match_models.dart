// Models for the Live Matches feature.
// Plain Dart classes — no build_runner needed.
// Mirrors Android: SocaLocaMatch, MatchScore, GoalEdit, MatchCard, TeamPlayer

// ─── Match state enum ─────────────────────────────────────────────────────────

enum MatchState {
  init,
  firstHalfStart,
  firstHalfEnd,
  secondHalfStart,
  secondHalfEnd,
  extraTimeFhStart,
  extraTimeFhEnd,
  extraTimeShStart,
  extraTimeShEnd,
  penalty,
  finish,
  abandoned,
  postponed,
  unknown;

  static MatchState fromString(String? s) {
    switch (s) {
      case 'INIT':
        return MatchState.init;
      case 'FIRST_HALF_START':
        return MatchState.firstHalfStart;
      case 'FIRST_HALF_END':
        return MatchState.firstHalfEnd;
      case 'SECOND_HALF_START':
        return MatchState.secondHalfStart;
      case 'SECOND_HALF_END':
        return MatchState.secondHalfEnd;
      case 'EXTRA_TIME_FH_START':
        return MatchState.extraTimeFhStart;
      case 'EXTRA_TIME_FH_END':
        return MatchState.extraTimeFhEnd;
      case 'EXTRA_TIME_SH_START':
        return MatchState.extraTimeShStart;
      case 'EXTRA_TIME_SH_END':
        return MatchState.extraTimeShEnd;
      case 'PENALTY':
        return MatchState.penalty;
      case 'FINISH':
        return MatchState.finish;
      case 'ABANDONED':
        return MatchState.abandoned;
      case 'POSTPONED':
        return MatchState.postponed;
      default:
        return MatchState.unknown;
    }
  }

  /// Human-readable display label matching Android live_match_details.xml
  String get label {
    switch (this) {
      case MatchState.init:
        return 'Upcoming';
      case MatchState.firstHalfStart:
        return 'First Half';
      case MatchState.firstHalfEnd:
        return 'Half Time';
      case MatchState.secondHalfStart:
        return 'Second Half';
      case MatchState.secondHalfEnd:
        return 'Full Time';
      case MatchState.extraTimeFhStart:
        return 'ET First Half';
      case MatchState.extraTimeFhEnd:
        return 'ET Half Time';
      case MatchState.extraTimeShStart:
        return 'ET Second Half';
      case MatchState.extraTimeShEnd:
        return 'ET Full Time';
      case MatchState.penalty:
        return 'Penalty Shootout';
      case MatchState.finish:
        return 'Full Time';
      case MatchState.abandoned:
        return 'Abandoned';
      case MatchState.postponed:
        return 'Postponed';
      case MatchState.unknown:
        return '';
    }
  }

  bool get isLive =>
      this == MatchState.firstHalfStart ||
      this == MatchState.secondHalfStart ||
      this == MatchState.extraTimeFhStart ||
      this == MatchState.extraTimeShStart ||
      this == MatchState.penalty;
}

// ─── Team ─────────────────────────────────────────────────────────────────────

class LiveMatchTeam {
  const LiveMatchTeam({
    required this.teamId,
    required this.teamName,
    this.teamShortName,
    this.imageUrl,
  });

  final String teamId;
  final String teamName;
  final String? teamShortName;
  final String? imageUrl;

  factory LiveMatchTeam.fromJson(Map<String, dynamic> j) => LiveMatchTeam(
        teamId: j['teamId']?.toString() ?? '',
        teamName: j['teamName']?.toString() ?? '',
        teamShortName: j['teamShortName']?.toString(),
        imageUrl: j['imageUrl']?.toString(),
      );
}

// ─── Player (from allUsers in match detail response) ─────────────────────────

class MatchPlayer {
  const MatchPlayer({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    this.playPosition,
    this.playPositionType,
    this.nationality,
    this.isPlayer = true,
    this.isCoach = false,
  });

  final String userId;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final String? playPosition;
  final String? playPositionType;
  final String? nationality;
  final bool isPlayer;
  final bool isCoach;

  String get fullName => '${firstName.trim()} ${lastName.trim()}'.trim();

  factory MatchPlayer.fromJson(Map<String, dynamic> j) => MatchPlayer(
        userId: j['userId']?.toString() ?? '',
        firstName: j['firstName']?.toString() ?? '',
        lastName: j['lastName']?.toString() ?? '',
        imageUrl: j['imageUrl']?.toString(),
        playPosition: j['playPosition']?.toString(),
        playPositionType: j['playPositionType']?.toString(),
        nationality: j['nationality']?.toString(),
        isPlayer: _parseBool(j['isPlayer']),
        isCoach: _parseBool(j['isCoach']),
      );
}

// ─── Jersey (from allJerseys in match detail response) ────────────────────────

class MatchJersey {
  const MatchJersey({
    required this.playerId,
    required this.teamId,
    required this.teamJerseyNo,
  });

  final String playerId;
  final String teamId;
  final String teamJerseyNo;

  factory MatchJersey.fromJson(Map<String, dynamic> j) => MatchJersey(
        playerId: j['playerId']?.toString() ?? '',
        teamId: j['teamId']?.toString() ?? '',
        teamJerseyNo: j['teamJerseyNo']?.toString() ?? '',
      );
}

// ─── Live match list item ─────────────────────────────────────────────────────

class LiveMatchListItem {
  const LiveMatchListItem({
    required this.matchId,
    required this.tournamentId,
    this.tournamentName,
    this.tournamentLogoUrl,
    this.tournamentCountry,
    this.matchDateTimeGmt,
    this.state,
    this.homeTeam,
    this.awayTeam,
    this.homeGoals = 0,
    this.awayGoals = 0,
    this.uniqueTournamentId = false,
  });

  final String matchId;
  final String tournamentId;
  final String? tournamentName;
  final String? tournamentLogoUrl;
  final String? tournamentCountry;
  final int? matchDateTimeGmt; // unix timestamp in seconds
  final MatchState? state;
  final LiveMatchTeam? homeTeam;
  final LiveMatchTeam? awayTeam;
  final int homeGoals;
  final int awayGoals;
  final bool uniqueTournamentId; // true = show tournament header row above

  factory LiveMatchListItem.fromJson(Map<String, dynamic> j) {
    final teams = (j['teams'] as List?)
            ?.map((t) => LiveMatchTeam.fromJson(t as Map<String, dynamic>))
            .toList() ??
        [];

    final score = j['score'] as Map<String, dynamic>?;

    return LiveMatchListItem(
      matchId: j['matchId']?.toString() ?? '',
      tournamentId: j['tournamentId']?.toString() ?? '',
      tournamentName: (j['tournamentName'] ?? j['tmntName'])?.toString(),
      tournamentLogoUrl: j['tournamentLogo']?.toString(),
      tournamentCountry: j['tournamentCountry']?.toString(),
      matchDateTimeGmt: _parseInt(j['matchDateTimeGmt']),
      state: MatchState.fromString(j['state']?.toString()),
      homeTeam: teams.isNotEmpty ? teams[0] : null,
      awayTeam: teams.length > 1 ? teams[1] : null,
      homeGoals: _parseInt(score?['myGoals']) ?? 0,
      awayGoals: _parseInt(score?['opponentGoals']) ?? 0,
    );
  }
}

// ─── Timeline events ──────────────────────────────────────────────────────────

class LiveGoalEvent {
  const LiveGoalEvent({
    required this.teamId,
    this.playerId,
    required this.playerName,
    required this.goalTime,
    this.goalSequence = 0,
    this.assistPlayerName,
    this.missed = false,
    this.ownGoal = false,
    this.isPenalty = false,
    this.absoluteTime,
  });

  final String teamId;
  final String? playerId;
  final String playerName;
  final int goalTime;
  final int goalSequence;
  final String? assistPlayerName;
  final bool missed;
  final bool ownGoal;
  final bool isPenalty;
  final int? absoluteTime;

  factory LiveGoalEvent.fromJson(Map<String, dynamic> j) => LiveGoalEvent(
        teamId: j['teamId']?.toString() ?? '',
        playerId: j['playerId']?.toString(),
        playerName: j['playerName']?.toString() ?? '',
        goalTime: _parseInt(j['goalTime']) ?? 0,
        goalSequence: _parseInt(j['goalSequence']) ?? 0,
        assistPlayerName: j['assistPlayerName']?.toString(),
        missed: _parseBool(j['missed']),
        ownGoal: _parseBool(j['ownGoal']),
        isPenalty: _parseBool(j['isPenalty']),
        absoluteTime: _parseInt(j['absoluteTime']),
      );
}

class LiveCardEvent {
  const LiveCardEvent({
    required this.teamId,
    this.playerId,
    required this.playerName,
    required this.cardTime,
    this.firstYellowCard = false,
    this.secondYellowCard = false,
    this.redCard = false,
    this.absoluteTime,
  });

  final String teamId;
  final String? playerId;
  final String playerName;
  final int cardTime;
  final bool firstYellowCard;
  final bool secondYellowCard;
  final bool redCard;
  final int? absoluteTime;

  factory LiveCardEvent.fromJson(Map<String, dynamic> j) => LiveCardEvent(
        teamId: j['teamId']?.toString() ?? '',
        playerId: j['playerId']?.toString(),
        playerName: j['playerName']?.toString() ?? '',
        cardTime: _parseInt(j['cardTime']) ?? 0,
        firstYellowCard: _parseBool(j['firstYellowCard']),
        secondYellowCard: _parseBool(j['secondYellowCard']),
        redCard: _parseBool(j['redCard']),
        absoluteTime: _parseInt(j['absoluteTime']),
      );

  String get cardType {
    if (redCard) return 'red';
    if (secondYellowCard) return 'second_yellow';
    return 'yellow';
  }
}

class LiveSubEvent {
  const LiveSubEvent({
    required this.teamId,
    this.playerId,
    required this.playerName,
    this.playerOutName,
    required this.subTime,
    this.absoluteTime,
  });

  final String teamId;
  final String? playerId;
  final String playerName;
  final String? playerOutName;
  final int subTime;
  final int? absoluteTime;

  factory LiveSubEvent.fromJson(Map<String, dynamic> j) => LiveSubEvent(
        teamId: j['teamId']?.toString() ?? '',
        playerId: j['playerId']?.toString(),
        playerName: j['playerName']?.toString() ?? '',
        playerOutName: j['playerOutName']?.toString(),
        subTime: _parseInt(j['time']) ?? 0,
        absoluteTime: _parseInt(j['absoluteTime']),
      );
}

class LivePenaltyEvent {
  const LivePenaltyEvent({
    required this.teamId,
    this.playerId,
    required this.playerName,
    this.goalSequence = 0,
    this.missed = false,
    this.absoluteTime,
  });

  final String teamId;
  final String? playerId;
  final String playerName;
  final int goalSequence;
  final bool missed;
  final int? absoluteTime;

  factory LivePenaltyEvent.fromJson(Map<String, dynamic> j) => LivePenaltyEvent(
        teamId: j['teamId']?.toString() ?? '',
        playerId: j['playerId']?.toString(),
        playerName: j['playerName']?.toString() ?? '',
        goalSequence: _parseInt(j['goalSequence']) ?? 0,
        missed: _parseBool(j['missed']),
        absoluteTime: _parseInt(j['absoluteTime']),
      );
}

// ─── Full match detail ────────────────────────────────────────────────────────

class LiveMatchDetail {
  const LiveMatchDetail({
    required this.matchId,
    required this.tournamentId,
    this.rawState,
    this.startTimeGmt,
    this.firstHalfStartTime,
    this.firstHalfEndTime,
    this.secondHalfStartTime,
    this.secondHalfEndTime,
    this.extraTimeFhStartTime,
    this.extraTimeFhEndTime,
    this.extraTimeShStartTime,
    this.extraTimeShEndTime,
    this.penaltyStartTime,
    this.finishTime,
    this.myGoals = 0,
    this.opponentGoals = 0,
    this.myExtraTime = 0,
    this.opponentExtraTime = 0,
    this.myPenalty = 0,
    this.opponentPenalty = 0,
    this.goals = const [],
    this.cards = const [],
    this.subs = const [],
    this.extraTimeGoals = const [],
    this.penaltyShots = const [],
    this.myTeam,
    this.opponentTeam,
    this.matchDateTimeGmt,
    this.allPlayers = const [],
    this.allJerseys = const [],
    this.myPlayerIds = const [],
    this.opponentPlayerIds = const [],
    this.matchName,
    this.matchDate,
    this.matchTime,
    this.stadiumName,
    this.city,
  });

  final String matchId;
  final String tournamentId;
  final String? rawState;
  final int? startTimeGmt;
  final int? firstHalfStartTime;
  final int? firstHalfEndTime;
  final int? secondHalfStartTime;
  final int? secondHalfEndTime;
  final int? extraTimeFhStartTime;
  final int? extraTimeFhEndTime;
  final int? extraTimeShStartTime;
  final int? extraTimeShEndTime;
  final int? penaltyStartTime;
  final int? finishTime;
  final int myGoals;
  final int opponentGoals;
  final int myExtraTime;
  final int opponentExtraTime;
  final int myPenalty;
  final int opponentPenalty;
  final List<LiveGoalEvent> goals;
  final List<LiveCardEvent> cards;
  final List<LiveSubEvent> subs;
  final List<LiveGoalEvent> extraTimeGoals;
  final List<LivePenaltyEvent> penaltyShots;
  final LiveMatchTeam? myTeam;
  final LiveMatchTeam? opponentTeam;
  final int? matchDateTimeGmt;

  // Player lineup fields
  final List<MatchPlayer> allPlayers;
  final List<MatchJersey> allJerseys;
  final List<String> myPlayerIds;
  final List<String> opponentPlayerIds;
  final String? matchName;
  final String? matchDate;
  final String? matchTime;
  final String? stadiumName;
  final String? city;

  MatchState get state => MatchState.fromString(rawState);

  bool get hasPenalties => penaltyShots.isNotEmpty;

  /// Combined display score (regular + extra time)
  int get displayHomeGoals => myGoals + myExtraTime;
  int get displayAwayGoals => opponentGoals + opponentExtraTime;

  /// Players belonging to myTeam (isPlayer == true)
  List<MatchPlayer> get myTeamPlayers => allPlayers
      .where((p) => p.isPlayer && myPlayerIds.contains(p.userId))
      .toList();

  /// Players belonging to opponent team (isPlayer == true)
  List<MatchPlayer> get opponentTeamPlayers => allPlayers
      .where((p) => p.isPlayer && opponentPlayerIds.contains(p.userId))
      .toList();

  /// Jersey number for a player in a specific team, null if not found.
  String? playerJerseyNo(String userId, String teamId) => allJerseys
      .where((j) => j.playerId == userId && j.teamId == teamId)
      .map((j) => j.teamJerseyNo)
      .firstOrNull;

  factory LiveMatchDetail.fromJson(
    String matchId,
    String tournamentId,
    Map<String, dynamic> json,
  ) {
    final matchDetails = json['matchDetails'] as Map<String, dynamic>? ?? {};
    final liveRecord = (json['liveRecord'] as Map<String, dynamic>?) ??
        (matchDetails['liveRecord'] as Map<String, dynamic>?) ??
        {};
    final score = (json['score'] as Map<String, dynamic>?) ??
        (matchDetails['score'] as Map<String, dynamic>?) ??
        {};

    // Extract teams from matchDetails.teams array
    final teams = (matchDetails['teams'] as List?)
            ?.map((t) => LiveMatchTeam.fromJson(t as Map<String, dynamic>))
            .toList() ??
        [];

    // The first team is "my team", second is opponent
    // These are indexed by myTeamId / opponentTeamId from matchShort
    final matchShort =
        matchDetails['matchShort'] as Map<String, dynamic>? ?? matchDetails;
    final myTeamId = matchShort['myTeamId']?.toString();
    final opponentTeamId = matchShort['opponentTeamId']?.toString();

    LiveMatchTeam? myTeam;
    LiveMatchTeam? opponentTeam;
    for (final t in teams) {
      if (t.teamId == myTeamId) {
        myTeam = t;
      } else if (t.teamId == opponentTeamId) {
        opponentTeam = t;
      }
    }
    // Fallback: use order
    if (myTeam == null && teams.isNotEmpty) myTeam = teams[0];
    if (opponentTeam == null && teams.length > 1) opponentTeam = teams[1];

    List<LiveGoalEvent> parseGoals(dynamic arr) =>
        (arr as List?)
            ?.map((e) => LiveGoalEvent.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    List<LiveCardEvent> parseCards(dynamic arr) =>
        (arr as List?)
            ?.map((e) => LiveCardEvent.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    List<LiveSubEvent> parseSubs(dynamic arr) =>
        (arr as List?)
            ?.map((e) => LiveSubEvent.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    List<LivePenaltyEvent> parsePenalties(dynamic arr) =>
        (arr as List?)
            ?.map((e) => LivePenaltyEvent.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    // Prefer liveRecord data; fall back to score object (returned by getMatchData)
    final goalsData = liveRecord['goals'] ?? score['goals'];
    final cardsData = liveRecord['cards'] ?? score['cards'];
    final subsData = liveRecord['subs'] ?? score['subs'];
    final extraTimeData = liveRecord['extraTime'] ?? score['extraTime'];
    final penaltyData = liveRecord['penalty'] ?? score['penalty'];

    return LiveMatchDetail(
      matchId: matchId,
      tournamentId: tournamentId,
      rawState: liveRecord['state']?.toString() ??
          matchDetails['state']?.toString() ??
          _stateFromScoreStatus(matchDetails['scoreStatus']?.toString()),
      startTimeGmt: _parseInt(liveRecord['startTimeGmt']),
      firstHalfStartTime: _parseInt(liveRecord['firstHalfStartTime']),
      firstHalfEndTime: _parseInt(liveRecord['firstHalfEndTime']),
      secondHalfStartTime: _parseInt(liveRecord['secondHalfStartTime']),
      secondHalfEndTime: _parseInt(liveRecord['secondHalfEndTime']),
      extraTimeFhStartTime: _parseInt(liveRecord['extraTimeFhStartTime']),
      extraTimeFhEndTime: _parseInt(liveRecord['extraTimeFhEndTime']),
      extraTimeShStartTime: _parseInt(liveRecord['extraTimeShStartTime']),
      extraTimeShEndTime: _parseInt(liveRecord['extraTimeShEndTime']),
      penaltyStartTime: _parseInt(liveRecord['penaltyStartTime']),
      finishTime: _parseInt(liveRecord['finishTime']),
      myGoals:
          _parseInt(liveRecord['myGoals']) ?? _parseInt(score['myGoals']) ?? 0,
      opponentGoals: _parseInt(liveRecord['opponentGoals']) ??
          _parseInt(score['opponentGoals']) ??
          0,
      myExtraTime: _parseInt(liveRecord['myExtraTime']) ??
          _parseInt(score['myExtraTime']) ??
          0,
      opponentExtraTime: _parseInt(liveRecord['opponentExtraTime']) ??
          _parseInt(score['opponentExtraTime']) ??
          0,
      myPenalty: _parseInt(score['myPenalty']) ?? 0,
      opponentPenalty: _parseInt(score['opponentPenalty']) ?? 0,
      goals: parseGoals(goalsData),
      cards: parseCards(cardsData),
      subs: parseSubs(subsData),
      extraTimeGoals: parseGoals(extraTimeData),
      penaltyShots: parsePenalties(penaltyData),
      myTeam: myTeam,
      opponentTeam: opponentTeam,
      matchDateTimeGmt: _parseInt(matchDetails['matchDateTimeGmt']),
      // allUsers and allJerseys are siblings of matchDetails in the API response,
      // not nested inside it. Fall back to matchDetails for other response shapes.
      allPlayers:
          ((json['allUsers'] ?? matchDetails['allUsers']) as List? ?? [])
              .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
              .toList(),
      allJerseys:
          ((json['allJerseys'] ?? matchDetails['allJerseys']) as List? ?? [])
              .map((e) => MatchJersey.fromJson(e as Map<String, dynamic>))
              .toList(),
      myPlayerIds: (matchDetails['myAllPlayers'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      opponentPlayerIds: (matchDetails['opponentAllPlayers'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      matchName: matchDetails['matchName']?.toString(),
      matchDate: matchDetails['matchDate']?.toString(),
      matchTime: matchDetails['matchTime']?.toString(),
      stadiumName: matchDetails['stadiumName']?.toString(),
      city: matchDetails['city']?.toString(),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

int? _parseInt(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  if (val is double) return val.toInt();
  return int.tryParse(val.toString());
}

bool _parseBool(dynamic val) {
  if (val == null) return false;
  if (val is bool) return val;
  if (val is int) return val != 0;
  return val.toString().toLowerCase() == 'true';
}

String? _stateFromScoreStatus(String? status) {
  switch (status?.toLowerCase()) {
    case 'accepted':
      return 'FINISH';
    case 'pending':
      return 'SECOND_HALF_END';
    default:
      return null;
  }
}
