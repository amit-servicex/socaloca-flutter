import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String type,
    required String title,
    required String body,
    String? senderId,
    String? senderName,
    String? senderImage,
    String? referenceId, // matchId, teamId, tournamentId, etc.
    String? referenceType, // 'match', 'team', 'tournament', 'social'
    @Default(false) bool isRead,
    String? createdAt,
    Map<String, dynamic>? data,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
