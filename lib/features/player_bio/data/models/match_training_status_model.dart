import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_training_status_model.freezed.dart';
part 'match_training_status_model.g.dart';

/// Model for match and training status from getMiniActivity API
@freezed
class MatchTrainingStatusModel with _$MatchTrainingStatusModel {
  const factory MatchTrainingStatusModel({
    @JsonKey(name: 'matches') int? matches,
    @JsonKey(name: 'mins') int? mins,
    @JsonKey(name: 'goals') int? goals,
    @JsonKey(name: 'assists') int? assists,
    @JsonKey(name: 'rating') double? rating,
    @JsonKey(name: 'year') int? year,
    @JsonKey(name: 'cleanSheetCount') int? cleanSheetCount,
    @JsonKey(name: 'sessions') int? sessions, // for training
    @JsonKey(name: 'month') int? month, // for training
  }) = _MatchTrainingStatusModel;

  factory MatchTrainingStatusModel.fromJson(Map<String, dynamic> json) =>
      _$MatchTrainingStatusModelFromJson(json);
}
