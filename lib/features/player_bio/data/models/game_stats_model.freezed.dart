// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameStatsModel _$GameStatsModelFromJson(Map<String, dynamic> json) {
  return _GameStatsModel.fromJson(json);
}

/// @nodoc
mixin _$GameStatsModel {
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
  @JsonKey(name: 'cleanSheetCount')
  int get cleanSheetCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'gameType')
  String? get gameType => throw _privateConstructorUsedError;
  @JsonKey(name: 'year')
  int? get year => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStatsModelCopyWith<GameStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStatsModelCopyWith<$Res> {
  factory $GameStatsModelCopyWith(
          GameStatsModel value, $Res Function(GameStatsModel) then) =
      _$GameStatsModelCopyWithImpl<$Res, GameStatsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matchCount') int matchCount,
      @JsonKey(name: 'goalCount') int goalCount,
      @JsonKey(name: 'assistCount') int assistCount,
      @JsonKey(name: 'yellowCardCount') int yellowCardCount,
      @JsonKey(name: 'redCardCount') int redCardCount,
      @JsonKey(name: 'mvpCount') int mvpCount,
      @JsonKey(name: 'cleanSheetCount') int cleanSheetCount,
      @JsonKey(name: 'gameType') String? gameType,
      @JsonKey(name: 'year') int? year});
}

/// @nodoc
class _$GameStatsModelCopyWithImpl<$Res, $Val extends GameStatsModel>
    implements $GameStatsModelCopyWith<$Res> {
  _$GameStatsModelCopyWithImpl(this._value, this._then);

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
    Object? cleanSheetCount = null,
    Object? gameType = freezed,
    Object? year = freezed,
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
      cleanSheetCount: null == cleanSheetCount
          ? _value.cleanSheetCount
          : cleanSheetCount // ignore: cast_nullable_to_non_nullable
              as int,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStatsModelImplCopyWith<$Res>
    implements $GameStatsModelCopyWith<$Res> {
  factory _$$GameStatsModelImplCopyWith(_$GameStatsModelImpl value,
          $Res Function(_$GameStatsModelImpl) then) =
      __$$GameStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matchCount') int matchCount,
      @JsonKey(name: 'goalCount') int goalCount,
      @JsonKey(name: 'assistCount') int assistCount,
      @JsonKey(name: 'yellowCardCount') int yellowCardCount,
      @JsonKey(name: 'redCardCount') int redCardCount,
      @JsonKey(name: 'mvpCount') int mvpCount,
      @JsonKey(name: 'cleanSheetCount') int cleanSheetCount,
      @JsonKey(name: 'gameType') String? gameType,
      @JsonKey(name: 'year') int? year});
}

/// @nodoc
class __$$GameStatsModelImplCopyWithImpl<$Res>
    extends _$GameStatsModelCopyWithImpl<$Res, _$GameStatsModelImpl>
    implements _$$GameStatsModelImplCopyWith<$Res> {
  __$$GameStatsModelImplCopyWithImpl(
      _$GameStatsModelImpl _value, $Res Function(_$GameStatsModelImpl) _then)
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
    Object? cleanSheetCount = null,
    Object? gameType = freezed,
    Object? year = freezed,
  }) {
    return _then(_$GameStatsModelImpl(
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
      cleanSheetCount: null == cleanSheetCount
          ? _value.cleanSheetCount
          : cleanSheetCount // ignore: cast_nullable_to_non_nullable
              as int,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStatsModelImpl implements _GameStatsModel {
  const _$GameStatsModelImpl(
      {@JsonKey(name: 'matchCount') this.matchCount = 0,
      @JsonKey(name: 'goalCount') this.goalCount = 0,
      @JsonKey(name: 'assistCount') this.assistCount = 0,
      @JsonKey(name: 'yellowCardCount') this.yellowCardCount = 0,
      @JsonKey(name: 'redCardCount') this.redCardCount = 0,
      @JsonKey(name: 'mvpCount') this.mvpCount = 0,
      @JsonKey(name: 'cleanSheetCount') this.cleanSheetCount = 0,
      @JsonKey(name: 'gameType') this.gameType,
      @JsonKey(name: 'year') this.year});

  factory _$GameStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStatsModelImplFromJson(json);

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
  @JsonKey(name: 'cleanSheetCount')
  final int cleanSheetCount;
  @override
  @JsonKey(name: 'gameType')
  final String? gameType;
  @override
  @JsonKey(name: 'year')
  final int? year;

  @override
  String toString() {
    return 'GameStatsModel(matchCount: $matchCount, goalCount: $goalCount, assistCount: $assistCount, yellowCardCount: $yellowCardCount, redCardCount: $redCardCount, mvpCount: $mvpCount, cleanSheetCount: $cleanSheetCount, gameType: $gameType, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStatsModelImpl &&
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
                other.mvpCount == mvpCount) &&
            (identical(other.cleanSheetCount, cleanSheetCount) ||
                other.cleanSheetCount == cleanSheetCount) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      matchCount,
      goalCount,
      assistCount,
      yellowCardCount,
      redCardCount,
      mvpCount,
      cleanSheetCount,
      gameType,
      year);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStatsModelImplCopyWith<_$GameStatsModelImpl> get copyWith =>
      __$$GameStatsModelImplCopyWithImpl<_$GameStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStatsModelImplToJson(
      this,
    );
  }
}

abstract class _GameStatsModel implements GameStatsModel {
  const factory _GameStatsModel(
      {@JsonKey(name: 'matchCount') final int matchCount,
      @JsonKey(name: 'goalCount') final int goalCount,
      @JsonKey(name: 'assistCount') final int assistCount,
      @JsonKey(name: 'yellowCardCount') final int yellowCardCount,
      @JsonKey(name: 'redCardCount') final int redCardCount,
      @JsonKey(name: 'mvpCount') final int mvpCount,
      @JsonKey(name: 'cleanSheetCount') final int cleanSheetCount,
      @JsonKey(name: 'gameType') final String? gameType,
      @JsonKey(name: 'year') final int? year}) = _$GameStatsModelImpl;

  factory _GameStatsModel.fromJson(Map<String, dynamic> json) =
      _$GameStatsModelImpl.fromJson;

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
  @JsonKey(name: 'cleanSheetCount')
  int get cleanSheetCount;
  @override
  @JsonKey(name: 'gameType')
  String? get gameType;
  @override
  @JsonKey(name: 'year')
  int? get year;
  @override
  @JsonKey(ignore: true)
  _$$GameStatsModelImplCopyWith<_$GameStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
