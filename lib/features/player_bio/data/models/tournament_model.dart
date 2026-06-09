import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';
part 'tournament_model.g.dart';

/// Model for tournament from getPlayerTmnts API
@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
    @JsonKey(name: 'tournamentId') String? tmntId,
    @JsonKey(name: 'name') String? tmntName,
    @JsonKey(name: 'logo') String? imageUrl,
    String? status,
    String? tmntType,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);
}
