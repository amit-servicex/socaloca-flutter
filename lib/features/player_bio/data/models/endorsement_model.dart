import 'package:freezed_annotation/freezed_annotation.dart';

part 'endorsement_model.freezed.dart';
part 'endorsement_model.g.dart';

int? _toInt(dynamic v) =>
    v == null ? null : (v is num ? v.toInt() : int.tryParse(v.toString()));

/// Model for endorser user details
@freezed
class EndorserUserModel with _$EndorserUserModel {
  const factory EndorserUserModel({
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'isPlayer') bool? isPlayer,
    @JsonKey(name: 'isCoach') bool? isCoach,
    @JsonKey(name: 'isAdmin') bool? isAdmin,
    @JsonKey(name: 'isFan') bool? isFan,
  }) = _EndorserUserModel;

  factory EndorserUserModel.fromJson(Map<String, dynamic> json) =>
      _$EndorserUserModelFromJson(json);
}

/// Model for academy in endorsement
@freezed
class EndorsementAcademyModel with _$EndorsementAcademyModel {
  const factory EndorsementAcademyModel({
    @JsonKey(name: 'academyId') String? academyId,
    @JsonKey(name: 'name') String? name,
  }) = _EndorsementAcademyModel;

  factory EndorsementAcademyModel.fromJson(Map<String, dynamic> json) =>
      _$EndorsementAcademyModelFromJson(json);
}

/// Model for endorsement from getEndorses API
@freezed
class EndorsementModel with _$EndorsementModel {
  const factory EndorsementModel({
    @JsonKey(name: 'comment') String? comment,
    @JsonKey(name: 'addedOn') int? addedOn,
    @JsonKey(name: 'published') int? published,
    @JsonKey(name: 'userDetails') EndorserUserModel? userDetails,
    @JsonKey(name: 'academy') EndorsementAcademyModel? academy,
  }) = _EndorsementModel;

  factory EndorsementModel.fromJson(Map<String, dynamic> json) =>
      _$EndorsementModelFromJson({
        ...json,
        'addedOn': _toInt(json['addedOn']),
        'published': _toInt(json['published']),
      });
}
