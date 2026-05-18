import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';
part 'tournament_model.g.dart';

@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
    required String id,
    required String name,
    String? logo,
    String? coverImage,
    String? status, // 'upcoming', 'ongoing', 'closed'
    String? startDate,
    String? endDate,
    String? country,
    String? city,
    String? organizerId,
    String? organizerName,
    @Default(0) int teamsCount,
    @Default(false) bool isFollowing,
    String? format, // 'league', 'cup_group', 'cup_knockout'
    String? description,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);
}

@freezed
class StandingsRow with _$StandingsRow {
  const factory StandingsRow({
    required int position,
    required String teamId,
    required String teamName,
    String? teamLogo,
    @Default(0) int played,
    @Default(0) int won,
    @Default(0) int drawn,
    @Default(0) int lost,
    @Default(0) int goalsFor,
    @Default(0) int goalsAgainst,
    @Default(0) int goalDifference,
    @Default(0) int points,
  }) = _StandingsRow;

  factory StandingsRow.fromJson(Map<String, dynamic> json) =>
      _$StandingsRowFromJson(json);
}

@freezed
class TrialModel with _$TrialModel {
  const factory TrialModel({
    required String id,
    required String organizerId,
    required String organizerName,
    String? organizerLogo,
    String? organizerType, // 'club', 'academy', 'fa'
    required String title,
    String? description,
    String? trialDate,
    String? venue,
    String? country,
    String? ageGroup,
    String? position,
    @Default(false) bool isRegistered,
  }) = _TrialModel;

  factory TrialModel.fromJson(Map<String, dynamic> json) =>
      _$TrialModelFromJson(json);
}
