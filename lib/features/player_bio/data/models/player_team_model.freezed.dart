// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayerTeamModel _$PlayerTeamModelFromJson(Map<String, dynamic> json) {
  return _PlayerTeamModel.fromJson(json);
}

/// @nodoc
mixin _$PlayerTeamModel {
  @JsonKey(name: 'teamId')
  String? get teamId => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamName')
  String? get teamName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerTeamModelCopyWith<PlayerTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerTeamModelCopyWith<$Res> {
  factory $PlayerTeamModelCopyWith(
          PlayerTeamModel value, $Res Function(PlayerTeamModel) then) =
      _$PlayerTeamModelCopyWithImpl<$Res, PlayerTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'teamId') String? teamId,
      @JsonKey(name: 'teamName') String? teamName,
      @JsonKey(name: 'imageUrl') String? imageUrl});
}

/// @nodoc
class _$PlayerTeamModelCopyWithImpl<$Res, $Val extends PlayerTeamModel>
    implements $PlayerTeamModelCopyWith<$Res> {
  _$PlayerTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerTeamModelImplCopyWith<$Res>
    implements $PlayerTeamModelCopyWith<$Res> {
  factory _$$PlayerTeamModelImplCopyWith(_$PlayerTeamModelImpl value,
          $Res Function(_$PlayerTeamModelImpl) then) =
      __$$PlayerTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'teamId') String? teamId,
      @JsonKey(name: 'teamName') String? teamName,
      @JsonKey(name: 'imageUrl') String? imageUrl});
}

/// @nodoc
class __$$PlayerTeamModelImplCopyWithImpl<$Res>
    extends _$PlayerTeamModelCopyWithImpl<$Res, _$PlayerTeamModelImpl>
    implements _$$PlayerTeamModelImplCopyWith<$Res> {
  __$$PlayerTeamModelImplCopyWithImpl(
      _$PlayerTeamModelImpl _value, $Res Function(_$PlayerTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$PlayerTeamModelImpl(
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerTeamModelImpl implements _PlayerTeamModel {
  const _$PlayerTeamModelImpl(
      {@JsonKey(name: 'teamId') this.teamId,
      @JsonKey(name: 'teamName') this.teamName,
      @JsonKey(name: 'imageUrl') this.imageUrl});

  factory _$PlayerTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerTeamModelImplFromJson(json);

  @override
  @JsonKey(name: 'teamId')
  final String? teamId;
  @override
  @JsonKey(name: 'teamName')
  final String? teamName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @override
  String toString() {
    return 'PlayerTeamModel(teamId: $teamId, teamName: $teamName, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerTeamModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, teamId, teamName, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerTeamModelImplCopyWith<_$PlayerTeamModelImpl> get copyWith =>
      __$$PlayerTeamModelImplCopyWithImpl<_$PlayerTeamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerTeamModelImplToJson(
      this,
    );
  }
}

abstract class _PlayerTeamModel implements PlayerTeamModel {
  const factory _PlayerTeamModel(
          {@JsonKey(name: 'teamId') final String? teamId,
          @JsonKey(name: 'teamName') final String? teamName,
          @JsonKey(name: 'imageUrl') final String? imageUrl}) =
      _$PlayerTeamModelImpl;

  factory _PlayerTeamModel.fromJson(Map<String, dynamic> json) =
      _$PlayerTeamModelImpl.fromJson;

  @override
  @JsonKey(name: 'teamId')
  String? get teamId;
  @override
  @JsonKey(name: 'teamName')
  String? get teamName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$PlayerTeamModelImplCopyWith<_$PlayerTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
