import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

Object? _readId(Map json, String key) {
  final val = json['userId'] ?? json['_id'] ?? json['id'] ?? json['clubId'];
  return val?.toString() ?? '';
}

Object? _readStringFallback(Map json, String key) {
  return json[key]?.toString() ?? '';
}

Object? _readName(Map json, String key) {
  if (json['name'] != null) return json['name'];
  final f = json['firstName']?.toString() ?? '';
  final l = json['lastName']?.toString() ?? '';
  final combo = '$f $l'.trim();
  return combo.isEmpty ? null : combo;
}

Object? _readPost(Map json, String key) {
  if (json['post'] != null) return json['post'].toString();
  if (json['postCount'] != null) return json['postCount'].toString();
  return '0';
}

/// Standard user model (player, coach, referee, fan, etc.)
/// Mirrors the JSON stored in SharedPreferences key 'Msai1Q'
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'userId', readValue: _readId) required String id,
    @JsonKey(readValue: _readName) String? name,
    String? firstName,
    String? lastName,
    String? email,
    @JsonKey(name: 'profileName') String? username,
    @JsonKey(name: 'imageUrl') String? profileImage,
    String? coverImage,
    @JsonKey(name: 'type')
    String? userType, // 'player', 'coach', 'referee', 'fan', etc.
    @JsonKey(name: 'aboutMe') String? bio,
    String? country,
    @JsonKey(name: 'userLoc') String? city,
    @JsonKey(name: 'mobile') String? phone,
    String? dob,
    @JsonKey(name: 'verified') @Default(false) bool isVerified,
    @Default(false) bool isPrivate,
    @Default(false) bool isBlocked,
    @JsonKey(name: 'acceptPolicy')
    @Default(false)
    bool policyAccepted, // Added for policy acceptance check
    @Default(false) bool profile, // Has completed profile setup
    @Default(false) bool isPlayer, // Role flags from Android
    @Default(false) bool isCoach,
    @Default(false) bool isAdmin,
    @Default(false) bool isFan,
    bool? isReferee, // Nullable to handle explicit nulls from API
    @JsonKey(name: 'followCount') int? followersCount,
    int? followingCount,
    int? matchesCount,
    @JsonKey(readValue: _readPost) @Default('0') String post,
    @JsonKey(name: 'playPosition') String? preferredPosition,
    String? nationality,
    String? token,

    // Additional API fields
    String? sclId,
    String? socialId,
    String? media,
    String? countryIso,
    String? countryCode,
    int? signUpTime,
    int? lastOnline,
    String? lastDevice,
    @Default(false) bool autoverify,
    @Default(false) bool verifyBadge,
    String? ageGroup,
    String? passKey,
    String? deviceType,
    String? deviceId,
    String? deviceModel,
    String? consentId,
    @Default(false) bool isDelete,
    @JsonKey(name: 'postCount') int? postCount,
    List<String>? brands,
    String? fa,
    String? faName,
    String? gender,
    int? height,
    @Default(false) bool isParentalConsent,
    String? jerseySize,
    String? leagueFollow,
    String? nationalityIso,
    int? parentComment,
    int? parentLikeFollow,
    int? parentPhotoVideo,
    String? parentPin,
    String? playLevel,
    String? playPositionType,
    String? preferredFoot,
    String? preferredJersey,
    String? referByUserId,
    String? referCode,
    String? referId,
    String? registerCountry,
    String? shoeSize,
    String? shoeSizeUnit,
    String? teamFollow,
    String? university,
    double? userLat,
    List<dynamic>? userLatLng,
    double? userLng,
    int? acceptPolicyOn,
    int? age,
    String? lastUpdateDeviceModel,
    String? lastUpdateDeviceType,
    int? lastUpdated,
    String? region,
    double? endGoalkeeper,
    double? endMental,
    double? endOverall,
    double? endPhysical,
    double? endTechnical,
    // Skill category scores
    @JsonKey(name: 'FTC') double? ftc,
    @JsonKey(name: 'DRB') double? drb,
    @JsonKey(name: 'CRS') double? crs,
    @JsonKey(name: 'STM') double? stm,
    @Default(false) bool passChange,
    int? likeCount,
    List<dynamic>? tagVideos,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Club user model — stored in SharedPreferences key 'Msai1Q_club'
@freezed
class ClubUserModel with _$ClubUserModel {
  const factory ClubUserModel({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(readValue: _readStringFallback) required String clubName,
    @JsonKey(readValue: _readStringFallback) required String email,
    String? logo,
    String? coverImage,
    String? country,
    String? city,
    String? bio,
    String? phone,
    String? token,
    @Default(false) bool isVerified,
    @JsonKey(name: 'followCount') int? followersCount,
    String? subscriptionPlan,

    // Additional API fields
    @JsonKey(name: 'clubId') String? clubId,
    String? adminBy,
    bool? isRequest,
    bool? accepted,
    String? subdomain,
    String? partnerType,
    bool? isPartner,
    String? contractFrom,
    String? contractTo,
    int? contractFromGmt,
    int? contractToGmt,
    int? createdOn,
    String? mainType,
    String? subType,
    String? nickName,
    String? formedYear,
    List<dynamic>? stadium,
    String? manager,
    String? confed,
    String? league,
    List<String>? comps,
    String? website,
    bool? liveTrial,
    String? instruction,
    String? homeKit,
    String? awayKit,
    String? thirdKit,
    int? likeCount,
    int? plan,
    String? imageUrl,
    bool? profile,
    bool? isDelete,
    String? deviceType,
    List<dynamic>? officials,
    String? sclId,
    int? zendesk,
    int? zendesklead,
    String? lastUpdateBy,
    int? lastUpdated,
  }) = _ClubUserModel;

  factory ClubUserModel.fromJson(Map<String, dynamic> json) =>
      _$ClubUserModelFromJson(json);
}
