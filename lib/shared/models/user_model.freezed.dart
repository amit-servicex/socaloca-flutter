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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  String? get userType =>
      throw _privateConstructorUsedError; // 'player', 'coach', 'referee', 'fan', etc.
  String? get bio => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;
  bool get policyAccepted =>
      throw _privateConstructorUsedError; // Added for policy acceptance check
  bool get profile =>
      throw _privateConstructorUsedError; // Has completed profile setup
  bool get isPlayer =>
      throw _privateConstructorUsedError; // Role flags from Android
  bool get isCoach => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isFan => throw _privateConstructorUsedError;
  bool get isReferee => throw _privateConstructorUsedError;
  int? get followersCount => throw _privateConstructorUsedError;
  int? get followingCount => throw _privateConstructorUsedError;
  int? get matchesCount => throw _privateConstructorUsedError;
  String? get preferredPosition => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

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
      {String id,
      String name,
      String? email,
      String? username,
      String? profileImage,
      String? coverImage,
      String? userType,
      String? bio,
      String? country,
      String? city,
      String? phone,
      String? dob,
      bool isVerified,
      bool isPrivate,
      bool isBlocked,
      bool policyAccepted,
      bool profile,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isFan,
      bool isReferee,
      int? followersCount,
      int? followingCount,
      int? matchesCount,
      String? preferredPosition,
      String? nationality,
      String? token});
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
    Object? name = null,
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
    Object? isReferee = null,
    Object? followersCount = freezed,
    Object? followingCount = freezed,
    Object? matchesCount = freezed,
    Object? preferredPosition = freezed,
    Object? nationality = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
      isReferee: null == isReferee
          ? _value.isReferee
          : isReferee // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {String id,
      String name,
      String? email,
      String? username,
      String? profileImage,
      String? coverImage,
      String? userType,
      String? bio,
      String? country,
      String? city,
      String? phone,
      String? dob,
      bool isVerified,
      bool isPrivate,
      bool isBlocked,
      bool policyAccepted,
      bool profile,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isFan,
      bool isReferee,
      int? followersCount,
      int? followingCount,
      int? matchesCount,
      String? preferredPosition,
      String? nationality,
      String? token});
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
    Object? name = null,
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
    Object? isReferee = null,
    Object? followersCount = freezed,
    Object? followingCount = freezed,
    Object? matchesCount = freezed,
    Object? preferredPosition = freezed,
    Object? nationality = freezed,
    Object? token = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
      isReferee: null == isReferee
          ? _value.isReferee
          : isReferee // ignore: cast_nullable_to_non_nullable
              as bool,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.name,
      this.email,
      this.username,
      this.profileImage,
      this.coverImage,
      this.userType,
      this.bio,
      this.country,
      this.city,
      this.phone,
      this.dob,
      this.isVerified = false,
      this.isPrivate = false,
      this.isBlocked = false,
      this.policyAccepted = false,
      this.profile = false,
      this.isPlayer = false,
      this.isCoach = false,
      this.isAdmin = false,
      this.isFan = false,
      this.isReferee = false,
      this.followersCount,
      this.followingCount,
      this.matchesCount,
      this.preferredPosition,
      this.nationality,
      this.token});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String? username;
  @override
  final String? profileImage;
  @override
  final String? coverImage;
  @override
  final String? userType;
// 'player', 'coach', 'referee', 'fan', etc.
  @override
  final String? bio;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? phone;
  @override
  final String? dob;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  @JsonKey()
  final bool isBlocked;
  @override
  @JsonKey()
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
  @JsonKey()
  final bool isReferee;
  @override
  final int? followersCount;
  @override
  final int? followingCount;
  @override
  final int? matchesCount;
  @override
  final String? preferredPosition;
  @override
  final String? nationality;
  @override
  final String? token;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, username: $username, profileImage: $profileImage, coverImage: $coverImage, userType: $userType, bio: $bio, country: $country, city: $city, phone: $phone, dob: $dob, isVerified: $isVerified, isPrivate: $isPrivate, isBlocked: $isBlocked, policyAccepted: $policyAccepted, profile: $profile, isPlayer: $isPlayer, isCoach: $isCoach, isAdmin: $isAdmin, isFan: $isFan, isReferee: $isReferee, followersCount: $followersCount, followingCount: $followingCount, matchesCount: $matchesCount, preferredPosition: $preferredPosition, nationality: $nationality, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
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
            (identical(other.preferredPosition, preferredPosition) ||
                other.preferredPosition == preferredPosition) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
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
        preferredPosition,
        nationality,
        token
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
      {required final String id,
      required final String name,
      final String? email,
      final String? username,
      final String? profileImage,
      final String? coverImage,
      final String? userType,
      final String? bio,
      final String? country,
      final String? city,
      final String? phone,
      final String? dob,
      final bool isVerified,
      final bool isPrivate,
      final bool isBlocked,
      final bool policyAccepted,
      final bool profile,
      final bool isPlayer,
      final bool isCoach,
      final bool isAdmin,
      final bool isFan,
      final bool isReferee,
      final int? followersCount,
      final int? followingCount,
      final int? matchesCount,
      final String? preferredPosition,
      final String? nationality,
      final String? token}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get email;
  @override
  String? get username;
  @override
  String? get profileImage;
  @override
  String? get coverImage;
  @override
  String? get userType;
  @override // 'player', 'coach', 'referee', 'fan', etc.
  String? get bio;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get phone;
  @override
  String? get dob;
  @override
  bool get isVerified;
  @override
  bool get isPrivate;
  @override
  bool get isBlocked;
  @override
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
  bool get isReferee;
  @override
  int? get followersCount;
  @override
  int? get followingCount;
  @override
  int? get matchesCount;
  @override
  String? get preferredPosition;
  @override
  String? get nationality;
  @override
  String? get token;
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
  String get id => throw _privateConstructorUsedError;
  String get clubName => throw _privateConstructorUsedError;
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
      {String id,
      String clubName,
      String email,
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
      {String id,
      String clubName,
      String email,
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
      {required this.id,
      required this.clubName,
      required this.email,
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
  final String id;
  @override
  final String clubName;
  @override
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
      {required final String id,
      required final String clubName,
      required final String email,
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
  String get id;
  @override
  String get clubName;
  @override
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
