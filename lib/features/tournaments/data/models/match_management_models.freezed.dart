// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_management_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchScoreModel _$MatchScoreModelFromJson(Map<String, dynamic> json) {
  return _MatchScoreModel.fromJson(json);
}

/// @nodoc
mixin _$MatchScoreModel {
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  int get homeScore => throw _privateConstructorUsedError;
  int get awayScore => throw _privateConstructorUsedError;
  int? get homeExtraTimeScore => throw _privateConstructorUsedError;
  int? get awayExtraTimeScore => throw _privateConstructorUsedError;
  int? get homePenaltyScore => throw _privateConstructorUsedError;
  int? get awayPenaltyScore => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'pending', 'accepted'
  String? get submittedBy => throw _privateConstructorUsedError;
  int? get submittedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchScoreModelCopyWith<MatchScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchScoreModelCopyWith<$Res> {
  factory $MatchScoreModelCopyWith(
          MatchScoreModel value, $Res Function(MatchScoreModel) then) =
      _$MatchScoreModelCopyWithImpl<$Res, MatchScoreModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matchId') String matchId,
      int homeScore,
      int awayScore,
      int? homeExtraTimeScore,
      int? awayExtraTimeScore,
      int? homePenaltyScore,
      int? awayPenaltyScore,
      String? winnerId,
      String? status,
      String? submittedBy,
      int? submittedOn});
}

/// @nodoc
class _$MatchScoreModelCopyWithImpl<$Res, $Val extends MatchScoreModel>
    implements $MatchScoreModelCopyWith<$Res> {
  _$MatchScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? homeScore = null,
    Object? awayScore = null,
    Object? homeExtraTimeScore = freezed,
    Object? awayExtraTimeScore = freezed,
    Object? homePenaltyScore = freezed,
    Object? awayPenaltyScore = freezed,
    Object? winnerId = freezed,
    Object? status = freezed,
    Object? submittedBy = freezed,
    Object? submittedOn = freezed,
  }) {
    return _then(_value.copyWith(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      homeScore: null == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int,
      awayScore: null == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int,
      homeExtraTimeScore: freezed == homeExtraTimeScore
          ? _value.homeExtraTimeScore
          : homeExtraTimeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayExtraTimeScore: freezed == awayExtraTimeScore
          ? _value.awayExtraTimeScore
          : awayExtraTimeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      homePenaltyScore: freezed == homePenaltyScore
          ? _value.homePenaltyScore
          : homePenaltyScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayPenaltyScore: freezed == awayPenaltyScore
          ? _value.awayPenaltyScore
          : awayPenaltyScore // ignore: cast_nullable_to_non_nullable
              as int?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedBy: freezed == submittedBy
          ? _value.submittedBy
          : submittedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedOn: freezed == submittedOn
          ? _value.submittedOn
          : submittedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchScoreModelImplCopyWith<$Res>
    implements $MatchScoreModelCopyWith<$Res> {
  factory _$$MatchScoreModelImplCopyWith(_$MatchScoreModelImpl value,
          $Res Function(_$MatchScoreModelImpl) then) =
      __$$MatchScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matchId') String matchId,
      int homeScore,
      int awayScore,
      int? homeExtraTimeScore,
      int? awayExtraTimeScore,
      int? homePenaltyScore,
      int? awayPenaltyScore,
      String? winnerId,
      String? status,
      String? submittedBy,
      int? submittedOn});
}

/// @nodoc
class __$$MatchScoreModelImplCopyWithImpl<$Res>
    extends _$MatchScoreModelCopyWithImpl<$Res, _$MatchScoreModelImpl>
    implements _$$MatchScoreModelImplCopyWith<$Res> {
  __$$MatchScoreModelImplCopyWithImpl(
      _$MatchScoreModelImpl _value, $Res Function(_$MatchScoreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? homeScore = null,
    Object? awayScore = null,
    Object? homeExtraTimeScore = freezed,
    Object? awayExtraTimeScore = freezed,
    Object? homePenaltyScore = freezed,
    Object? awayPenaltyScore = freezed,
    Object? winnerId = freezed,
    Object? status = freezed,
    Object? submittedBy = freezed,
    Object? submittedOn = freezed,
  }) {
    return _then(_$MatchScoreModelImpl(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      homeScore: null == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int,
      awayScore: null == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int,
      homeExtraTimeScore: freezed == homeExtraTimeScore
          ? _value.homeExtraTimeScore
          : homeExtraTimeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayExtraTimeScore: freezed == awayExtraTimeScore
          ? _value.awayExtraTimeScore
          : awayExtraTimeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      homePenaltyScore: freezed == homePenaltyScore
          ? _value.homePenaltyScore
          : homePenaltyScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayPenaltyScore: freezed == awayPenaltyScore
          ? _value.awayPenaltyScore
          : awayPenaltyScore // ignore: cast_nullable_to_non_nullable
              as int?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedBy: freezed == submittedBy
          ? _value.submittedBy
          : submittedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedOn: freezed == submittedOn
          ? _value.submittedOn
          : submittedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchScoreModelImpl implements _MatchScoreModel {
  const _$MatchScoreModelImpl(
      {@JsonKey(name: 'matchId') required this.matchId,
      required this.homeScore,
      required this.awayScore,
      this.homeExtraTimeScore,
      this.awayExtraTimeScore,
      this.homePenaltyScore,
      this.awayPenaltyScore,
      this.winnerId,
      this.status,
      this.submittedBy,
      this.submittedOn});

  factory _$MatchScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchScoreModelImplFromJson(json);

  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final int homeScore;
  @override
  final int awayScore;
  @override
  final int? homeExtraTimeScore;
  @override
  final int? awayExtraTimeScore;
  @override
  final int? homePenaltyScore;
  @override
  final int? awayPenaltyScore;
  @override
  final String? winnerId;
  @override
  final String? status;
// 'pending', 'accepted'
  @override
  final String? submittedBy;
  @override
  final int? submittedOn;

  @override
  String toString() {
    return 'MatchScoreModel(matchId: $matchId, homeScore: $homeScore, awayScore: $awayScore, homeExtraTimeScore: $homeExtraTimeScore, awayExtraTimeScore: $awayExtraTimeScore, homePenaltyScore: $homePenaltyScore, awayPenaltyScore: $awayPenaltyScore, winnerId: $winnerId, status: $status, submittedBy: $submittedBy, submittedOn: $submittedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchScoreModelImpl &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.homeScore, homeScore) ||
                other.homeScore == homeScore) &&
            (identical(other.awayScore, awayScore) ||
                other.awayScore == awayScore) &&
            (identical(other.homeExtraTimeScore, homeExtraTimeScore) ||
                other.homeExtraTimeScore == homeExtraTimeScore) &&
            (identical(other.awayExtraTimeScore, awayExtraTimeScore) ||
                other.awayExtraTimeScore == awayExtraTimeScore) &&
            (identical(other.homePenaltyScore, homePenaltyScore) ||
                other.homePenaltyScore == homePenaltyScore) &&
            (identical(other.awayPenaltyScore, awayPenaltyScore) ||
                other.awayPenaltyScore == awayPenaltyScore) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submittedBy, submittedBy) ||
                other.submittedBy == submittedBy) &&
            (identical(other.submittedOn, submittedOn) ||
                other.submittedOn == submittedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      matchId,
      homeScore,
      awayScore,
      homeExtraTimeScore,
      awayExtraTimeScore,
      homePenaltyScore,
      awayPenaltyScore,
      winnerId,
      status,
      submittedBy,
      submittedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchScoreModelImplCopyWith<_$MatchScoreModelImpl> get copyWith =>
      __$$MatchScoreModelImplCopyWithImpl<_$MatchScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchScoreModelImplToJson(
      this,
    );
  }
}

abstract class _MatchScoreModel implements MatchScoreModel {
  const factory _MatchScoreModel(
      {@JsonKey(name: 'matchId') required final String matchId,
      required final int homeScore,
      required final int awayScore,
      final int? homeExtraTimeScore,
      final int? awayExtraTimeScore,
      final int? homePenaltyScore,
      final int? awayPenaltyScore,
      final String? winnerId,
      final String? status,
      final String? submittedBy,
      final int? submittedOn}) = _$MatchScoreModelImpl;

  factory _MatchScoreModel.fromJson(Map<String, dynamic> json) =
      _$MatchScoreModelImpl.fromJson;

  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  int get homeScore;
  @override
  int get awayScore;
  @override
  int? get homeExtraTimeScore;
  @override
  int? get awayExtraTimeScore;
  @override
  int? get homePenaltyScore;
  @override
  int? get awayPenaltyScore;
  @override
  String? get winnerId;
  @override
  String? get status;
  @override // 'pending', 'accepted'
  String? get submittedBy;
  @override
  int? get submittedOn;
  @override
  @JsonKey(ignore: true)
  _$$MatchScoreModelImplCopyWith<_$MatchScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchGoalModel _$MatchGoalModelFromJson(Map<String, dynamic> json) {
  return _MatchGoalModel.fromJson(json);
}

/// @nodoc
mixin _$MatchGoalModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError; // Minute of goal
  bool get isOwnGoal => throw _privateConstructorUsedError;
  bool get isPenalty => throw _privateConstructorUsedError;
  String? get assistPlayerId => throw _privateConstructorUsedError;
  String? get assistPlayerName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchGoalModelCopyWith<MatchGoalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchGoalModelCopyWith<$Res> {
  factory $MatchGoalModelCopyWith(
          MatchGoalModel value, $Res Function(MatchGoalModel) then) =
      _$MatchGoalModelCopyWithImpl<$Res, MatchGoalModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String teamName,
      int minute,
      bool isOwnGoal,
      bool isPenalty,
      String? assistPlayerId,
      String? assistPlayerName});
}

/// @nodoc
class _$MatchGoalModelCopyWithImpl<$Res, $Val extends MatchGoalModel>
    implements $MatchGoalModelCopyWith<$Res> {
  _$MatchGoalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? minute = null,
    Object? isOwnGoal = null,
    Object? isPenalty = null,
    Object? assistPlayerId = freezed,
    Object? assistPlayerName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
      isOwnGoal: null == isOwnGoal
          ? _value.isOwnGoal
          : isOwnGoal // ignore: cast_nullable_to_non_nullable
              as bool,
      isPenalty: null == isPenalty
          ? _value.isPenalty
          : isPenalty // ignore: cast_nullable_to_non_nullable
              as bool,
      assistPlayerId: freezed == assistPlayerId
          ? _value.assistPlayerId
          : assistPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      assistPlayerName: freezed == assistPlayerName
          ? _value.assistPlayerName
          : assistPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchGoalModelImplCopyWith<$Res>
    implements $MatchGoalModelCopyWith<$Res> {
  factory _$$MatchGoalModelImplCopyWith(_$MatchGoalModelImpl value,
          $Res Function(_$MatchGoalModelImpl) then) =
      __$$MatchGoalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String teamName,
      int minute,
      bool isOwnGoal,
      bool isPenalty,
      String? assistPlayerId,
      String? assistPlayerName});
}

/// @nodoc
class __$$MatchGoalModelImplCopyWithImpl<$Res>
    extends _$MatchGoalModelCopyWithImpl<$Res, _$MatchGoalModelImpl>
    implements _$$MatchGoalModelImplCopyWith<$Res> {
  __$$MatchGoalModelImplCopyWithImpl(
      _$MatchGoalModelImpl _value, $Res Function(_$MatchGoalModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? minute = null,
    Object? isOwnGoal = null,
    Object? isPenalty = null,
    Object? assistPlayerId = freezed,
    Object? assistPlayerName = freezed,
  }) {
    return _then(_$MatchGoalModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
      isOwnGoal: null == isOwnGoal
          ? _value.isOwnGoal
          : isOwnGoal // ignore: cast_nullable_to_non_nullable
              as bool,
      isPenalty: null == isPenalty
          ? _value.isPenalty
          : isPenalty // ignore: cast_nullable_to_non_nullable
              as bool,
      assistPlayerId: freezed == assistPlayerId
          ? _value.assistPlayerId
          : assistPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      assistPlayerName: freezed == assistPlayerName
          ? _value.assistPlayerName
          : assistPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchGoalModelImpl implements _MatchGoalModel {
  const _$MatchGoalModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.playerId,
      required this.playerName,
      this.playerImage,
      required this.teamId,
      required this.teamName,
      required this.minute,
      this.isOwnGoal = false,
      this.isPenalty = false,
      this.assistPlayerId,
      this.assistPlayerName});

  factory _$MatchGoalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchGoalModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String? playerImage;
  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final int minute;
// Minute of goal
  @override
  @JsonKey()
  final bool isOwnGoal;
  @override
  @JsonKey()
  final bool isPenalty;
  @override
  final String? assistPlayerId;
  @override
  final String? assistPlayerName;

  @override
  String toString() {
    return 'MatchGoalModel(id: $id, matchId: $matchId, playerId: $playerId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, teamName: $teamName, minute: $minute, isOwnGoal: $isOwnGoal, isPenalty: $isPenalty, assistPlayerId: $assistPlayerId, assistPlayerName: $assistPlayerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchGoalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerImage, playerImage) ||
                other.playerImage == playerImage) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.isOwnGoal, isOwnGoal) ||
                other.isOwnGoal == isOwnGoal) &&
            (identical(other.isPenalty, isPenalty) ||
                other.isPenalty == isPenalty) &&
            (identical(other.assistPlayerId, assistPlayerId) ||
                other.assistPlayerId == assistPlayerId) &&
            (identical(other.assistPlayerName, assistPlayerName) ||
                other.assistPlayerName == assistPlayerName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      matchId,
      playerId,
      playerName,
      playerImage,
      teamId,
      teamName,
      minute,
      isOwnGoal,
      isPenalty,
      assistPlayerId,
      assistPlayerName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchGoalModelImplCopyWith<_$MatchGoalModelImpl> get copyWith =>
      __$$MatchGoalModelImplCopyWithImpl<_$MatchGoalModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchGoalModelImplToJson(
      this,
    );
  }
}

abstract class _MatchGoalModel implements MatchGoalModel {
  const factory _MatchGoalModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String playerId,
      required final String playerName,
      final String? playerImage,
      required final String teamId,
      required final String teamName,
      required final int minute,
      final bool isOwnGoal,
      final bool isPenalty,
      final String? assistPlayerId,
      final String? assistPlayerName}) = _$MatchGoalModelImpl;

  factory _MatchGoalModel.fromJson(Map<String, dynamic> json) =
      _$MatchGoalModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String? get playerImage;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  int get minute;
  @override // Minute of goal
  bool get isOwnGoal;
  @override
  bool get isPenalty;
  @override
  String? get assistPlayerId;
  @override
  String? get assistPlayerName;
  @override
  @JsonKey(ignore: true)
  _$$MatchGoalModelImplCopyWith<_$MatchGoalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchCardModel _$MatchCardModelFromJson(Map<String, dynamic> json) {
  return _MatchCardModel.fromJson(json);
}

/// @nodoc
mixin _$MatchCardModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String get cardType =>
      throw _privateConstructorUsedError; // 'yellow' or 'red'
  int get minute => throw _privateConstructorUsedError; // Minute of card
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchCardModelCopyWith<MatchCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchCardModelCopyWith<$Res> {
  factory $MatchCardModelCopyWith(
          MatchCardModel value, $Res Function(MatchCardModel) then) =
      _$MatchCardModelCopyWithImpl<$Res, MatchCardModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String teamName,
      String cardType,
      int minute,
      String? reason});
}

/// @nodoc
class _$MatchCardModelCopyWithImpl<$Res, $Val extends MatchCardModel>
    implements $MatchCardModelCopyWith<$Res> {
  _$MatchCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? cardType = null,
    Object? minute = null,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchCardModelImplCopyWith<$Res>
    implements $MatchCardModelCopyWith<$Res> {
  factory _$$MatchCardModelImplCopyWith(_$MatchCardModelImpl value,
          $Res Function(_$MatchCardModelImpl) then) =
      __$$MatchCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String teamName,
      String cardType,
      int minute,
      String? reason});
}

/// @nodoc
class __$$MatchCardModelImplCopyWithImpl<$Res>
    extends _$MatchCardModelCopyWithImpl<$Res, _$MatchCardModelImpl>
    implements _$$MatchCardModelImplCopyWith<$Res> {
  __$$MatchCardModelImplCopyWithImpl(
      _$MatchCardModelImpl _value, $Res Function(_$MatchCardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? cardType = null,
    Object? minute = null,
    Object? reason = freezed,
  }) {
    return _then(_$MatchCardModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchCardModelImpl implements _MatchCardModel {
  const _$MatchCardModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.playerId,
      required this.playerName,
      this.playerImage,
      required this.teamId,
      required this.teamName,
      required this.cardType,
      required this.minute,
      this.reason});

  factory _$MatchCardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchCardModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String? playerImage;
  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final String cardType;
// 'yellow' or 'red'
  @override
  final int minute;
// Minute of card
  @override
  final String? reason;

  @override
  String toString() {
    return 'MatchCardModel(id: $id, matchId: $matchId, playerId: $playerId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, teamName: $teamName, cardType: $cardType, minute: $minute, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchCardModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerImage, playerImage) ||
                other.playerImage == playerImage) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, matchId, playerId,
      playerName, playerImage, teamId, teamName, cardType, minute, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchCardModelImplCopyWith<_$MatchCardModelImpl> get copyWith =>
      __$$MatchCardModelImplCopyWithImpl<_$MatchCardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchCardModelImplToJson(
      this,
    );
  }
}

abstract class _MatchCardModel implements MatchCardModel {
  const factory _MatchCardModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String playerId,
      required final String playerName,
      final String? playerImage,
      required final String teamId,
      required final String teamName,
      required final String cardType,
      required final int minute,
      final String? reason}) = _$MatchCardModelImpl;

  factory _MatchCardModel.fromJson(Map<String, dynamic> json) =
      _$MatchCardModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String? get playerImage;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  String get cardType;
  @override // 'yellow' or 'red'
  int get minute;
  @override // Minute of card
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$MatchCardModelImplCopyWith<_$MatchCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchMVPModel _$MatchMVPModelFromJson(Map<String, dynamic> json) {
  return _MatchMVPModel.fromJson(json);
}

/// @nodoc
mixin _$MatchMVPModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String? get selectedBy => throw _privateConstructorUsedError;
  int? get selectedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchMVPModelCopyWith<MatchMVPModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchMVPModelCopyWith<$Res> {
  factory $MatchMVPModelCopyWith(
          MatchMVPModel value, $Res Function(MatchMVPModel) then) =
      _$MatchMVPModelCopyWithImpl<$Res, MatchMVPModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String teamName,
      String? selectedBy,
      int? selectedOn});
}

/// @nodoc
class _$MatchMVPModelCopyWithImpl<$Res, $Val extends MatchMVPModel>
    implements $MatchMVPModelCopyWith<$Res> {
  _$MatchMVPModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? selectedBy = freezed,
    Object? selectedOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedBy: freezed == selectedBy
          ? _value.selectedBy
          : selectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedOn: freezed == selectedOn
          ? _value.selectedOn
          : selectedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchMVPModelImplCopyWith<$Res>
    implements $MatchMVPModelCopyWith<$Res> {
  factory _$$MatchMVPModelImplCopyWith(
          _$MatchMVPModelImpl value, $Res Function(_$MatchMVPModelImpl) then) =
      __$$MatchMVPModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String teamName,
      String? selectedBy,
      int? selectedOn});
}

/// @nodoc
class __$$MatchMVPModelImplCopyWithImpl<$Res>
    extends _$MatchMVPModelCopyWithImpl<$Res, _$MatchMVPModelImpl>
    implements _$$MatchMVPModelImplCopyWith<$Res> {
  __$$MatchMVPModelImplCopyWithImpl(
      _$MatchMVPModelImpl _value, $Res Function(_$MatchMVPModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? selectedBy = freezed,
    Object? selectedOn = freezed,
  }) {
    return _then(_$MatchMVPModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedBy: freezed == selectedBy
          ? _value.selectedBy
          : selectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedOn: freezed == selectedOn
          ? _value.selectedOn
          : selectedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchMVPModelImpl implements _MatchMVPModel {
  const _$MatchMVPModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.playerId,
      required this.playerName,
      this.playerImage,
      required this.teamId,
      required this.teamName,
      this.selectedBy,
      this.selectedOn});

  factory _$MatchMVPModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchMVPModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String? playerImage;
  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final String? selectedBy;
  @override
  final int? selectedOn;

  @override
  String toString() {
    return 'MatchMVPModel(id: $id, matchId: $matchId, playerId: $playerId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, teamName: $teamName, selectedBy: $selectedBy, selectedOn: $selectedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchMVPModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerImage, playerImage) ||
                other.playerImage == playerImage) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.selectedBy, selectedBy) ||
                other.selectedBy == selectedBy) &&
            (identical(other.selectedOn, selectedOn) ||
                other.selectedOn == selectedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, matchId, playerId,
      playerName, playerImage, teamId, teamName, selectedBy, selectedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchMVPModelImplCopyWith<_$MatchMVPModelImpl> get copyWith =>
      __$$MatchMVPModelImplCopyWithImpl<_$MatchMVPModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchMVPModelImplToJson(
      this,
    );
  }
}

abstract class _MatchMVPModel implements MatchMVPModel {
  const factory _MatchMVPModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String playerId,
      required final String playerName,
      final String? playerImage,
      required final String teamId,
      required final String teamName,
      final String? selectedBy,
      final int? selectedOn}) = _$MatchMVPModelImpl;

  factory _MatchMVPModel.fromJson(Map<String, dynamic> json) =
      _$MatchMVPModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String? get playerImage;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  String? get selectedBy;
  @override
  int? get selectedOn;
  @override
  @JsonKey(ignore: true)
  _$$MatchMVPModelImplCopyWith<_$MatchMVPModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchPlayerModel _$MatchPlayerModelFromJson(Map<String, dynamic> json) {
  return _MatchPlayerModel.fromJson(json);
}

/// @nodoc
mixin _$MatchPlayerModel {
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  String? get jerseyNumber => throw _privateConstructorUsedError;
  bool get isStarting =>
      throw _privateConstructorUsedError; // Starting XI or substitute
  bool get isPlaying =>
      throw _privateConstructorUsedError; // Currently on field
  int? get minuteIn =>
      throw _privateConstructorUsedError; // Substitution minute (when entered)
  int? get minuteOut =>
      throw _privateConstructorUsedError; // Substitution minute (when left)
  String? get replacedPlayerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchPlayerModelCopyWith<MatchPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchPlayerModelCopyWith<$Res> {
  factory $MatchPlayerModelCopyWith(
          MatchPlayerModel value, $Res Function(MatchPlayerModel) then) =
      _$MatchPlayerModelCopyWithImpl<$Res, MatchPlayerModel>;
  @useResult
  $Res call(
      {String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String? position,
      String? jerseyNumber,
      bool isStarting,
      bool isPlaying,
      int? minuteIn,
      int? minuteOut,
      String? replacedPlayerId});
}

/// @nodoc
class _$MatchPlayerModelCopyWithImpl<$Res, $Val extends MatchPlayerModel>
    implements $MatchPlayerModelCopyWith<$Res> {
  _$MatchPlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? position = freezed,
    Object? jerseyNumber = freezed,
    Object? isStarting = null,
    Object? isPlaying = null,
    Object? minuteIn = freezed,
    Object? minuteOut = freezed,
    Object? replacedPlayerId = freezed,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isStarting: null == isStarting
          ? _value.isStarting
          : isStarting // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      minuteIn: freezed == minuteIn
          ? _value.minuteIn
          : minuteIn // ignore: cast_nullable_to_non_nullable
              as int?,
      minuteOut: freezed == minuteOut
          ? _value.minuteOut
          : minuteOut // ignore: cast_nullable_to_non_nullable
              as int?,
      replacedPlayerId: freezed == replacedPlayerId
          ? _value.replacedPlayerId
          : replacedPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchPlayerModelImplCopyWith<$Res>
    implements $MatchPlayerModelCopyWith<$Res> {
  factory _$$MatchPlayerModelImplCopyWith(_$MatchPlayerModelImpl value,
          $Res Function(_$MatchPlayerModelImpl) then) =
      __$$MatchPlayerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      String? position,
      String? jerseyNumber,
      bool isStarting,
      bool isPlaying,
      int? minuteIn,
      int? minuteOut,
      String? replacedPlayerId});
}

/// @nodoc
class __$$MatchPlayerModelImplCopyWithImpl<$Res>
    extends _$MatchPlayerModelCopyWithImpl<$Res, _$MatchPlayerModelImpl>
    implements _$$MatchPlayerModelImplCopyWith<$Res> {
  __$$MatchPlayerModelImplCopyWithImpl(_$MatchPlayerModelImpl _value,
      $Res Function(_$MatchPlayerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? position = freezed,
    Object? jerseyNumber = freezed,
    Object? isStarting = null,
    Object? isPlaying = null,
    Object? minuteIn = freezed,
    Object? minuteOut = freezed,
    Object? replacedPlayerId = freezed,
  }) {
    return _then(_$MatchPlayerModelImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isStarting: null == isStarting
          ? _value.isStarting
          : isStarting // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      minuteIn: freezed == minuteIn
          ? _value.minuteIn
          : minuteIn // ignore: cast_nullable_to_non_nullable
              as int?,
      minuteOut: freezed == minuteOut
          ? _value.minuteOut
          : minuteOut // ignore: cast_nullable_to_non_nullable
              as int?,
      replacedPlayerId: freezed == replacedPlayerId
          ? _value.replacedPlayerId
          : replacedPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchPlayerModelImpl implements _MatchPlayerModel {
  const _$MatchPlayerModelImpl(
      {required this.playerId,
      required this.playerName,
      this.playerImage,
      required this.teamId,
      this.position,
      this.jerseyNumber,
      this.isStarting = false,
      this.isPlaying = false,
      this.minuteIn,
      this.minuteOut,
      this.replacedPlayerId});

  factory _$MatchPlayerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchPlayerModelImplFromJson(json);

  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String? playerImage;
  @override
  final String teamId;
  @override
  final String? position;
  @override
  final String? jerseyNumber;
  @override
  @JsonKey()
  final bool isStarting;
// Starting XI or substitute
  @override
  @JsonKey()
  final bool isPlaying;
// Currently on field
  @override
  final int? minuteIn;
// Substitution minute (when entered)
  @override
  final int? minuteOut;
// Substitution minute (when left)
  @override
  final String? replacedPlayerId;

  @override
  String toString() {
    return 'MatchPlayerModel(playerId: $playerId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, position: $position, jerseyNumber: $jerseyNumber, isStarting: $isStarting, isPlaying: $isPlaying, minuteIn: $minuteIn, minuteOut: $minuteOut, replacedPlayerId: $replacedPlayerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchPlayerModelImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerImage, playerImage) ||
                other.playerImage == playerImage) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.isStarting, isStarting) ||
                other.isStarting == isStarting) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.minuteIn, minuteIn) ||
                other.minuteIn == minuteIn) &&
            (identical(other.minuteOut, minuteOut) ||
                other.minuteOut == minuteOut) &&
            (identical(other.replacedPlayerId, replacedPlayerId) ||
                other.replacedPlayerId == replacedPlayerId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerId,
      playerName,
      playerImage,
      teamId,
      position,
      jerseyNumber,
      isStarting,
      isPlaying,
      minuteIn,
      minuteOut,
      replacedPlayerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchPlayerModelImplCopyWith<_$MatchPlayerModelImpl> get copyWith =>
      __$$MatchPlayerModelImplCopyWithImpl<_$MatchPlayerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchPlayerModelImplToJson(
      this,
    );
  }
}

abstract class _MatchPlayerModel implements MatchPlayerModel {
  const factory _MatchPlayerModel(
      {required final String playerId,
      required final String playerName,
      final String? playerImage,
      required final String teamId,
      final String? position,
      final String? jerseyNumber,
      final bool isStarting,
      final bool isPlaying,
      final int? minuteIn,
      final int? minuteOut,
      final String? replacedPlayerId}) = _$MatchPlayerModelImpl;

  factory _MatchPlayerModel.fromJson(Map<String, dynamic> json) =
      _$MatchPlayerModelImpl.fromJson;

  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String? get playerImage;
  @override
  String get teamId;
  @override
  String? get position;
  @override
  String? get jerseyNumber;
  @override
  bool get isStarting;
  @override // Starting XI or substitute
  bool get isPlaying;
  @override // Currently on field
  int? get minuteIn;
  @override // Substitution minute (when entered)
  int? get minuteOut;
  @override // Substitution minute (when left)
  String? get replacedPlayerId;
  @override
  @JsonKey(ignore: true)
  _$$MatchPlayerModelImplCopyWith<_$MatchPlayerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchSquadModel _$MatchSquadModelFromJson(Map<String, dynamic> json) {
  return _MatchSquadModel.fromJson(json);
}

/// @nodoc
mixin _$MatchSquadModel {
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  List<MatchPlayerModel> get startingXI => throw _privateConstructorUsedError;
  List<MatchPlayerModel> get substitutes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchSquadModelCopyWith<MatchSquadModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchSquadModelCopyWith<$Res> {
  factory $MatchSquadModelCopyWith(
          MatchSquadModel value, $Res Function(MatchSquadModel) then) =
      _$MatchSquadModelCopyWithImpl<$Res, MatchSquadModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matchId') String matchId,
      String teamId,
      String teamName,
      List<MatchPlayerModel> startingXI,
      List<MatchPlayerModel> substitutes});
}

/// @nodoc
class _$MatchSquadModelCopyWithImpl<$Res, $Val extends MatchSquadModel>
    implements $MatchSquadModelCopyWith<$Res> {
  _$MatchSquadModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? teamId = null,
    Object? teamName = null,
    Object? startingXI = null,
    Object? substitutes = null,
  }) {
    return _then(_value.copyWith(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      startingXI: null == startingXI
          ? _value.startingXI
          : startingXI // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayerModel>,
      substitutes: null == substitutes
          ? _value.substitutes
          : substitutes // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayerModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchSquadModelImplCopyWith<$Res>
    implements $MatchSquadModelCopyWith<$Res> {
  factory _$$MatchSquadModelImplCopyWith(_$MatchSquadModelImpl value,
          $Res Function(_$MatchSquadModelImpl) then) =
      __$$MatchSquadModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matchId') String matchId,
      String teamId,
      String teamName,
      List<MatchPlayerModel> startingXI,
      List<MatchPlayerModel> substitutes});
}

/// @nodoc
class __$$MatchSquadModelImplCopyWithImpl<$Res>
    extends _$MatchSquadModelCopyWithImpl<$Res, _$MatchSquadModelImpl>
    implements _$$MatchSquadModelImplCopyWith<$Res> {
  __$$MatchSquadModelImplCopyWithImpl(
      _$MatchSquadModelImpl _value, $Res Function(_$MatchSquadModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? teamId = null,
    Object? teamName = null,
    Object? startingXI = null,
    Object? substitutes = null,
  }) {
    return _then(_$MatchSquadModelImpl(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      startingXI: null == startingXI
          ? _value._startingXI
          : startingXI // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayerModel>,
      substitutes: null == substitutes
          ? _value._substitutes
          : substitutes // ignore: cast_nullable_to_non_nullable
              as List<MatchPlayerModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchSquadModelImpl implements _MatchSquadModel {
  const _$MatchSquadModelImpl(
      {@JsonKey(name: 'matchId') required this.matchId,
      required this.teamId,
      required this.teamName,
      final List<MatchPlayerModel> startingXI = const [],
      final List<MatchPlayerModel> substitutes = const []})
      : _startingXI = startingXI,
        _substitutes = substitutes;

  factory _$MatchSquadModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchSquadModelImplFromJson(json);

  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String teamId;
  @override
  final String teamName;
  final List<MatchPlayerModel> _startingXI;
  @override
  @JsonKey()
  List<MatchPlayerModel> get startingXI {
    if (_startingXI is EqualUnmodifiableListView) return _startingXI;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_startingXI);
  }

  final List<MatchPlayerModel> _substitutes;
  @override
  @JsonKey()
  List<MatchPlayerModel> get substitutes {
    if (_substitutes is EqualUnmodifiableListView) return _substitutes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_substitutes);
  }

  @override
  String toString() {
    return 'MatchSquadModel(matchId: $matchId, teamId: $teamId, teamName: $teamName, startingXI: $startingXI, substitutes: $substitutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchSquadModelImpl &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            const DeepCollectionEquality()
                .equals(other._startingXI, _startingXI) &&
            const DeepCollectionEquality()
                .equals(other._substitutes, _substitutes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      matchId,
      teamId,
      teamName,
      const DeepCollectionEquality().hash(_startingXI),
      const DeepCollectionEquality().hash(_substitutes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchSquadModelImplCopyWith<_$MatchSquadModelImpl> get copyWith =>
      __$$MatchSquadModelImplCopyWithImpl<_$MatchSquadModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchSquadModelImplToJson(
      this,
    );
  }
}

abstract class _MatchSquadModel implements MatchSquadModel {
  const factory _MatchSquadModel(
      {@JsonKey(name: 'matchId') required final String matchId,
      required final String teamId,
      required final String teamName,
      final List<MatchPlayerModel> startingXI,
      final List<MatchPlayerModel> substitutes}) = _$MatchSquadModelImpl;

  factory _MatchSquadModel.fromJson(Map<String, dynamic> json) =
      _$MatchSquadModelImpl.fromJson;

  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  List<MatchPlayerModel> get startingXI;
  @override
  List<MatchPlayerModel> get substitutes;
  @override
  @JsonKey(ignore: true)
  _$$MatchSquadModelImplCopyWith<_$MatchSquadModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchDetailsModel _$MatchDetailsModelFromJson(Map<String, dynamic> json) {
  return _MatchDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$MatchDetailsModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String? get matchId => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get tournamentName => throw _privateConstructorUsedError;
  String? get homeTeamId => throw _privateConstructorUsedError;
  String? get homeTeamName => throw _privateConstructorUsedError;
  String? get homeTeamLogo => throw _privateConstructorUsedError;
  String? get awayTeamId => throw _privateConstructorUsedError;
  String? get awayTeamName => throw _privateConstructorUsedError;
  String? get awayTeamLogo => throw _privateConstructorUsedError;
  int? get homeScore => throw _privateConstructorUsedError;
  int? get awayScore => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get matchDate => throw _privateConstructorUsedError;
  int get matchDateMs => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError; // Management data
  MatchScoreModel? get scoreData => throw _privateConstructorUsedError;
  List<MatchGoalModel> get goals => throw _privateConstructorUsedError;
  List<MatchCardModel> get cards => throw _privateConstructorUsedError;
  MatchMVPModel? get mvp => throw _privateConstructorUsedError;
  MatchSquadModel? get homeSquad => throw _privateConstructorUsedError;
  MatchSquadModel? get awaySquad =>
      throw _privateConstructorUsedError; // Permissions
  bool get canManage => throw _privateConstructorUsedError;
  bool get canEditScore => throw _privateConstructorUsedError;
  bool get canAcceptScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchDetailsModelCopyWith<MatchDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDetailsModelCopyWith<$Res> {
  factory $MatchDetailsModelCopyWith(
          MatchDetailsModel value, $Res Function(MatchDetailsModel) then) =
      _$MatchDetailsModelCopyWithImpl<$Res, MatchDetailsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
      String? tournamentId,
      String? tournamentName,
      String? homeTeamId,
      String? homeTeamName,
      String? homeTeamLogo,
      String? awayTeamId,
      String? awayTeamName,
      String? awayTeamLogo,
      int? homeScore,
      int? awayScore,
      String? status,
      String? matchDate,
      int matchDateMs,
      String? venue,
      String? gameType,
      String? ageGroup,
      MatchScoreModel? scoreData,
      List<MatchGoalModel> goals,
      List<MatchCardModel> cards,
      MatchMVPModel? mvp,
      MatchSquadModel? homeSquad,
      MatchSquadModel? awaySquad,
      bool canManage,
      bool canEditScore,
      bool canAcceptScore});

  $MatchScoreModelCopyWith<$Res>? get scoreData;
  $MatchMVPModelCopyWith<$Res>? get mvp;
  $MatchSquadModelCopyWith<$Res>? get homeSquad;
  $MatchSquadModelCopyWith<$Res>? get awaySquad;
}

/// @nodoc
class _$MatchDetailsModelCopyWithImpl<$Res, $Val extends MatchDetailsModel>
    implements $MatchDetailsModelCopyWith<$Res> {
  _$MatchDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
    Object? homeTeamId = freezed,
    Object? homeTeamName = freezed,
    Object? homeTeamLogo = freezed,
    Object? awayTeamId = freezed,
    Object? awayTeamName = freezed,
    Object? awayTeamLogo = freezed,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
    Object? status = freezed,
    Object? matchDate = freezed,
    Object? matchDateMs = null,
    Object? venue = freezed,
    Object? gameType = freezed,
    Object? ageGroup = freezed,
    Object? scoreData = freezed,
    Object? goals = null,
    Object? cards = null,
    Object? mvp = freezed,
    Object? homeSquad = freezed,
    Object? awaySquad = freezed,
    Object? canManage = null,
    Object? canEditScore = null,
    Object? canAcceptScore = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      homeTeamId: freezed == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamName: freezed == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamLogo: freezed == homeTeamLogo
          ? _value.homeTeamLogo
          : homeTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamId: freezed == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamName: freezed == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamLogo: freezed == awayTeamLogo
          ? _value.awayTeamLogo
          : awayTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      homeScore: freezed == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayScore: freezed == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDateMs: null == matchDateMs
          ? _value.matchDateMs
          : matchDateMs // ignore: cast_nullable_to_non_nullable
              as int,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreData: freezed == scoreData
          ? _value.scoreData
          : scoreData // ignore: cast_nullable_to_non_nullable
              as MatchScoreModel?,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<MatchGoalModel>,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<MatchCardModel>,
      mvp: freezed == mvp
          ? _value.mvp
          : mvp // ignore: cast_nullable_to_non_nullable
              as MatchMVPModel?,
      homeSquad: freezed == homeSquad
          ? _value.homeSquad
          : homeSquad // ignore: cast_nullable_to_non_nullable
              as MatchSquadModel?,
      awaySquad: freezed == awaySquad
          ? _value.awaySquad
          : awaySquad // ignore: cast_nullable_to_non_nullable
              as MatchSquadModel?,
      canManage: null == canManage
          ? _value.canManage
          : canManage // ignore: cast_nullable_to_non_nullable
              as bool,
      canEditScore: null == canEditScore
          ? _value.canEditScore
          : canEditScore // ignore: cast_nullable_to_non_nullable
              as bool,
      canAcceptScore: null == canAcceptScore
          ? _value.canAcceptScore
          : canAcceptScore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchScoreModelCopyWith<$Res>? get scoreData {
    if (_value.scoreData == null) {
      return null;
    }

    return $MatchScoreModelCopyWith<$Res>(_value.scoreData!, (value) {
      return _then(_value.copyWith(scoreData: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchMVPModelCopyWith<$Res>? get mvp {
    if (_value.mvp == null) {
      return null;
    }

    return $MatchMVPModelCopyWith<$Res>(_value.mvp!, (value) {
      return _then(_value.copyWith(mvp: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchSquadModelCopyWith<$Res>? get homeSquad {
    if (_value.homeSquad == null) {
      return null;
    }

    return $MatchSquadModelCopyWith<$Res>(_value.homeSquad!, (value) {
      return _then(_value.copyWith(homeSquad: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchSquadModelCopyWith<$Res>? get awaySquad {
    if (_value.awaySquad == null) {
      return null;
    }

    return $MatchSquadModelCopyWith<$Res>(_value.awaySquad!, (value) {
      return _then(_value.copyWith(awaySquad: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchDetailsModelImplCopyWith<$Res>
    implements $MatchDetailsModelCopyWith<$Res> {
  factory _$$MatchDetailsModelImplCopyWith(_$MatchDetailsModelImpl value,
          $Res Function(_$MatchDetailsModelImpl) then) =
      __$$MatchDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
      String? tournamentId,
      String? tournamentName,
      String? homeTeamId,
      String? homeTeamName,
      String? homeTeamLogo,
      String? awayTeamId,
      String? awayTeamName,
      String? awayTeamLogo,
      int? homeScore,
      int? awayScore,
      String? status,
      String? matchDate,
      int matchDateMs,
      String? venue,
      String? gameType,
      String? ageGroup,
      MatchScoreModel? scoreData,
      List<MatchGoalModel> goals,
      List<MatchCardModel> cards,
      MatchMVPModel? mvp,
      MatchSquadModel? homeSquad,
      MatchSquadModel? awaySquad,
      bool canManage,
      bool canEditScore,
      bool canAcceptScore});

  @override
  $MatchScoreModelCopyWith<$Res>? get scoreData;
  @override
  $MatchMVPModelCopyWith<$Res>? get mvp;
  @override
  $MatchSquadModelCopyWith<$Res>? get homeSquad;
  @override
  $MatchSquadModelCopyWith<$Res>? get awaySquad;
}

/// @nodoc
class __$$MatchDetailsModelImplCopyWithImpl<$Res>
    extends _$MatchDetailsModelCopyWithImpl<$Res, _$MatchDetailsModelImpl>
    implements _$$MatchDetailsModelImplCopyWith<$Res> {
  __$$MatchDetailsModelImplCopyWithImpl(_$MatchDetailsModelImpl _value,
      $Res Function(_$MatchDetailsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
    Object? tournamentId = freezed,
    Object? tournamentName = freezed,
    Object? homeTeamId = freezed,
    Object? homeTeamName = freezed,
    Object? homeTeamLogo = freezed,
    Object? awayTeamId = freezed,
    Object? awayTeamName = freezed,
    Object? awayTeamLogo = freezed,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
    Object? status = freezed,
    Object? matchDate = freezed,
    Object? matchDateMs = null,
    Object? venue = freezed,
    Object? gameType = freezed,
    Object? ageGroup = freezed,
    Object? scoreData = freezed,
    Object? goals = null,
    Object? cards = null,
    Object? mvp = freezed,
    Object? homeSquad = freezed,
    Object? awaySquad = freezed,
    Object? canManage = null,
    Object? canEditScore = null,
    Object? canAcceptScore = null,
  }) {
    return _then(_$MatchDetailsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      homeTeamId: freezed == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamName: freezed == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamLogo: freezed == homeTeamLogo
          ? _value.homeTeamLogo
          : homeTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamId: freezed == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamName: freezed == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamLogo: freezed == awayTeamLogo
          ? _value.awayTeamLogo
          : awayTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      homeScore: freezed == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      awayScore: freezed == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDateMs: null == matchDateMs
          ? _value.matchDateMs
          : matchDateMs // ignore: cast_nullable_to_non_nullable
              as int,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreData: freezed == scoreData
          ? _value.scoreData
          : scoreData // ignore: cast_nullable_to_non_nullable
              as MatchScoreModel?,
      goals: null == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<MatchGoalModel>,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<MatchCardModel>,
      mvp: freezed == mvp
          ? _value.mvp
          : mvp // ignore: cast_nullable_to_non_nullable
              as MatchMVPModel?,
      homeSquad: freezed == homeSquad
          ? _value.homeSquad
          : homeSquad // ignore: cast_nullable_to_non_nullable
              as MatchSquadModel?,
      awaySquad: freezed == awaySquad
          ? _value.awaySquad
          : awaySquad // ignore: cast_nullable_to_non_nullable
              as MatchSquadModel?,
      canManage: null == canManage
          ? _value.canManage
          : canManage // ignore: cast_nullable_to_non_nullable
              as bool,
      canEditScore: null == canEditScore
          ? _value.canEditScore
          : canEditScore // ignore: cast_nullable_to_non_nullable
              as bool,
      canAcceptScore: null == canAcceptScore
          ? _value.canAcceptScore
          : canAcceptScore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchDetailsModelImpl implements _MatchDetailsModel {
  const _$MatchDetailsModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') this.matchId,
      this.tournamentId,
      this.tournamentName,
      this.homeTeamId,
      this.homeTeamName,
      this.homeTeamLogo,
      this.awayTeamId,
      this.awayTeamName,
      this.awayTeamLogo,
      this.homeScore,
      this.awayScore,
      this.status,
      this.matchDate,
      this.matchDateMs = 0,
      this.venue,
      this.gameType,
      this.ageGroup,
      this.scoreData,
      final List<MatchGoalModel> goals = const [],
      final List<MatchCardModel> cards = const [],
      this.mvp,
      this.homeSquad,
      this.awaySquad,
      this.canManage = false,
      this.canEditScore = false,
      this.canAcceptScore = false})
      : _goals = goals,
        _cards = cards;

  factory _$MatchDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String? matchId;
  @override
  final String? tournamentId;
  @override
  final String? tournamentName;
  @override
  final String? homeTeamId;
  @override
  final String? homeTeamName;
  @override
  final String? homeTeamLogo;
  @override
  final String? awayTeamId;
  @override
  final String? awayTeamName;
  @override
  final String? awayTeamLogo;
  @override
  final int? homeScore;
  @override
  final int? awayScore;
  @override
  final String? status;
  @override
  final String? matchDate;
  @override
  @JsonKey()
  final int matchDateMs;
  @override
  final String? venue;
  @override
  final String? gameType;
  @override
  final String? ageGroup;
// Management data
  @override
  final MatchScoreModel? scoreData;
  final List<MatchGoalModel> _goals;
  @override
  @JsonKey()
  List<MatchGoalModel> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  final List<MatchCardModel> _cards;
  @override
  @JsonKey()
  List<MatchCardModel> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final MatchMVPModel? mvp;
  @override
  final MatchSquadModel? homeSquad;
  @override
  final MatchSquadModel? awaySquad;
// Permissions
  @override
  @JsonKey()
  final bool canManage;
  @override
  @JsonKey()
  final bool canEditScore;
  @override
  @JsonKey()
  final bool canAcceptScore;

  @override
  String toString() {
    return 'MatchDetailsModel(id: $id, matchId: $matchId, tournamentId: $tournamentId, tournamentName: $tournamentName, homeTeamId: $homeTeamId, homeTeamName: $homeTeamName, homeTeamLogo: $homeTeamLogo, awayTeamId: $awayTeamId, awayTeamName: $awayTeamName, awayTeamLogo: $awayTeamLogo, homeScore: $homeScore, awayScore: $awayScore, status: $status, matchDate: $matchDate, matchDateMs: $matchDateMs, venue: $venue, gameType: $gameType, ageGroup: $ageGroup, scoreData: $scoreData, goals: $goals, cards: $cards, mvp: $mvp, homeSquad: $homeSquad, awaySquad: $awaySquad, canManage: $canManage, canEditScore: $canEditScore, canAcceptScore: $canAcceptScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.homeTeamName, homeTeamName) ||
                other.homeTeamName == homeTeamName) &&
            (identical(other.homeTeamLogo, homeTeamLogo) ||
                other.homeTeamLogo == homeTeamLogo) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
            (identical(other.awayTeamName, awayTeamName) ||
                other.awayTeamName == awayTeamName) &&
            (identical(other.awayTeamLogo, awayTeamLogo) ||
                other.awayTeamLogo == awayTeamLogo) &&
            (identical(other.homeScore, homeScore) ||
                other.homeScore == homeScore) &&
            (identical(other.awayScore, awayScore) ||
                other.awayScore == awayScore) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchDateMs, matchDateMs) ||
                other.matchDateMs == matchDateMs) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.scoreData, scoreData) ||
                other.scoreData == scoreData) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.mvp, mvp) || other.mvp == mvp) &&
            (identical(other.homeSquad, homeSquad) ||
                other.homeSquad == homeSquad) &&
            (identical(other.awaySquad, awaySquad) ||
                other.awaySquad == awaySquad) &&
            (identical(other.canManage, canManage) ||
                other.canManage == canManage) &&
            (identical(other.canEditScore, canEditScore) ||
                other.canEditScore == canEditScore) &&
            (identical(other.canAcceptScore, canAcceptScore) ||
                other.canAcceptScore == canAcceptScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        matchId,
        tournamentId,
        tournamentName,
        homeTeamId,
        homeTeamName,
        homeTeamLogo,
        awayTeamId,
        awayTeamName,
        awayTeamLogo,
        homeScore,
        awayScore,
        status,
        matchDate,
        matchDateMs,
        venue,
        gameType,
        ageGroup,
        scoreData,
        const DeepCollectionEquality().hash(_goals),
        const DeepCollectionEquality().hash(_cards),
        mvp,
        homeSquad,
        awaySquad,
        canManage,
        canEditScore,
        canAcceptScore
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchDetailsModelImplCopyWith<_$MatchDetailsModelImpl> get copyWith =>
      __$$MatchDetailsModelImplCopyWithImpl<_$MatchDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _MatchDetailsModel implements MatchDetailsModel {
  const factory _MatchDetailsModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') final String? matchId,
      final String? tournamentId,
      final String? tournamentName,
      final String? homeTeamId,
      final String? homeTeamName,
      final String? homeTeamLogo,
      final String? awayTeamId,
      final String? awayTeamName,
      final String? awayTeamLogo,
      final int? homeScore,
      final int? awayScore,
      final String? status,
      final String? matchDate,
      final int matchDateMs,
      final String? venue,
      final String? gameType,
      final String? ageGroup,
      final MatchScoreModel? scoreData,
      final List<MatchGoalModel> goals,
      final List<MatchCardModel> cards,
      final MatchMVPModel? mvp,
      final MatchSquadModel? homeSquad,
      final MatchSquadModel? awaySquad,
      final bool canManage,
      final bool canEditScore,
      final bool canAcceptScore}) = _$MatchDetailsModelImpl;

  factory _MatchDetailsModel.fromJson(Map<String, dynamic> json) =
      _$MatchDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String? get matchId;
  @override
  String? get tournamentId;
  @override
  String? get tournamentName;
  @override
  String? get homeTeamId;
  @override
  String? get homeTeamName;
  @override
  String? get homeTeamLogo;
  @override
  String? get awayTeamId;
  @override
  String? get awayTeamName;
  @override
  String? get awayTeamLogo;
  @override
  int? get homeScore;
  @override
  int? get awayScore;
  @override
  String? get status;
  @override
  String? get matchDate;
  @override
  int get matchDateMs;
  @override
  String? get venue;
  @override
  String? get gameType;
  @override
  String? get ageGroup;
  @override // Management data
  MatchScoreModel? get scoreData;
  @override
  List<MatchGoalModel> get goals;
  @override
  List<MatchCardModel> get cards;
  @override
  MatchMVPModel? get mvp;
  @override
  MatchSquadModel? get homeSquad;
  @override
  MatchSquadModel? get awaySquad;
  @override // Permissions
  bool get canManage;
  @override
  bool get canEditScore;
  @override
  bool get canAcceptScore;
  @override
  @JsonKey(ignore: true)
  _$$MatchDetailsModelImplCopyWith<_$MatchDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchPhotoModel _$MatchPhotoModelFromJson(Map<String, dynamic> json) {
  return _MatchPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$MatchPhotoModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  String? get uploadedBy => throw _privateConstructorUsedError;
  int? get uploadedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchPhotoModelCopyWith<MatchPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchPhotoModelCopyWith<$Res> {
  factory $MatchPhotoModelCopyWith(
          MatchPhotoModel value, $Res Function(MatchPhotoModel) then) =
      _$MatchPhotoModelCopyWithImpl<$Res, MatchPhotoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String imageUrl,
      String? caption,
      String? uploadedBy,
      int? uploadedOn});
}

/// @nodoc
class _$MatchPhotoModelCopyWithImpl<$Res, $Val extends MatchPhotoModel>
    implements $MatchPhotoModelCopyWith<$Res> {
  _$MatchPhotoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? imageUrl = null,
    Object? caption = freezed,
    Object? uploadedBy = freezed,
    Object? uploadedOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedBy: freezed == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedOn: freezed == uploadedOn
          ? _value.uploadedOn
          : uploadedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchPhotoModelImplCopyWith<$Res>
    implements $MatchPhotoModelCopyWith<$Res> {
  factory _$$MatchPhotoModelImplCopyWith(_$MatchPhotoModelImpl value,
          $Res Function(_$MatchPhotoModelImpl) then) =
      __$$MatchPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String imageUrl,
      String? caption,
      String? uploadedBy,
      int? uploadedOn});
}

/// @nodoc
class __$$MatchPhotoModelImplCopyWithImpl<$Res>
    extends _$MatchPhotoModelCopyWithImpl<$Res, _$MatchPhotoModelImpl>
    implements _$$MatchPhotoModelImplCopyWith<$Res> {
  __$$MatchPhotoModelImplCopyWithImpl(
      _$MatchPhotoModelImpl _value, $Res Function(_$MatchPhotoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? imageUrl = null,
    Object? caption = freezed,
    Object? uploadedBy = freezed,
    Object? uploadedOn = freezed,
  }) {
    return _then(_$MatchPhotoModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedBy: freezed == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedOn: freezed == uploadedOn
          ? _value.uploadedOn
          : uploadedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchPhotoModelImpl implements _MatchPhotoModel {
  const _$MatchPhotoModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.imageUrl,
      this.caption,
      this.uploadedBy,
      this.uploadedOn});

  factory _$MatchPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchPhotoModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String imageUrl;
  @override
  final String? caption;
  @override
  final String? uploadedBy;
  @override
  final int? uploadedOn;

  @override
  String toString() {
    return 'MatchPhotoModel(id: $id, matchId: $matchId, imageUrl: $imageUrl, caption: $caption, uploadedBy: $uploadedBy, uploadedOn: $uploadedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchPhotoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
            (identical(other.uploadedOn, uploadedOn) ||
                other.uploadedOn == uploadedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, matchId, imageUrl, caption, uploadedBy, uploadedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchPhotoModelImplCopyWith<_$MatchPhotoModelImpl> get copyWith =>
      __$$MatchPhotoModelImplCopyWithImpl<_$MatchPhotoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchPhotoModelImplToJson(
      this,
    );
  }
}

abstract class _MatchPhotoModel implements MatchPhotoModel {
  const factory _MatchPhotoModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String imageUrl,
      final String? caption,
      final String? uploadedBy,
      final int? uploadedOn}) = _$MatchPhotoModelImpl;

  factory _MatchPhotoModel.fromJson(Map<String, dynamic> json) =
      _$MatchPhotoModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get imageUrl;
  @override
  String? get caption;
  @override
  String? get uploadedBy;
  @override
  int? get uploadedOn;
  @override
  @JsonKey(ignore: true)
  _$$MatchPhotoModelImplCopyWith<_$MatchPhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchVideoModel _$MatchVideoModelFromJson(Map<String, dynamic> json) {
  return _MatchVideoModel.fromJson(json);
}

/// @nodoc
mixin _$MatchVideoModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get uploadedBy => throw _privateConstructorUsedError;
  int? get uploadedOn => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchVideoModelCopyWith<MatchVideoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchVideoModelCopyWith<$Res> {
  factory $MatchVideoModelCopyWith(
          MatchVideoModel value, $Res Function(MatchVideoModel) then) =
      _$MatchVideoModelCopyWithImpl<$Res, MatchVideoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String videoUrl,
      String? thumbnailUrl,
      String? title,
      String? description,
      String? uploadedBy,
      int? uploadedOn,
      int duration});
}

/// @nodoc
class _$MatchVideoModelCopyWithImpl<$Res, $Val extends MatchVideoModel>
    implements $MatchVideoModelCopyWith<$Res> {
  _$MatchVideoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? videoUrl = null,
    Object? thumbnailUrl = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? uploadedBy = freezed,
    Object? uploadedOn = freezed,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedBy: freezed == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedOn: freezed == uploadedOn
          ? _value.uploadedOn
          : uploadedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchVideoModelImplCopyWith<$Res>
    implements $MatchVideoModelCopyWith<$Res> {
  factory _$$MatchVideoModelImplCopyWith(_$MatchVideoModelImpl value,
          $Res Function(_$MatchVideoModelImpl) then) =
      __$$MatchVideoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String videoUrl,
      String? thumbnailUrl,
      String? title,
      String? description,
      String? uploadedBy,
      int? uploadedOn,
      int duration});
}

/// @nodoc
class __$$MatchVideoModelImplCopyWithImpl<$Res>
    extends _$MatchVideoModelCopyWithImpl<$Res, _$MatchVideoModelImpl>
    implements _$$MatchVideoModelImplCopyWith<$Res> {
  __$$MatchVideoModelImplCopyWithImpl(
      _$MatchVideoModelImpl _value, $Res Function(_$MatchVideoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? videoUrl = null,
    Object? thumbnailUrl = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? uploadedBy = freezed,
    Object? uploadedOn = freezed,
    Object? duration = null,
  }) {
    return _then(_$MatchVideoModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedBy: freezed == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadedOn: freezed == uploadedOn
          ? _value.uploadedOn
          : uploadedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchVideoModelImpl implements _MatchVideoModel {
  const _$MatchVideoModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.videoUrl,
      this.thumbnailUrl,
      this.title,
      this.description,
      this.uploadedBy,
      this.uploadedOn,
      this.duration = 0});

  factory _$MatchVideoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchVideoModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String videoUrl;
  @override
  final String? thumbnailUrl;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? uploadedBy;
  @override
  final int? uploadedOn;
  @override
  @JsonKey()
  final int duration;

  @override
  String toString() {
    return 'MatchVideoModel(id: $id, matchId: $matchId, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, title: $title, description: $description, uploadedBy: $uploadedBy, uploadedOn: $uploadedOn, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchVideoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
            (identical(other.uploadedOn, uploadedOn) ||
                other.uploadedOn == uploadedOn) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, matchId, videoUrl,
      thumbnailUrl, title, description, uploadedBy, uploadedOn, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchVideoModelImplCopyWith<_$MatchVideoModelImpl> get copyWith =>
      __$$MatchVideoModelImplCopyWithImpl<_$MatchVideoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchVideoModelImplToJson(
      this,
    );
  }
}

abstract class _MatchVideoModel implements MatchVideoModel {
  const factory _MatchVideoModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String videoUrl,
      final String? thumbnailUrl,
      final String? title,
      final String? description,
      final String? uploadedBy,
      final int? uploadedOn,
      final int duration}) = _$MatchVideoModelImpl;

  factory _MatchVideoModel.fromJson(Map<String, dynamic> json) =
      _$MatchVideoModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get videoUrl;
  @override
  String? get thumbnailUrl;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get uploadedBy;
  @override
  int? get uploadedOn;
  @override
  int get duration;
  @override
  @JsonKey(ignore: true)
  _$$MatchVideoModelImplCopyWith<_$MatchVideoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchRatingModel _$MatchRatingModelFromJson(Map<String, dynamic> json) {
  return _MatchRatingModel.fromJson(json);
}

/// @nodoc
mixin _$MatchRatingModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError; // 0-10 scale
  String? get ratedBy => throw _privateConstructorUsedError;
  int? get ratedOn => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchRatingModelCopyWith<MatchRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchRatingModelCopyWith<$Res> {
  factory $MatchRatingModelCopyWith(
          MatchRatingModel value, $Res Function(MatchRatingModel) then) =
      _$MatchRatingModelCopyWithImpl<$Res, MatchRatingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      double rating,
      String? ratedBy,
      int? ratedOn,
      String? comment});
}

/// @nodoc
class _$MatchRatingModelCopyWithImpl<$Res, $Val extends MatchRatingModel>
    implements $MatchRatingModelCopyWith<$Res> {
  _$MatchRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? rating = null,
    Object? ratedBy = freezed,
    Object? ratedOn = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      ratedBy: freezed == ratedBy
          ? _value.ratedBy
          : ratedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      ratedOn: freezed == ratedOn
          ? _value.ratedOn
          : ratedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchRatingModelImplCopyWith<$Res>
    implements $MatchRatingModelCopyWith<$Res> {
  factory _$$MatchRatingModelImplCopyWith(_$MatchRatingModelImpl value,
          $Res Function(_$MatchRatingModelImpl) then) =
      __$$MatchRatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String playerId,
      String playerName,
      String? playerImage,
      String teamId,
      double rating,
      String? ratedBy,
      int? ratedOn,
      String? comment});
}

/// @nodoc
class __$$MatchRatingModelImplCopyWithImpl<$Res>
    extends _$MatchRatingModelCopyWithImpl<$Res, _$MatchRatingModelImpl>
    implements _$$MatchRatingModelImplCopyWith<$Res> {
  __$$MatchRatingModelImplCopyWithImpl(_$MatchRatingModelImpl _value,
      $Res Function(_$MatchRatingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? playerImage = freezed,
    Object? teamId = null,
    Object? rating = null,
    Object? ratedBy = freezed,
    Object? ratedOn = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$MatchRatingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      ratedBy: freezed == ratedBy
          ? _value.ratedBy
          : ratedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      ratedOn: freezed == ratedOn
          ? _value.ratedOn
          : ratedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchRatingModelImpl implements _MatchRatingModel {
  const _$MatchRatingModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.playerId,
      required this.playerName,
      this.playerImage,
      required this.teamId,
      this.rating = 0.0,
      this.ratedBy,
      this.ratedOn,
      this.comment});

  factory _$MatchRatingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchRatingModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String? playerImage;
  @override
  final String teamId;
  @override
  @JsonKey()
  final double rating;
// 0-10 scale
  @override
  final String? ratedBy;
  @override
  final int? ratedOn;
  @override
  final String? comment;

  @override
  String toString() {
    return 'MatchRatingModel(id: $id, matchId: $matchId, playerId: $playerId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, rating: $rating, ratedBy: $ratedBy, ratedOn: $ratedOn, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchRatingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerImage, playerImage) ||
                other.playerImage == playerImage) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.ratedBy, ratedBy) || other.ratedBy == ratedBy) &&
            (identical(other.ratedOn, ratedOn) || other.ratedOn == ratedOn) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, matchId, playerId,
      playerName, playerImage, teamId, rating, ratedBy, ratedOn, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchRatingModelImplCopyWith<_$MatchRatingModelImpl> get copyWith =>
      __$$MatchRatingModelImplCopyWithImpl<_$MatchRatingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchRatingModelImplToJson(
      this,
    );
  }
}

abstract class _MatchRatingModel implements MatchRatingModel {
  const factory _MatchRatingModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String playerId,
      required final String playerName,
      final String? playerImage,
      required final String teamId,
      final double rating,
      final String? ratedBy,
      final int? ratedOn,
      final String? comment}) = _$MatchRatingModelImpl;

  factory _MatchRatingModel.fromJson(Map<String, dynamic> json) =
      _$MatchRatingModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String? get playerImage;
  @override
  String get teamId;
  @override
  double get rating;
  @override // 0-10 scale
  String? get ratedBy;
  @override
  int? get ratedOn;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$MatchRatingModelImplCopyWith<_$MatchRatingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubstitutionModel _$SubstitutionModelFromJson(Map<String, dynamic> json) {
  return _SubstitutionModel.fromJson(json);
}

/// @nodoc
mixin _$SubstitutionModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String get matchId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get playerInId => throw _privateConstructorUsedError;
  String get playerInName => throw _privateConstructorUsedError;
  String get playerOutId => throw _privateConstructorUsedError;
  String get playerOutName => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubstitutionModelCopyWith<SubstitutionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubstitutionModelCopyWith<$Res> {
  factory $SubstitutionModelCopyWith(
          SubstitutionModel value, $Res Function(SubstitutionModel) then) =
      _$SubstitutionModelCopyWithImpl<$Res, SubstitutionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String teamId,
      String playerInId,
      String playerInName,
      String playerOutId,
      String playerOutName,
      int minute,
      String? reason});
}

/// @nodoc
class _$SubstitutionModelCopyWithImpl<$Res, $Val extends SubstitutionModel>
    implements $SubstitutionModelCopyWith<$Res> {
  _$SubstitutionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? teamId = null,
    Object? playerInId = null,
    Object? playerInName = null,
    Object? playerOutId = null,
    Object? playerOutName = null,
    Object? minute = null,
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerInId: null == playerInId
          ? _value.playerInId
          : playerInId // ignore: cast_nullable_to_non_nullable
              as String,
      playerInName: null == playerInName
          ? _value.playerInName
          : playerInName // ignore: cast_nullable_to_non_nullable
              as String,
      playerOutId: null == playerOutId
          ? _value.playerOutId
          : playerOutId // ignore: cast_nullable_to_non_nullable
              as String,
      playerOutName: null == playerOutName
          ? _value.playerOutName
          : playerOutName // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubstitutionModelImplCopyWith<$Res>
    implements $SubstitutionModelCopyWith<$Res> {
  factory _$$SubstitutionModelImplCopyWith(_$SubstitutionModelImpl value,
          $Res Function(_$SubstitutionModelImpl) then) =
      __$$SubstitutionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String matchId,
      String teamId,
      String playerInId,
      String playerInName,
      String playerOutId,
      String playerOutName,
      int minute,
      String? reason});
}

/// @nodoc
class __$$SubstitutionModelImplCopyWithImpl<$Res>
    extends _$SubstitutionModelCopyWithImpl<$Res, _$SubstitutionModelImpl>
    implements _$$SubstitutionModelImplCopyWith<$Res> {
  __$$SubstitutionModelImplCopyWithImpl(_$SubstitutionModelImpl _value,
      $Res Function(_$SubstitutionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = null,
    Object? teamId = null,
    Object? playerInId = null,
    Object? playerInName = null,
    Object? playerOutId = null,
    Object? playerOutName = null,
    Object? minute = null,
    Object? reason = freezed,
  }) {
    return _then(_$SubstitutionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerInId: null == playerInId
          ? _value.playerInId
          : playerInId // ignore: cast_nullable_to_non_nullable
              as String,
      playerInName: null == playerInName
          ? _value.playerInName
          : playerInName // ignore: cast_nullable_to_non_nullable
              as String,
      playerOutId: null == playerOutId
          ? _value.playerOutId
          : playerOutId // ignore: cast_nullable_to_non_nullable
              as String,
      playerOutName: null == playerOutName
          ? _value.playerOutName
          : playerOutName // ignore: cast_nullable_to_non_nullable
              as String,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubstitutionModelImpl implements _SubstitutionModel {
  const _$SubstitutionModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') required this.matchId,
      required this.teamId,
      required this.playerInId,
      required this.playerInName,
      required this.playerOutId,
      required this.playerOutName,
      required this.minute,
      this.reason});

  factory _$SubstitutionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubstitutionModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String matchId;
  @override
  final String teamId;
  @override
  final String playerInId;
  @override
  final String playerInName;
  @override
  final String playerOutId;
  @override
  final String playerOutName;
  @override
  final int minute;
  @override
  final String? reason;

  @override
  String toString() {
    return 'SubstitutionModel(id: $id, matchId: $matchId, teamId: $teamId, playerInId: $playerInId, playerInName: $playerInName, playerOutId: $playerOutId, playerOutName: $playerOutName, minute: $minute, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubstitutionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.playerInId, playerInId) ||
                other.playerInId == playerInId) &&
            (identical(other.playerInName, playerInName) ||
                other.playerInName == playerInName) &&
            (identical(other.playerOutId, playerOutId) ||
                other.playerOutId == playerOutId) &&
            (identical(other.playerOutName, playerOutName) ||
                other.playerOutName == playerOutName) &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, matchId, teamId, playerInId,
      playerInName, playerOutId, playerOutName, minute, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubstitutionModelImplCopyWith<_$SubstitutionModelImpl> get copyWith =>
      __$$SubstitutionModelImplCopyWithImpl<_$SubstitutionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubstitutionModelImplToJson(
      this,
    );
  }
}

abstract class _SubstitutionModel implements SubstitutionModel {
  const factory _SubstitutionModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') required final String matchId,
      required final String teamId,
      required final String playerInId,
      required final String playerInName,
      required final String playerOutId,
      required final String playerOutName,
      required final int minute,
      final String? reason}) = _$SubstitutionModelImpl;

  factory _SubstitutionModel.fromJson(Map<String, dynamic> json) =
      _$SubstitutionModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String get matchId;
  @override
  String get teamId;
  @override
  String get playerInId;
  @override
  String get playerInName;
  @override
  String get playerOutId;
  @override
  String get playerOutName;
  @override
  int get minute;
  @override
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$SubstitutionModelImplCopyWith<_$SubstitutionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
