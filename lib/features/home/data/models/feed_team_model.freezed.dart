// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedTeamModel _$FeedTeamModelFromJson(Map<String, dynamic> json) {
  return _FeedTeamModel.fromJson(json);
}

/// @nodoc
mixin _$FeedTeamModel {
  @JsonKey(name: 'teamId')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamName')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamLogo')
  String? get logo => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamCoverImage')
  String? get coverImage => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'adminId')
  String? get adminId => throw _privateConstructorUsedError;
  @JsonKey(name: 'adminName')
  String? get adminName => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'playerCount')
  int get playersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchCount')
  int get matchesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'followedByMe')
  bool get isFollowing => throw _privateConstructorUsedError;
  @JsonKey(name: 'followerCount')
  int get followersCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedTeamModelCopyWith<FeedTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedTeamModelCopyWith<$Res> {
  factory $FeedTeamModelCopyWith(
          FeedTeamModel value, $Res Function(FeedTeamModel) then) =
      _$FeedTeamModelCopyWithImpl<$Res, FeedTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'teamId') String id,
      @JsonKey(name: 'teamName') String name,
      @JsonKey(name: 'teamLogo') String? logo,
      @JsonKey(name: 'teamCoverImage') String? coverImage,
      String? country,
      String? city,
      @JsonKey(name: 'adminId') String? adminId,
      @JsonKey(name: 'adminName') String? adminName,
      String? bio,
      @JsonKey(name: 'playerCount') int playersCount,
      @JsonKey(name: 'matchCount') int matchesCount,
      @JsonKey(name: 'followedByMe') bool isFollowing,
      @JsonKey(name: 'followerCount') int followersCount});
}

/// @nodoc
class _$FeedTeamModelCopyWithImpl<$Res, $Val extends FeedTeamModel>
    implements $FeedTeamModelCopyWith<$Res> {
  _$FeedTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logo = freezed,
    Object? coverImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? adminId = freezed,
    Object? adminName = freezed,
    Object? bio = freezed,
    Object? playersCount = null,
    Object? matchesCount = null,
    Object? isFollowing = null,
    Object? followersCount = null,
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
      adminId: freezed == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminName: freezed == adminName
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      playersCount: null == playersCount
          ? _value.playersCount
          : playersCount // ignore: cast_nullable_to_non_nullable
              as int,
      matchesCount: null == matchesCount
          ? _value.matchesCount
          : matchesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedTeamModelImplCopyWith<$Res>
    implements $FeedTeamModelCopyWith<$Res> {
  factory _$$FeedTeamModelImplCopyWith(
          _$FeedTeamModelImpl value, $Res Function(_$FeedTeamModelImpl) then) =
      __$$FeedTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'teamId') String id,
      @JsonKey(name: 'teamName') String name,
      @JsonKey(name: 'teamLogo') String? logo,
      @JsonKey(name: 'teamCoverImage') String? coverImage,
      String? country,
      String? city,
      @JsonKey(name: 'adminId') String? adminId,
      @JsonKey(name: 'adminName') String? adminName,
      String? bio,
      @JsonKey(name: 'playerCount') int playersCount,
      @JsonKey(name: 'matchCount') int matchesCount,
      @JsonKey(name: 'followedByMe') bool isFollowing,
      @JsonKey(name: 'followerCount') int followersCount});
}

/// @nodoc
class __$$FeedTeamModelImplCopyWithImpl<$Res>
    extends _$FeedTeamModelCopyWithImpl<$Res, _$FeedTeamModelImpl>
    implements _$$FeedTeamModelImplCopyWith<$Res> {
  __$$FeedTeamModelImplCopyWithImpl(
      _$FeedTeamModelImpl _value, $Res Function(_$FeedTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logo = freezed,
    Object? coverImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? adminId = freezed,
    Object? adminName = freezed,
    Object? bio = freezed,
    Object? playersCount = null,
    Object? matchesCount = null,
    Object? isFollowing = null,
    Object? followersCount = null,
  }) {
    return _then(_$FeedTeamModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
      adminId: freezed == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      adminName: freezed == adminName
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      playersCount: null == playersCount
          ? _value.playersCount
          : playersCount // ignore: cast_nullable_to_non_nullable
              as int,
      matchesCount: null == matchesCount
          ? _value.matchesCount
          : matchesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedTeamModelImpl implements _FeedTeamModel {
  const _$FeedTeamModelImpl(
      {@JsonKey(name: 'teamId') required this.id,
      @JsonKey(name: 'teamName') required this.name,
      @JsonKey(name: 'teamLogo') this.logo,
      @JsonKey(name: 'teamCoverImage') this.coverImage,
      this.country,
      this.city,
      @JsonKey(name: 'adminId') this.adminId,
      @JsonKey(name: 'adminName') this.adminName,
      this.bio,
      @JsonKey(name: 'playerCount') this.playersCount = 0,
      @JsonKey(name: 'matchCount') this.matchesCount = 0,
      @JsonKey(name: 'followedByMe') this.isFollowing = false,
      @JsonKey(name: 'followerCount') this.followersCount = 0});

  factory _$FeedTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedTeamModelImplFromJson(json);

  @override
  @JsonKey(name: 'teamId')
  final String id;
  @override
  @JsonKey(name: 'teamName')
  final String name;
  @override
  @JsonKey(name: 'teamLogo')
  final String? logo;
  @override
  @JsonKey(name: 'teamCoverImage')
  final String? coverImage;
  @override
  final String? country;
  @override
  final String? city;
  @override
  @JsonKey(name: 'adminId')
  final String? adminId;
  @override
  @JsonKey(name: 'adminName')
  final String? adminName;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'playerCount')
  final int playersCount;
  @override
  @JsonKey(name: 'matchCount')
  final int matchesCount;
  @override
  @JsonKey(name: 'followedByMe')
  final bool isFollowing;
  @override
  @JsonKey(name: 'followerCount')
  final int followersCount;

  @override
  String toString() {
    return 'FeedTeamModel(id: $id, name: $name, logo: $logo, coverImage: $coverImage, country: $country, city: $city, adminId: $adminId, adminName: $adminName, bio: $bio, playersCount: $playersCount, matchesCount: $matchesCount, isFollowing: $isFollowing, followersCount: $followersCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.adminName, adminName) ||
                other.adminName == adminName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.playersCount, playersCount) ||
                other.playersCount == playersCount) &&
            (identical(other.matchesCount, matchesCount) ||
                other.matchesCount == matchesCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      logo,
      coverImage,
      country,
      city,
      adminId,
      adminName,
      bio,
      playersCount,
      matchesCount,
      isFollowing,
      followersCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedTeamModelImplCopyWith<_$FeedTeamModelImpl> get copyWith =>
      __$$FeedTeamModelImplCopyWithImpl<_$FeedTeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedTeamModelImplToJson(
      this,
    );
  }
}

abstract class _FeedTeamModel implements FeedTeamModel {
  const factory _FeedTeamModel(
          {@JsonKey(name: 'teamId') required final String id,
          @JsonKey(name: 'teamName') required final String name,
          @JsonKey(name: 'teamLogo') final String? logo,
          @JsonKey(name: 'teamCoverImage') final String? coverImage,
          final String? country,
          final String? city,
          @JsonKey(name: 'adminId') final String? adminId,
          @JsonKey(name: 'adminName') final String? adminName,
          final String? bio,
          @JsonKey(name: 'playerCount') final int playersCount,
          @JsonKey(name: 'matchCount') final int matchesCount,
          @JsonKey(name: 'followedByMe') final bool isFollowing,
          @JsonKey(name: 'followerCount') final int followersCount}) =
      _$FeedTeamModelImpl;

  factory _FeedTeamModel.fromJson(Map<String, dynamic> json) =
      _$FeedTeamModelImpl.fromJson;

  @override
  @JsonKey(name: 'teamId')
  String get id;
  @override
  @JsonKey(name: 'teamName')
  String get name;
  @override
  @JsonKey(name: 'teamLogo')
  String? get logo;
  @override
  @JsonKey(name: 'teamCoverImage')
  String? get coverImage;
  @override
  String? get country;
  @override
  String? get city;
  @override
  @JsonKey(name: 'adminId')
  String? get adminId;
  @override
  @JsonKey(name: 'adminName')
  String? get adminName;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'playerCount')
  int get playersCount;
  @override
  @JsonKey(name: 'matchCount')
  int get matchesCount;
  @override
  @JsonKey(name: 'followedByMe')
  bool get isFollowing;
  @override
  @JsonKey(name: 'followerCount')
  int get followersCount;
  @override
  @JsonKey(ignore: true)
  _$$FeedTeamModelImplCopyWith<_$FeedTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
