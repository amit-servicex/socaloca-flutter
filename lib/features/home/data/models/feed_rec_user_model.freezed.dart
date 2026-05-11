// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_rec_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedRecUserModel _$FeedRecUserModelFromJson(Map<String, dynamic> json) {
  return _FeedRecUserModel.fromJson(json);
}

/// @nodoc
mixin _$FeedRecUserModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstName')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastName')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'userType')
  String? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'country')
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'city')
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'isFollowing')
  bool get isFollowing => throw _privateConstructorUsedError;
  @JsonKey(name: 'followCount')
  int get followCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedRecUserModelCopyWith<FeedRecUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedRecUserModelCopyWith<$Res> {
  factory $FeedRecUserModelCopyWith(
          FeedRecUserModel value, $Res Function(FeedRecUserModel) then) =
      _$FeedRecUserModelCopyWithImpl<$Res, FeedRecUserModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'firstName') String? firstName,
      @JsonKey(name: 'lastName') String? lastName,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'userType') String? userType,
      @JsonKey(name: 'country') String? country,
      @JsonKey(name: 'city') String? city,
      @JsonKey(name: 'isFollowing') bool isFollowing,
      @JsonKey(name: 'followCount') int followCount});
}

/// @nodoc
class _$FeedRecUserModelCopyWithImpl<$Res, $Val extends FeedRecUserModel>
    implements $FeedRecUserModelCopyWith<$Res> {
  _$FeedRecUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? imageUrl = freezed,
    Object? userType = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? isFollowing = null,
    Object? followCount = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedRecUserModelImplCopyWith<$Res>
    implements $FeedRecUserModelCopyWith<$Res> {
  factory _$$FeedRecUserModelImplCopyWith(_$FeedRecUserModelImpl value,
          $Res Function(_$FeedRecUserModelImpl) then) =
      __$$FeedRecUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'firstName') String? firstName,
      @JsonKey(name: 'lastName') String? lastName,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'userType') String? userType,
      @JsonKey(name: 'country') String? country,
      @JsonKey(name: 'city') String? city,
      @JsonKey(name: 'isFollowing') bool isFollowing,
      @JsonKey(name: 'followCount') int followCount});
}

/// @nodoc
class __$$FeedRecUserModelImplCopyWithImpl<$Res>
    extends _$FeedRecUserModelCopyWithImpl<$Res, _$FeedRecUserModelImpl>
    implements _$$FeedRecUserModelImplCopyWith<$Res> {
  __$$FeedRecUserModelImplCopyWithImpl(_$FeedRecUserModelImpl _value,
      $Res Function(_$FeedRecUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? imageUrl = freezed,
    Object? userType = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? isFollowing = null,
    Object? followCount = null,
  }) {
    return _then(_$FeedRecUserModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedRecUserModelImpl implements _FeedRecUserModel {
  const _$FeedRecUserModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'firstName') this.firstName,
      @JsonKey(name: 'lastName') this.lastName,
      @JsonKey(name: 'imageUrl') this.imageUrl,
      @JsonKey(name: 'userType') this.userType,
      @JsonKey(name: 'country') this.country,
      @JsonKey(name: 'city') this.city,
      @JsonKey(name: 'isFollowing') this.isFollowing = false,
      @JsonKey(name: 'followCount') this.followCount = 0});

  factory _$FeedRecUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedRecUserModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'userId')
  final String? userId;
  @override
  @JsonKey(name: 'firstName')
  final String? firstName;
  @override
  @JsonKey(name: 'lastName')
  final String? lastName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'userType')
  final String? userType;
  @override
  @JsonKey(name: 'country')
  final String? country;
  @override
  @JsonKey(name: 'city')
  final String? city;
  @override
  @JsonKey(name: 'isFollowing')
  final bool isFollowing;
  @override
  @JsonKey(name: 'followCount')
  final int followCount;

  @override
  String toString() {
    return 'FeedRecUserModel(id: $id, userId: $userId, firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl, userType: $userType, country: $country, city: $city, isFollowing: $isFollowing, followCount: $followCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedRecUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.followCount, followCount) ||
                other.followCount == followCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, firstName, lastName,
      imageUrl, userType, country, city, isFollowing, followCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedRecUserModelImplCopyWith<_$FeedRecUserModelImpl> get copyWith =>
      __$$FeedRecUserModelImplCopyWithImpl<_$FeedRecUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedRecUserModelImplToJson(
      this,
    );
  }
}

abstract class _FeedRecUserModel implements FeedRecUserModel {
  const factory _FeedRecUserModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'userId') final String? userId,
          @JsonKey(name: 'firstName') final String? firstName,
          @JsonKey(name: 'lastName') final String? lastName,
          @JsonKey(name: 'imageUrl') final String? imageUrl,
          @JsonKey(name: 'userType') final String? userType,
          @JsonKey(name: 'country') final String? country,
          @JsonKey(name: 'city') final String? city,
          @JsonKey(name: 'isFollowing') final bool isFollowing,
          @JsonKey(name: 'followCount') final int followCount}) =
      _$FeedRecUserModelImpl;

  factory _FeedRecUserModel.fromJson(Map<String, dynamic> json) =
      _$FeedRecUserModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'userId')
  String? get userId;
  @override
  @JsonKey(name: 'firstName')
  String? get firstName;
  @override
  @JsonKey(name: 'lastName')
  String? get lastName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'userType')
  String? get userType;
  @override
  @JsonKey(name: 'country')
  String? get country;
  @override
  @JsonKey(name: 'city')
  String? get city;
  @override
  @JsonKey(name: 'isFollowing')
  bool get isFollowing;
  @override
  @JsonKey(name: 'followCount')
  int get followCount;
  @override
  @JsonKey(ignore: true)
  _$$FeedRecUserModelImplCopyWith<_$FeedRecUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
