import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_model.freezed.dart';
part 'player_model.g.dart';

/// Model for player data from getFanPlayers API
@freezed
class PlayerModel with _$PlayerModel {
  const factory PlayerModel({
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'playerId') String? playerId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'playPosition') String? playPosition,
    @JsonKey(name: 'playPositionType') String? playPositionType,
    @JsonKey(name: 'teamJerseyNo') String? teamJerseyNo,
    @JsonKey(name: 'yearOfBirth') String? yearOfBirth,
    @JsonKey(name: 'dob') String? dob,
    @JsonKey(name: 'nationality') String? nationality,
    @JsonKey(name: 'isPlayer') @Default(false) bool isPlayer,
    @JsonKey(name: 'isCoach') @Default(false) bool isCoach,
    @JsonKey(name: 'isAdmin') @Default(false) bool isAdmin,
    @JsonKey(name: 'goalCount') @Default(0) int goalCount,
    @JsonKey(name: 'assistCount') @Default(0) int assistCount,
    @JsonKey(name: 'momCount') @Default(0) int momCount,
    @JsonKey(name: 'rCard') @Default(0) int rCard,
    @JsonKey(name: 'yCard') @Default(0) int yCard,
    @JsonKey(name: 'lastOnline') int? lastOnline,
  }) = _PlayerModel;

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
}
