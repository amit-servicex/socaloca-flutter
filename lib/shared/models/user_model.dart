import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Standard user model (player, coach, referee, fan, etc.)
/// Mirrors the JSON stored in SharedPreferences key 'Msai1Q'
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    String? email,
    String? username,
    String? profileImage,
    String? coverImage,
    String? userType, // 'player', 'coach', 'referee', 'fan', etc.
    String? bio,
    String? country,
    String? city,
    String? phone,
    String? dob,
    @Default(false) bool isVerified,
    @Default(false) bool isPrivate,
    @Default(false) bool isBlocked,
    @Default(false) bool policyAccepted, // Added for policy acceptance check
    @Default(false) bool profile, // Has completed profile setup
    @Default(false) bool isPlayer, // Role flags from Android
    @Default(false) bool isCoach,
    @Default(false) bool isAdmin,
    @Default(false) bool isFan,
    @Default(false) bool isReferee,
    int? followersCount,
    int? followingCount,
    int? matchesCount,
    String? preferredPosition,
    String? nationality,
    String? token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Club user model — stored in SharedPreferences key 'Msai1Q_club'
@freezed
class ClubUserModel with _$ClubUserModel {
  const factory ClubUserModel({
    required String id,
    required String clubName,
    required String email,
    String? logo,
    String? coverImage,
    String? country,
    String? city,
    String? bio,
    String? phone,
    String? token,
    @Default(false) bool isVerified,
    int? followersCount,
    String? subscriptionPlan,
  }) = _ClubUserModel;

  factory ClubUserModel.fromJson(Map<String, dynamic> json) =>
      _$ClubUserModelFromJson(json);
}
