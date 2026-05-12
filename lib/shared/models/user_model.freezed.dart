// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: 'userId', readValue: _readId)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readName)
  String? get name => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'profileName')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get profileImage => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get userType =>
      throw _privateConstructorUsedError; // 'player', 'coach', 'referee', 'fan', etc.
  @JsonKey(name: 'aboutMe')
  String? get bio => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'userLoc')
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile')
  String? get phone => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  @JsonKey(name: 'verified')
  bool get isVerified => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;
  @JsonKey(name: 'acceptPolicy')
  bool get policyAccepted =>
      throw _privateConstructorUsedError; // Added for policy acceptance check
  bool get profile =>
      throw _privateConstructorUsedError; // Has completed profile setup
  bool get isPlayer =>
      throw _privateConstructorUsedError; // Role flags from Android
  bool get isCoach => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isFan => throw _privateConstructorUsedError;
  bool? get isReferee =>
      throw _privateConstructorUsedError; // Nullable to handle explicit nulls from API
  @JsonKey(name: 'followCount')
  int? get followersCount => throw _privateConstructorUsedError;
  int? get followingCount => throw _privateConstructorUsedError;
  int? get matchesCount => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readPost)
  String get post => throw _privateConstructorUsedError;
  @JsonKey(name: 'playPosition')
  String? get preferredPosition => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get token =>
      throw _privateConstructorUsedError; // Additional API fields
  String? get sclId => throw _privateConstructorUsedError;
  String? get socialId => throw _privateConstructorUsedError;
  String? get media => throw _privateConstructorUsedError;
  String? get countryIso => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  int? get signUpTime => throw _privateConstructorUsedError;
  int? get lastOnline => throw _privateConstructorUsedError;
  String? get lastDevice => throw _privateConstructorUsedError;
  bool get autoverify => throw _privateConstructorUsedError;
  bool get verifyBadge => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  String? get passKey => throw _privateConstructorUsedError;
  String? get deviceType => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  String? get deviceModel => throw _privateConstructorUsedError;
  String? get consentId => throw _privateConstructorUsedError;
  bool get isDelete => throw _privateConstructorUsedError;
  @JsonKey(name: 'postCount')
  int? get postCount => throw _privateConstructorUsedError;
  List<String>? get brands => throw _privateConstructorUsedError;
  String? get fa => throw _privateConstructorUsedError;
  String? get faName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  bool get isParentalConsent => throw _privateConstructorUsedError;
  String? get jerseySize => throw _privateConstructorUsedError;
  String? get leagueFollow => throw _privateConstructorUsedError;
  String? get nationalityIso => throw _privateConstructorUsedError;
  int? get parentComment => throw _privateConstructorUsedError;
  int? get parentLikeFollow => throw _privateConstructorUsedError;
  int? get parentPhotoVideo => throw _privateConstructorUsedError;
  String? get parentPin => throw _privateConstructorUsedError;
  String? get playLevel => throw _privateConstructorUsedError;
  String? get playPositionType => throw _privateConstructorUsedError;
  String? get preferredFoot => throw _privateConstructorUsedError;
  String? get preferredJersey => throw _privateConstructorUsedError;
  String? get referByUserId => throw _privateConstructorUsedError;
  String? get referCode => throw _privateConstructorUsedError;
  String? get referId => throw _privateConstructorUsedError;
  String? get registerCountry => throw _privateConstructorUsedError;
  String? get shoeSize => throw _privateConstructorUsedError;
  String? get shoeSizeUnit => throw _privateConstructorUsedError;
  String? get teamFollow => throw _privateConstructorUsedError;
  String? get university => throw _privateConstructorUsedError;
  double? get userLat => throw _privateConstructorUsedError;
  List<dynamic>? get userLatLng => throw _privateConstructorUsedError;
  double? get userLng => throw _privateConstructorUsedError;
  int? get acceptPolicyOn => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get lastUpdateDeviceModel => throw _privateConstructorUsedError;
  String? get lastUpdateDeviceType => throw _privateConstructorUsedError;
  int? get lastUpdated => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  int? get endGoalkeeper => throw _privateConstructorUsedError;
  int? get endMental => throw _privateConstructorUsedError;
  int? get endOverall => throw _privateConstructorUsedError;
  int? get endPhysical => throw _privateConstructorUsedError;
  int? get endTechnical => throw _privateConstructorUsedError;
  bool get passChange => throw _privateConstructorUsedError;
  int? get likeCount => throw _privateConstructorUsedError;
  List<dynamic>? get tagVideos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userId', readValue: _readId) String id,
      @JsonKey(readValue: _readName) String? name,
      String? firstName,
      String? lastName,
      String? email,
      @JsonKey(name: 'profileName') String? username,
      @JsonKey(name: 'imageUrl') String? profileImage,
      String? coverImage,
      @JsonKey(name: 'type') String? userType,
      @JsonKey(name: 'aboutMe') String? bio,
      String? country,
      @JsonKey(name: 'userLoc') String? city,
      @JsonKey(name: 'mobile') String? phone,
      String? dob,
      @JsonKey(name: 'verified') bool isVerified,
      bool isPrivate,
      bool isBlocked,
      @JsonKey(name: 'acceptPolicy') bool policyAccepted,
      bool profile,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isFan,
      bool? isReferee,
      @JsonKey(name: 'followCount') int? followersCount,
      int? followingCount,
      int? matchesCount,
      @JsonKey(readValue: _readPost) String post,
      @JsonKey(name: 'playPosition') String? preferredPosition,
      String? nationality,
      String? token,
      String? sclId,
      String? socialId,
      String? media,
      String? countryIso,
      String? countryCode,
      int? signUpTime,
      int? lastOnline,
      String? lastDevice,
      bool autoverify,
      bool verifyBadge,
      String? ageGroup,
      String? passKey,
      String? deviceType,
      String? deviceId,
      String? deviceModel,
      String? consentId,
      bool isDelete,
      @JsonKey(name: 'postCount') int? postCount,
      List<String>? brands,
      String? fa,
      String? faName,
      String? gender,
      int? height,
      bool isParentalConsent,
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
      int? endGoalkeeper,
      int? endMental,
      int? endOverall,
      int? endPhysical,
      int? endTechnical,
      bool passChange,
      int? likeCount,
      List<dynamic>? tagVideos});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? profileImage = freezed,
    Object? coverImage = freezed,
    Object? userType = freezed,
    Object? bio = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? isVerified = null,
    Object? isPrivate = null,
    Object? isBlocked = null,
    Object? policyAccepted = null,
    Object? profile = null,
    Object? isPlayer = null,
    Object? isCoach = null,
    Object? isAdmin = null,
    Object? isFan = null,
    Object? isReferee = freezed,
    Object? followersCount = freezed,
    Object? followingCount = freezed,
    Object? matchesCount = freezed,
    Object? post = null,
    Object? preferredPosition = freezed,
    Object? nationality = freezed,
    Object? token = freezed,
    Object? sclId = freezed,
    Object? socialId = freezed,
    Object? media = freezed,
    Object? countryIso = freezed,
    Object? countryCode = freezed,
    Object? signUpTime = freezed,
    Object? lastOnline = freezed,
    Object? lastDevice = freezed,
    Object? autoverify = null,
    Object? verifyBadge = null,
    Object? ageGroup = freezed,
    Object? passKey = freezed,
    Object? deviceType = freezed,
    Object? deviceId = freezed,
    Object? deviceModel = freezed,
    Object? consentId = freezed,
    Object? isDelete = null,
    Object? postCount = freezed,
    Object? brands = freezed,
    Object? fa = freezed,
    Object? faName = freezed,
    Object? gender = freezed,
    Object? height = freezed,
    Object? isParentalConsent = null,
    Object? jerseySize = freezed,
    Object? leagueFollow = freezed,
    Object? nationalityIso = freezed,
    Object? parentComment = freezed,
    Object? parentLikeFollow = freezed,
    Object? parentPhotoVideo = freezed,
    Object? parentPin = freezed,
    Object? playLevel = freezed,
    Object? playPositionType = freezed,
    Object? preferredFoot = freezed,
    Object? preferredJersey = freezed,
    Object? referByUserId = freezed,
    Object? referCode = freezed,
    Object? referId = freezed,
    Object? registerCountry = freezed,
    Object? shoeSize = freezed,
    Object? shoeSizeUnit = freezed,
    Object? teamFollow = freezed,
    Object? university = freezed,
    Object? userLat = freezed,
    Object? userLatLng = freezed,
    Object? userLng = freezed,
    Object? acceptPolicyOn = freezed,
    Object? age = freezed,
    Object? lastUpdateDeviceModel = freezed,
    Object? lastUpdateDeviceType = freezed,
    Object? lastUpdated = freezed,
    Object? region = freezed,
    Object? endGoalkeeper = freezed,
    Object? endMental = freezed,
    Object? endOverall = freezed,
    Object? endPhysical = freezed,
    Object? endTechnical = freezed,
    Object? passChange = null,
    Object? likeCount = freezed,
    Object? tagVideos = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      policyAccepted: null == policyAccepted
          ? _value.policyAccepted
          : policyAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlayer: null == isPlayer
          ? _value.isPlayer
          : isPlayer // ignore: cast_nullable_to_non_nullable
              as bool,
      isCoach: null == isCoach
          ? _value.isCoach
          : isCoach // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isFan: null == isFan
          ? _value.isFan
          : isFan // ignore: cast_nullable_to_non_nullable
              as bool,
      isReferee: freezed == isReferee
          ? _value.isReferee
          : isReferee // ignore: cast_nullable_to_non_nullable
              as bool?,
      followersCount: freezed == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      followingCount: freezed == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int?,
      matchesCount: freezed == matchesCount
          ? _value.matchesCount
          : matchesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String,
      preferredPosition: freezed == preferredPosition
          ? _value.preferredPosition
          : preferredPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      sclId: freezed == sclId
          ? _value.sclId
          : sclId // ignore: cast_nullable_to_non_nullable
              as String?,
      socialId: freezed == socialId
          ? _value.socialId
          : socialId // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      countryIso: freezed == countryIso
          ? _value.countryIso
          : countryIso // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      signUpTime: freezed == signUpTime
          ? _value.signUpTime
          : signUpTime // ignore: cast_nullable_to_non_nullable
              as int?,
      lastOnline: freezed == lastOnline
          ? _value.lastOnline
          : lastOnline // ignore: cast_nullable_to_non_nullable
              as int?,
      lastDevice: freezed == lastDevice
          ? _value.lastDevice
          : lastDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      autoverify: null == autoverify
          ? _value.autoverify
          : autoverify // ignore: cast_nullable_to_non_nullable
              as bool,
      verifyBadge: null == verifyBadge
          ? _value.verifyBadge
          : verifyBadge // ignore: cast_nullable_to_non_nullable
              as bool,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      passKey: freezed == passKey
          ? _value.passKey
          : passKey // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceType: freezed == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      consentId: freezed == consentId
          ? _value.consentId
          : consentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      postCount: freezed == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int?,
      brands: freezed == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fa: freezed == fa
          ? _value.fa
          : fa // ignore: cast_nullable_to_non_nullable
              as String?,
      faName: freezed == faName
          ? _value.faName
          : faName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      isParentalConsent: null == isParentalConsent
          ? _value.isParentalConsent
          : isParentalConsent // ignore: cast_nullable_to_non_nullable
              as bool,
      jerseySize: freezed == jerseySize
          ? _value.jerseySize
          : jerseySize // ignore: cast_nullable_to_non_nullable
              as String?,
      leagueFollow: freezed == leagueFollow
          ? _value.leagueFollow
          : leagueFollow // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalityIso: freezed == nationalityIso
          ? _value.nationalityIso
          : nationalityIso // ignore: cast_nullable_to_non_nullable
              as String?,
      parentComment: freezed == parentComment
          ? _value.parentComment
          : parentComment // ignore: cast_nullable_to_non_nullable
              as int?,
      parentLikeFollow: freezed == parentLikeFollow
          ? _value.parentLikeFollow
          : parentLikeFollow // ignore: cast_nullable_to_non_nullable
              as int?,
      parentPhotoVideo: freezed == parentPhotoVideo
          ? _value.parentPhotoVideo
          : parentPhotoVideo // ignore: cast_nullable_to_non_nullable
              as int?,
      parentPin: freezed == parentPin
          ? _value.parentPin
          : parentPin // ignore: cast_nullable_to_non_nullable
              as String?,
      playLevel: freezed == playLevel
          ? _value.playLevel
          : playLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      playPositionType: freezed == playPositionType
          ? _value.playPositionType
          : playPositionType // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredFoot: freezed == preferredFoot
          ? _value.preferredFoot
          : preferredFoot // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredJersey: freezed == preferredJersey
          ? _value.preferredJersey
          : preferredJersey // ignore: cast_nullable_to_non_nullable
              as String?,
      referByUserId: freezed == referByUserId
          ? _value.referByUserId
          : referByUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      referCode: freezed == referCode
          ? _value.referCode
          : referCode // ignore: cast_nullable_to_non_nullable
              as String?,
      referId: freezed == referId
          ? _value.referId
          : referId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerCountry: freezed == registerCountry
          ? _value.registerCountry
          : registerCountry // ignore: cast_nullable_to_non_nullable
              as String?,
      shoeSize: freezed == shoeSize
          ? _value.shoeSize
          : shoeSize // ignore: cast_nullable_to_non_nullable
              as String?,
      shoeSizeUnit: freezed == shoeSizeUnit
          ? _value.shoeSizeUnit
          : shoeSizeUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      teamFollow: freezed == teamFollow
          ? _value.teamFollow
          : teamFollow // ignore: cast_nullable_to_non_nullable
              as String?,
      university: freezed == university
          ? _value.university
          : university // ignore: cast_nullable_to_non_nullable
              as String?,
      userLat: freezed == userLat
          ? _value.userLat
          : userLat // ignore: cast_nullable_to_non_nullable
              as double?,
      userLatLng: freezed == userLatLng
          ? _value.userLatLng
          : userLatLng // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      userLng: freezed == userLng
          ? _value.userLng
          : userLng // ignore: cast_nullable_to_non_nullable
              as double?,
      acceptPolicyOn: freezed == acceptPolicyOn
          ? _value.acceptPolicyOn
          : acceptPolicyOn // ignore: cast_nullable_to_non_nullable
              as int?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdateDeviceModel: freezed == lastUpdateDeviceModel
          ? _value.lastUpdateDeviceModel
          : lastUpdateDeviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdateDeviceType: freezed == lastUpdateDeviceType
          ? _value.lastUpdateDeviceType
          : lastUpdateDeviceType // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      endGoalkeeper: freezed == endGoalkeeper
          ? _value.endGoalkeeper
          : endGoalkeeper // ignore: cast_nullable_to_non_nullable
              as int?,
      endMental: freezed == endMental
          ? _value.endMental
          : endMental // ignore: cast_nullable_to_non_nullable
              as int?,
      endOverall: freezed == endOverall
          ? _value.endOverall
          : endOverall // ignore: cast_nullable_to_non_nullable
              as int?,
      endPhysical: freezed == endPhysical
          ? _value.endPhysical
          : endPhysical // ignore: cast_nullable_to_non_nullable
              as int?,
      endTechnical: freezed == endTechnical
          ? _value.endTechnical
          : endTechnical // ignore: cast_nullable_to_non_nullable
              as int?,
      passChange: null == passChange
          ? _value.passChange
          : passChange // ignore: cast_nullable_to_non_nullable
              as bool,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      tagVideos: freezed == tagVideos
          ? _value.tagVideos
          : tagVideos // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId', readValue: _readId) String id,
      @JsonKey(readValue: _readName) String? name,
      String? firstName,
      String? lastName,
      String? email,
      @JsonKey(name: 'profileName') String? username,
      @JsonKey(name: 'imageUrl') String? profileImage,
      String? coverImage,
      @JsonKey(name: 'type') String? userType,
      @JsonKey(name: 'aboutMe') String? bio,
      String? country,
      @JsonKey(name: 'userLoc') String? city,
      @JsonKey(name: 'mobile') String? phone,
      String? dob,
      @JsonKey(name: 'verified') bool isVerified,
      bool isPrivate,
      bool isBlocked,
      @JsonKey(name: 'acceptPolicy') bool policyAccepted,
      bool profile,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isFan,
      bool? isReferee,
      @JsonKey(name: 'followCount') int? followersCount,
      int? followingCount,
      int? matchesCount,
      @JsonKey(readValue: _readPost) String post,
      @JsonKey(name: 'playPosition') String? preferredPosition,
      String? nationality,
      String? token,
      String? sclId,
      String? socialId,
      String? media,
      String? countryIso,
      String? countryCode,
      int? signUpTime,
      int? lastOnline,
      String? lastDevice,
      bool autoverify,
      bool verifyBadge,
      String? ageGroup,
      String? passKey,
      String? deviceType,
      String? deviceId,
      String? deviceModel,
      String? consentId,
      bool isDelete,
      @JsonKey(name: 'postCount') int? postCount,
      List<String>? brands,
      String? fa,
      String? faName,
      String? gender,
      int? height,
      bool isParentalConsent,
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
      int? endGoalkeeper,
      int? endMental,
      int? endOverall,
      int? endPhysical,
      int? endTechnical,
      bool passChange,
      int? likeCount,
      List<dynamic>? tagVideos});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? profileImage = freezed,
    Object? coverImage = freezed,
    Object? userType = freezed,
    Object? bio = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
    Object? isVerified = null,
    Object? isPrivate = null,
    Object? isBlocked = null,
    Object? policyAccepted = null,
    Object? profile = null,
    Object? isPlayer = null,
    Object? isCoach = null,
    Object? isAdmin = null,
    Object? isFan = null,
    Object? isReferee = freezed,
    Object? followersCount = freezed,
    Object? followingCount = freezed,
    Object? matchesCount = freezed,
    Object? post = null,
    Object? preferredPosition = freezed,
    Object? nationality = freezed,
    Object? token = freezed,
    Object? sclId = freezed,
    Object? socialId = freezed,
    Object? media = freezed,
    Object? countryIso = freezed,
    Object? countryCode = freezed,
    Object? signUpTime = freezed,
    Object? lastOnline = freezed,
    Object? lastDevice = freezed,
    Object? autoverify = null,
    Object? verifyBadge = null,
    Object? ageGroup = freezed,
    Object? passKey = freezed,
    Object? deviceType = freezed,
    Object? deviceId = freezed,
    Object? deviceModel = freezed,
    Object? consentId = freezed,
    Object? isDelete = null,
    Object? postCount = freezed,
    Object? brands = freezed,
    Object? fa = freezed,
    Object? faName = freezed,
    Object? gender = freezed,
    Object? height = freezed,
    Object? isParentalConsent = null,
    Object? jerseySize = freezed,
    Object? leagueFollow = freezed,
    Object? nationalityIso = freezed,
    Object? parentComment = freezed,
    Object? parentLikeFollow = freezed,
    Object? parentPhotoVideo = freezed,
    Object? parentPin = freezed,
    Object? playLevel = freezed,
    Object? playPositionType = freezed,
    Object? preferredFoot = freezed,
    Object? preferredJersey = freezed,
    Object? referByUserId = freezed,
    Object? referCode = freezed,
    Object? referId = freezed,
    Object? registerCountry = freezed,
    Object? shoeSize = freezed,
    Object? shoeSizeUnit = freezed,
    Object? teamFollow = freezed,
    Object? university = freezed,
    Object? userLat = freezed,
    Object? userLatLng = freezed,
    Object? userLng = freezed,
    Object? acceptPolicyOn = freezed,
    Object? age = freezed,
    Object? lastUpdateDeviceModel = freezed,
    Object? lastUpdateDeviceType = freezed,
    Object? lastUpdated = freezed,
    Object? region = freezed,
    Object? endGoalkeeper = freezed,
    Object? endMental = freezed,
    Object? endOverall = freezed,
    Object? endPhysical = freezed,
    Object? endTechnical = freezed,
    Object? passChange = null,
    Object? likeCount = freezed,
    Object? tagVideos = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      policyAccepted: null == policyAccepted
          ? _value.policyAccepted
          : policyAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlayer: null == isPlayer
          ? _value.isPlayer
          : isPlayer // ignore: cast_nullable_to_non_nullable
              as bool,
      isCoach: null == isCoach
          ? _value.isCoach
          : isCoach // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isFan: null == isFan
          ? _value.isFan
          : isFan // ignore: cast_nullable_to_non_nullable
              as bool,
      isReferee: freezed == isReferee
          ? _value.isReferee
          : isReferee // ignore: cast_nullable_to_non_nullable
              as bool?,
      followersCount: freezed == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      followingCount: freezed == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int?,
      matchesCount: freezed == matchesCount
          ? _value.matchesCount
          : matchesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String,
      preferredPosition: freezed == preferredPosition
          ? _value.preferredPosition
          : preferredPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      sclId: freezed == sclId
          ? _value.sclId
          : sclId // ignore: cast_nullable_to_non_nullable
              as String?,
      socialId: freezed == socialId
          ? _value.socialId
          : socialId // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      countryIso: freezed == countryIso
          ? _value.countryIso
          : countryIso // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      signUpTime: freezed == signUpTime
          ? _value.signUpTime
          : signUpTime // ignore: cast_nullable_to_non_nullable
              as int?,
      lastOnline: freezed == lastOnline
          ? _value.lastOnline
          : lastOnline // ignore: cast_nullable_to_non_nullable
              as int?,
      lastDevice: freezed == lastDevice
          ? _value.lastDevice
          : lastDevice // ignore: cast_nullable_to_non_nullable
              as String?,
      autoverify: null == autoverify
          ? _value.autoverify
          : autoverify // ignore: cast_nullable_to_non_nullable
              as bool,
      verifyBadge: null == verifyBadge
          ? _value.verifyBadge
          : verifyBadge // ignore: cast_nullable_to_non_nullable
              as bool,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      passKey: freezed == passKey
          ? _value.passKey
          : passKey // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceType: freezed == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      consentId: freezed == consentId
          ? _value.consentId
          : consentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      postCount: freezed == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int?,
      brands: freezed == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fa: freezed == fa
          ? _value.fa
          : fa // ignore: cast_nullable_to_non_nullable
              as String?,
      faName: freezed == faName
          ? _value.faName
          : faName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      isParentalConsent: null == isParentalConsent
          ? _value.isParentalConsent
          : isParentalConsent // ignore: cast_nullable_to_non_nullable
              as bool,
      jerseySize: freezed == jerseySize
          ? _value.jerseySize
          : jerseySize // ignore: cast_nullable_to_non_nullable
              as String?,
      leagueFollow: freezed == leagueFollow
          ? _value.leagueFollow
          : leagueFollow // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalityIso: freezed == nationalityIso
          ? _value.nationalityIso
          : nationalityIso // ignore: cast_nullable_to_non_nullable
              as String?,
      parentComment: freezed == parentComment
          ? _value.parentComment
          : parentComment // ignore: cast_nullable_to_non_nullable
              as int?,
      parentLikeFollow: freezed == parentLikeFollow
          ? _value.parentLikeFollow
          : parentLikeFollow // ignore: cast_nullable_to_non_nullable
              as int?,
      parentPhotoVideo: freezed == parentPhotoVideo
          ? _value.parentPhotoVideo
          : parentPhotoVideo // ignore: cast_nullable_to_non_nullable
              as int?,
      parentPin: freezed == parentPin
          ? _value.parentPin
          : parentPin // ignore: cast_nullable_to_non_nullable
              as String?,
      playLevel: freezed == playLevel
          ? _value.playLevel
          : playLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      playPositionType: freezed == playPositionType
          ? _value.playPositionType
          : playPositionType // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredFoot: freezed == preferredFoot
          ? _value.preferredFoot
          : preferredFoot // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredJersey: freezed == preferredJersey
          ? _value.preferredJersey
          : preferredJersey // ignore: cast_nullable_to_non_nullable
              as String?,
      referByUserId: freezed == referByUserId
          ? _value.referByUserId
          : referByUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      referCode: freezed == referCode
          ? _value.referCode
          : referCode // ignore: cast_nullable_to_non_nullable
              as String?,
      referId: freezed == referId
          ? _value.referId
          : referId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerCountry: freezed == registerCountry
          ? _value.registerCountry
          : registerCountry // ignore: cast_nullable_to_non_nullable
              as String?,
      shoeSize: freezed == shoeSize
          ? _value.shoeSize
          : shoeSize // ignore: cast_nullable_to_non_nullable
              as String?,
      shoeSizeUnit: freezed == shoeSizeUnit
          ? _value.shoeSizeUnit
          : shoeSizeUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      teamFollow: freezed == teamFollow
          ? _value.teamFollow
          : teamFollow // ignore: cast_nullable_to_non_nullable
              as String?,
      university: freezed == university
          ? _value.university
          : university // ignore: cast_nullable_to_non_nullable
              as String?,
      userLat: freezed == userLat
          ? _value.userLat
          : userLat // ignore: cast_nullable_to_non_nullable
              as double?,
      userLatLng: freezed == userLatLng
          ? _value._userLatLng
          : userLatLng // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      userLng: freezed == userLng
          ? _value.userLng
          : userLng // ignore: cast_nullable_to_non_nullable
              as double?,
      acceptPolicyOn: freezed == acceptPolicyOn
          ? _value.acceptPolicyOn
          : acceptPolicyOn // ignore: cast_nullable_to_non_nullable
              as int?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdateDeviceModel: freezed == lastUpdateDeviceModel
          ? _value.lastUpdateDeviceModel
          : lastUpdateDeviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdateDeviceType: freezed == lastUpdateDeviceType
          ? _value.lastUpdateDeviceType
          : lastUpdateDeviceType // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      endGoalkeeper: freezed == endGoalkeeper
          ? _value.endGoalkeeper
          : endGoalkeeper // ignore: cast_nullable_to_non_nullable
              as int?,
      endMental: freezed == endMental
          ? _value.endMental
          : endMental // ignore: cast_nullable_to_non_nullable
              as int?,
      endOverall: freezed == endOverall
          ? _value.endOverall
          : endOverall // ignore: cast_nullable_to_non_nullable
              as int?,
      endPhysical: freezed == endPhysical
          ? _value.endPhysical
          : endPhysical // ignore: cast_nullable_to_non_nullable
              as int?,
      endTechnical: freezed == endTechnical
          ? _value.endTechnical
          : endTechnical // ignore: cast_nullable_to_non_nullable
              as int?,
      passChange: null == passChange
          ? _value.passChange
          : passChange // ignore: cast_nullable_to_non_nullable
              as bool,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      tagVideos: freezed == tagVideos
          ? _value._tagVideos
          : tagVideos // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@JsonKey(name: 'userId', readValue: _readId) required this.id,
      @JsonKey(readValue: _readName) this.name,
      this.firstName,
      this.lastName,
      this.email,
      @JsonKey(name: 'profileName') this.username,
      @JsonKey(name: 'imageUrl') this.profileImage,
      this.coverImage,
      @JsonKey(name: 'type') this.userType,
      @JsonKey(name: 'aboutMe') this.bio,
      this.country,
      @JsonKey(name: 'userLoc') this.city,
      @JsonKey(name: 'mobile') this.phone,
      this.dob,
      @JsonKey(name: 'verified') this.isVerified = false,
      this.isPrivate = false,
      this.isBlocked = false,
      @JsonKey(name: 'acceptPolicy') this.policyAccepted = false,
      this.profile = false,
      this.isPlayer = false,
      this.isCoach = false,
      this.isAdmin = false,
      this.isFan = false,
      this.isReferee,
      @JsonKey(name: 'followCount') this.followersCount,
      this.followingCount,
      this.matchesCount,
      @JsonKey(readValue: _readPost) this.post = '0',
      @JsonKey(name: 'playPosition') this.preferredPosition,
      this.nationality,
      this.token,
      this.sclId,
      this.socialId,
      this.media,
      this.countryIso,
      this.countryCode,
      this.signUpTime,
      this.lastOnline,
      this.lastDevice,
      this.autoverify = false,
      this.verifyBadge = false,
      this.ageGroup,
      this.passKey,
      this.deviceType,
      this.deviceId,
      this.deviceModel,
      this.consentId,
      this.isDelete = false,
      @JsonKey(name: 'postCount') this.postCount,
      final List<String>? brands,
      this.fa,
      this.faName,
      this.gender,
      this.height,
      this.isParentalConsent = false,
      this.jerseySize,
      this.leagueFollow,
      this.nationalityIso,
      this.parentComment,
      this.parentLikeFollow,
      this.parentPhotoVideo,
      this.parentPin,
      this.playLevel,
      this.playPositionType,
      this.preferredFoot,
      this.preferredJersey,
      this.referByUserId,
      this.referCode,
      this.referId,
      this.registerCountry,
      this.shoeSize,
      this.shoeSizeUnit,
      this.teamFollow,
      this.university,
      this.userLat,
      final List<dynamic>? userLatLng,
      this.userLng,
      this.acceptPolicyOn,
      this.age,
      this.lastUpdateDeviceModel,
      this.lastUpdateDeviceType,
      this.lastUpdated,
      this.region,
      this.endGoalkeeper,
      this.endMental,
      this.endOverall,
      this.endPhysical,
      this.endTechnical,
      this.passChange = false,
      this.likeCount,
      final List<dynamic>? tagVideos})
      : _brands = brands,
        _userLatLng = userLatLng,
        _tagVideos = tagVideos;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey(name: 'userId', readValue: _readId)
  final String id;
  @override
  @JsonKey(readValue: _readName)
  final String? name;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  @JsonKey(name: 'profileName')
  final String? username;
  @override
  @JsonKey(name: 'imageUrl')
  final String? profileImage;
  @override
  final String? coverImage;
  @override
  @JsonKey(name: 'type')
  final String? userType;
// 'player', 'coach', 'referee', 'fan', etc.
  @override
  @JsonKey(name: 'aboutMe')
  final String? bio;
  @override
  final String? country;
  @override
  @JsonKey(name: 'userLoc')
  final String? city;
  @override
  @JsonKey(name: 'mobile')
  final String? phone;
  @override
  final String? dob;
  @override
  @JsonKey(name: 'verified')
  final bool isVerified;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  @JsonKey()
  final bool isBlocked;
  @override
  @JsonKey(name: 'acceptPolicy')
  final bool policyAccepted;
// Added for policy acceptance check
  @override
  @JsonKey()
  final bool profile;
// Has completed profile setup
  @override
  @JsonKey()
  final bool isPlayer;
// Role flags from Android
  @override
  @JsonKey()
  final bool isCoach;
  @override
  @JsonKey()
  final bool isAdmin;
  @override
  @JsonKey()
  final bool isFan;
  @override
  final bool? isReferee;
// Nullable to handle explicit nulls from API
  @override
  @JsonKey(name: 'followCount')
  final int? followersCount;
  @override
  final int? followingCount;
  @override
  final int? matchesCount;
  @override
  @JsonKey(readValue: _readPost)
  final String post;
  @override
  @JsonKey(name: 'playPosition')
  final String? preferredPosition;
  @override
  final String? nationality;
  @override
  final String? token;
// Additional API fields
  @override
  final String? sclId;
  @override
  final String? socialId;
  @override
  final String? media;
  @override
  final String? countryIso;
  @override
  final String? countryCode;
  @override
  final int? signUpTime;
  @override
  final int? lastOnline;
  @override
  final String? lastDevice;
  @override
  @JsonKey()
  final bool autoverify;
  @override
  @JsonKey()
  final bool verifyBadge;
  @override
  final String? ageGroup;
  @override
  final String? passKey;
  @override
  final String? deviceType;
  @override
  final String? deviceId;
  @override
  final String? deviceModel;
  @override
  final String? consentId;
  @override
  @JsonKey()
  final bool isDelete;
  @override
  @JsonKey(name: 'postCount')
  final int? postCount;
  final List<String>? _brands;
  @override
  List<String>? get brands {
    final value = _brands;
    if (value == null) return null;
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? fa;
  @override
  final String? faName;
  @override
  final String? gender;
  @override
  final int? height;
  @override
  @JsonKey()
  final bool isParentalConsent;
  @override
  final String? jerseySize;
  @override
  final String? leagueFollow;
  @override
  final String? nationalityIso;
  @override
  final int? parentComment;
  @override
  final int? parentLikeFollow;
  @override
  final int? parentPhotoVideo;
  @override
  final String? parentPin;
  @override
  final String? playLevel;
  @override
  final String? playPositionType;
  @override
  final String? preferredFoot;
  @override
  final String? preferredJersey;
  @override
  final String? referByUserId;
  @override
  final String? referCode;
  @override
  final String? referId;
  @override
  final String? registerCountry;
  @override
  final String? shoeSize;
  @override
  final String? shoeSizeUnit;
  @override
  final String? teamFollow;
  @override
  final String? university;
  @override
  final double? userLat;
  final List<dynamic>? _userLatLng;
  @override
  List<dynamic>? get userLatLng {
    final value = _userLatLng;
    if (value == null) return null;
    if (_userLatLng is EqualUnmodifiableListView) return _userLatLng;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? userLng;
  @override
  final int? acceptPolicyOn;
  @override
  final int? age;
  @override
  final String? lastUpdateDeviceModel;
  @override
  final String? lastUpdateDeviceType;
  @override
  final int? lastUpdated;
  @override
  final String? region;
  @override
  final int? endGoalkeeper;
  @override
  final int? endMental;
  @override
  final int? endOverall;
  @override
  final int? endPhysical;
  @override
  final int? endTechnical;
  @override
  @JsonKey()
  final bool passChange;
  @override
  final int? likeCount;
  final List<dynamic>? _tagVideos;
  @override
  List<dynamic>? get tagVideos {
    final value = _tagVideos;
    if (value == null) return null;
    if (_tagVideos is EqualUnmodifiableListView) return _tagVideos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, firstName: $firstName, lastName: $lastName, email: $email, username: $username, profileImage: $profileImage, coverImage: $coverImage, userType: $userType, bio: $bio, country: $country, city: $city, phone: $phone, dob: $dob, isVerified: $isVerified, isPrivate: $isPrivate, isBlocked: $isBlocked, policyAccepted: $policyAccepted, profile: $profile, isPlayer: $isPlayer, isCoach: $isCoach, isAdmin: $isAdmin, isFan: $isFan, isReferee: $isReferee, followersCount: $followersCount, followingCount: $followingCount, matchesCount: $matchesCount, post: $post, preferredPosition: $preferredPosition, nationality: $nationality, token: $token, sclId: $sclId, socialId: $socialId, media: $media, countryIso: $countryIso, countryCode: $countryCode, signUpTime: $signUpTime, lastOnline: $lastOnline, lastDevice: $lastDevice, autoverify: $autoverify, verifyBadge: $verifyBadge, ageGroup: $ageGroup, passKey: $passKey, deviceType: $deviceType, deviceId: $deviceId, deviceModel: $deviceModel, consentId: $consentId, isDelete: $isDelete, postCount: $postCount, brands: $brands, fa: $fa, faName: $faName, gender: $gender, height: $height, isParentalConsent: $isParentalConsent, jerseySize: $jerseySize, leagueFollow: $leagueFollow, nationalityIso: $nationalityIso, parentComment: $parentComment, parentLikeFollow: $parentLikeFollow, parentPhotoVideo: $parentPhotoVideo, parentPin: $parentPin, playLevel: $playLevel, playPositionType: $playPositionType, preferredFoot: $preferredFoot, preferredJersey: $preferredJersey, referByUserId: $referByUserId, referCode: $referCode, referId: $referId, registerCountry: $registerCountry, shoeSize: $shoeSize, shoeSizeUnit: $shoeSizeUnit, teamFollow: $teamFollow, university: $university, userLat: $userLat, userLatLng: $userLatLng, userLng: $userLng, acceptPolicyOn: $acceptPolicyOn, age: $age, lastUpdateDeviceModel: $lastUpdateDeviceModel, lastUpdateDeviceType: $lastUpdateDeviceType, lastUpdated: $lastUpdated, region: $region, endGoalkeeper: $endGoalkeeper, endMental: $endMental, endOverall: $endOverall, endPhysical: $endPhysical, endTechnical: $endTechnical, passChange: $passChange, likeCount: $likeCount, tagVideos: $tagVideos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.policyAccepted, policyAccepted) ||
                other.policyAccepted == policyAccepted) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.isPlayer, isPlayer) ||
                other.isPlayer == isPlayer) &&
            (identical(other.isCoach, isCoach) || other.isCoach == isCoach) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isFan, isFan) || other.isFan == isFan) &&
            (identical(other.isReferee, isReferee) ||
                other.isReferee == isReferee) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.matchesCount, matchesCount) ||
                other.matchesCount == matchesCount) &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.preferredPosition, preferredPosition) ||
                other.preferredPosition == preferredPosition) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.sclId, sclId) || other.sclId == sclId) &&
            (identical(other.socialId, socialId) ||
                other.socialId == socialId) &&
            (identical(other.media, media) || other.media == media) &&
            (identical(other.countryIso, countryIso) ||
                other.countryIso == countryIso) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.signUpTime, signUpTime) ||
                other.signUpTime == signUpTime) &&
            (identical(other.lastOnline, lastOnline) ||
                other.lastOnline == lastOnline) &&
            (identical(other.lastDevice, lastDevice) ||
                other.lastDevice == lastDevice) &&
            (identical(other.autoverify, autoverify) ||
                other.autoverify == autoverify) &&
            (identical(other.verifyBadge, verifyBadge) ||
                other.verifyBadge == verifyBadge) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.passKey, passKey) || other.passKey == passKey) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.consentId, consentId) ||
                other.consentId == consentId) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            (identical(other.fa, fa) || other.fa == fa) &&
            (identical(other.faName, faName) || other.faName == faName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.isParentalConsent, isParentalConsent) ||
                other.isParentalConsent == isParentalConsent) &&
            (identical(other.jerseySize, jerseySize) ||
                other.jerseySize == jerseySize) &&
            (identical(other.leagueFollow, leagueFollow) ||
                other.leagueFollow == leagueFollow) &&
            (identical(other.nationalityIso, nationalityIso) ||
                other.nationalityIso == nationalityIso) &&
            (identical(other.parentComment, parentComment) ||
                other.parentComment == parentComment) &&
            (identical(other.parentLikeFollow, parentLikeFollow) ||
                other.parentLikeFollow == parentLikeFollow) &&
            (identical(other.parentPhotoVideo, parentPhotoVideo) ||
                other.parentPhotoVideo == parentPhotoVideo) &&
            (identical(other.parentPin, parentPin) ||
                other.parentPin == parentPin) &&
            (identical(other.playLevel, playLevel) ||
                other.playLevel == playLevel) &&
            (identical(other.playPositionType, playPositionType) ||
                other.playPositionType == playPositionType) &&
            (identical(other.preferredFoot, preferredFoot) ||
                other.preferredFoot == preferredFoot) &&
            (identical(other.preferredJersey, preferredJersey) || other.preferredJersey == preferredJersey) &&
            (identical(other.referByUserId, referByUserId) || other.referByUserId == referByUserId) &&
            (identical(other.referCode, referCode) || other.referCode == referCode) &&
            (identical(other.referId, referId) || other.referId == referId) &&
            (identical(other.registerCountry, registerCountry) || other.registerCountry == registerCountry) &&
            (identical(other.shoeSize, shoeSize) || other.shoeSize == shoeSize) &&
            (identical(other.shoeSizeUnit, shoeSizeUnit) || other.shoeSizeUnit == shoeSizeUnit) &&
            (identical(other.teamFollow, teamFollow) || other.teamFollow == teamFollow) &&
            (identical(other.university, university) || other.university == university) &&
            (identical(other.userLat, userLat) || other.userLat == userLat) &&
            const DeepCollectionEquality().equals(other._userLatLng, _userLatLng) &&
            (identical(other.userLng, userLng) || other.userLng == userLng) &&
            (identical(other.acceptPolicyOn, acceptPolicyOn) || other.acceptPolicyOn == acceptPolicyOn) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.lastUpdateDeviceModel, lastUpdateDeviceModel) || other.lastUpdateDeviceModel == lastUpdateDeviceModel) &&
            (identical(other.lastUpdateDeviceType, lastUpdateDeviceType) || other.lastUpdateDeviceType == lastUpdateDeviceType) &&
            (identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.endGoalkeeper, endGoalkeeper) || other.endGoalkeeper == endGoalkeeper) &&
            (identical(other.endMental, endMental) || other.endMental == endMental) &&
            (identical(other.endOverall, endOverall) || other.endOverall == endOverall) &&
            (identical(other.endPhysical, endPhysical) || other.endPhysical == endPhysical) &&
            (identical(other.endTechnical, endTechnical) || other.endTechnical == endTechnical) &&
            (identical(other.passChange, passChange) || other.passChange == passChange) &&
            (identical(other.likeCount, likeCount) || other.likeCount == likeCount) &&
            const DeepCollectionEquality().equals(other._tagVideos, _tagVideos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        firstName,
        lastName,
        email,
        username,
        profileImage,
        coverImage,
        userType,
        bio,
        country,
        city,
        phone,
        dob,
        isVerified,
        isPrivate,
        isBlocked,
        policyAccepted,
        profile,
        isPlayer,
        isCoach,
        isAdmin,
        isFan,
        isReferee,
        followersCount,
        followingCount,
        matchesCount,
        post,
        preferredPosition,
        nationality,
        token,
        sclId,
        socialId,
        media,
        countryIso,
        countryCode,
        signUpTime,
        lastOnline,
        lastDevice,
        autoverify,
        verifyBadge,
        ageGroup,
        passKey,
        deviceType,
        deviceId,
        deviceModel,
        consentId,
        isDelete,
        postCount,
        const DeepCollectionEquality().hash(_brands),
        fa,
        faName,
        gender,
        height,
        isParentalConsent,
        jerseySize,
        leagueFollow,
        nationalityIso,
        parentComment,
        parentLikeFollow,
        parentPhotoVideo,
        parentPin,
        playLevel,
        playPositionType,
        preferredFoot,
        preferredJersey,
        referByUserId,
        referCode,
        referId,
        registerCountry,
        shoeSize,
        shoeSizeUnit,
        teamFollow,
        university,
        userLat,
        const DeepCollectionEquality().hash(_userLatLng),
        userLng,
        acceptPolicyOn,
        age,
        lastUpdateDeviceModel,
        lastUpdateDeviceType,
        lastUpdated,
        region,
        endGoalkeeper,
        endMental,
        endOverall,
        endPhysical,
        endTechnical,
        passChange,
        likeCount,
        const DeepCollectionEquality().hash(_tagVideos)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {@JsonKey(name: 'userId', readValue: _readId) required final String id,
      @JsonKey(readValue: _readName) final String? name,
      final String? firstName,
      final String? lastName,
      final String? email,
      @JsonKey(name: 'profileName') final String? username,
      @JsonKey(name: 'imageUrl') final String? profileImage,
      final String? coverImage,
      @JsonKey(name: 'type') final String? userType,
      @JsonKey(name: 'aboutMe') final String? bio,
      final String? country,
      @JsonKey(name: 'userLoc') final String? city,
      @JsonKey(name: 'mobile') final String? phone,
      final String? dob,
      @JsonKey(name: 'verified') final bool isVerified,
      final bool isPrivate,
      final bool isBlocked,
      @JsonKey(name: 'acceptPolicy') final bool policyAccepted,
      final bool profile,
      final bool isPlayer,
      final bool isCoach,
      final bool isAdmin,
      final bool isFan,
      final bool? isReferee,
      @JsonKey(name: 'followCount') final int? followersCount,
      final int? followingCount,
      final int? matchesCount,
      @JsonKey(readValue: _readPost) final String post,
      @JsonKey(name: 'playPosition') final String? preferredPosition,
      final String? nationality,
      final String? token,
      final String? sclId,
      final String? socialId,
      final String? media,
      final String? countryIso,
      final String? countryCode,
      final int? signUpTime,
      final int? lastOnline,
      final String? lastDevice,
      final bool autoverify,
      final bool verifyBadge,
      final String? ageGroup,
      final String? passKey,
      final String? deviceType,
      final String? deviceId,
      final String? deviceModel,
      final String? consentId,
      final bool isDelete,
      @JsonKey(name: 'postCount') final int? postCount,
      final List<String>? brands,
      final String? fa,
      final String? faName,
      final String? gender,
      final int? height,
      final bool isParentalConsent,
      final String? jerseySize,
      final String? leagueFollow,
      final String? nationalityIso,
      final int? parentComment,
      final int? parentLikeFollow,
      final int? parentPhotoVideo,
      final String? parentPin,
      final String? playLevel,
      final String? playPositionType,
      final String? preferredFoot,
      final String? preferredJersey,
      final String? referByUserId,
      final String? referCode,
      final String? referId,
      final String? registerCountry,
      final String? shoeSize,
      final String? shoeSizeUnit,
      final String? teamFollow,
      final String? university,
      final double? userLat,
      final List<dynamic>? userLatLng,
      final double? userLng,
      final int? acceptPolicyOn,
      final int? age,
      final String? lastUpdateDeviceModel,
      final String? lastUpdateDeviceType,
      final int? lastUpdated,
      final String? region,
      final int? endGoalkeeper,
      final int? endMental,
      final int? endOverall,
      final int? endPhysical,
      final int? endTechnical,
      final bool passChange,
      final int? likeCount,
      final List<dynamic>? tagVideos}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @JsonKey(name: 'userId', readValue: _readId)
  String get id;
  @override
  @JsonKey(readValue: _readName)
  String? get name;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  @JsonKey(name: 'profileName')
  String? get username;
  @override
  @JsonKey(name: 'imageUrl')
  String? get profileImage;
  @override
  String? get coverImage;
  @override
  @JsonKey(name: 'type')
  String? get userType;
  @override // 'player', 'coach', 'referee', 'fan', etc.
  @JsonKey(name: 'aboutMe')
  String? get bio;
  @override
  String? get country;
  @override
  @JsonKey(name: 'userLoc')
  String? get city;
  @override
  @JsonKey(name: 'mobile')
  String? get phone;
  @override
  String? get dob;
  @override
  @JsonKey(name: 'verified')
  bool get isVerified;
  @override
  bool get isPrivate;
  @override
  bool get isBlocked;
  @override
  @JsonKey(name: 'acceptPolicy')
  bool get policyAccepted;
  @override // Added for policy acceptance check
  bool get profile;
  @override // Has completed profile setup
  bool get isPlayer;
  @override // Role flags from Android
  bool get isCoach;
  @override
  bool get isAdmin;
  @override
  bool get isFan;
  @override
  bool? get isReferee;
  @override // Nullable to handle explicit nulls from API
  @JsonKey(name: 'followCount')
  int? get followersCount;
  @override
  int? get followingCount;
  @override
  int? get matchesCount;
  @override
  @JsonKey(readValue: _readPost)
  String get post;
  @override
  @JsonKey(name: 'playPosition')
  String? get preferredPosition;
  @override
  String? get nationality;
  @override
  String? get token;
  @override // Additional API fields
  String? get sclId;
  @override
  String? get socialId;
  @override
  String? get media;
  @override
  String? get countryIso;
  @override
  String? get countryCode;
  @override
  int? get signUpTime;
  @override
  int? get lastOnline;
  @override
  String? get lastDevice;
  @override
  bool get autoverify;
  @override
  bool get verifyBadge;
  @override
  String? get ageGroup;
  @override
  String? get passKey;
  @override
  String? get deviceType;
  @override
  String? get deviceId;
  @override
  String? get deviceModel;
  @override
  String? get consentId;
  @override
  bool get isDelete;
  @override
  @JsonKey(name: 'postCount')
  int? get postCount;
  @override
  List<String>? get brands;
  @override
  String? get fa;
  @override
  String? get faName;
  @override
  String? get gender;
  @override
  int? get height;
  @override
  bool get isParentalConsent;
  @override
  String? get jerseySize;
  @override
  String? get leagueFollow;
  @override
  String? get nationalityIso;
  @override
  int? get parentComment;
  @override
  int? get parentLikeFollow;
  @override
  int? get parentPhotoVideo;
  @override
  String? get parentPin;
  @override
  String? get playLevel;
  @override
  String? get playPositionType;
  @override
  String? get preferredFoot;
  @override
  String? get preferredJersey;
  @override
  String? get referByUserId;
  @override
  String? get referCode;
  @override
  String? get referId;
  @override
  String? get registerCountry;
  @override
  String? get shoeSize;
  @override
  String? get shoeSizeUnit;
  @override
  String? get teamFollow;
  @override
  String? get university;
  @override
  double? get userLat;
  @override
  List<dynamic>? get userLatLng;
  @override
  double? get userLng;
  @override
  int? get acceptPolicyOn;
  @override
  int? get age;
  @override
  String? get lastUpdateDeviceModel;
  @override
  String? get lastUpdateDeviceType;
  @override
  int? get lastUpdated;
  @override
  String? get region;
  @override
  int? get endGoalkeeper;
  @override
  int? get endMental;
  @override
  int? get endOverall;
  @override
  int? get endPhysical;
  @override
  int? get endTechnical;
  @override
  bool get passChange;
  @override
  int? get likeCount;
  @override
  List<dynamic>? get tagVideos;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubUserModel _$ClubUserModelFromJson(Map<String, dynamic> json) {
  return _ClubUserModel.fromJson(json);
}

/// @nodoc
mixin _$ClubUserModel {
  @JsonKey(readValue: _readId)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readStringFallback)
  String get clubName => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readStringFallback)
  String get email => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  int? get followersCount => throw _privateConstructorUsedError;
  String? get subscriptionPlan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubUserModelCopyWith<ClubUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubUserModelCopyWith<$Res> {
  factory $ClubUserModelCopyWith(
          ClubUserModel value, $Res Function(ClubUserModel) then) =
      _$ClubUserModelCopyWithImpl<$Res, ClubUserModel>;
  @useResult
  $Res call(
      {@JsonKey(readValue: _readId) String id,
      @JsonKey(readValue: _readStringFallback) String clubName,
      @JsonKey(readValue: _readStringFallback) String email,
      String? logo,
      String? coverImage,
      String? country,
      String? city,
      String? bio,
      String? phone,
      String? token,
      bool isVerified,
      int? followersCount,
      String? subscriptionPlan});
}

/// @nodoc
class _$ClubUserModelCopyWithImpl<$Res, $Val extends ClubUserModel>
    implements $ClubUserModelCopyWith<$Res> {
  _$ClubUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubName = null,
    Object? email = null,
    Object? logo = freezed,
    Object? coverImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? bio = freezed,
    Object? phone = freezed,
    Object? token = freezed,
    Object? isVerified = null,
    Object? followersCount = freezed,
    Object? subscriptionPlan = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      followersCount: freezed == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      subscriptionPlan: freezed == subscriptionPlan
          ? _value.subscriptionPlan
          : subscriptionPlan // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubUserModelImplCopyWith<$Res>
    implements $ClubUserModelCopyWith<$Res> {
  factory _$$ClubUserModelImplCopyWith(
          _$ClubUserModelImpl value, $Res Function(_$ClubUserModelImpl) then) =
      __$$ClubUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(readValue: _readId) String id,
      @JsonKey(readValue: _readStringFallback) String clubName,
      @JsonKey(readValue: _readStringFallback) String email,
      String? logo,
      String? coverImage,
      String? country,
      String? city,
      String? bio,
      String? phone,
      String? token,
      bool isVerified,
      int? followersCount,
      String? subscriptionPlan});
}

/// @nodoc
class __$$ClubUserModelImplCopyWithImpl<$Res>
    extends _$ClubUserModelCopyWithImpl<$Res, _$ClubUserModelImpl>
    implements _$$ClubUserModelImplCopyWith<$Res> {
  __$$ClubUserModelImplCopyWithImpl(
      _$ClubUserModelImpl _value, $Res Function(_$ClubUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubName = null,
    Object? email = null,
    Object? logo = freezed,
    Object? coverImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? bio = freezed,
    Object? phone = freezed,
    Object? token = freezed,
    Object? isVerified = null,
    Object? followersCount = freezed,
    Object? subscriptionPlan = freezed,
  }) {
    return _then(_$ClubUserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      followersCount: freezed == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      subscriptionPlan: freezed == subscriptionPlan
          ? _value.subscriptionPlan
          : subscriptionPlan // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubUserModelImpl implements _ClubUserModel {
  const _$ClubUserModelImpl(
      {@JsonKey(readValue: _readId) required this.id,
      @JsonKey(readValue: _readStringFallback) required this.clubName,
      @JsonKey(readValue: _readStringFallback) required this.email,
      this.logo,
      this.coverImage,
      this.country,
      this.city,
      this.bio,
      this.phone,
      this.token,
      this.isVerified = false,
      this.followersCount,
      this.subscriptionPlan});

  factory _$ClubUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubUserModelImplFromJson(json);

  @override
  @JsonKey(readValue: _readId)
  final String id;
  @override
  @JsonKey(readValue: _readStringFallback)
  final String clubName;
  @override
  @JsonKey(readValue: _readStringFallback)
  final String email;
  @override
  final String? logo;
  @override
  final String? coverImage;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? bio;
  @override
  final String? phone;
  @override
  final String? token;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final int? followersCount;
  @override
  final String? subscriptionPlan;

  @override
  String toString() {
    return 'ClubUserModel(id: $id, clubName: $clubName, email: $email, logo: $logo, coverImage: $coverImage, country: $country, city: $city, bio: $bio, phone: $phone, token: $token, isVerified: $isVerified, followersCount: $followersCount, subscriptionPlan: $subscriptionPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.subscriptionPlan, subscriptionPlan) ||
                other.subscriptionPlan == subscriptionPlan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clubName,
      email,
      logo,
      coverImage,
      country,
      city,
      bio,
      phone,
      token,
      isVerified,
      followersCount,
      subscriptionPlan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubUserModelImplCopyWith<_$ClubUserModelImpl> get copyWith =>
      __$$ClubUserModelImplCopyWithImpl<_$ClubUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubUserModelImplToJson(
      this,
    );
  }
}

abstract class _ClubUserModel implements ClubUserModel {
  const factory _ClubUserModel(
      {@JsonKey(readValue: _readId) required final String id,
      @JsonKey(readValue: _readStringFallback) required final String clubName,
      @JsonKey(readValue: _readStringFallback) required final String email,
      final String? logo,
      final String? coverImage,
      final String? country,
      final String? city,
      final String? bio,
      final String? phone,
      final String? token,
      final bool isVerified,
      final int? followersCount,
      final String? subscriptionPlan}) = _$ClubUserModelImpl;

  factory _ClubUserModel.fromJson(Map<String, dynamic> json) =
      _$ClubUserModelImpl.fromJson;

  @override
  @JsonKey(readValue: _readId)
  String get id;
  @override
  @JsonKey(readValue: _readStringFallback)
  String get clubName;
  @override
  @JsonKey(readValue: _readStringFallback)
  String get email;
  @override
  String? get logo;
  @override
  String? get coverImage;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get bio;
  @override
  String? get phone;
  @override
  String? get token;
  @override
  bool get isVerified;
  @override
  int? get followersCount;
  @override
  String? get subscriptionPlan;
  @override
  @JsonKey(ignore: true)
  _$$ClubUserModelImplCopyWith<_$ClubUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
