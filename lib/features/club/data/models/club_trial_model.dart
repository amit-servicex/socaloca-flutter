import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_trial_model.freezed.dart';
part 'club_trial_model.g.dart';

/// Trial listing entry — used by allClubTrials endpoint.
@freezed
class ClubTrialModel with _$ClubTrialModel {
  const factory ClubTrialModel({
    @JsonKey(name: 'trialId') String? trialId,
    @JsonKey(name: 'clubName') String? clubName,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'ageGroup') String? ageGroup,
    @JsonKey(name: 'startDate') String? startDate,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'imageUrl') String? imageUrl,
  }) = _ClubTrialModel;

  factory ClubTrialModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTrialModelFromJson(json);
}
