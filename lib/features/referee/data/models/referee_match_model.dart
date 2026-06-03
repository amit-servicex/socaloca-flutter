import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'referee_match_model.freezed.dart';
part 'referee_match_model.g.dart';

/// Represents a match in the referee's lists (requests, matches, live).
@freezed
class RefereeMatchModel with _$RefereeMatchModel {
  const RefereeMatchModel._();

  const factory RefereeMatchModel({
    @JsonKey(name: 'matchId') String? matchId,
    @JsonKey(name: 'tournamentId') String? tournamentId,
    @JsonKey(name: 'tournament') String? tournamentName,
    @JsonKey(name: 'roundName') String? roundName,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'fieldName') String? fieldName,
    @JsonKey(name: 'mainAccept') int? mainAccept,
    @JsonKey(name: 'matchDateTimeGmt') int? matchDateTimeGmt,
    @JsonKey(name: 'myTeamId') String? myTeamId,
    @JsonKey(name: 'opponentTeamId') String? opponentTeamId,
    @JsonKey(name: 'stadiumName') String? stadiumName,
    @JsonKey(name: 'score') RefereeScoreModel? score,
    @JsonKey(name: 'teams') List<RefereeTeamModel>? teams,
    @JsonKey(name: 'ageGroup') String? ageGroup,
    // "upcoming" | "live" | "completed"
    @JsonKey(name: 'matchStatus') String? matchStatus,
    // "0" = not submitted, "1" = submitted
    @JsonKey(name: 'scoreStatus') String? scoreStatus,
    // "pending" | "accepted" | "declined"
    @JsonKey(name: 'acceptStatus') String? acceptStatus,
    @JsonKey(name: 'asstRef1') String? asstRef1,
    @JsonKey(name: 'asstRef2') String? asstRef2,
    @JsonKey(name: 'mainRef') String? mainRef,
    @JsonKey(name: 'matchCommis') String? matchCommis,
    @JsonKey(name: 'currentMinute') String? currentMinute,
    @JsonKey(name: 'state') String? state,
  }) = _RefereeMatchModel;

  factory RefereeMatchModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeMatchModelFromJson(json);

  RefereeTeamModel? get myTeam {
    if (teams == null || teams!.isEmpty) return null;
    final matchTeamId = myTeamId;
    if (matchTeamId == null || matchTeamId.isEmpty) return teams!.first;
    return teams!.firstWhere(
      (team) => team.teamId == matchTeamId,
      orElse: () => teams!.first,
    );
  }

  RefereeTeamModel? get opponentTeam {
    if (teams == null || teams!.length < 2) return null;
    final selectedMyTeam = myTeam;
    return teams!.firstWhere(
      (team) => team.teamId != selectedMyTeam?.teamId,
      orElse: () => teams![1],
    );
  }

  String? get teamA => myTeam?.teamShortName?.isNotEmpty == true
      ? myTeam?.teamShortName
      : myTeam?.teamName;
  String? get teamAId => myTeam?.teamId;
  String? get teamALogo => myTeam?.imageUrl;
  String? get teamAScore => score?.myGoals?.toString();

  String? get teamB => opponentTeam?.teamShortName?.isNotEmpty == true
      ? opponentTeam?.teamShortName
      : opponentTeam?.teamName;
  String? get teamBId => opponentTeam?.teamId;
  String? get teamBLogo => opponentTeam?.imageUrl;
  String? get teamBScore => score?.opponentGoals?.toString();

  String? get venue => stadiumName;

  String? get matchDate {
    if (matchDateTimeGmt == null) return null;
    final dt = DateTime.fromMillisecondsSinceEpoch(matchDateTimeGmt!).toLocal();
    return DateFormat('MMMM d').format(dt);
  }

  String? get matchTime {
    if (matchDateTimeGmt == null) return null;
    final dt = DateTime.fromMillisecondsSinceEpoch(matchDateTimeGmt!).toLocal();
    return DateFormat('hh:mm a').format(dt);
  }

  bool canManage(String currentUserId) {
    return mainRef == currentUserId ||
        (matchCommis != null &&
            matchCommis!.isNotEmpty &&
            matchCommis!.toLowerCase() == currentUserId.toLowerCase());
  }

  String get liveState => state ?? matchStatus ?? '';
}

@freezed
class RefereeScoreModel with _$RefereeScoreModel {
  const factory RefereeScoreModel({
    int? myGoals,
    int? opponentGoals,
  }) = _RefereeScoreModel;

  factory RefereeScoreModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeScoreModelFromJson(json);
}

@freezed
class RefereeTeamModel with _$RefereeTeamModel {
  const factory RefereeTeamModel({
    String? teamId,
    String? teamName,
    String? teamShortName,
    String? imageUrl,
  }) = _RefereeTeamModel;

  factory RefereeTeamModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeTeamModelFromJson(json);
}

/// Simple dropdown item used for tournament filter spinners.
@freezed
class TournamentDropdownItem with _$TournamentDropdownItem {
  const factory TournamentDropdownItem({
    @JsonKey(name: 'tournamentId') String? tournamentId,
    @JsonKey(name: 'name') String? tournamentName,
  }) = _TournamentDropdownItem;

  factory TournamentDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$TournamentDropdownItemFromJson(json);
}
