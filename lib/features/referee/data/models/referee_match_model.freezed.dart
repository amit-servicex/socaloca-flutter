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
  @JsonKey(name: 'tournamentName')
  String? get tournamentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'roundName')
  String? get roundName => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamA')
  String? get teamA => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamAId')
  String? get teamAId => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamALogo')
  String? get teamALogo => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamAScore')
  String? get teamAScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamB')
  String? get teamB => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamBId')
  String? get teamBId => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamBLogo')
  String? get teamBLogo => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamBScore')
  String? get teamBScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchDate')
  String? get matchDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchTime')
  String? get matchTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue')
  String? get venue => throw _privateConstructorUsedError;
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
      @JsonKey(name: 'tournamentName') String? tournamentName,
      @JsonKey(name: 'roundName') String? roundName,
      @JsonKey(name: 'teamA') String? teamA,
      @JsonKey(name: 'teamAId') String? teamAId,
      @JsonKey(name: 'teamALogo') String? teamALogo,
      @JsonKey(name: 'teamAScore') String? teamAScore,
      @JsonKey(name: 'teamB') String? teamB,
      @JsonKey(name: 'teamBId') String? teamBId,
      @JsonKey(name: 'teamBLogo') String? teamBLogo,
      @JsonKey(name: 'teamBScore') String? teamBScore,
      @JsonKey(name: 'matchDate') String? matchDate,
      @JsonKey(name: 'matchTime') String? matchTime,
      @JsonKey(name: 'venue') String? venue,
      @JsonKey(name: 'ageGroup') String? ageGroup,
      @JsonKey(name: 'matchStatus') String? matchStatus,
      @JsonKey(name: 'scoreStatus') String? scoreStatus,
      @JsonKey(name: 'acceptStatus') String? acceptStatus,
      @JsonKey(name: 'asstRef1') String? asstRef1,
      @JsonKey(name: 'asstRef2') String? asstRef2,
      @JsonKey(name: 'mainRef') String? mainRef,
      @JsonKey(name: 'matchCommis') String? matchCommis,
      @JsonKey(name: 'currentMinute') String? currentMinute});
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
    Object? teamA = freezed,
    Object? teamAId = freezed,
    Object? teamALogo = freezed,
    Object? teamAScore = freezed,
    Object? teamB = freezed,
    Object? teamBId = freezed,
    Object? teamBLogo = freezed,
    Object? teamBScore = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? venue = freezed,
    Object? ageGroup = freezed,
    Object? matchStatus = freezed,
    Object? scoreStatus = freezed,
    Object? acceptStatus = freezed,
    Object? asstRef1 = freezed,
    Object? asstRef2 = freezed,
    Object? mainRef = freezed,
    Object? matchCommis = freezed,
    Object? currentMinute = freezed,
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
      teamA: freezed == teamA
          ? _value.teamA
          : teamA // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAId: freezed == teamAId
          ? _value.teamAId
          : teamAId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamALogo: freezed == teamALogo
          ? _value.teamALogo
          : teamALogo // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAScore: freezed == teamAScore
          ? _value.teamAScore
          : teamAScore // ignore: cast_nullable_to_non_nullable
              as String?,
      teamB: freezed == teamB
          ? _value.teamB
          : teamB // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBId: freezed == teamBId
          ? _value.teamBId
          : teamBId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBLogo: freezed == teamBLogo
          ? _value.teamBLogo
          : teamBLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBScore: freezed == teamBScore
          ? _value.teamBScore
          : teamBScore // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ) as $Val);
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
      @JsonKey(name: 'tournamentName') String? tournamentName,
      @JsonKey(name: 'roundName') String? roundName,
      @JsonKey(name: 'teamA') String? teamA,
      @JsonKey(name: 'teamAId') String? teamAId,
      @JsonKey(name: 'teamALogo') String? teamALogo,
      @JsonKey(name: 'teamAScore') String? teamAScore,
      @JsonKey(name: 'teamB') String? teamB,
      @JsonKey(name: 'teamBId') String? teamBId,
      @JsonKey(name: 'teamBLogo') String? teamBLogo,
      @JsonKey(name: 'teamBScore') String? teamBScore,
      @JsonKey(name: 'matchDate') String? matchDate,
      @JsonKey(name: 'matchTime') String? matchTime,
      @JsonKey(name: 'venue') String? venue,
      @JsonKey(name: 'ageGroup') String? ageGroup,
      @JsonKey(name: 'matchStatus') String? matchStatus,
      @JsonKey(name: 'scoreStatus') String? scoreStatus,
      @JsonKey(name: 'acceptStatus') String? acceptStatus,
      @JsonKey(name: 'asstRef1') String? asstRef1,
      @JsonKey(name: 'asstRef2') String? asstRef2,
      @JsonKey(name: 'mainRef') String? mainRef,
      @JsonKey(name: 'matchCommis') String? matchCommis,
      @JsonKey(name: 'currentMinute') String? currentMinute});
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
    Object? teamA = freezed,
    Object? teamAId = freezed,
    Object? teamALogo = freezed,
    Object? teamAScore = freezed,
    Object? teamB = freezed,
    Object? teamBId = freezed,
    Object? teamBLogo = freezed,
    Object? teamBScore = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? venue = freezed,
    Object? ageGroup = freezed,
    Object? matchStatus = freezed,
    Object? scoreStatus = freezed,
    Object? acceptStatus = freezed,
    Object? asstRef1 = freezed,
    Object? asstRef2 = freezed,
    Object? mainRef = freezed,
    Object? matchCommis = freezed,
    Object? currentMinute = freezed,
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
      teamA: freezed == teamA
          ? _value.teamA
          : teamA // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAId: freezed == teamAId
          ? _value.teamAId
          : teamAId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamALogo: freezed == teamALogo
          ? _value.teamALogo
          : teamALogo // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAScore: freezed == teamAScore
          ? _value.teamAScore
          : teamAScore // ignore: cast_nullable_to_non_nullable
              as String?,
      teamB: freezed == teamB
          ? _value.teamB
          : teamB // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBId: freezed == teamBId
          ? _value.teamBId
          : teamBId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBLogo: freezed == teamBLogo
          ? _value.teamBLogo
          : teamBLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      teamBScore: freezed == teamBScore
          ? _value.teamBScore
          : teamBScore // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefereeMatchModelImpl implements _RefereeMatchModel {
  const _$RefereeMatchModelImpl(
      {@JsonKey(name: 'matchId') this.matchId,
      @JsonKey(name: 'tournamentId') this.tournamentId,
      @JsonKey(name: 'tournamentName') this.tournamentName,
      @JsonKey(name: 'roundName') this.roundName,
      @JsonKey(name: 'teamA') this.teamA,
      @JsonKey(name: 'teamAId') this.teamAId,
      @JsonKey(name: 'teamALogo') this.teamALogo,
      @JsonKey(name: 'teamAScore') this.teamAScore,
      @JsonKey(name: 'teamB') this.teamB,
      @JsonKey(name: 'teamBId') this.teamBId,
      @JsonKey(name: 'teamBLogo') this.teamBLogo,
      @JsonKey(name: 'teamBScore') this.teamBScore,
      @JsonKey(name: 'matchDate') this.matchDate,
      @JsonKey(name: 'matchTime') this.matchTime,
      @JsonKey(name: 'venue') this.venue,
      @JsonKey(name: 'ageGroup') this.ageGroup,
      @JsonKey(name: 'matchStatus') this.matchStatus,
      @JsonKey(name: 'scoreStatus') this.scoreStatus,
      @JsonKey(name: 'acceptStatus') this.acceptStatus,
      @JsonKey(name: 'asstRef1') this.asstRef1,
      @JsonKey(name: 'asstRef2') this.asstRef2,
      @JsonKey(name: 'mainRef') this.mainRef,
      @JsonKey(name: 'matchCommis') this.matchCommis,
      @JsonKey(name: 'currentMinute') this.currentMinute});

  factory _$RefereeMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefereeMatchModelImplFromJson(json);

  @override
  @JsonKey(name: 'matchId')
  final String? matchId;
  @override
  @JsonKey(name: 'tournamentId')
  final String? tournamentId;
  @override
  @JsonKey(name: 'tournamentName')
  final String? tournamentName;
  @override
  @JsonKey(name: 'roundName')
  final String? roundName;
  @override
  @JsonKey(name: 'teamA')
  final String? teamA;
  @override
  @JsonKey(name: 'teamAId')
  final String? teamAId;
  @override
  @JsonKey(name: 'teamALogo')
  final String? teamALogo;
  @override
  @JsonKey(name: 'teamAScore')
  final String? teamAScore;
  @override
  @JsonKey(name: 'teamB')
  final String? teamB;
  @override
  @JsonKey(name: 'teamBId')
  final String? teamBId;
  @override
  @JsonKey(name: 'teamBLogo')
  final String? teamBLogo;
  @override
  @JsonKey(name: 'teamBScore')
  final String? teamBScore;
  @override
  @JsonKey(name: 'matchDate')
  final String? matchDate;
  @override
  @JsonKey(name: 'matchTime')
  final String? matchTime;
  @override
  @JsonKey(name: 'venue')
  final String? venue;
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
  String toString() {
    return 'RefereeMatchModel(matchId: $matchId, tournamentId: $tournamentId, tournamentName: $tournamentName, roundName: $roundName, teamA: $teamA, teamAId: $teamAId, teamALogo: $teamALogo, teamAScore: $teamAScore, teamB: $teamB, teamBId: $teamBId, teamBLogo: $teamBLogo, teamBScore: $teamBScore, matchDate: $matchDate, matchTime: $matchTime, venue: $venue, ageGroup: $ageGroup, matchStatus: $matchStatus, scoreStatus: $scoreStatus, acceptStatus: $acceptStatus, asstRef1: $asstRef1, asstRef2: $asstRef2, mainRef: $mainRef, matchCommis: $matchCommis, currentMinute: $currentMinute)';
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
            (identical(other.teamA, teamA) || other.teamA == teamA) &&
            (identical(other.teamAId, teamAId) || other.teamAId == teamAId) &&
            (identical(other.teamALogo, teamALogo) ||
                other.teamALogo == teamALogo) &&
            (identical(other.teamAScore, teamAScore) ||
                other.teamAScore == teamAScore) &&
            (identical(other.teamB, teamB) || other.teamB == teamB) &&
            (identical(other.teamBId, teamBId) || other.teamBId == teamBId) &&
            (identical(other.teamBLogo, teamBLogo) ||
                other.teamBLogo == teamBLogo) &&
            (identical(other.teamBScore, teamBScore) ||
                other.teamBScore == teamBScore) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.venue, venue) || other.venue == venue) &&
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
                other.currentMinute == currentMinute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        matchId,
        tournamentId,
        tournamentName,
        roundName,
        teamA,
        teamAId,
        teamALogo,
        teamAScore,
        teamB,
        teamBId,
        teamBLogo,
        teamBScore,
        matchDate,
        matchTime,
        venue,
        ageGroup,
        matchStatus,
        scoreStatus,
        acceptStatus,
        asstRef1,
        asstRef2,
        mainRef,
        matchCommis,
        currentMinute
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

abstract class _RefereeMatchModel implements RefereeMatchModel {
  const factory _RefereeMatchModel(
          {@JsonKey(name: 'matchId') final String? matchId,
          @JsonKey(name: 'tournamentId') final String? tournamentId,
          @JsonKey(name: 'tournamentName') final String? tournamentName,
          @JsonKey(name: 'roundName') final String? roundName,
          @JsonKey(name: 'teamA') final String? teamA,
          @JsonKey(name: 'teamAId') final String? teamAId,
          @JsonKey(name: 'teamALogo') final String? teamALogo,
          @JsonKey(name: 'teamAScore') final String? teamAScore,
          @JsonKey(name: 'teamB') final String? teamB,
          @JsonKey(name: 'teamBId') final String? teamBId,
          @JsonKey(name: 'teamBLogo') final String? teamBLogo,
          @JsonKey(name: 'teamBScore') final String? teamBScore,
          @JsonKey(name: 'matchDate') final String? matchDate,
          @JsonKey(name: 'matchTime') final String? matchTime,
          @JsonKey(name: 'venue') final String? venue,
          @JsonKey(name: 'ageGroup') final String? ageGroup,
          @JsonKey(name: 'matchStatus') final String? matchStatus,
          @JsonKey(name: 'scoreStatus') final String? scoreStatus,
          @JsonKey(name: 'acceptStatus') final String? acceptStatus,
          @JsonKey(name: 'asstRef1') final String? asstRef1,
          @JsonKey(name: 'asstRef2') final String? asstRef2,
          @JsonKey(name: 'mainRef') final String? mainRef,
          @JsonKey(name: 'matchCommis') final String? matchCommis,
          @JsonKey(name: 'currentMinute') final String? currentMinute}) =
      _$RefereeMatchModelImpl;

  factory _RefereeMatchModel.fromJson(Map<String, dynamic> json) =
      _$RefereeMatchModelImpl.fromJson;

  @override
  @JsonKey(name: 'matchId')
  String? get matchId;
  @override
  @JsonKey(name: 'tournamentId')
  String? get tournamentId;
  @override
  @JsonKey(name: 'tournamentName')
  String? get tournamentName;
  @override
  @JsonKey(name: 'roundName')
  String? get roundName;
  @override
  @JsonKey(name: 'teamA')
  String? get teamA;
  @override
  @JsonKey(name: 'teamAId')
  String? get teamAId;
  @override
  @JsonKey(name: 'teamALogo')
  String? get teamALogo;
  @override
  @JsonKey(name: 'teamAScore')
  String? get teamAScore;
  @override
  @JsonKey(name: 'teamB')
  String? get teamB;
  @override
  @JsonKey(name: 'teamBId')
  String? get teamBId;
  @override
  @JsonKey(name: 'teamBLogo')
  String? get teamBLogo;
  @override
  @JsonKey(name: 'teamBScore')
  String? get teamBScore;
  @override
  @JsonKey(name: 'matchDate')
  String? get matchDate;
  @override
  @JsonKey(name: 'matchTime')
  String? get matchTime;
  @override
  @JsonKey(name: 'venue')
  String? get venue;
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
  @JsonKey(ignore: true)
  _$$RefereeMatchModelImplCopyWith<_$RefereeMatchModelImpl> get copyWith =>
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
  @JsonKey(name: 'tournamentName')
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
      @JsonKey(name: 'tournamentName') String? tournamentName});
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
      @JsonKey(name: 'tournamentName') String? tournamentName});
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
      @JsonKey(name: 'tournamentName') this.tournamentName});

  factory _$TournamentDropdownItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentDropdownItemImplFromJson(json);

  @override
  @JsonKey(name: 'tournamentId')
  final String? tournamentId;
  @override
  @JsonKey(name: 'tournamentName')
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
          @JsonKey(name: 'tournamentName') final String? tournamentName}) =
      _$TournamentDropdownItemImpl;

  factory _TournamentDropdownItem.fromJson(Map<String, dynamic> json) =
      _$TournamentDropdownItemImpl.fromJson;

  @override
  @JsonKey(name: 'tournamentId')
  String? get tournamentId;
  @override
  @JsonKey(name: 'tournamentName')
  String? get tournamentName;
  @override
  @JsonKey(ignore: true)
  _$$TournamentDropdownItemImplCopyWith<_$TournamentDropdownItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
