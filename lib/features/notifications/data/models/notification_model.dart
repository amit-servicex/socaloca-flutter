import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    @JsonKey(name: '_id') required String id,
    required String forUserId,
    required String notificationType,
    String? imageUrl,
    required String title,
    required String body,
    required Map<String, dynamic> payload,
    required bool seen,
    required int generatedOn,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
