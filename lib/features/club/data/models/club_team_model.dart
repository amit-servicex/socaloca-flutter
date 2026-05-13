import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/api_constants.dart';

part 'club_team_model.freezed.dart';
part 'club_team_model.g.dart';

@freezed
class ClubTeamModel with _$ClubTeamModel {
  const factory ClubTeamModel({
    required String teamId,
    @JsonKey(name: '_id') String? id,
    String? createdBy,
    String? clubId,
    String? teamName,
    String? teamShortName,
    String? imageUrl,
    String? country,
    String? city,
    String? fa,
    @Default(false) bool clubTeam,
    @Default(0) int seq,
    String? gender,
    String? ageGroup,
    String? ageCat,
    String? gameType,
    int? createdOn,
    @Default(0) int followCount,
    @Default(false) bool archive,
    @Default([]) List<String> admins,
    @Default([]) List<String> teamPlayers,
    @Default([]) List<String> coaches,
    @Default([]) List<String> managers,
    @Default(false) bool directTeam,
    @Default(0.0) double rating,
    @Default(0) int ratingCounter,
    @Default(false) bool isDelete,
    String? lastUpdateBy,
    int? lastUpdated,
  }) = _ClubTeamModel;

  factory ClubTeamModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTeamModelFromJson(json);

  /// Custom factory to handle API response with image URL conversion
  factory ClubTeamModel.fromApiJson(Map<String, dynamic> json) {
    final mappedJson = Map<String, dynamic>.from(json);

    mappedJson['teamId'] = json['teamId'] ?? json['_id'] ?? '';
    mappedJson['seq'] = json['seq'] ?? 0;
    mappedJson['rating'] = (json['rating'] as num?)?.toDouble() ?? 0.0;

    return ClubTeamModel.fromJson(mappedJson);
  }
}

/// Extension methods for ClubTeamModel
extension ClubTeamModelX on ClubTeamModel {
  /// Get full image URL
  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}
