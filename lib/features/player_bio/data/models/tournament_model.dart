import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';
part 'tournament_model.g.dart';

/// Model for tournament from getPlayerTmnts API
@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
    @JsonKey(name: 'tmntId') String? tmntId,
    @JsonKey(name: 'tmntName') String? tmntName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);
}
