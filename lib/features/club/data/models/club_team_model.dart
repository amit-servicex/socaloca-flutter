import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/api_constants.dart';

part 'club_team_model.freezed.dart';
part 'club_team_model.g.dart';

@freezed
class ClubTeamModel with _$ClubTeamModel {
  const factory ClubTeamModel({
    required String teamId,
    String? teamName,
    String? imageUrl,
    @Default(0) int seq,
  }) = _ClubTeamModel;

  factory ClubTeamModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTeamModelFromJson(json);

  /// Custom factory to handle API response with image URL conversion
  factory ClubTeamModel.fromApiJson(Map<String, dynamic> json) {
    final mappedJson = {
      'teamId': json['teamId'] ?? json['_id'],
      'teamName': json['teamName'],
      'imageUrl': json['imageUrl'],
      'seq': json['seq'] ?? 0,
    };

    return ClubTeamModel.fromJson(mappedJson);
  }
}

/// Extension methods for ClubTeamModel
extension ClubTeamModelX on ClubTeamModel {
  /// Get full image URL
  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}
