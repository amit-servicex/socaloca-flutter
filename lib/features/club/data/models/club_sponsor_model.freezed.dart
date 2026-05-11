// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_sponsor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubSponsorModel _$ClubSponsorModelFromJson(Map<String, dynamic> json) {
  return _ClubSponsorModel.fromJson(json);
}

/// @nodoc
mixin _$ClubSponsorModel {
  String get sponsorId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubSponsorModelCopyWith<ClubSponsorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubSponsorModelCopyWith<$Res> {
  factory $ClubSponsorModelCopyWith(
          ClubSponsorModel value, $Res Function(ClubSponsorModel) then) =
      _$ClubSponsorModelCopyWithImpl<$Res, ClubSponsorModel>;
  @useResult
  $Res call({String sponsorId, String? name, String? imageUrl, int seq});
}

/// @nodoc
class _$ClubSponsorModelCopyWithImpl<$Res, $Val extends ClubSponsorModel>
    implements $ClubSponsorModelCopyWith<$Res> {
  _$ClubSponsorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sponsorId = null,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? seq = null,
  }) {
    return _then(_value.copyWith(
      sponsorId: null == sponsorId
          ? _value.sponsorId
          : sponsorId // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubSponsorModelImplCopyWith<$Res>
    implements $ClubSponsorModelCopyWith<$Res> {
  factory _$$ClubSponsorModelImplCopyWith(_$ClubSponsorModelImpl value,
          $Res Function(_$ClubSponsorModelImpl) then) =
      __$$ClubSponsorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sponsorId, String? name, String? imageUrl, int seq});
}

/// @nodoc
class __$$ClubSponsorModelImplCopyWithImpl<$Res>
    extends _$ClubSponsorModelCopyWithImpl<$Res, _$ClubSponsorModelImpl>
    implements _$$ClubSponsorModelImplCopyWith<$Res> {
  __$$ClubSponsorModelImplCopyWithImpl(_$ClubSponsorModelImpl _value,
      $Res Function(_$ClubSponsorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sponsorId = null,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? seq = null,
  }) {
    return _then(_$ClubSponsorModelImpl(
      sponsorId: null == sponsorId
          ? _value.sponsorId
          : sponsorId // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubSponsorModelImpl implements _ClubSponsorModel {
  const _$ClubSponsorModelImpl(
      {required this.sponsorId, this.name, this.imageUrl, this.seq = 0});

  factory _$ClubSponsorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubSponsorModelImplFromJson(json);

  @override
  final String sponsorId;
  @override
  final String? name;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int seq;

  @override
  String toString() {
    return 'ClubSponsorModel(sponsorId: $sponsorId, name: $name, imageUrl: $imageUrl, seq: $seq)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubSponsorModelImpl &&
            (identical(other.sponsorId, sponsorId) ||
                other.sponsorId == sponsorId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.seq, seq) || other.seq == seq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sponsorId, name, imageUrl, seq);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubSponsorModelImplCopyWith<_$ClubSponsorModelImpl> get copyWith =>
      __$$ClubSponsorModelImplCopyWithImpl<_$ClubSponsorModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubSponsorModelImplToJson(
      this,
    );
  }
}

abstract class _ClubSponsorModel implements ClubSponsorModel {
  const factory _ClubSponsorModel(
      {required final String sponsorId,
      final String? name,
      final String? imageUrl,
      final int seq}) = _$ClubSponsorModelImpl;

  factory _ClubSponsorModel.fromJson(Map<String, dynamic> json) =
      _$ClubSponsorModelImpl.fromJson;

  @override
  String get sponsorId;
  @override
  String? get name;
  @override
  String? get imageUrl;
  @override
  int get seq;
  @override
  @JsonKey(ignore: true)
  _$$ClubSponsorModelImplCopyWith<_$ClubSponsorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
