import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/api_constants.dart';

part 'club_player_model.freezed.dart';
part 'club_player_model.g.dart';

@freezed
class ClubPlayerModel with _$ClubPlayerModel {
  const factory ClubPlayerModel({
    required String userId,
    String? firstName,
    String? lastName,
    String? position,
    String? imageUrl,
    @Default(0) int jersey,
    @Default(0) int seq,
  }) = _ClubPlayerModel;

  factory ClubPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$ClubPlayerModelFromJson(json);

  /// Custom factory to handle API response with image URL conversion
  factory ClubPlayerModel.fromApiJson(Map<String, dynamic> json) {
    final mappedJson = {
      'userId': json['userId'] ?? json['_id'],
      'firstName': json['firstName'],
      'lastName': json['lastName'],
      'position': json['position'],
      'imageUrl': json['imageUrl'],
      'jersey': json['jersey'] ?? 0,
      'seq': json['seq'] ?? 0,
    };

    return ClubPlayerModel.fromJson(mappedJson);
  }
}

/// Extension methods for ClubPlayerModel
extension ClubPlayerModelX on ClubPlayerModel {
  /// Get full name
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  /// Get full image URL
  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}
