import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_match_model.freezed.dart';
part 'pickup_match_model.g.dart';

/// Pickup Match Model - mirrors Android PickUpMatch.java
@freezed
class PickupMatchModel with _$PickupMatchModel {
  const factory PickupMatchModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') String? matchId,
    @JsonKey(name: 'createdBy') String? createdBy,
    @JsonKey(name: 'createdByName') String? createdByName,
    @JsonKey(name: 'createdByImage') String? createdByImage,
    String? gameType,
    String? gender,
    String? country,
    String? city,
    String? venueName,
    String? locationName,
    @Default(0.0) double locationLat,
    @Default(0.0) double locationLng,
    String? matchDate,
    String? startTime,
    String? endTime,
    @Default(0) int startTimeGmt,
    @Default(0) int endTimeGmt,
    String? avgAge,
    @Default(0) int maxPlayer,
    String? matchNote,
    @Default(false) bool isDelete,
    @Default(true) bool active,
    @Default(0) int createdOn,
    @Default(0) int requestCount,
    @Default(0) int acceptedCount,
    @Default(false) bool isRequested,
    @Default(false) bool isAccepted,
    @Default(false) bool isRejected,
    @Default(false) bool isCancelled,
    String? requestStatus, // 'pending', 'accepted', 'declined', or null
  }) = _PickupMatchModel;

  factory PickupMatchModel.fromJson(Map<String, dynamic> json) =>
      _$PickupMatchModelFromJson(json);
}

extension PickupMatchModelX on PickupMatchModel {
  String get effectiveId => matchId ?? id ?? '';
}
