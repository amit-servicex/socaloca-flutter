import 'package:freezed_annotation/freezed_annotation.dart';

part 'academy_model.freezed.dart';
part 'academy_model.g.dart';

/// Model for academy from getAcademyList API
@freezed
class AcademyModel with _$AcademyModel {
  const factory AcademyModel({
    @JsonKey(name: 'academyId') String? academyId,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'headOfAcademy') String? headOfAcademy,
    @JsonKey(name: 'director') String? director,
    @JsonKey(name: 'manager') String? manager,
    @JsonKey(name: 'countryCode') String? countryCode,
    @JsonKey(name: 'countryIso') String? countryIso,
    @JsonKey(name: 'mobile') String? mobile,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'formedYear') String? formedYear,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'liveTrial') String? liveTrial,
    @JsonKey(name: 'lat') String? lat,
    @JsonKey(name: 'lng') String? lng,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'about') String? about,
    @JsonKey(name: 'lastUpdateBy') String? lastUpdateBy,
    @JsonKey(name: 'module') String? module,
    @JsonKey(name: 'website') String? website,
    @JsonKey(name: 'createdOn') int? createdOn,
    @JsonKey(name: 'lastUpdated') int? lastUpdated,
    @JsonKey(name: 'isDelete') bool? isDelete,
    @JsonKey(name: 'verified') bool? verified,
    @JsonKey(name: 'verifyBadge') bool? verifyBadge,
    @JsonKey(name: 'profile') bool? profile,
    @JsonKey(name: 'following') bool? following,
    @JsonKey(name: 'survey') int? survey,
    @JsonKey(name: 'step') int? step,
    @JsonKey(name: 'seq') int? seq,
  }) = _AcademyModel;

  factory AcademyModel.fromJson(Map<String, dynamic> json) =>
      _$AcademyModelFromJson(json);
}
