import 'package:freezed_annotation/freezed_annotation.dart';

part 'academy_model.freezed.dart';
part 'academy_model.g.dart';

/// Model for academy from getUserAcademy API
@freezed
class AcademyModel with _$AcademyModel {
  const factory AcademyModel({
    @JsonKey(name: 'academyId') String? academyId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'imageUrl') String? imageUrl,
  }) = _AcademyModel;

  factory AcademyModel.fromJson(Map<String, dynamic> json) =>
      _$AcademyModelFromJson(json);
}
