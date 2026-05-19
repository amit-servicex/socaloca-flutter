// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchUserModel _$SearchUserModelFromJson(Map<String, dynamic> json) {
  return _SearchUserModel.fromJson(json);
}

/// @nodoc
mixin _$SearchUserModel {
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get profileName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get profileImage => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get playPosition => throw _privateConstructorUsedError;
  String? get playPositionType => throw _privateConstructorUsedError;
  bool get isPlayer => throw _privateConstructorUsedError;
  bool get isCoach => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isReferee => throw _privateConstructorUsedError;
  bool get isFan => throw _privateConstructorUsedError;
  int get appearance => throw _privateConstructorUsedError;
  int get appearCount => throw _privateConstructorUsedError;
  int get selfAppearCount => throw _privateConstructorUsedError;
  int get goals => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readEndorseBy)
  int get endorsedBy => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readFollowers)
  int get followers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchUserModelCopyWith<SearchUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchUserModelCopyWith<$Res> {
  factory $SearchUserModelCopyWith(
          SearchUserModel value, $Res Function(SearchUserModel) then) =
      _$SearchUserModelCopyWithImpl<$Res, SearchUserModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String userId,
      @JsonKey(name: '_id') String? id,
      String firstName,
      String lastName,
      String? profileName,
      @JsonKey(name: 'imageUrl') String? profileImage,
      String? country,
      String? nationality,
      String? playPosition,
      String? playPositionType,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isReferee,
      bool isFan,
      int appearance,
      int appearCount,
      int selfAppearCount,
      int goals,
      int postCount,
      @JsonKey(readValue: _readEndorseBy) int endorsedBy,
      @JsonKey(readValue: _readFollowers) int followers});
}

/// @nodoc
class _$SearchUserModelCopyWithImpl<$Res, $Val extends SearchUserModel>
    implements $SearchUserModelCopyWith<$Res> {
  _$SearchUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? profileName = freezed,
    Object? profileImage = freezed,
    Object? country = freezed,
    Object? nationality = freezed,
    Object? playPosition = freezed,
    Object? playPositionType = freezed,
    Object? isPlayer = null,
    Object? isCoach = null,
    Object? isAdmin = null,
    Object? isReferee = null,
    Object? isFan = null,
    Object? appearance = null,
    Object? appearCount = null,
    Object? selfAppearCount = null,
    Object? goals = null,
    Object? postCount = null,
    Object? endorsedBy = null,
    Object? followers = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      profileName: freezed == profileName
          ? _value.profileName
          : profileName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      playPosition: freezed == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      playPositionType: freezed == playPositionType
          ? _value.playPositionType
          : playPositionType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isReferee: null == isReferee
          ? _value.isReferee
          : isReferee // ignore: cast_nullable_to_non_nullable
              as bool,
      isFan: null == isFan
          ? _value.isFan
          : isFan // ignore: cast_nullable_to_non_nullable
              as bool,
      appearance: null == appearance
          ? _value.appearance
          : appearance // ignore: cast_nullable_to_non_nullable
              as int,
      appearCount: null == appearCount
          ? _value.appearCount
          : appearCount // ignore: cast_nullable_to_non_nullable
              as int,
      selfAppearCount: null == selfAppearCount
          ? _value.selfAppearCount
          : selfAppearCount // ignore: cast_nullable_to_non_nullable
              as int,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as int,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      endorsedBy: null == endorsedBy
          ? _value.endorsedBy
          : endorsedBy // ignore: cast_nullable_to_non_nullable
              as int,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchUserModelImplCopyWith<$Res>
    implements $SearchUserModelCopyWith<$Res> {
  factory _$$SearchUserModelImplCopyWith(_$SearchUserModelImpl value,
          $Res Function(_$SearchUserModelImpl) then) =
      __$$SearchUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userId') String userId,
      @JsonKey(name: '_id') String? id,
      String firstName,
      String lastName,
      String? profileName,
      @JsonKey(name: 'imageUrl') String? profileImage,
      String? country,
      String? nationality,
      String? playPosition,
      String? playPositionType,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isReferee,
      bool isFan,
      int appearance,
      int appearCount,
      int selfAppearCount,
      int goals,
      int postCount,
      @JsonKey(readValue: _readEndorseBy) int endorsedBy,
      @JsonKey(readValue: _readFollowers) int followers});
}

/// @nodoc
class __$$SearchUserModelImplCopyWithImpl<$Res>
    extends _$SearchUserModelCopyWithImpl<$Res, _$SearchUserModelImpl>
    implements _$$SearchUserModelImplCopyWith<$Res> {
  __$$SearchUserModelImplCopyWithImpl(
      _$SearchUserModelImpl _value, $Res Function(_$SearchUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? profileName = freezed,
    Object? profileImage = freezed,
    Object? country = freezed,
    Object? nationality = freezed,
    Object? playPosition = freezed,
    Object? playPositionType = freezed,
    Object? isPlayer = null,
    Object? isCoach = null,
    Object? isAdmin = null,
    Object? isReferee = null,
    Object? isFan = null,
    Object? appearance = null,
    Object? appearCount = null,
    Object? selfAppearCount = null,
    Object? goals = null,
    Object? postCount = null,
    Object? endorsedBy = null,
    Object? followers = null,
  }) {
    return _then(_$SearchUserModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      profileName: freezed == profileName
          ? _value.profileName
          : profileName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      playPosition: freezed == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      playPositionType: freezed == playPositionType
          ? _value.playPositionType
          : playPositionType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isReferee: null == isReferee
          ? _value.isReferee
          : isReferee // ignore: cast_nullable_to_non_nullable
              as bool,
      isFan: null == isFan
          ? _value.isFan
          : isFan // ignore: cast_nullable_to_non_nullable
              as bool,
      appearance: null == appearance
          ? _value.appearance
          : appearance // ignore: cast_nullable_to_non_nullable
              as int,
      appearCount: null == appearCount
          ? _value.appearCount
          : appearCount // ignore: cast_nullable_to_non_nullable
              as int,
      selfAppearCount: null == selfAppearCount
          ? _value.selfAppearCount
          : selfAppearCount // ignore: cast_nullable_to_non_nullable
              as int,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as int,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      endorsedBy: null == endorsedBy
          ? _value.endorsedBy
          : endorsedBy // ignore: cast_nullable_to_non_nullable
              as int,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchUserModelImpl implements _SearchUserModel {
  const _$SearchUserModelImpl(
      {@JsonKey(name: 'userId') this.userId = '',
      @JsonKey(name: '_id') this.id,
      this.firstName = '',
      this.lastName = '',
      this.profileName,
      @JsonKey(name: 'imageUrl') this.profileImage,
      this.country,
      this.nationality,
      this.playPosition,
      this.playPositionType,
      this.isPlayer = false,
      this.isCoach = false,
      this.isAdmin = false,
      this.isReferee = false,
      this.isFan = false,
      this.appearance = 0,
      this.appearCount = 0,
      this.selfAppearCount = 0,
      this.goals = 0,
      this.postCount = 0,
      @JsonKey(readValue: _readEndorseBy) this.endorsedBy = 0,
      @JsonKey(readValue: _readFollowers) this.followers = 0});

  factory _$SearchUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchUserModelImplFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  final String? profileName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? profileImage;
  @override
  final String? country;
  @override
  final String? nationality;
  @override
  final String? playPosition;
  @override
  final String? playPositionType;
  @override
  @JsonKey()
  final bool isPlayer;
  @override
  @JsonKey()
  final bool isCoach;
  @override
  @JsonKey()
  final bool isAdmin;
  @override
  @JsonKey()
  final bool isReferee;
  @override
  @JsonKey()
  final bool isFan;
  @override
  @JsonKey()
  final int appearance;
  @override
  @JsonKey()
  final int appearCount;
  @override
  @JsonKey()
  final int selfAppearCount;
  @override
  @JsonKey()
  final int goals;
  @override
  @JsonKey()
  final int postCount;
  @override
  @JsonKey(readValue: _readEndorseBy)
  final int endorsedBy;
  @override
  @JsonKey(readValue: _readFollowers)
  final int followers;

  @override
  String toString() {
    return 'SearchUserModel(userId: $userId, id: $id, firstName: $firstName, lastName: $lastName, profileName: $profileName, profileImage: $profileImage, country: $country, nationality: $nationality, playPosition: $playPosition, playPositionType: $playPositionType, isPlayer: $isPlayer, isCoach: $isCoach, isAdmin: $isAdmin, isReferee: $isReferee, isFan: $isFan, appearance: $appearance, appearCount: $appearCount, selfAppearCount: $selfAppearCount, goals: $goals, postCount: $postCount, endorsedBy: $endorsedBy, followers: $followers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchUserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.profileName, profileName) ||
                other.profileName == profileName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.playPosition, playPosition) ||
                other.playPosition == playPosition) &&
            (identical(other.playPositionType, playPositionType) ||
                other.playPositionType == playPositionType) &&
            (identical(other.isPlayer, isPlayer) ||
                other.isPlayer == isPlayer) &&
            (identical(other.isCoach, isCoach) || other.isCoach == isCoach) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isReferee, isReferee) ||
                other.isReferee == isReferee) &&
            (identical(other.isFan, isFan) || other.isFan == isFan) &&
            (identical(other.appearance, appearance) ||
                other.appearance == appearance) &&
            (identical(other.appearCount, appearCount) ||
                other.appearCount == appearCount) &&
            (identical(other.selfAppearCount, selfAppearCount) ||
                other.selfAppearCount == selfAppearCount) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.endorsedBy, endorsedBy) ||
                other.endorsedBy == endorsedBy) &&
            (identical(other.followers, followers) ||
                other.followers == followers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userId,
        id,
        firstName,
        lastName,
        profileName,
        profileImage,
        country,
        nationality,
        playPosition,
        playPositionType,
        isPlayer,
        isCoach,
        isAdmin,
        isReferee,
        isFan,
        appearance,
        appearCount,
        selfAppearCount,
        goals,
        postCount,
        endorsedBy,
        followers
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchUserModelImplCopyWith<_$SearchUserModelImpl> get copyWith =>
      __$$SearchUserModelImplCopyWithImpl<_$SearchUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchUserModelImplToJson(
      this,
    );
  }
}

abstract class _SearchUserModel implements SearchUserModel {
  const factory _SearchUserModel(
          {@JsonKey(name: 'userId') final String userId,
          @JsonKey(name: '_id') final String? id,
          final String firstName,
          final String lastName,
          final String? profileName,
          @JsonKey(name: 'imageUrl') final String? profileImage,
          final String? country,
          final String? nationality,
          final String? playPosition,
          final String? playPositionType,
          final bool isPlayer,
          final bool isCoach,
          final bool isAdmin,
          final bool isReferee,
          final bool isFan,
          final int appearance,
          final int appearCount,
          final int selfAppearCount,
          final int goals,
          final int postCount,
          @JsonKey(readValue: _readEndorseBy) final int endorsedBy,
          @JsonKey(readValue: _readFollowers) final int followers}) =
      _$SearchUserModelImpl;

  factory _SearchUserModel.fromJson(Map<String, dynamic> json) =
      _$SearchUserModelImpl.fromJson;

  @override
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get profileName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get profileImage;
  @override
  String? get country;
  @override
  String? get nationality;
  @override
  String? get playPosition;
  @override
  String? get playPositionType;
  @override
  bool get isPlayer;
  @override
  bool get isCoach;
  @override
  bool get isAdmin;
  @override
  bool get isReferee;
  @override
  bool get isFan;
  @override
  int get appearance;
  @override
  int get appearCount;
  @override
  int get selfAppearCount;
  @override
  int get goals;
  @override
  int get postCount;
  @override
  @JsonKey(readValue: _readEndorseBy)
  int get endorsedBy;
  @override
  @JsonKey(readValue: _readFollowers)
  int get followers;
  @override
  @JsonKey(ignore: true)
  _$$SearchUserModelImplCopyWith<_$SearchUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
