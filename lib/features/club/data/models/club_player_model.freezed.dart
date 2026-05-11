// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubPlayerModel _$ClubPlayerModelFromJson(Map<String, dynamic> json) {
  return _ClubPlayerModel.fromJson(json);
}

/// @nodoc
mixin _$ClubPlayerModel {
  String get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get jersey => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubPlayerModelCopyWith<ClubPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubPlayerModelCopyWith<$Res> {
  factory $ClubPlayerModelCopyWith(
          ClubPlayerModel value, $Res Function(ClubPlayerModel) then) =
      _$ClubPlayerModelCopyWithImpl<$Res, ClubPlayerModel>;
  @useResult
  $Res call(
      {String userId,
      String? firstName,
      String? lastName,
      String? position,
      String? imageUrl,
      int jersey,
      int seq});
}

/// @nodoc
class _$ClubPlayerModelCopyWithImpl<$Res, $Val extends ClubPlayerModel>
    implements $ClubPlayerModelCopyWith<$Res> {
  _$ClubPlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? position = freezed,
    Object? imageUrl = freezed,
    Object? jersey = null,
    Object? seq = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jersey: null == jersey
          ? _value.jersey
          : jersey // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubPlayerModelImplCopyWith<$Res>
    implements $ClubPlayerModelCopyWith<$Res> {
  factory _$$ClubPlayerModelImplCopyWith(_$ClubPlayerModelImpl value,
          $Res Function(_$ClubPlayerModelImpl) then) =
      __$$ClubPlayerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String? firstName,
      String? lastName,
      String? position,
      String? imageUrl,
      int jersey,
      int seq});
}

/// @nodoc
class __$$ClubPlayerModelImplCopyWithImpl<$Res>
    extends _$ClubPlayerModelCopyWithImpl<$Res, _$ClubPlayerModelImpl>
    implements _$$ClubPlayerModelImplCopyWith<$Res> {
  __$$ClubPlayerModelImplCopyWithImpl(
      _$ClubPlayerModelImpl _value, $Res Function(_$ClubPlayerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? position = freezed,
    Object? imageUrl = freezed,
    Object? jersey = null,
    Object? seq = null,
  }) {
    return _then(_$ClubPlayerModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jersey: null == jersey
          ? _value.jersey
          : jersey // ignore: cast_nullable_to_non_nullable
              as int,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubPlayerModelImpl implements _ClubPlayerModel {
  const _$ClubPlayerModelImpl(
      {required this.userId,
      this.firstName,
      this.lastName,
      this.position,
      this.imageUrl,
      this.jersey = 0,
      this.seq = 0});

  factory _$ClubPlayerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubPlayerModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? position;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int jersey;
  @override
  @JsonKey()
  final int seq;

  @override
  String toString() {
    return 'ClubPlayerModel(userId: $userId, firstName: $firstName, lastName: $lastName, position: $position, imageUrl: $imageUrl, jersey: $jersey, seq: $seq)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubPlayerModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.jersey, jersey) || other.jersey == jersey) &&
            (identical(other.seq, seq) || other.seq == seq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, firstName, lastName,
      position, imageUrl, jersey, seq);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubPlayerModelImplCopyWith<_$ClubPlayerModelImpl> get copyWith =>
      __$$ClubPlayerModelImplCopyWithImpl<_$ClubPlayerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubPlayerModelImplToJson(
      this,
    );
  }
}

abstract class _ClubPlayerModel implements ClubPlayerModel {
  const factory _ClubPlayerModel(
      {required final String userId,
      final String? firstName,
      final String? lastName,
      final String? position,
      final String? imageUrl,
      final int jersey,
      final int seq}) = _$ClubPlayerModelImpl;

  factory _ClubPlayerModel.fromJson(Map<String, dynamic> json) =
      _$ClubPlayerModelImpl.fromJson;

  @override
  String get userId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get position;
  @override
  String? get imageUrl;
  @override
  int get jersey;
  @override
  int get seq;
  @override
  @JsonKey(ignore: true)
  _$$ClubPlayerModelImplCopyWith<_$ClubPlayerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
