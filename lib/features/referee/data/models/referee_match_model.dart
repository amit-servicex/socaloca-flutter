import 'package:freezed_annotation/freezed_annotation.dart';

part 'referee_match_model.freezed.dart';
part 'referee_match_model.g.dart';

/// Represents a match in the referee's lists (requests, matches, live).
@freezed
class RefereeMatchModel with _$RefereeMatchModel {
  const factory RefereeMatchModel({
    @JsonKey(name: 'matchId') String? matchId,
    @JsonKey(name: 'tournamentId') String? tournamentId,
    @JsonKey(name: 'tournamentName') String? tournamentName,
    @JsonKey(name: 'roundName') String? roundName,
    @JsonKey(name: 'teamA') String? teamA,
    @JsonKey(name: 'teamAId') String? teamAId,
    @JsonKey(name: 'teamALogo') String? teamALogo,
    @JsonKey(name: 'teamAScore') String? teamAScore,
    @JsonKey(name: 'teamB') String? teamB,
    @JsonKey(name: 'teamBId') String? teamBId,
    @JsonKey(name: 'teamBLogo') String? teamBLogo,
    @JsonKey(name: 'teamBScore') String? teamBScore,
    @JsonKey(name: 'matchDate') String? matchDate,
    @JsonKey(name: 'matchTime') String? matchTime,
    @JsonKey(name: 'venue') String? venue,
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
  }) = _RefereeMatchModel;

  factory RefereeMatchModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeMatchModelFromJson(json);
}

/// Simple dropdown item used for tournament filter spinners.
@freezed
class TournamentDropdownItem with _$TournamentDropdownItem {
  const factory TournamentDropdownItem({
    @JsonKey(name: 'tournamentId') String? tournamentId,
    @JsonKey(name: 'tournamentName') String? tournamentName,
  }) = _TournamentDropdownItem;

  factory TournamentDropdownItem.fromJson(Map<String, dynamic> json) =>
      _$TournamentDropdownItemFromJson(json);
}
