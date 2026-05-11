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
  String? get playPosition => throw _privateConstructorUsedError;
  bool get isPlayer => throw _privateConstructorUsedError;
  bool get isCoach => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isReferee => throw _privateConstructorUsedError;
  bool get isFan => throw _privateConstructorUsedError;
  int get appearance => throw _privateConstructorUsedError;
  int get goals => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;
  int get endorsedBy => throw _privateConstructorUsedError;
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
      String? playPosition,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isReferee,
      bool isFan,
      int appearance,
      int goals,
      int postCount,
      int endorsedBy,
      int followers});
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
    Object? playPosition = freezed,
    Object? isPlayer = null,
    Object? isCoach = null,
    Object? isAdmin = null,
    Object? isReferee = null,
    Object? isFan = null,
    Object? appearance = null,
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
      playPosition: freezed == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
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
      String? playPosition,
      bool isPlayer,
      bool isCoach,
      bool isAdmin,
      bool isReferee,
      bool isFan,
      int appearance,
      int goals,
      int postCount,
      int endorsedBy,
      int followers});
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
    Object? playPosition = freezed,
    Object? isPlayer = null,
    Object? isCoach = null,
    Object? isAdmin = null,
    Object? isReferee = null,
    Object? isFan = null,
    Object? appearance = null,
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
      playPosition: freezed == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
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
      {@JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: '_id') this.id,
      required this.firstName,
      required this.lastName,
      this.profileName,
      @JsonKey(name: 'imageUrl') this.profileImage,
      this.country,
      this.playPosition,
      this.isPlayer = false,
      this.isCoach = false,
      this.isAdmin = false,
      this.isReferee = false,
      this.isFan = false,
      this.appearance = 0,
      this.goals = 0,
      this.postCount = 0,
      this.endorsedBy = 0,
      this.followers = 0});

  factory _$SearchUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchUserModelImplFromJson(json);

  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? profileName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? profileImage;
  @override
  final String? country;
  @override
  final String? playPosition;
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
  final int goals;
  @override
  @JsonKey()
  final int postCount;
  @override
  @JsonKey()
  final int endorsedBy;
  @override
  @JsonKey()
  final int followers;

  @override
  String toString() {
    return 'SearchUserModel(userId: $userId, id: $id, firstName: $firstName, lastName: $lastName, profileName: $profileName, profileImage: $profileImage, country: $country, playPosition: $playPosition, isPlayer: $isPlayer, isCoach: $isCoach, isAdmin: $isAdmin, isReferee: $isReferee, isFan: $isFan, appearance: $appearance, goals: $goals, postCount: $postCount, endorsedBy: $endorsedBy, followers: $followers)';
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
            (identical(other.playPosition, playPosition) ||
                other.playPosition == playPosition) &&
            (identical(other.isPlayer, isPlayer) ||
                other.isPlayer == isPlayer) &&
            (identical(other.isCoach, isCoach) || other.isCoach == isCoach) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isReferee, isReferee) ||
                other.isReferee == isReferee) &&
            (identical(other.isFan, isFan) || other.isFan == isFan) &&
            (identical(other.appearance, appearance) ||
                other.appearance == appearance) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      id,
      firstName,
      lastName,
      profileName,
      profileImage,
      country,
      playPosition,
      isPlayer,
      isCoach,
      isAdmin,
      isReferee,
      isFan,
      appearance,
      goals,
      postCount,
      endorsedBy,
      followers);

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
      {@JsonKey(name: 'userId') required final String userId,
      @JsonKey(name: '_id') final String? id,
      required final String firstName,
      required final String lastName,
      final String? profileName,
      @JsonKey(name: 'imageUrl') final String? profileImage,
      final String? country,
      final String? playPosition,
      final bool isPlayer,
      final bool isCoach,
      final bool isAdmin,
      final bool isReferee,
      final bool isFan,
      final int appearance,
      final int goals,
      final int postCount,
      final int endorsedBy,
      final int followers}) = _$SearchUserModelImpl;

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
  String? get playPosition;
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
  int get goals;
  @override
  int get postCount;
  @override
  int get endorsedBy;
  @override
  int get followers;
  @override
  @JsonKey(ignore: true)
  _$$SearchUserModelImplCopyWith<_$SearchUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
