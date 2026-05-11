import 'package:freezed_annotation/freezed_annotation.dart';

part 'tagged_video_model.freezed.dart';
part 'tagged_video_model.g.dart';

/// Model for academy in tagged video
@freezed
class TaggedVideoAcademyModel with _$TaggedVideoAcademyModel {
  const factory TaggedVideoAcademyModel({
    @JsonKey(name: 'academyId') String? academyId,
    @JsonKey(name: 'name') String? name,
  }) = _TaggedVideoAcademyModel;

  factory TaggedVideoAcademyModel.fromJson(Map<String, dynamic> json) =>
      _$TaggedVideoAcademyModelFromJson(json);
}

/// Model for tagged video from getPlayerAcaVdos API
@freezed
class TaggedVideoModel with _$TaggedVideoModel {
  const factory TaggedVideoModel({
    @JsonKey(name: 'postId') String? postId,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'thumbnail') String? thumbnail,
    @JsonKey(name: 'addedOn') int? addedOn,
    @JsonKey(name: 'tags') List<String>? tags,
    @JsonKey(name: 'academy') TaggedVideoAcademyModel? academy,
  }) = _TaggedVideoModel;

  factory TaggedVideoModel.fromJson(Map<String, dynamic> json) =>
      _$TaggedVideoModelFromJson(json);
}
