import 'package:freezed_annotation/freezed_annotation.dart';

part 'pickup_match_model.freezed.dart';
part 'pickup_match_model.g.dart';

@freezed
class PickupMatchModel with _$PickupMatchModel {
  const factory PickupMatchModel({
    required String id,
    required String hostId,
    required String hostName,
    String? hostImage,
    required String title,
    String? venue,
    String? matchDate,
    String? matchTime,
    String? country,
    String? city,
    double? latitude,
    double? longitude,
    @Default(0) int totalSlots,
    @Default(0) int filledSlots,
    @Default('open') String status,   // 'open', 'full', 'cancelled'
    @Default(false) bool hasRequested,
    @Default(false) bool isAccepted,
    String? description,
    String? ageGroup,
    String? skillLevel,
  }) = _PickupMatchModel;

  factory PickupMatchModel.fromJson(Map<String, dynamic> json) =>
      _$PickupMatchModelFromJson(json);
}
