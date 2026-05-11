// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubTeamModel _$ClubTeamModelFromJson(Map<String, dynamic> json) {
  return _ClubTeamModel.fromJson(json);
}

/// @nodoc
mixin _$ClubTeamModel {
  String get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubTeamModelCopyWith<ClubTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubTeamModelCopyWith<$Res> {
  factory $ClubTeamModelCopyWith(
          ClubTeamModel value, $Res Function(ClubTeamModel) then) =
      _$ClubTeamModelCopyWithImpl<$Res, ClubTeamModel>;
  @useResult
  $Res call({String teamId, String? teamName, String? imageUrl, int seq});
}

/// @nodoc
class _$ClubTeamModelCopyWithImpl<$Res, $Val extends ClubTeamModel>
    implements $ClubTeamModelCopyWith<$Res> {
  _$ClubTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = freezed,
    Object? imageUrl = freezed,
    Object? seq = null,
  }) {
    return _then(_value.copyWith(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ClubTeamModelImplCopyWith<$Res>
    implements $ClubTeamModelCopyWith<$Res> {
  factory _$$ClubTeamModelImplCopyWith(
          _$ClubTeamModelImpl value, $Res Function(_$ClubTeamModelImpl) then) =
      __$$ClubTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String teamId, String? teamName, String? imageUrl, int seq});
}

/// @nodoc
class __$$ClubTeamModelImplCopyWithImpl<$Res>
    extends _$ClubTeamModelCopyWithImpl<$Res, _$ClubTeamModelImpl>
    implements _$$ClubTeamModelImplCopyWith<$Res> {
  __$$ClubTeamModelImplCopyWithImpl(
      _$ClubTeamModelImpl _value, $Res Function(_$ClubTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = freezed,
    Object? imageUrl = freezed,
    Object? seq = null,
  }) {
    return _then(_$ClubTeamModelImpl(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
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
class _$ClubTeamModelImpl implements _ClubTeamModel {
  const _$ClubTeamModelImpl(
      {required this.teamId, this.teamName, this.imageUrl, this.seq = 0});

  factory _$ClubTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubTeamModelImplFromJson(json);

  @override
  final String teamId;
  @override
  final String? teamName;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int seq;

  @override
  String toString() {
    return 'ClubTeamModel(teamId: $teamId, teamName: $teamName, imageUrl: $imageUrl, seq: $seq)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubTeamModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.seq, seq) || other.seq == seq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, teamId, teamName, imageUrl, seq);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubTeamModelImplCopyWith<_$ClubTeamModelImpl> get copyWith =>
      __$$ClubTeamModelImplCopyWithImpl<_$ClubTeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubTeamModelImplToJson(
      this,
    );
  }
}

abstract class _ClubTeamModel implements ClubTeamModel {
  const factory _ClubTeamModel(
      {required final String teamId,
      final String? teamName,
      final String? imageUrl,
      final int seq}) = _$ClubTeamModelImpl;

  factory _ClubTeamModel.fromJson(Map<String, dynamic> json) =
      _$ClubTeamModelImpl.fromJson;

  @override
  String get teamId;
  @override
  String? get teamName;
  @override
  String? get imageUrl;
  @override
  int get seq;
  @override
  @JsonKey(ignore: true)
  _$$ClubTeamModelImplCopyWith<_$ClubTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
