import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_player_stats_model.freezed.dart';
part 'club_player_stats_model.g.dart';

/// Player stats for a single sport (football or futsal).
/// Populated from the getPlayerStats API response.
@freezed
class ClubPlayerStatsModel with _$ClubPlayerStatsModel {
  const factory ClubPlayerStatsModel({
    @JsonKey(name: 'matchCount') @Default(0) int matchCount,
    @JsonKey(name: 'goalCount') @Default(0) int goalCount,
    @JsonKey(name: 'assistCount') @Default(0) int assistCount,
    @JsonKey(name: 'yellowCardCount') @Default(0) int yellowCardCount,
    @JsonKey(name: 'redCardCount') @Default(0) int redCardCount,
    @JsonKey(name: 'mvpCount') @Default(0) int mvpCount,
  }) = _ClubPlayerStatsModel;

  factory ClubPlayerStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ClubPlayerStatsModelFromJson(json);
}

/// Wrapper holding both football and futsal stats from getPlayerStats.
class ClubPlayerStatsResult {
  final ClubPlayerStatsModel? football;
  final ClubPlayerStatsModel? futsal;

  const ClubPlayerStatsResult({this.football, this.futsal});
}
