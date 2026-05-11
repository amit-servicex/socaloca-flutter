import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_model.freezed.dart';
part 'match_model.g.dart';

/// Core match model — used by played, upcoming and live match screens.
/// ⚠️ Both getMatchDetails (played) and getMatchData (live/upcoming) return
/// this same shape with slightly different field populations.
@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    required String homeTeamId,
    required String awayTeamId,
    required String homeTeamName,
    required String awayTeamName,
    String? homeTeamLogo,
    String? awayTeamLogo,
    String? matchDate,
    String? matchTime,
    String? venue,
    String? status,          // 'live', 'upcoming', 'played', 'pending', etc.
    MatchScore? score,
    String? tournamentId,
    String? tournamentName,
    String? cupId,
    bool? isOneOff,
    @Default([]) List<MatchEvent> events,
    String? refereeId,
    String? refereeName,
    int? duration,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}

@freezed
class MatchScore with _$MatchScore {
  const factory MatchScore({
    @Default(0) int homeGoals,
    @Default(0) int awayGoals,
    int? homeExtraTime,
    int? awayExtraTime,
    int? homePenalties,
    int? awayPenalties,
  }) = _MatchScore;

  factory MatchScore.fromJson(Map<String, dynamic> json) =>
      _$MatchScoreFromJson(json);
}

@freezed
class MatchEvent with _$MatchEvent {
  const factory MatchEvent({
    required String type,    // 'goal', 'card', 'sub', 'foul'
    required String playerId,
    required String playerName,
    int? minute,
    String? teamId,
    String? detail,          // 'yellow', 'red', 'assist', etc.
  }) = _MatchEvent;

  factory MatchEvent.fromJson(Map<String, dynamic> json) =>
      _$MatchEventFromJson(json);
}
