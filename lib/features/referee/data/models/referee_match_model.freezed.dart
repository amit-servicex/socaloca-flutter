// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referee_match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RefereeMatchModel _$RefereeMatchModelFromJson(Map<String, dynamic> json) {
  return _RefereeMatchModel.fromJson(json);
}

/// @nodoc
mixin _$RefereeMatchModel {
  @JsonKey(name: 'matchId')
  String? get matchId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tournamentId')
  String? get tournamentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tournament')
  String? get tournamentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'roundName')
  String? get roundName => throw _privateConstructorUsedError;
  @JsonKey(name: 'city')
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'fieldName')
  String? get fieldName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mainAccept')
  int? get mainAccept => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchDateTimeGmt')
  int? get matchDateTimeGmt => throw _privateConstructorUsedError;
  @JsonKey(name: 'myTeamId')
  String? get myTeamId => throw _privateConstructorUsedError;
  @JsonKey(name: 'opponentTeamId')
  String? get opponentTeamId => throw _privateConstructorUsedError;
  @JsonKey(name: 'stadiumName')
  String? get stadiumName => throw _privateConstructorUsedError;
  @JsonKey(name: 'score')
  RefereeScoreModel? get score => throw _privateConstructorUsedError;
  @JsonKey(name: 'teams')
  List<RefereeTeamModel>? get teams => throw _privateConstructorUsedError;
  @JsonKey(name: 'ageGroup')
  String? get ageGroup =>
      throw _privateConstructorUsedError; // "upcoming" | "live" | "completed"
  @JsonKey(name: 'matchStatus')
  String? get matchStatus =>
      throw _privateConstructorUsedError; // "0" = not submitted, "1" = submitted
  @JsonKey(name: 'scoreStatus')
  String? get scoreStatus =>
      throw _privateConstructorUsedError; // "pending" | "accepted" | "declined"
  @JsonKey(name: 'acceptStatus')
  String? get acceptStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'asstRef1')
  String? get asstRef1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'asstRef2')
  String? get asstRef2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'mainRef')
  String? get mainRef => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchCommis')
  String? get matchCommis => throw _privateConstructorUsedError;
  @JsonKey(name: 'currentMinute')
  String? get currentMinute => throw _privateConstructorUsedError;
  @JsonKey(name: 'state')
  String? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefereeMatchModelCopyWith<RefereeMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefereeMatchModelCopyWith<$Res> {
  factory $RefereeMatchModelCopyWith(
          RefereeMatchModel value, $Res Function(RefereeMatchModel) then) =
      _$RefereeMatchModelCopyWithImpl<$Res, RefereeMatchModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matchId') String? matchId,
      @JsonKey(name: 'tournamentId') String? tournamentId,
      @JsonKey(name: 'tournament') String? tournamentName,
      @JsonKey(name: 'roundName') String? roundName,
      @JsonKey(name: 'city') String? city,
      @JsonKey(name: 'fieldName') String? fieldName,
      @JsonKey(name: 'mainAccept') int? mainAccept,
      @JsonKey(name: 'matchDateTimeGmt') int? matchDateTimeGmt,
      @JsonKey(name: 'myTeamId') String? myTeamId,
      @JsonKey(name: 'opponentTeamId') String? opponentTeamId,
      @JsonKey(name: 'stadiumName') String? stadiumName,
      @JsonKey(name: 'score') RefereeScoreModel? score,
      @JsonKey(name: 'teams') List<RefereeTeamModel>? teams,
      @JsonKey(name: 'ageGroup') String? ageGroup,
      @JsonKey(name: 'matchStatus') String? matchStatus,
      @JsonKey(name: 'scoreStatus') String? scoreStatus,
      @JsonKey(name: 'acceptStatus') String? acceptStatus,
      @JsonKey(name: 'asstRef1') String? asstRef1,
      @JsonKey(name: 'asstRef2') String? asstRef2,
      @JsonKey(name: 'mainRef') String? mainRef,
      @JsonKey(name: 'matchCommis') String? matchCommis,
      @JsonKey(name: 'currentMinute') String? currentMinute,
      @JsonKey(name: 'state') String? state});

  $RefereeScoreModelCopyWith<$Res>? get score;
}

/// @nodoc
class _$RefereeMatchModelCopyWithImpl<$Res, $Val extends RefereeMatchModel>
    implements $RefereeMatchModelCopyWith<$Res> {
  _$RefereeMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = freezed,
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
    Object? roundName = freezed,
    Object? city = freezed,
    Object? fieldName = freezed,
    Object? mainAccept = freezed,
    Object? matchDateTimeGmt = freezed,
    Object? myTeamId = freezed,
    Object? opponentTeamId = freezed,
    Object? stadiumName = freezed,
    Object? score = freezed,
    Object? teams = freezed,
    Object? ageGroup = freezed,
    Object? matchStatus = freezed,
    Object? scoreStatus = freezed,
    Object? acceptStatus = freezed,
    Object? asstRef1 = freezed,
    Object? asstRef2 = freezed,
    Object? mainRef = freezed,
    Object? matchCommis = freezed,
    Object? currentMinute = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      roundName: freezed == roundName
          ? _value.roundName
          : roundName // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      mainAccept: freezed == mainAccept
          ? _value.mainAccept
          : mainAccept // ignore: cast_nullable_to_non_nullable
              as int?,
      matchDateTimeGmt: freezed == matchDateTimeGmt
          ? _value.matchDateTimeGmt
          : matchDateTimeGmt // ignore: cast_nullable_to_non_nullable
              as int?,
      myTeamId: freezed == myTeamId
          ? _value.myTeamId
          : myTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamId: freezed == opponentTeamId
          ? _value.opponentTeamId
          : opponentTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      stadiumName: freezed == stadiumName
          ? _value.stadiumName
          : stadiumName // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as RefereeScoreModel?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<RefereeTeamModel>?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      matchStatus: freezed == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreStatus: freezed == scoreStatus
          ? _value.scoreStatus
          : scoreStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      asstRef1: freezed == asstRef1
          ? _value.asstRef1
          : asstRef1 // ignore: cast_nullable_to_non_nullable
              as String?,
      asstRef2: freezed == asstRef2
          ? _value.asstRef2
          : asstRef2 // ignore: cast_nullable_to_non_nullable
              as String?,
      mainRef: freezed == mainRef
          ? _value.mainRef
          : mainRef // ignore: cast_nullable_to_non_nullable
              as String?,
      matchCommis: freezed == matchCommis
          ? _value.matchCommis
          : matchCommis // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMinute: freezed == currentMinute
          ? _value.currentMinute
          : currentMinute // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RefereeScoreModelCopyWith<$Res>? get score {
    if (_value.score == null) {
      return null;
    }

    return $RefereeScoreModelCopyWith<$Res>(_value.score!, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RefereeMatchModelImplCopyWith<$Res>
    implements $RefereeMatchModelCopyWith<$Res> {
  factory _$$RefereeMatchModelImplCopyWith(_$RefereeMatchModelImpl value,
          $Res Function(_$RefereeMatchModelImpl) then) =
      __$$RefereeMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matchId') String? matchId,
      @JsonKey(name: 'tournamentId') String? tournamentId,
      @JsonKey(name: 'tournament') String? tournamentName,
      @JsonKey(name: 'roundName') String? roundName,
      @JsonKey(name: 'city') String? city,
      @JsonKey(name: 'fieldName') String? fieldName,
      @JsonKey(name: 'mainAccept') int? mainAccept,
      @JsonKey(name: 'matchDateTimeGmt') int? matchDateTimeGmt,
      @JsonKey(name: 'myTeamId') String? myTeamId,
      @JsonKey(name: 'opponentTeamId') String? opponentTeamId,
      @JsonKey(name: 'stadiumName') String? stadiumName,
      @JsonKey(name: 'score') RefereeScoreModel? score,
      @JsonKey(name: 'teams') List<RefereeTeamModel>? teams,
      @JsonKey(name: 'ageGroup') String? ageGroup,
      @JsonKey(name: 'matchStatus') String? matchStatus,
      @JsonKey(name: 'scoreStatus') String? scoreStatus,
      @JsonKey(name: 'acceptStatus') String? acceptStatus,
      @JsonKey(name: 'asstRef1') String? asstRef1,
      @JsonKey(name: 'asstRef2') String? asstRef2,
      @JsonKey(name: 'mainRef') String? mainRef,
      @JsonKey(name: 'matchCommis') String? matchCommis,
      @JsonKey(name: 'currentMinute') String? currentMinute,
      @JsonKey(name: 'state') String? state});

  @override
  $RefereeScoreModelCopyWith<$Res>? get score;
}

/// @nodoc
class __$$RefereeMatchModelImplCopyWithImpl<$Res>
    extends _$RefereeMatchModelCopyWithImpl<$Res, _$RefereeMatchModelImpl>
    implements _$$RefereeMatchModelImplCopyWith<$Res> {
  __$$RefereeMatchModelImplCopyWithImpl(_$RefereeMatchModelImpl _value,
      $Res Function(_$RefereeMatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = freezed,
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
    Object? roundName = freezed,
    Object? city = freezed,
    Object? fieldName = freezed,
    Object? mainAccept = freezed,
    Object? matchDateTimeGmt = freezed,
    Object? myTeamId = freezed,
    Object? opponentTeamId = freezed,
    Object? stadiumName = freezed,
    Object? score = freezed,
    Object? teams = freezed,
    Object? ageGroup = freezed,
    Object? matchStatus = freezed,
    Object? scoreStatus = freezed,
    Object? acceptStatus = freezed,
    Object? asstRef1 = freezed,
    Object? asstRef2 = freezed,
    Object? mainRef = freezed,
    Object? matchCommis = freezed,
    Object? currentMinute = freezed,
    Object? state = freezed,
  }) {
    return _then(_$RefereeMatchModelImpl(
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      roundName: freezed == roundName
          ? _value.roundName
          : roundName // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      mainAccept: freezed == mainAccept
          ? _value.mainAccept
          : mainAccept // ignore: cast_nullable_to_non_nullable
              as int?,
      matchDateTimeGmt: freezed == matchDateTimeGmt
          ? _value.matchDateTimeGmt
          : matchDateTimeGmt // ignore: cast_nullable_to_non_nullable
              as int?,
      myTeamId: freezed == myTeamId
          ? _value.myTeamId
          : myTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamId: freezed == opponentTeamId
          ? _value.opponentTeamId
          : opponentTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      stadiumName: freezed == stadiumName
          ? _value.stadiumName
          : stadiumName // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as RefereeScoreModel?,
      teams: freezed == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<RefereeTeamModel>?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      matchStatus: freezed == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreStatus: freezed == scoreStatus
          ? _value.scoreStatus
          : scoreStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      asstRef1: freezed == asstRef1
          ? _value.asstRef1
          : asstRef1 // ignore: cast_nullable_to_non_nullable
              as String?,
      asstRef2: freezed == asstRef2
          ? _value.asstRef2
          : asstRef2 // ignore: cast_nullable_to_non_nullable
              as String?,
      mainRef: freezed == mainRef
          ? _value.mainRef
          : mainRef // ignore: cast_nullable_to_non_nullable
              as String?,
      matchCommis: freezed == matchCommis
          ? _value.matchCommis
          : matchCommis // ignore: cast_nullable_to_non_nullable
              as String?,
      currentMinute: freezed == currentMinute
          ? _value.currentMinute
          : currentMinute // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefereeMatchModelImpl extends _RefereeMatchModel {
  const _$RefereeMatchModelImpl(
      {@JsonKey(name: 'matchId') this.matchId,
      @JsonKey(name: 'tournamentId') this.tournamentId,
      @JsonKey(name: 'tournament') this.tournamentName,
      @JsonKey(name: 'roundName') this.roundName,
      @JsonKey(name: 'city') this.city,
      @JsonKey(name: 'fieldName') this.fieldName,
      @JsonKey(name: 'mainAccept') this.mainAccept,
      @JsonKey(name: 'matchDateTimeGmt') this.matchDateTimeGmt,
      @JsonKey(name: 'myTeamId') this.myTeamId,
      @JsonKey(name: 'opponentTeamId') this.opponentTeamId,
      @JsonKey(name: 'stadiumName') this.stadiumName,
      @JsonKey(name: 'score') this.score,
      @JsonKey(name: 'teams') final List<RefereeTeamModel>? teams,
      @JsonKey(name: 'ageGroup') this.ageGroup,
      @JsonKey(name: 'matchStatus') this.matchStatus,
      @JsonKey(name: 'scoreStatus') this.scoreStatus,
      @JsonKey(name: 'acceptStatus') this.acceptStatus,
      @JsonKey(name: 'asstRef1') this.asstRef1,
      @JsonKey(name: 'asstRef2') this.asstRef2,
      @JsonKey(name: 'mainRef') this.mainRef,
      @JsonKey(name: 'matchCommis') this.matchCommis,
      @JsonKey(name: 'currentMinute') this.currentMinute,
      @JsonKey(name: 'state') this.state})
      : _teams = teams,
        super._();

  factory _$RefereeMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefereeMatchModelImplFromJson(json);

  @override
  @JsonKey(name: 'matchId')
  final String? matchId;
  @override
  @JsonKey(name: 'tournamentId')
  final String? tournamentId;
  @override
  @JsonKey(name: 'tournament')
  final String? tournamentName;
  @override
  @JsonKey(name: 'roundName')
  final String? roundName;
  @override
  @JsonKey(name: 'city')
  final String? city;
  @override
  @JsonKey(name: 'fieldName')
  final String? fieldName;
  @override
  @JsonKey(name: 'mainAccept')
  final int? mainAccept;
  @override
  @JsonKey(name: 'matchDateTimeGmt')
  final int? matchDateTimeGmt;
  @override
  @JsonKey(name: 'myTeamId')
  final String? myTeamId;
  @override
  @JsonKey(name: 'opponentTeamId')
  final String? opponentTeamId;
  @override
  @JsonKey(name: 'stadiumName')
  final String? stadiumName;
  @override
  @JsonKey(name: 'score')
  final RefereeScoreModel? score;
  final List<RefereeTeamModel>? _teams;
  @override
  @JsonKey(name: 'teams')
  List<RefereeTeamModel>? get teams {
    final value = _teams;
    if (value == null) return null;
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'ageGroup')
  final String? ageGroup;
// "upcoming" | "live" | "completed"
  @override
  @JsonKey(name: 'matchStatus')
  final String? matchStatus;
// "0" = not submitted, "1" = submitted
  @override
  @JsonKey(name: 'scoreStatus')
  final String? scoreStatus;
// "pending" | "accepted" | "declined"
  @override
  @JsonKey(name: 'acceptStatus')
  final String? acceptStatus;
  @override
  @JsonKey(name: 'asstRef1')
  final String? asstRef1;
  @override
  @JsonKey(name: 'asstRef2')
  final String? asstRef2;
  @override
  @JsonKey(name: 'mainRef')
  final String? mainRef;
  @override
  @JsonKey(name: 'matchCommis')
  final String? matchCommis;
  @override
  @JsonKey(name: 'currentMinute')
  final String? currentMinute;
  @override
  @JsonKey(name: 'state')
  final String? state;

  @override
  String toString() {
    return 'RefereeMatchModel(matchId: $matchId, tournamentId: $tournamentId, tournamentName: $tournamentName, roundName: $roundName, city: $city, fieldName: $fieldName, mainAccept: $mainAccept, matchDateTimeGmt: $matchDateTimeGmt, myTeamId: $myTeamId, opponentTeamId: $opponentTeamId, stadiumName: $stadiumName, score: $score, teams: $teams, ageGroup: $ageGroup, matchStatus: $matchStatus, scoreStatus: $scoreStatus, acceptStatus: $acceptStatus, asstRef1: $asstRef1, asstRef2: $asstRef2, mainRef: $mainRef, matchCommis: $matchCommis, currentMinute: $currentMinute, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefereeMatchModelImpl &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName) &&
            (identical(other.roundName, roundName) ||
                other.roundName == roundName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.mainAccept, mainAccept) ||
                other.mainAccept == mainAccept) &&
            (identical(other.matchDateTimeGmt, matchDateTimeGmt) ||
                other.matchDateTimeGmt == matchDateTimeGmt) &&
            (identical(other.myTeamId, myTeamId) ||
                other.myTeamId == myTeamId) &&
            (identical(other.opponentTeamId, opponentTeamId) ||
                other.opponentTeamId == opponentTeamId) &&
            (identical(other.stadiumName, stadiumName) ||
                other.stadiumName == stadiumName) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.matchStatus, matchStatus) ||
                other.matchStatus == matchStatus) &&
            (identical(other.scoreStatus, scoreStatus) ||
                other.scoreStatus == scoreStatus) &&
            (identical(other.acceptStatus, acceptStatus) ||
                other.acceptStatus == acceptStatus) &&
            (identical(other.asstRef1, asstRef1) ||
                other.asstRef1 == asstRef1) &&
            (identical(other.asstRef2, asstRef2) ||
                other.asstRef2 == asstRef2) &&
            (identical(other.mainRef, mainRef) || other.mainRef == mainRef) &&
            (identical(other.matchCommis, matchCommis) ||
                other.matchCommis == matchCommis) &&
            (identical(other.currentMinute, currentMinute) ||
                other.currentMinute == currentMinute) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        matchId,
        tournamentId,
        tournamentName,
        roundName,
        city,
        fieldName,
        mainAccept,
        matchDateTimeGmt,
        myTeamId,
        opponentTeamId,
        stadiumName,
        score,
        const DeepCollectionEquality().hash(_teams),
        ageGroup,
        matchStatus,
        scoreStatus,
        acceptStatus,
        asstRef1,
        asstRef2,
        mainRef,
        matchCommis,
        currentMinute,
        state
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefereeMatchModelImplCopyWith<_$RefereeMatchModelImpl> get copyWith =>
      __$$RefereeMatchModelImplCopyWithImpl<_$RefereeMatchModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefereeMatchModelImplToJson(
      this,
    );
  }
}

abstract class _RefereeMatchModel extends RefereeMatchModel {
  const factory _RefereeMatchModel(
      {@JsonKey(name: 'matchId') final String? matchId,
      @JsonKey(name: 'tournamentId') final String? tournamentId,
      @JsonKey(name: 'tournament') final String? tournamentName,
      @JsonKey(name: 'roundName') final String? roundName,
      @JsonKey(name: 'city') final String? city,
      @JsonKey(name: 'fieldName') final String? fieldName,
      @JsonKey(name: 'mainAccept') final int? mainAccept,
      @JsonKey(name: 'matchDateTimeGmt') final int? matchDateTimeGmt,
      @JsonKey(name: 'myTeamId') final String? myTeamId,
      @JsonKey(name: 'opponentTeamId') final String? opponentTeamId,
      @JsonKey(name: 'stadiumName') final String? stadiumName,
      @JsonKey(name: 'score') final RefereeScoreModel? score,
      @JsonKey(name: 'teams') final List<RefereeTeamModel>? teams,
      @JsonKey(name: 'ageGroup') final String? ageGroup,
      @JsonKey(name: 'matchStatus') final String? matchStatus,
      @JsonKey(name: 'scoreStatus') final String? scoreStatus,
      @JsonKey(name: 'acceptStatus') final String? acceptStatus,
      @JsonKey(name: 'asstRef1') final String? asstRef1,
      @JsonKey(name: 'asstRef2') final String? asstRef2,
      @JsonKey(name: 'mainRef') final String? mainRef,
      @JsonKey(name: 'matchCommis') final String? matchCommis,
      @JsonKey(name: 'currentMinute') final String? currentMinute,
      @JsonKey(name: 'state') final String? state}) = _$RefereeMatchModelImpl;
  const _RefereeMatchModel._() : super._();

  factory _RefereeMatchModel.fromJson(Map<String, dynamic> json) =
      _$RefereeMatchModelImpl.fromJson;

  @override
  @JsonKey(name: 'matchId')
  String? get matchId;
  @override
  @JsonKey(name: 'tournamentId')
  String? get tournamentId;
  @override
  @JsonKey(name: 'tournament')
  String? get tournamentName;
  @override
  @JsonKey(name: 'roundName')
  String? get roundName;
  @override
  @JsonKey(name: 'city')
  String? get city;
  @override
  @JsonKey(name: 'fieldName')
  String? get fieldName;
  @override
  @JsonKey(name: 'mainAccept')
  int? get mainAccept;
  @override
  @JsonKey(name: 'matchDateTimeGmt')
  int? get matchDateTimeGmt;
  @override
  @JsonKey(name: 'myTeamId')
  String? get myTeamId;
  @override
  @JsonKey(name: 'opponentTeamId')
  String? get opponentTeamId;
  @override
  @JsonKey(name: 'stadiumName')
  String? get stadiumName;
  @override
  @JsonKey(name: 'score')
  RefereeScoreModel? get score;
  @override
  @JsonKey(name: 'teams')
  List<RefereeTeamModel>? get teams;
  @override
  @JsonKey(name: 'ageGroup')
  String? get ageGroup;
  @override // "upcoming" | "live" | "completed"
  @JsonKey(name: 'matchStatus')
  String? get matchStatus;
  @override // "0" = not submitted, "1" = submitted
  @JsonKey(name: 'scoreStatus')
  String? get scoreStatus;
  @override // "pending" | "accepted" | "declined"
  @JsonKey(name: 'acceptStatus')
  String? get acceptStatus;
  @override
  @JsonKey(name: 'asstRef1')
  String? get asstRef1;
  @override
  @JsonKey(name: 'asstRef2')
  String? get asstRef2;
  @override
  @JsonKey(name: 'mainRef')
  String? get mainRef;
  @override
  @JsonKey(name: 'matchCommis')
  String? get matchCommis;
  @override
  @JsonKey(name: 'currentMinute')
  String? get currentMinute;
  @override
  @JsonKey(name: 'state')
  String? get state;
  @override
  @JsonKey(ignore: true)
  _$$RefereeMatchModelImplCopyWith<_$RefereeMatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RefereeScoreModel _$RefereeScoreModelFromJson(Map<String, dynamic> json) {
  return _RefereeScoreModel.fromJson(json);
}

/// @nodoc
mixin _$RefereeScoreModel {
  int? get myGoals => throw _privateConstructorUsedError;
  int? get opponentGoals => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefereeScoreModelCopyWith<RefereeScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefereeScoreModelCopyWith<$Res> {
  factory $RefereeScoreModelCopyWith(
          RefereeScoreModel value, $Res Function(RefereeScoreModel) then) =
      _$RefereeScoreModelCopyWithImpl<$Res, RefereeScoreModel>;
  @useResult
  $Res call({int? myGoals, int? opponentGoals});
}

/// @nodoc
class _$RefereeScoreModelCopyWithImpl<$Res, $Val extends RefereeScoreModel>
    implements $RefereeScoreModelCopyWith<$Res> {
  _$RefereeScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myGoals = freezed,
    Object? opponentGoals = freezed,
  }) {
    return _then(_value.copyWith(
      myGoals: freezed == myGoals
          ? _value.myGoals
          : myGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentGoals: freezed == opponentGoals
          ? _value.opponentGoals
          : opponentGoals // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefereeScoreModelImplCopyWith<$Res>
    implements $RefereeScoreModelCopyWith<$Res> {
  factory _$$RefereeScoreModelImplCopyWith(_$RefereeScoreModelImpl value,
          $Res Function(_$RefereeScoreModelImpl) then) =
      __$$RefereeScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? myGoals, int? opponentGoals});
}

/// @nodoc
class __$$RefereeScoreModelImplCopyWithImpl<$Res>
    extends _$RefereeScoreModelCopyWithImpl<$Res, _$RefereeScoreModelImpl>
    implements _$$RefereeScoreModelImplCopyWith<$Res> {
  __$$RefereeScoreModelImplCopyWithImpl(_$RefereeScoreModelImpl _value,
      $Res Function(_$RefereeScoreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myGoals = freezed,
    Object? opponentGoals = freezed,
  }) {
    return _then(_$RefereeScoreModelImpl(
      myGoals: freezed == myGoals
          ? _value.myGoals
          : myGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentGoals: freezed == opponentGoals
          ? _value.opponentGoals
          : opponentGoals // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefereeScoreModelImpl implements _RefereeScoreModel {
  const _$RefereeScoreModelImpl({this.myGoals, this.opponentGoals});

  factory _$RefereeScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefereeScoreModelImplFromJson(json);

  @override
  final int? myGoals;
  @override
  final int? opponentGoals;

  @override
  String toString() {
    return 'RefereeScoreModel(myGoals: $myGoals, opponentGoals: $opponentGoals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefereeScoreModelImpl &&
            (identical(other.myGoals, myGoals) || other.myGoals == myGoals) &&
            (identical(other.opponentGoals, opponentGoals) ||
                other.opponentGoals == opponentGoals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, myGoals, opponentGoals);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefereeScoreModelImplCopyWith<_$RefereeScoreModelImpl> get copyWith =>
      __$$RefereeScoreModelImplCopyWithImpl<_$RefereeScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefereeScoreModelImplToJson(
      this,
    );
  }
}

abstract class _RefereeScoreModel implements RefereeScoreModel {
  const factory _RefereeScoreModel(
      {final int? myGoals, final int? opponentGoals}) = _$RefereeScoreModelImpl;

  factory _RefereeScoreModel.fromJson(Map<String, dynamic> json) =
      _$RefereeScoreModelImpl.fromJson;

  @override
  int? get myGoals;
  @override
  int? get opponentGoals;
  @override
  @JsonKey(ignore: true)
  _$$RefereeScoreModelImplCopyWith<_$RefereeScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RefereeTeamModel _$RefereeTeamModelFromJson(Map<String, dynamic> json) {
  return _RefereeTeamModel.fromJson(json);
}

/// @nodoc
mixin _$RefereeTeamModel {
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamShortName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefereeTeamModelCopyWith<RefereeTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefereeTeamModelCopyWith<$Res> {
  factory $RefereeTeamModelCopyWith(
          RefereeTeamModel value, $Res Function(RefereeTeamModel) then) =
      _$RefereeTeamModelCopyWithImpl<$Res, RefereeTeamModel>;
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamShortName,
      String? imageUrl});
}

/// @nodoc
class _$RefereeTeamModelCopyWithImpl<$Res, $Val extends RefereeTeamModel>
    implements $RefereeTeamModelCopyWith<$Res> {
  _$RefereeTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
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
      teamShortName: freezed == teamShortName
          ? _value.teamShortName
          : teamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefereeTeamModelImplCopyWith<$Res>
    implements $RefereeTeamModelCopyWith<$Res> {
  factory _$$RefereeTeamModelImplCopyWith(_$RefereeTeamModelImpl value,
          $Res Function(_$RefereeTeamModelImpl) then) =
      __$$RefereeTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamShortName,
      String? imageUrl});
}

/// @nodoc
class __$$RefereeTeamModelImplCopyWithImpl<$Res>
    extends _$RefereeTeamModelCopyWithImpl<$Res, _$RefereeTeamModelImpl>
    implements _$$RefereeTeamModelImplCopyWith<$Res> {
  __$$RefereeTeamModelImplCopyWithImpl(_$RefereeTeamModelImpl _value,
      $Res Function(_$RefereeTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$RefereeTeamModelImpl(
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamShortName: freezed == teamShortName
          ? _value.teamShortName
          : teamShortName // ignore: cast_nullable_to_non_nullable
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
class _$RefereeTeamModelImpl implements _RefereeTeamModel {
  const _$RefereeTeamModelImpl(
      {this.teamId, this.teamName, this.teamShortName, this.imageUrl});

  factory _$RefereeTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefereeTeamModelImplFromJson(json);

  @override
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? teamShortName;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'RefereeTeamModel(teamId: $teamId, teamName: $teamName, teamShortName: $teamShortName, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefereeTeamModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamShortName, teamShortName) ||
                other.teamShortName == teamShortName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, teamId, teamName, teamShortName, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefereeTeamModelImplCopyWith<_$RefereeTeamModelImpl> get copyWith =>
      __$$RefereeTeamModelImplCopyWithImpl<_$RefereeTeamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefereeTeamModelImplToJson(
      this,
    );
  }
}

abstract class _RefereeTeamModel implements RefereeTeamModel {
  const factory _RefereeTeamModel(
      {final String? teamId,
      final String? teamName,
      final String? teamShortName,
      final String? imageUrl}) = _$RefereeTeamModelImpl;

  factory _RefereeTeamModel.fromJson(Map<String, dynamic> json) =
      _$RefereeTeamModelImpl.fromJson;

  @override
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get teamShortName;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$RefereeTeamModelImplCopyWith<_$RefereeTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TournamentDropdownItem _$TournamentDropdownItemFromJson(
    Map<String, dynamic> json) {
  return _TournamentDropdownItem.fromJson(json);
}

/// @nodoc
mixin _$TournamentDropdownItem {
  @JsonKey(name: 'tournamentId')
  String? get tournamentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get tournamentName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentDropdownItemCopyWith<TournamentDropdownItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentDropdownItemCopyWith<$Res> {
  factory $TournamentDropdownItemCopyWith(TournamentDropdownItem value,
          $Res Function(TournamentDropdownItem) then) =
      _$TournamentDropdownItemCopyWithImpl<$Res, TournamentDropdownItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tournamentId') String? tournamentId,
      @JsonKey(name: 'name') String? tournamentName});
}

/// @nodoc
class _$TournamentDropdownItemCopyWithImpl<$Res,
        $Val extends TournamentDropdownItem>
    implements $TournamentDropdownItemCopyWith<$Res> {
  _$TournamentDropdownItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
  }) {
    return _then(_value.copyWith(
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentDropdownItemImplCopyWith<$Res>
    implements $TournamentDropdownItemCopyWith<$Res> {
  factory _$$TournamentDropdownItemImplCopyWith(
          _$TournamentDropdownItemImpl value,
          $Res Function(_$TournamentDropdownItemImpl) then) =
      __$$TournamentDropdownItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tournamentId') String? tournamentId,
      @JsonKey(name: 'name') String? tournamentName});
}

/// @nodoc
class __$$TournamentDropdownItemImplCopyWithImpl<$Res>
    extends _$TournamentDropdownItemCopyWithImpl<$Res,
        _$TournamentDropdownItemImpl>
    implements _$$TournamentDropdownItemImplCopyWith<$Res> {
  __$$TournamentDropdownItemImplCopyWithImpl(
      _$TournamentDropdownItemImpl _value,
      $Res Function(_$TournamentDropdownItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
  }) {
    return _then(_$TournamentDropdownItemImpl(
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentDropdownItemImpl implements _TournamentDropdownItem {
  const _$TournamentDropdownItemImpl(
      {@JsonKey(name: 'tournamentId') this.tournamentId,
      @JsonKey(name: 'name') this.tournamentName});

  factory _$TournamentDropdownItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentDropdownItemImplFromJson(json);

  @override
  @JsonKey(name: 'tournamentId')
  final String? tournamentId;
  @override
  @JsonKey(name: 'name')
  final String? tournamentName;

  @override
  String toString() {
    return 'TournamentDropdownItem(tournamentId: $tournamentId, tournamentName: $tournamentName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentDropdownItemImpl &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tournamentId, tournamentName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentDropdownItemImplCopyWith<_$TournamentDropdownItemImpl>
      get copyWith => __$$TournamentDropdownItemImplCopyWithImpl<
          _$TournamentDropdownItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentDropdownItemImplToJson(
      this,
    );
  }
}

abstract class _TournamentDropdownItem implements TournamentDropdownItem {
  const factory _TournamentDropdownItem(
          {@JsonKey(name: 'tournamentId') final String? tournamentId,
          @JsonKey(name: 'name') final String? tournamentName}) =
      _$TournamentDropdownItemImpl;

  factory _TournamentDropdownItem.fromJson(Map<String, dynamic> json) =
      _$TournamentDropdownItemImpl.fromJson;

  @override
  @JsonKey(name: 'tournamentId')
  String? get tournamentId;
  @override
  @JsonKey(name: 'name')
  String? get tournamentName;
  @override
  @JsonKey(ignore: true)
  _$$TournamentDropdownItemImplCopyWith<_$TournamentDropdownItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
