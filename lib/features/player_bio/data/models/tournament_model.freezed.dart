// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TournamentModel _$TournamentModelFromJson(Map<String, dynamic> json) {
  return _TournamentModel.fromJson(json);
}

/// @nodoc
mixin _$TournamentModel {
  @JsonKey(name: 'tournamentId')
  String? get tmntId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get tmntName => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo')
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get tmntType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentModelCopyWith<TournamentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentModelCopyWith<$Res> {
  factory $TournamentModelCopyWith(
          TournamentModel value, $Res Function(TournamentModel) then) =
      _$TournamentModelCopyWithImpl<$Res, TournamentModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tournamentId') String? tmntId,
      @JsonKey(name: 'name') String? tmntName,
      @JsonKey(name: 'logo') String? imageUrl,
      String? status,
      String? tmntType});
}

/// @nodoc
class _$TournamentModelCopyWithImpl<$Res, $Val extends TournamentModel>
    implements $TournamentModelCopyWith<$Res> {
  _$TournamentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tmntId = freezed,
    Object? tmntName = freezed,
    Object? imageUrl = freezed,
    Object? status = freezed,
    Object? tmntType = freezed,
  }) {
    return _then(_value.copyWith(
      tmntId: freezed == tmntId
          ? _value.tmntId
          : tmntId // ignore: cast_nullable_to_non_nullable
              as String?,
      tmntName: freezed == tmntName
          ? _value.tmntName
          : tmntName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tmntType: freezed == tmntType
          ? _value.tmntType
          : tmntType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentModelImplCopyWith<$Res>
    implements $TournamentModelCopyWith<$Res> {
  factory _$$TournamentModelImplCopyWith(_$TournamentModelImpl value,
          $Res Function(_$TournamentModelImpl) then) =
      __$$TournamentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tournamentId') String? tmntId,
      @JsonKey(name: 'name') String? tmntName,
      @JsonKey(name: 'logo') String? imageUrl,
      String? status,
      String? tmntType});
}

/// @nodoc
class __$$TournamentModelImplCopyWithImpl<$Res>
    extends _$TournamentModelCopyWithImpl<$Res, _$TournamentModelImpl>
    implements _$$TournamentModelImplCopyWith<$Res> {
  __$$TournamentModelImplCopyWithImpl(
      _$TournamentModelImpl _value, $Res Function(_$TournamentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tmntId = freezed,
    Object? tmntName = freezed,
    Object? imageUrl = freezed,
    Object? status = freezed,
    Object? tmntType = freezed,
  }) {
    return _then(_$TournamentModelImpl(
      tmntId: freezed == tmntId
          ? _value.tmntId
          : tmntId // ignore: cast_nullable_to_non_nullable
              as String?,
      tmntName: freezed == tmntName
          ? _value.tmntName
          : tmntName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tmntType: freezed == tmntType
          ? _value.tmntType
          : tmntType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentModelImpl implements _TournamentModel {
  const _$TournamentModelImpl(
      {@JsonKey(name: 'tournamentId') this.tmntId,
      @JsonKey(name: 'name') this.tmntName,
      @JsonKey(name: 'logo') this.imageUrl,
      this.status,
      this.tmntType});

  factory _$TournamentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentModelImplFromJson(json);

  @override
  @JsonKey(name: 'tournamentId')
  final String? tmntId;
  @override
  @JsonKey(name: 'name')
  final String? tmntName;
  @override
  @JsonKey(name: 'logo')
  final String? imageUrl;
  @override
  final String? status;
  @override
  final String? tmntType;

  @override
  String toString() {
    return 'TournamentModel(tmntId: $tmntId, tmntName: $tmntName, imageUrl: $imageUrl, status: $status, tmntType: $tmntType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentModelImpl &&
            (identical(other.tmntId, tmntId) || other.tmntId == tmntId) &&
            (identical(other.tmntName, tmntName) ||
                other.tmntName == tmntName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tmntType, tmntType) ||
                other.tmntType == tmntType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tmntId, tmntName, imageUrl, status, tmntType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentModelImplCopyWith<_$TournamentModelImpl> get copyWith =>
      __$$TournamentModelImplCopyWithImpl<_$TournamentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentModelImplToJson(
      this,
    );
  }
}

abstract class _TournamentModel implements TournamentModel {
  const factory _TournamentModel(
      {@JsonKey(name: 'tournamentId') final String? tmntId,
      @JsonKey(name: 'name') final String? tmntName,
      @JsonKey(name: 'logo') final String? imageUrl,
      final String? status,
      final String? tmntType}) = _$TournamentModelImpl;

  factory _TournamentModel.fromJson(Map<String, dynamic> json) =
      _$TournamentModelImpl.fromJson;

  @override
  @JsonKey(name: 'tournamentId')
  String? get tmntId;
  @override
  @JsonKey(name: 'name')
  String? get tmntName;
  @override
  @JsonKey(name: 'logo')
  String? get imageUrl;
  @override
  String? get status;
  @override
  String? get tmntType;
  @override
  @JsonKey(ignore: true)
  _$$TournamentModelImplCopyWith<_$TournamentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
