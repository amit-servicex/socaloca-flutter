class MatchUpdateModel {
  final String matchId;
  final String myTeamId;
  final String opponentTeamId;
  final int myGoals;
  final int opponentGoals;
  final MatchUpdateTeam? myTeam;
  final MatchUpdateTeam? opponentTeam;
  final MatchUpdateInfo? matchInfo;
  final MatchUpdateTournament? tmntInfo;

  const MatchUpdateModel({
    required this.matchId,
    required this.myTeamId,
    required this.opponentTeamId,
    required this.myGoals,
    required this.opponentGoals,
    this.myTeam,
    this.opponentTeam,
    this.matchInfo,
    this.tmntInfo,
  });

  String get homeTeamName => myTeam?.teamName ?? '';
  String get awayTeamName => opponentTeam?.teamName ?? '';
  String get homeTeamLogo => myTeam?.imageUrl ?? '';
  String get awayTeamLogo => opponentTeam?.imageUrl ?? '';
  String get tournamentName => tmntInfo?.name ?? '';
  String get tournamentLogo => tmntInfo?.logo ?? '';
  String get stadiumName => matchInfo?.stadiumName ?? '';
  String get fieldName => matchInfo?.fieldName ?? '';
  String get locationName => matchInfo?.locationName ?? '';
  int? get matchDateTimeGmt => matchInfo?.matchDateTimeGmt;

  factory MatchUpdateModel.fromJson(Map<String, dynamic> json) {
    return MatchUpdateModel(
      matchId: json['matchId']?.toString() ?? '',
      myTeamId: json['myTeamId']?.toString() ?? '',
      opponentTeamId: json['opponentTeamId']?.toString() ?? '',
      myGoals: (json['myGoals'] as num?)?.toInt() ?? 0,
      opponentGoals: (json['opponentGoals'] as num?)?.toInt() ?? 0,
      myTeam: json['myTeam'] is Map<String, dynamic>
          ? MatchUpdateTeam.fromJson(json['myTeam'] as Map<String, dynamic>)
          : null,
      opponentTeam: json['opponentTeam'] is Map<String, dynamic>
          ? MatchUpdateTeam.fromJson(
              json['opponentTeam'] as Map<String, dynamic>)
          : null,
      matchInfo: json['matchInfo'] is Map<String, dynamic>
          ? MatchUpdateInfo.fromJson(json['matchInfo'] as Map<String, dynamic>)
          : null,
      tmntInfo: json['tmntInfo'] is Map<String, dynamic>
          ? MatchUpdateTournament.fromJson(
              json['tmntInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MatchUpdateTeam {
  final String id;
  final String teamId;
  final String teamName;
  final String imageUrl;

  const MatchUpdateTeam({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.imageUrl,
  });

  factory MatchUpdateTeam.fromJson(Map<String, dynamic> json) {
    return MatchUpdateTeam(
      id: json['_id']?.toString() ?? '',
      teamId: json['teamId']?.toString() ?? '',
      teamName: json['teamName']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }
}

class MatchUpdateInfo {
  final String id;
  final String matchId;
  final String myTeamId;
  final String opponentTeamId;
  final String stadiumName;
  final String fieldName;
  final String locationName;
  final int? matchDateTimeGmt;

  const MatchUpdateInfo({
    required this.id,
    required this.matchId,
    required this.myTeamId,
    required this.opponentTeamId,
    required this.stadiumName,
    required this.fieldName,
    required this.locationName,
    this.matchDateTimeGmt,
  });

  factory MatchUpdateInfo.fromJson(Map<String, dynamic> json) {
    return MatchUpdateInfo(
      id: json['_id']?.toString() ?? '',
      matchId: json['matchId']?.toString() ?? '',
      myTeamId: json['myTeamId']?.toString() ?? '',
      opponentTeamId: json['opponentTeamId']?.toString() ?? '',
      stadiumName: json['stadiumName']?.toString() ?? '',
      fieldName: json['fieldName']?.toString() ?? '',
      locationName: json['locationName']?.toString() ?? '',
      matchDateTimeGmt: (json['matchDateTimeGmt'] as num?)?.toInt(),
    );
  }
}

class MatchUpdateTournament {
  final String id;
  final String tournamentId;
  final String visibility;
  final String name;
  final String logo;
  final String status;

  const MatchUpdateTournament({
    required this.id,
    required this.tournamentId,
    required this.visibility,
    required this.name,
    required this.logo,
    required this.status,
  });

  factory MatchUpdateTournament.fromJson(Map<String, dynamic> json) {
    return MatchUpdateTournament(
      id: json['_id']?.toString() ?? '',
      tournamentId: json['tournamentId']?.toString() ?? '',
      visibility: json['visibility']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}
