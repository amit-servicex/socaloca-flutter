// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) {
  return _MatchModel.fromJson(json);
}

/// @nodoc
mixin _$MatchModel {
  String get id => throw _privateConstructorUsedError;
  String get homeTeamId => throw _privateConstructorUsedError;
  String get awayTeamId => throw _privateConstructorUsedError;
  String get homeTeamName => throw _privateConstructorUsedError;
  String get awayTeamName => throw _privateConstructorUsedError;
  String? get homeTeamLogo => throw _privateConstructorUsedError;
  String? get awayTeamLogo => throw _privateConstructorUsedError;
  String? get matchDate => throw _privateConstructorUsedError;
  String? get matchTime => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'live', 'upcoming', 'played', 'pending', etc.
  MatchScore? get score => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get tournamentName => throw _privateConstructorUsedError;
  String? get cupId => throw _privateConstructorUsedError;
  bool? get isOneOff => throw _privateConstructorUsedError;
  List<MatchEvent> get events => throw _privateConstructorUsedError;
  String? get refereeId => throw _privateConstructorUsedError;
  String? get refereeName => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchModelCopyWith<MatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchModelCopyWith<$Res> {
  factory $MatchModelCopyWith(
          MatchModel value, $Res Function(MatchModel) then) =
      _$MatchModelCopyWithImpl<$Res, MatchModel>;
  @useResult
  $Res call(
      {String id,
      String homeTeamId,
      String awayTeamId,
      String homeTeamName,
      String awayTeamName,
      String? homeTeamLogo,
      String? awayTeamLogo,
      String? matchDate,
      String? matchTime,
      String? venue,
      String? status,
      MatchScore? score,
      String? tournamentId,
      String? tournamentName,
      String? cupId,
      bool? isOneOff,
      List<MatchEvent> events,
      String? refereeId,
      String? refereeName,
      int? duration});

  $MatchScoreCopyWith<$Res>? get score;
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res, $Val extends MatchModel>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? homeTeamLogo = freezed,
    Object? awayTeamLogo = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? venue = freezed,
    Object? status = freezed,
    Object? score = freezed,
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
    Object? cupId = freezed,
    Object? isOneOff = freezed,
    Object? events = null,
    Object? refereeId = freezed,
    Object? refereeName = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamId: null == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamId: null == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamLogo: freezed == homeTeamLogo
          ? _value.homeTeamLogo
          : homeTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamLogo: freezed == awayTeamLogo
          ? _value.awayTeamLogo
          : awayTeamLogo // ignore: cast_nullable_to_non_nullable
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as MatchScore?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      cupId: freezed == cupId
          ? _value.cupId
          : cupId // ignore: cast_nullable_to_non_nullable
              as String?,
      isOneOff: freezed == isOneOff
          ? _value.isOneOff
          : isOneOff // ignore: cast_nullable_to_non_nullable
              as bool?,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<MatchEvent>,
      refereeId: freezed == refereeId
          ? _value.refereeId
          : refereeId // ignore: cast_nullable_to_non_nullable
              as String?,
      refereeName: freezed == refereeName
          ? _value.refereeName
          : refereeName // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchScoreCopyWith<$Res>? get score {
    if (_value.score == null) {
      return null;
    }

    return $MatchScoreCopyWith<$Res>(_value.score!, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchModelImplCopyWith<$Res>
    implements $MatchModelCopyWith<$Res> {
  factory _$$MatchModelImplCopyWith(
          _$MatchModelImpl value, $Res Function(_$MatchModelImpl) then) =
      __$$MatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String homeTeamId,
      String awayTeamId,
      String homeTeamName,
      String awayTeamName,
      String? homeTeamLogo,
      String? awayTeamLogo,
      String? matchDate,
      String? matchTime,
      String? venue,
      String? status,
      MatchScore? score,
      String? tournamentId,
      String? tournamentName,
      String? cupId,
      bool? isOneOff,
      List<MatchEvent> events,
      String? refereeId,
      String? refereeName,
      int? duration});

  @override
  $MatchScoreCopyWith<$Res>? get score;
}

/// @nodoc
class __$$MatchModelImplCopyWithImpl<$Res>
    extends _$MatchModelCopyWithImpl<$Res, _$MatchModelImpl>
    implements _$$MatchModelImplCopyWith<$Res> {
  __$$MatchModelImplCopyWithImpl(
      _$MatchModelImpl _value, $Res Function(_$MatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? homeTeamLogo = freezed,
    Object? awayTeamLogo = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? venue = freezed,
    Object? status = freezed,
    Object? score = freezed,
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
    Object? cupId = freezed,
    Object? isOneOff = freezed,
    Object? events = null,
    Object? refereeId = freezed,
    Object? refereeName = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$MatchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamId: null == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamId: null == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamLogo: freezed == homeTeamLogo
          ? _value.homeTeamLogo
          : homeTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamLogo: freezed == awayTeamLogo
          ? _value.awayTeamLogo
          : awayTeamLogo // ignore: cast_nullable_to_non_nullable
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as MatchScore?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      cupId: freezed == cupId
          ? _value.cupId
          : cupId // ignore: cast_nullable_to_non_nullable
              as String?,
      isOneOff: freezed == isOneOff
          ? _value.isOneOff
          : isOneOff // ignore: cast_nullable_to_non_nullable
              as bool?,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<MatchEvent>,
      refereeId: freezed == refereeId
          ? _value.refereeId
          : refereeId // ignore: cast_nullable_to_non_nullable
              as String?,
      refereeName: freezed == refereeName
          ? _value.refereeName
          : refereeName // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchModelImpl implements _MatchModel {
  const _$MatchModelImpl(
      {required this.id,
      required this.homeTeamId,
      required this.awayTeamId,
      required this.homeTeamName,
      required this.awayTeamName,
      this.homeTeamLogo,
      this.awayTeamLogo,
      this.matchDate,
      this.matchTime,
      this.venue,
      this.status,
      this.score,
      this.tournamentId,
      this.tournamentName,
      this.cupId,
      this.isOneOff,
      final List<MatchEvent> events = const [],
      this.refereeId,
      this.refereeName,
      this.duration})
      : _events = events;

  factory _$MatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchModelImplFromJson(json);

  @override
  final String id;
  @override
  final String homeTeamId;
  @override
  final String awayTeamId;
  @override
  final String homeTeamName;
  @override
  final String awayTeamName;
  @override
  final String? homeTeamLogo;
  @override
  final String? awayTeamLogo;
  @override
  final String? matchDate;
  @override
  final String? matchTime;
  @override
  final String? venue;
  @override
  final String? status;
// 'live', 'upcoming', 'played', 'pending', etc.
  @override
  final MatchScore? score;
  @override
  final String? tournamentId;
  @override
  final String? tournamentName;
  @override
  final String? cupId;
  @override
  final bool? isOneOff;
  final List<MatchEvent> _events;
  @override
  @JsonKey()
  List<MatchEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  final String? refereeId;
  @override
  final String? refereeName;
  @override
  final int? duration;

  @override
  String toString() {
    return 'MatchModel(id: $id, homeTeamId: $homeTeamId, awayTeamId: $awayTeamId, homeTeamName: $homeTeamName, awayTeamName: $awayTeamName, homeTeamLogo: $homeTeamLogo, awayTeamLogo: $awayTeamLogo, matchDate: $matchDate, matchTime: $matchTime, venue: $venue, status: $status, score: $score, tournamentId: $tournamentId, tournamentName: $tournamentName, cupId: $cupId, isOneOff: $isOneOff, events: $events, refereeId: $refereeId, refereeName: $refereeName, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
            (identical(other.homeTeamName, homeTeamName) ||
                other.homeTeamName == homeTeamName) &&
            (identical(other.awayTeamName, awayTeamName) ||
                other.awayTeamName == awayTeamName) &&
            (identical(other.homeTeamLogo, homeTeamLogo) ||
                other.homeTeamLogo == homeTeamLogo) &&
            (identical(other.awayTeamLogo, awayTeamLogo) ||
                other.awayTeamLogo == awayTeamLogo) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName) &&
            (identical(other.cupId, cupId) || other.cupId == cupId) &&
            (identical(other.isOneOff, isOneOff) ||
                other.isOneOff == isOneOff) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            (identical(other.refereeId, refereeId) ||
                other.refereeId == refereeId) &&
            (identical(other.refereeName, refereeName) ||
                other.refereeName == refereeName) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        homeTeamId,
        awayTeamId,
        homeTeamName,
        awayTeamName,
        homeTeamLogo,
        awayTeamLogo,
        matchDate,
        matchTime,
        venue,
        status,
        score,
        tournamentId,
        tournamentName,
        cupId,
        isOneOff,
        const DeepCollectionEquality().hash(_events),
        refereeId,
        refereeName,
        duration
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      __$$MatchModelImplCopyWithImpl<_$MatchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchModelImplToJson(
      this,
    );
  }
}

abstract class _MatchModel implements MatchModel {
  const factory _MatchModel(
      {required final String id,
      required final String homeTeamId,
      required final String awayTeamId,
      required final String homeTeamName,
      required final String awayTeamName,
      final String? homeTeamLogo,
      final String? awayTeamLogo,
      final String? matchDate,
      final String? matchTime,
      final String? venue,
      final String? status,
      final MatchScore? score,
      final String? tournamentId,
      final String? tournamentName,
      final String? cupId,
      final bool? isOneOff,
      final List<MatchEvent> events,
      final String? refereeId,
      final String? refereeName,
      final int? duration}) = _$MatchModelImpl;

  factory _MatchModel.fromJson(Map<String, dynamic> json) =
      _$MatchModelImpl.fromJson;

  @override
  String get id;
  @override
  String get homeTeamId;
  @override
  String get awayTeamId;
  @override
  String get homeTeamName;
  @override
  String get awayTeamName;
  @override
  String? get homeTeamLogo;
  @override
  String? get awayTeamLogo;
  @override
  String? get matchDate;
  @override
  String? get matchTime;
  @override
  String? get venue;
  @override
  String? get status;
  @override // 'live', 'upcoming', 'played', 'pending', etc.
  MatchScore? get score;
  @override
  String? get tournamentId;
  @override
  String? get tournamentName;
  @override
  String? get cupId;
  @override
  bool? get isOneOff;
  @override
  List<MatchEvent> get events;
  @override
  String? get refereeId;
  @override
  String? get refereeName;
  @override
  int? get duration;
  @override
  @JsonKey(ignore: true)
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchScore _$MatchScoreFromJson(Map<String, dynamic> json) {
  return _MatchScore.fromJson(json);
}

/// @nodoc
mixin _$MatchScore {
  int get homeGoals => throw _privateConstructorUsedError;
  int get awayGoals => throw _privateConstructorUsedError;
  int? get homeExtraTime => throw _privateConstructorUsedError;
  int? get awayExtraTime => throw _privateConstructorUsedError;
  int? get homePenalties => throw _privateConstructorUsedError;
  int? get awayPenalties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchScoreCopyWith<MatchScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchScoreCopyWith<$Res> {
  factory $MatchScoreCopyWith(
          MatchScore value, $Res Function(MatchScore) then) =
      _$MatchScoreCopyWithImpl<$Res, MatchScore>;
  @useResult
  $Res call(
      {int homeGoals,
      int awayGoals,
      int? homeExtraTime,
      int? awayExtraTime,
      int? homePenalties,
      int? awayPenalties});
}

/// @nodoc
class _$MatchScoreCopyWithImpl<$Res, $Val extends MatchScore>
    implements $MatchScoreCopyWith<$Res> {
  _$MatchScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeGoals = null,
    Object? awayGoals = null,
    Object? homeExtraTime = freezed,
    Object? awayExtraTime = freezed,
    Object? homePenalties = freezed,
    Object? awayPenalties = freezed,
  }) {
    return _then(_value.copyWith(
      homeGoals: null == homeGoals
          ? _value.homeGoals
          : homeGoals // ignore: cast_nullable_to_non_nullable
              as int,
      awayGoals: null == awayGoals
          ? _value.awayGoals
          : awayGoals // ignore: cast_nullable_to_non_nullable
              as int,
      homeExtraTime: freezed == homeExtraTime
          ? _value.homeExtraTime
          : homeExtraTime // ignore: cast_nullable_to_non_nullable
              as int?,
      awayExtraTime: freezed == awayExtraTime
          ? _value.awayExtraTime
          : awayExtraTime // ignore: cast_nullable_to_non_nullable
              as int?,
      homePenalties: freezed == homePenalties
          ? _value.homePenalties
          : homePenalties // ignore: cast_nullable_to_non_nullable
              as int?,
      awayPenalties: freezed == awayPenalties
          ? _value.awayPenalties
          : awayPenalties // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchScoreImplCopyWith<$Res>
    implements $MatchScoreCopyWith<$Res> {
  factory _$$MatchScoreImplCopyWith(
          _$MatchScoreImpl value, $Res Function(_$MatchScoreImpl) then) =
      __$$MatchScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int homeGoals,
      int awayGoals,
      int? homeExtraTime,
      int? awayExtraTime,
      int? homePenalties,
      int? awayPenalties});
}

/// @nodoc
class __$$MatchScoreImplCopyWithImpl<$Res>
    extends _$MatchScoreCopyWithImpl<$Res, _$MatchScoreImpl>
    implements _$$MatchScoreImplCopyWith<$Res> {
  __$$MatchScoreImplCopyWithImpl(
      _$MatchScoreImpl _value, $Res Function(_$MatchScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeGoals = null,
    Object? awayGoals = null,
    Object? homeExtraTime = freezed,
    Object? awayExtraTime = freezed,
    Object? homePenalties = freezed,
    Object? awayPenalties = freezed,
  }) {
    return _then(_$MatchScoreImpl(
      homeGoals: null == homeGoals
          ? _value.homeGoals
          : homeGoals // ignore: cast_nullable_to_non_nullable
              as int,
      awayGoals: null == awayGoals
          ? _value.awayGoals
          : awayGoals // ignore: cast_nullable_to_non_nullable
              as int,
      homeExtraTime: freezed == homeExtraTime
          ? _value.homeExtraTime
          : homeExtraTime // ignore: cast_nullable_to_non_nullable
              as int?,
      awayExtraTime: freezed == awayExtraTime
          ? _value.awayExtraTime
          : awayExtraTime // ignore: cast_nullable_to_non_nullable
              as int?,
      homePenalties: freezed == homePenalties
          ? _value.homePenalties
          : homePenalties // ignore: cast_nullable_to_non_nullable
              as int?,
      awayPenalties: freezed == awayPenalties
          ? _value.awayPenalties
          : awayPenalties // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchScoreImpl implements _MatchScore {
  const _$MatchScoreImpl(
      {this.homeGoals = 0,
      this.awayGoals = 0,
      this.homeExtraTime,
      this.awayExtraTime,
      this.homePenalties,
      this.awayPenalties});

  factory _$MatchScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchScoreImplFromJson(json);

  @override
  @JsonKey()
  final int homeGoals;
  @override
  @JsonKey()
  final int awayGoals;
  @override
  final int? homeExtraTime;
  @override
  final int? awayExtraTime;
  @override
  final int? homePenalties;
  @override
  final int? awayPenalties;

  @override
  String toString() {
    return 'MatchScore(homeGoals: $homeGoals, awayGoals: $awayGoals, homeExtraTime: $homeExtraTime, awayExtraTime: $awayExtraTime, homePenalties: $homePenalties, awayPenalties: $awayPenalties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchScoreImpl &&
            (identical(other.homeGoals, homeGoals) ||
                other.homeGoals == homeGoals) &&
            (identical(other.awayGoals, awayGoals) ||
                other.awayGoals == awayGoals) &&
            (identical(other.homeExtraTime, homeExtraTime) ||
                other.homeExtraTime == homeExtraTime) &&
            (identical(other.awayExtraTime, awayExtraTime) ||
                other.awayExtraTime == awayExtraTime) &&
            (identical(other.homePenalties, homePenalties) ||
                other.homePenalties == homePenalties) &&
            (identical(other.awayPenalties, awayPenalties) ||
                other.awayPenalties == awayPenalties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, homeGoals, awayGoals,
      homeExtraTime, awayExtraTime, homePenalties, awayPenalties);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchScoreImplCopyWith<_$MatchScoreImpl> get copyWith =>
      __$$MatchScoreImplCopyWithImpl<_$MatchScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchScoreImplToJson(
      this,
    );
  }
}

abstract class _MatchScore implements MatchScore {
  const factory _MatchScore(
      {final int homeGoals,
      final int awayGoals,
      final int? homeExtraTime,
      final int? awayExtraTime,
      final int? homePenalties,
      final int? awayPenalties}) = _$MatchScoreImpl;

  factory _MatchScore.fromJson(Map<String, dynamic> json) =
      _$MatchScoreImpl.fromJson;

  @override
  int get homeGoals;
  @override
  int get awayGoals;
  @override
  int? get homeExtraTime;
  @override
  int? get awayExtraTime;
  @override
  int? get homePenalties;
  @override
  int? get awayPenalties;
  @override
  @JsonKey(ignore: true)
  _$$MatchScoreImplCopyWith<_$MatchScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchEvent _$MatchEventFromJson(Map<String, dynamic> json) {
  return _MatchEvent.fromJson(json);
}

/// @nodoc
mixin _$MatchEvent {
  String get type =>
      throw _privateConstructorUsedError; // 'goal', 'card', 'sub', 'foul'
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  int? get minute => throw _privateConstructorUsedError;
  String? get teamId => throw _privateConstructorUsedError;
  String? get detail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchEventCopyWith<MatchEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchEventCopyWith<$Res> {
  factory $MatchEventCopyWith(
          MatchEvent value, $Res Function(MatchEvent) then) =
      _$MatchEventCopyWithImpl<$Res, MatchEvent>;
  @useResult
  $Res call(
      {String type,
      String playerId,
      String playerName,
      int? minute,
      String? teamId,
      String? detail});
}

/// @nodoc
class _$MatchEventCopyWithImpl<$Res, $Val extends MatchEvent>
    implements $MatchEventCopyWith<$Res> {
  _$MatchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? minute = freezed,
    Object? teamId = freezed,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      minute: freezed == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchEventImplCopyWith<$Res>
    implements $MatchEventCopyWith<$Res> {
  factory _$$MatchEventImplCopyWith(
          _$MatchEventImpl value, $Res Function(_$MatchEventImpl) then) =
      __$$MatchEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String playerId,
      String playerName,
      int? minute,
      String? teamId,
      String? detail});
}

/// @nodoc
class __$$MatchEventImplCopyWithImpl<$Res>
    extends _$MatchEventCopyWithImpl<$Res, _$MatchEventImpl>
    implements _$$MatchEventImplCopyWith<$Res> {
  __$$MatchEventImplCopyWithImpl(
      _$MatchEventImpl _value, $Res Function(_$MatchEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? minute = freezed,
    Object? teamId = freezed,
    Object? detail = freezed,
  }) {
    return _then(_$MatchEventImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      minute: freezed == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchEventImpl implements _MatchEvent {
  const _$MatchEventImpl(
      {required this.type,
      required this.playerId,
      required this.playerName,
      this.minute,
      this.teamId,
      this.detail});

  factory _$MatchEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchEventImplFromJson(json);

  @override
  final String type;
// 'goal', 'card', 'sub', 'foul'
  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final int? minute;
  @override
  final String? teamId;
  @override
  final String? detail;

  @override
  String toString() {
    return 'MatchEvent(type: $type, playerId: $playerId, playerName: $playerName, minute: $minute, teamId: $teamId, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, playerId, playerName, minute, teamId, detail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchEventImplCopyWith<_$MatchEventImpl> get copyWith =>
      __$$MatchEventImplCopyWithImpl<_$MatchEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchEventImplToJson(
      this,
    );
  }
}

abstract class _MatchEvent implements MatchEvent {
  const factory _MatchEvent(
      {required final String type,
      required final String playerId,
      required final String playerName,
      final int? minute,
      final String? teamId,
      final String? detail}) = _$MatchEventImpl;

  factory _MatchEvent.fromJson(Map<String, dynamic> json) =
      _$MatchEventImpl.fromJson;

  @override
  String get type;
  @override // 'goal', 'card', 'sub', 'foul'
  String get playerId;
  @override
  String get playerName;
  @override
  int? get minute;
  @override
  String? get teamId;
  @override
  String? get detail;
  @override
  @JsonKey(ignore: true)
  _$$MatchEventImplCopyWith<_$MatchEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
