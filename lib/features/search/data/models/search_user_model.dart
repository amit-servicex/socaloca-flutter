import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user_model.freezed.dart';
part 'search_user_model.g.dart';

Object? _readEndorseBy(Map<dynamic, dynamic> json, String key) =>
    json['endorsedBy'] ?? json['endorseBy'];

Object? _readFollowers(Map<dynamic, dynamic> json, String key) =>
    json['followers'] ?? json['followCount'];

@freezed
class SearchUserModel with _$SearchUserModel {
  const factory SearchUserModel({
    @JsonKey(name: 'userId') @Default('') String userId,
    @JsonKey(name: '_id') String? id,
    @Default('') String firstName,
    @Default('') String lastName,
    String? profileName,
    @JsonKey(name: 'imageUrl') String? profileImage,
    String? country,
    String? nationality,
    String? playPosition,
    String? playPositionType,
    @Default(false) bool isPlayer,
    @Default(false) bool isCoach,
    @Default(false) bool isAdmin,
    @Default(false) bool isReferee,
    @Default(false) bool isFan,
    @Default(0) int appearance,
    @Default(0) int appearCount,
    @Default(0) int selfAppearCount,
    @Default(0) int goals,
    @Default(0) int postCount,
    @JsonKey(readValue: _readEndorseBy) @Default(0) int endorsedBy,
    @JsonKey(readValue: _readFollowers) @Default(0) int followers,
  }) = _SearchUserModel;

  factory SearchUserModel.fromJson(Map<String, dynamic> json) =>
      _$SearchUserModelFromJson(json);
}

/// Extension for computed properties
extension SearchUserModelX on SearchUserModel {
  String get fullName => '$firstName $lastName'.trim();

  String get displayNationality => nationality ?? country ?? '';

  String get positionText {
    if (playPosition == null || playPosition!.isEmpty) return '';
    if (playPositionType == null || playPositionType!.isEmpty) {
      return playPosition!;
    }
    return '$playPosition | $playPositionType';
  }

  int get refereeMatchCount {
    if (appearCount > 0) return appearCount;
    if (selfAppearCount > 0) return selfAppearCount;
    return 0;
  }

  String get userType {
    if (isPlayer) return 'Player';
    if (isCoach) return 'Coach';
    if (isAdmin) return 'Manager';
    if (isReferee) return 'Referee';
    if (isFan) return 'Fan';
    return 'User';
  }
}
