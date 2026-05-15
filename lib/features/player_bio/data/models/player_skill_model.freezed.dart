// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_skill_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayerSkillModel _$PlayerSkillModelFromJson(Map<String, dynamic> json) {
  return _PlayerSkillModel.fromJson(json);
}

/// @nodoc
mixin _$PlayerSkillModel {
  @JsonKey(name: 'skillName')
  String? get skillName => throw _privateConstructorUsedError;
  @JsonKey(name: 'skillShort')
  String? get skillShort => throw _privateConstructorUsedError;
  @JsonKey(name: 'skillAvg')
  double? get skillAvg => throw _privateConstructorUsedError;
  @JsonKey(name: 'ratingCounter')
  int? get ratingCounter => throw _privateConstructorUsedError;
  @JsonKey(name: 'rateByMe')
  bool? get rateByMe => throw _privateConstructorUsedError;
  @JsonKey(name: 'myRating')
  double? get myRating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerSkillModelCopyWith<PlayerSkillModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerSkillModelCopyWith<$Res> {
  factory $PlayerSkillModelCopyWith(
          PlayerSkillModel value, $Res Function(PlayerSkillModel) then) =
      _$PlayerSkillModelCopyWithImpl<$Res, PlayerSkillModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'skillName') String? skillName,
      @JsonKey(name: 'skillShort') String? skillShort,
      @JsonKey(name: 'skillAvg') double? skillAvg,
      @JsonKey(name: 'ratingCounter') int? ratingCounter,
      @JsonKey(name: 'rateByMe') bool? rateByMe,
      @JsonKey(name: 'myRating') double? myRating});
}

/// @nodoc
class _$PlayerSkillModelCopyWithImpl<$Res, $Val extends PlayerSkillModel>
    implements $PlayerSkillModelCopyWith<$Res> {
  _$PlayerSkillModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillName = freezed,
    Object? skillShort = freezed,
    Object? skillAvg = freezed,
    Object? ratingCounter = freezed,
    Object? rateByMe = freezed,
    Object? myRating = freezed,
  }) {
    return _then(_value.copyWith(
      skillName: freezed == skillName
          ? _value.skillName
          : skillName // ignore: cast_nullable_to_non_nullable
              as String?,
      skillShort: freezed == skillShort
          ? _value.skillShort
          : skillShort // ignore: cast_nullable_to_non_nullable
              as String?,
      skillAvg: freezed == skillAvg
          ? _value.skillAvg
          : skillAvg // ignore: cast_nullable_to_non_nullable
              as double?,
      ratingCounter: freezed == ratingCounter
          ? _value.ratingCounter
          : ratingCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      rateByMe: freezed == rateByMe
          ? _value.rateByMe
          : rateByMe // ignore: cast_nullable_to_non_nullable
              as bool?,
      myRating: freezed == myRating
          ? _value.myRating
          : myRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerSkillModelImplCopyWith<$Res>
    implements $PlayerSkillModelCopyWith<$Res> {
  factory _$$PlayerSkillModelImplCopyWith(_$PlayerSkillModelImpl value,
          $Res Function(_$PlayerSkillModelImpl) then) =
      __$$PlayerSkillModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'skillName') String? skillName,
      @JsonKey(name: 'skillShort') String? skillShort,
      @JsonKey(name: 'skillAvg') double? skillAvg,
      @JsonKey(name: 'ratingCounter') int? ratingCounter,
      @JsonKey(name: 'rateByMe') bool? rateByMe,
      @JsonKey(name: 'myRating') double? myRating});
}

/// @nodoc
class __$$PlayerSkillModelImplCopyWithImpl<$Res>
    extends _$PlayerSkillModelCopyWithImpl<$Res, _$PlayerSkillModelImpl>
    implements _$$PlayerSkillModelImplCopyWith<$Res> {
  __$$PlayerSkillModelImplCopyWithImpl(_$PlayerSkillModelImpl _value,
      $Res Function(_$PlayerSkillModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillName = freezed,
    Object? skillShort = freezed,
    Object? skillAvg = freezed,
    Object? ratingCounter = freezed,
    Object? rateByMe = freezed,
    Object? myRating = freezed,
  }) {
    return _then(_$PlayerSkillModelImpl(
      skillName: freezed == skillName
          ? _value.skillName
          : skillName // ignore: cast_nullable_to_non_nullable
              as String?,
      skillShort: freezed == skillShort
          ? _value.skillShort
          : skillShort // ignore: cast_nullable_to_non_nullable
              as String?,
      skillAvg: freezed == skillAvg
          ? _value.skillAvg
          : skillAvg // ignore: cast_nullable_to_non_nullable
              as double?,
      ratingCounter: freezed == ratingCounter
          ? _value.ratingCounter
          : ratingCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      rateByMe: freezed == rateByMe
          ? _value.rateByMe
          : rateByMe // ignore: cast_nullable_to_non_nullable
              as bool?,
      myRating: freezed == myRating
          ? _value.myRating
          : myRating // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerSkillModelImpl implements _PlayerSkillModel {
  const _$PlayerSkillModelImpl(
      {@JsonKey(name: 'skillName') this.skillName,
      @JsonKey(name: 'skillShort') this.skillShort,
      @JsonKey(name: 'skillAvg') this.skillAvg,
      @JsonKey(name: 'ratingCounter') this.ratingCounter,
      @JsonKey(name: 'rateByMe') this.rateByMe,
      @JsonKey(name: 'myRating') this.myRating});

  factory _$PlayerSkillModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerSkillModelImplFromJson(json);

  @override
  @JsonKey(name: 'skillName')
  final String? skillName;
  @override
  @JsonKey(name: 'skillShort')
  final String? skillShort;
  @override
  @JsonKey(name: 'skillAvg')
  final double? skillAvg;
  @override
  @JsonKey(name: 'ratingCounter')
  final int? ratingCounter;
  @override
  @JsonKey(name: 'rateByMe')
  final bool? rateByMe;
  @override
  @JsonKey(name: 'myRating')
  final double? myRating;

  @override
  String toString() {
    return 'PlayerSkillModel(skillName: $skillName, skillShort: $skillShort, skillAvg: $skillAvg, ratingCounter: $ratingCounter, rateByMe: $rateByMe, myRating: $myRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerSkillModelImpl &&
            (identical(other.skillName, skillName) ||
                other.skillName == skillName) &&
            (identical(other.skillShort, skillShort) ||
                other.skillShort == skillShort) &&
            (identical(other.skillAvg, skillAvg) ||
                other.skillAvg == skillAvg) &&
            (identical(other.ratingCounter, ratingCounter) ||
                other.ratingCounter == ratingCounter) &&
            (identical(other.rateByMe, rateByMe) ||
                other.rateByMe == rateByMe) &&
            (identical(other.myRating, myRating) ||
                other.myRating == myRating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, skillName, skillShort, skillAvg,
      ratingCounter, rateByMe, myRating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerSkillModelImplCopyWith<_$PlayerSkillModelImpl> get copyWith =>
      __$$PlayerSkillModelImplCopyWithImpl<_$PlayerSkillModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerSkillModelImplToJson(
      this,
    );
  }
}

abstract class _PlayerSkillModel implements PlayerSkillModel {
  const factory _PlayerSkillModel(
          {@JsonKey(name: 'skillName') final String? skillName,
          @JsonKey(name: 'skillShort') final String? skillShort,
          @JsonKey(name: 'skillAvg') final double? skillAvg,
          @JsonKey(name: 'ratingCounter') final int? ratingCounter,
          @JsonKey(name: 'rateByMe') final bool? rateByMe,
          @JsonKey(name: 'myRating') final double? myRating}) =
      _$PlayerSkillModelImpl;

  factory _PlayerSkillModel.fromJson(Map<String, dynamic> json) =
      _$PlayerSkillModelImpl.fromJson;

  @override
  @JsonKey(name: 'skillName')
  String? get skillName;
  @override
  @JsonKey(name: 'skillShort')
  String? get skillShort;
  @override
  @JsonKey(name: 'skillAvg')
  double? get skillAvg;
  @override
  @JsonKey(name: 'ratingCounter')
  int? get ratingCounter;
  @override
  @JsonKey(name: 'rateByMe')
  bool? get rateByMe;
  @override
  @JsonKey(name: 'myRating')
  double? get myRating;
  @override
  @JsonKey(ignore: true)
  _$$PlayerSkillModelImplCopyWith<_$PlayerSkillModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
