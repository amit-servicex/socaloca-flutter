import 'package:freezed_annotation/freezed_annotation.dart';

part 'referee_tournament_model.freezed.dart';
part 'referee_tournament_model.g.dart';

/// Tournament assigned to the referee — used in the Tournament tab.
@freezed
class RefereeTournamentModel with _$RefereeTournamentModel {
  const factory RefereeTournamentModel({
    @JsonKey(name: 'tournamentId') String? tournamentId,
    @JsonKey(name: 'tournamentName') String? tournamentName,
    @JsonKey(name: 'tournamentImage') String? tournamentImage,
    @JsonKey(name: 'startDate') String? startDate,
    @JsonKey(name: 'endDate') String? endDate,
    @JsonKey(name: 'venue') String? venue,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'organiserName') String? organiserName,
    @JsonKey(name: 'ageGroup') String? ageGroup,
    // "ongoing" | "upcoming" | "closed"
    @JsonKey(name: 'status') String? status,
  }) = _RefereeTournamentModel;

  factory RefereeTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeTournamentModelFromJson(json);
}
