// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_player_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubPlayerStatsModel _$ClubPlayerStatsModelFromJson(Map<String, dynamic> json) {
  return _ClubPlayerStatsModel.fromJson(json);
}

/// @nodoc
mixin _$ClubPlayerStatsModel {
  @JsonKey(name: 'matchCount')
  int get matchCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'goalCount')
  int get goalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'assistCount')
  int get assistCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'yellowCardCount')
  int get yellowCardCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'redCardCount')
  int get redCardCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'mvpCount')
  int get mvpCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubPlayerStatsModelCopyWith<ClubPlayerStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubPlayerStatsModelCopyWith<$Res> {
  factory $ClubPlayerStatsModelCopyWith(ClubPlayerStatsModel value,
          $Res Function(ClubPlayerStatsModel) then) =
      _$ClubPlayerStatsModelCopyWithImpl<$Res, ClubPlayerStatsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matchCount') int matchCount,
      @JsonKey(name: 'goalCount') int goalCount,
      @JsonKey(name: 'assistCount') int assistCount,
      @JsonKey(name: 'yellowCardCount') int yellowCardCount,
      @JsonKey(name: 'redCardCount') int redCardCount,
      @JsonKey(name: 'mvpCount') int mvpCount});
}

/// @nodoc
class _$ClubPlayerStatsModelCopyWithImpl<$Res,
        $Val extends ClubPlayerStatsModel>
    implements $ClubPlayerStatsModelCopyWith<$Res> {
  _$ClubPlayerStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchCount = null,
    Object? goalCount = null,
    Object? assistCount = null,
    Object? yellowCardCount = null,
    Object? redCardCount = null,
    Object? mvpCount = null,
  }) {
    return _then(_value.copyWith(
      matchCount: null == matchCount
          ? _value.matchCount
          : matchCount // ignore: cast_nullable_to_non_nullable
              as int,
      goalCount: null == goalCount
          ? _value.goalCount
          : goalCount // ignore: cast_nullable_to_non_nullable
              as int,
      assistCount: null == assistCount
          ? _value.assistCount
          : assistCount // ignore: cast_nullable_to_non_nullable
              as int,
      yellowCardCount: null == yellowCardCount
          ? _value.yellowCardCount
          : yellowCardCount // ignore: cast_nullable_to_non_nullable
              as int,
      redCardCount: null == redCardCount
          ? _value.redCardCount
          : redCardCount // ignore: cast_nullable_to_non_nullable
              as int,
      mvpCount: null == mvpCount
          ? _value.mvpCount
          : mvpCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubPlayerStatsModelImplCopyWith<$Res>
    implements $ClubPlayerStatsModelCopyWith<$Res> {
  factory _$$ClubPlayerStatsModelImplCopyWith(_$ClubPlayerStatsModelImpl value,
          $Res Function(_$ClubPlayerStatsModelImpl) then) =
      __$$ClubPlayerStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matchCount') int matchCount,
      @JsonKey(name: 'goalCount') int goalCount,
      @JsonKey(name: 'assistCount') int assistCount,
      @JsonKey(name: 'yellowCardCount') int yellowCardCount,
      @JsonKey(name: 'redCardCount') int redCardCount,
      @JsonKey(name: 'mvpCount') int mvpCount});
}

/// @nodoc
class __$$ClubPlayerStatsModelImplCopyWithImpl<$Res>
    extends _$ClubPlayerStatsModelCopyWithImpl<$Res, _$ClubPlayerStatsModelImpl>
    implements _$$ClubPlayerStatsModelImplCopyWith<$Res> {
  __$$ClubPlayerStatsModelImplCopyWithImpl(_$ClubPlayerStatsModelImpl _value,
      $Res Function(_$ClubPlayerStatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchCount = null,
    Object? goalCount = null,
    Object? assistCount = null,
    Object? yellowCardCount = null,
    Object? redCardCount = null,
    Object? mvpCount = null,
  }) {
    return _then(_$ClubPlayerStatsModelImpl(
      matchCount: null == matchCount
          ? _value.matchCount
          : matchCount // ignore: cast_nullable_to_non_nullable
              as int,
      goalCount: null == goalCount
          ? _value.goalCount
          : goalCount // ignore: cast_nullable_to_non_nullable
              as int,
      assistCount: null == assistCount
          ? _value.assistCount
          : assistCount // ignore: cast_nullable_to_non_nullable
              as int,
      yellowCardCount: null == yellowCardCount
          ? _value.yellowCardCount
          : yellowCardCount // ignore: cast_nullable_to_non_nullable
              as int,
      redCardCount: null == redCardCount
          ? _value.redCardCount
          : redCardCount // ignore: cast_nullable_to_non_nullable
              as int,
      mvpCount: null == mvpCount
          ? _value.mvpCount
          : mvpCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubPlayerStatsModelImpl implements _ClubPlayerStatsModel {
  const _$ClubPlayerStatsModelImpl(
      {@JsonKey(name: 'matchCount') this.matchCount = 0,
      @JsonKey(name: 'goalCount') this.goalCount = 0,
      @JsonKey(name: 'assistCount') this.assistCount = 0,
      @JsonKey(name: 'yellowCardCount') this.yellowCardCount = 0,
      @JsonKey(name: 'redCardCount') this.redCardCount = 0,
      @JsonKey(name: 'mvpCount') this.mvpCount = 0});

  factory _$ClubPlayerStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubPlayerStatsModelImplFromJson(json);

  @override
  @JsonKey(name: 'matchCount')
  final int matchCount;
  @override
  @JsonKey(name: 'goalCount')
  final int goalCount;
  @override
  @JsonKey(name: 'assistCount')
  final int assistCount;
  @override
  @JsonKey(name: 'yellowCardCount')
  final int yellowCardCount;
  @override
  @JsonKey(name: 'redCardCount')
  final int redCardCount;
  @override
  @JsonKey(name: 'mvpCount')
  final int mvpCount;

  @override
  String toString() {
    return 'ClubPlayerStatsModel(matchCount: $matchCount, goalCount: $goalCount, assistCount: $assistCount, yellowCardCount: $yellowCardCount, redCardCount: $redCardCount, mvpCount: $mvpCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubPlayerStatsModelImpl &&
            (identical(other.matchCount, matchCount) ||
                other.matchCount == matchCount) &&
            (identical(other.goalCount, goalCount) ||
                other.goalCount == goalCount) &&
            (identical(other.assistCount, assistCount) ||
                other.assistCount == assistCount) &&
            (identical(other.yellowCardCount, yellowCardCount) ||
                other.yellowCardCount == yellowCardCount) &&
            (identical(other.redCardCount, redCardCount) ||
                other.redCardCount == redCardCount) &&
            (identical(other.mvpCount, mvpCount) ||
                other.mvpCount == mvpCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, matchCount, goalCount,
      assistCount, yellowCardCount, redCardCount, mvpCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubPlayerStatsModelImplCopyWith<_$ClubPlayerStatsModelImpl>
      get copyWith =>
          __$$ClubPlayerStatsModelImplCopyWithImpl<_$ClubPlayerStatsModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubPlayerStatsModelImplToJson(
      this,
    );
  }
}

abstract class _ClubPlayerStatsModel implements ClubPlayerStatsModel {
  const factory _ClubPlayerStatsModel(
          {@JsonKey(name: 'matchCount') final int matchCount,
          @JsonKey(name: 'goalCount') final int goalCount,
          @JsonKey(name: 'assistCount') final int assistCount,
          @JsonKey(name: 'yellowCardCount') final int yellowCardCount,
          @JsonKey(name: 'redCardCount') final int redCardCount,
          @JsonKey(name: 'mvpCount') final int mvpCount}) =
      _$ClubPlayerStatsModelImpl;

  factory _ClubPlayerStatsModel.fromJson(Map<String, dynamic> json) =
      _$ClubPlayerStatsModelImpl.fromJson;

  @override
  @JsonKey(name: 'matchCount')
  int get matchCount;
  @override
  @JsonKey(name: 'goalCount')
  int get goalCount;
  @override
  @JsonKey(name: 'assistCount')
  int get assistCount;
  @override
  @JsonKey(name: 'yellowCardCount')
  int get yellowCardCount;
  @override
  @JsonKey(name: 'redCardCount')
  int get redCardCount;
  @override
  @JsonKey(name: 'mvpCount')
  int get mvpCount;
  @override
  @JsonKey(ignore: true)
  _$$ClubPlayerStatsModelImplCopyWith<_$ClubPlayerStatsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
