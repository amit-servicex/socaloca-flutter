import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/api_constants.dart';

part 'club_sponsor_model.freezed.dart';
part 'club_sponsor_model.g.dart';

@freezed
class ClubSponsorModel with _$ClubSponsorModel {
  const factory ClubSponsorModel({
    required String sponsorId,
    String? name,
    String? imageUrl,
    @Default(0) int seq,
  }) = _ClubSponsorModel;

  factory ClubSponsorModel.fromJson(Map<String, dynamic> json) =>
      _$ClubSponsorModelFromJson(json);

  /// Custom factory to handle API response with image URL conversion
  factory ClubSponsorModel.fromApiJson(Map<String, dynamic> json) {
    final mappedJson = {
      'sponsorId': json['sponsorId'] ?? json['_id'],
      'name': json['name'],
      'imageUrl': json['imageUrl'],
      'seq': json['seq'] ?? 0,
    };

    return ClubSponsorModel.fromJson(mappedJson);
  }
}

/// Extension methods for ClubSponsorModel
extension ClubSponsorModelX on ClubSponsorModel {
  /// Get full image URL
  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}
