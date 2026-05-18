import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_trial_model.freezed.dart';
part 'club_trial_model.g.dart';

int _readInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _readDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

/// Shared trial listing entry for club and academy trials.
@freezed
class ClubTrialModel with _$ClubTrialModel {
  const ClubTrialModel._();

  const factory ClubTrialModel({
    @JsonKey(name: '_id') String? id,
    String? trialId,
    String? clubId,
    String? faId,
    String? trialType,
    String? trialName,
    String? registerDateFrom,
    String? registerDateTo,
    @JsonKey(fromJson: _readInt) @Default(0) int registerDateFromGmt,
    @JsonKey(fromJson: _readInt) @Default(0) int registerDateToGmt,
    String? trialDateFrom,
    String? trialDateTo,
    @JsonKey(fromJson: _readInt) @Default(0) int trialDateFromGmt,
    @JsonKey(fromJson: _readInt) @Default(0) int trialDateToGmt,
    String? currency,
    String? gender,
    String? brief,
    String? location,
    String? trialVenue,
    @JsonKey(fromJson: _readInt) @Default(0) int ageFrom,
    @JsonKey(fromJson: _readInt) @Default(0) int ageTo,
    @JsonKey(fromJson: _readDouble) @Default(0) double lat,
    @JsonKey(fromJson: _readDouble) @Default(0) double lng,
    @JsonKey(fromJson: _readInt) @Default(0) int cost,
    @Default(false) bool isDelete,
    @Default(false) bool active,
    ClubTrialOrgModel? clubDetails,
    ClubTrialOrgModel? academyDetails,
    ClubTrialStatusModel? trialStatus,
  }) = _ClubTrialModel;

  factory ClubTrialModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTrialModelFromJson(json);

  String get displayName =>
      clubDetails?.displayName ?? academyDetails?.displayName ?? '';

  String get displayEmail => clubDetails?.email ?? academyDetails?.email ?? '';

  String get displayImage =>
      clubDetails?.imageUrl ?? academyDetails?.imageUrl ?? '';

  String get providerId =>
      clubDetails?.providerId ??
      academyDetails?.providerId ??
      clubId ??
      faId ??
      '';

  String get effectiveTrialId => trialId ?? id ?? '';
}

@freezed
class ClubTrialOrgModel with _$ClubTrialOrgModel {
  const ClubTrialOrgModel._();

  const factory ClubTrialOrgModel({
    @JsonKey(name: '_id') String? id,
    String? clubId,
    String? academyId,
    String? clubName,
    String? name,
    String? email,
    String? imageUrl,
  }) = _ClubTrialOrgModel;

  factory ClubTrialOrgModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTrialOrgModelFromJson(json);

  String get displayName => clubName ?? name ?? '';

  String get providerId => clubId ?? academyId ?? id ?? '';
}

@freezed
class ClubTrialStatusModel with _$ClubTrialStatusModel {
  const factory ClubTrialStatusModel({
    @Default(false) bool expire,
    @Default(false) bool canRegister,
    @Default(false) bool live,
    @Default(false) bool registered,
  }) = _ClubTrialStatusModel;

  factory ClubTrialStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTrialStatusModelFromJson(json);
}
