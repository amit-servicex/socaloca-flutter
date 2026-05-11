import 'package:freezed_annotation/freezed_annotation.dart';

part 'endorsed_player_model.freezed.dart';
part 'endorsed_player_model.g.dart';

/// Model for most endorsed players (from getMostEndorsed API)
@freezed
class EndorsedPlayerModel with _$EndorsedPlayerModel {
  const factory EndorsedPlayerModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'position') String? position,
    @JsonKey(name: 'endorsementCount') @Default(0) int endorsementCount,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'userType') String? userType,
  }) = _EndorsedPlayerModel;

  factory EndorsedPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$EndorsedPlayerModelFromJson(json);
}
