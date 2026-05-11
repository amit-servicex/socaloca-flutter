import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_stats_model.freezed.dart';
part 'game_stats_model.g.dart';

/// Model for game stats (Football/Futsal) from getPlayerStats API
@freezed
class GameStatsModel with _$GameStatsModel {
  const factory GameStatsModel({
    @JsonKey(name: 'matchCount') @Default(0) int matchCount,
    @JsonKey(name: 'goalCount') @Default(0) int goalCount,
    @JsonKey(name: 'assistCount') @Default(0) int assistCount,
    @JsonKey(name: 'yellowCardCount') @Default(0) int yellowCardCount,
    @JsonKey(name: 'redCardCount') @Default(0) int redCardCount,
    @JsonKey(name: 'mvpCount') @Default(0) int mvpCount,
    @JsonKey(name: 'cleanSheetCount') @Default(0) int cleanSheetCount,
    @JsonKey(name: 'gameType') String? gameType,
    @JsonKey(name: 'year') int? year,
  }) = _GameStatsModel;

  factory GameStatsModel.fromJson(Map<String, dynamic> json) =>
      _$GameStatsModelFromJson(json);
}
