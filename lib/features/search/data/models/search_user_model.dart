import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user_model.freezed.dart';
part 'search_user_model.g.dart';

@freezed
class SearchUserModel with _$SearchUserModel {
  const factory SearchUserModel({
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: '_id') String? id,
    required String firstName,
    required String lastName,
    String? profileName,
    @JsonKey(name: 'imageUrl') String? profileImage,
    String? country,
    String? playPosition,
    @Default(false) bool isPlayer,
    @Default(false) bool isCoach,
    @Default(false) bool isAdmin,
    @Default(false) bool isReferee,
    @Default(false) bool isFan,
    @Default(0) int appearance,
    @Default(0) int goals,
    @Default(0) int postCount,
    @Default(0) int endorsedBy,
    @Default(0) int followers,
  }) = _SearchUserModel;

  factory SearchUserModel.fromJson(Map<String, dynamic> json) =>
      _$SearchUserModelFromJson(json);
}

/// Extension for computed properties
extension SearchUserModelX on SearchUserModel {
  String get fullName => '$firstName $lastName'.trim();

  String get userType {
    if (isPlayer) return 'Player';
    if (isCoach) return 'Coach';
    if (isAdmin) return 'Manager';
    if (isReferee) return 'Referee';
    if (isFan) return 'Fan';
    return 'User';
  }
}
