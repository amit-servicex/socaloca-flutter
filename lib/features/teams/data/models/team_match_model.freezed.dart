// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamMatchModel _$TeamMatchModelFromJson(Map<String, dynamic> json) {
  return _TeamMatchModel.fromJson(json);
}

/// @nodoc
mixin _$TeamMatchModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get matchId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  bool get configure => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  bool get isDelete => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String? get matchName => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get createdByChild => throw _privateConstructorUsedError;
  String? get matchDate => throw _privateConstructorUsedError;
  String? get matchTime => throw _privateConstructorUsedError;
  int? get matchDateTimeGmt => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get gameSemiType => throw _privateConstructorUsedError;
  String? get matchType => throw _privateConstructorUsedError;
  String? get myTeamId => throw _privateConstructorUsedError;
  String? get myTeamName => throw _privateConstructorUsedError;
  String? get myTeamShortName => throw _privateConstructorUsedError;
  String? get opponentTeamId => throw _privateConstructorUsedError;
  String? get opponentTeamName => throw _privateConstructorUsedError;
  String? get opponentTeamShortName => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get stadiumName => throw _privateConstructorUsedError;
  String? get fieldName => throw _privateConstructorUsedError;
  String? get locationName => throw _privateConstructorUsedError;
  double get locationLat => throw _privateConstructorUsedError;
  double get locationLng => throw _privateConstructorUsedError;
  int get totalTimeMins => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  bool get referees => throw _privateConstructorUsedError;
  int get substitutes => throw _privateConstructorUsedError;
  String? get matchNote => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String? get acceptStatus => throw _privateConstructorUsedError;
  int? get createdOn => throw _privateConstructorUsedError;
  String? get acceptedBy => throw _privateConstructorUsedError;
  String? get scoreStatus => throw _privateConstructorUsedError;
  bool get myTeamScore => throw _privateConstructorUsedError;
  bool get opponentTeamScore => throw _privateConstructorUsedError;
  bool get penaltyScore => throw _privateConstructorUsedError;
  bool get extraTimeScore => throw _privateConstructorUsedError;
  bool get extraTimeSaved => throw _privateConstructorUsedError;
  bool get penaltySaved => throw _privateConstructorUsedError;
  bool get myTeamCard => throw _privateConstructorUsedError;
  bool get substituteSaved => throw _privateConstructorUsedError;
  bool get opponentTeamCard => throw _privateConstructorUsedError;
  bool get myTeamMvp => throw _privateConstructorUsedError;
  bool get opponentTeamMvp => throw _privateConstructorUsedError;
  bool get myTeamRating => throw _privateConstructorUsedError;
  bool get opponentRating => throw _privateConstructorUsedError;
  String? get myMvpPlayerId => throw _privateConstructorUsedError;
  String? get myMvpPlayerName => throw _privateConstructorUsedError;
  String? get opponentMvpPlayerId => throw _privateConstructorUsedError;
  String? get opponentMvpPlayerName => throw _privateConstructorUsedError;
  bool get matchMvp => throw _privateConstructorUsedError;
  String? get mvpTeamId => throw _privateConstructorUsedError;
  String? get mvpPlayerId => throw _privateConstructorUsedError;
  String? get mvpPlayerName => throw _privateConstructorUsedError;
  String? get leg => throw _privateConstructorUsedError;
  String? get round => throw _privateConstructorUsedError;
  List<dynamic> get myPlayers => throw _privateConstructorUsedError;
  List<dynamic> get opponentPlayers => throw _privateConstructorUsedError;
  dynamic get myCoach => throw _privateConstructorUsedError;
  dynamic get oppoCoach => throw _privateConstructorUsedError;
  dynamic get myManager => throw _privateConstructorUsedError;
  dynamic get oppoManager => throw _privateConstructorUsedError;
  bool get mgmtSaved => throw _privateConstructorUsedError;
  bool get penaltyNum => throw _privateConstructorUsedError;
  bool get extraTimeNum => throw _privateConstructorUsedError;
  bool get cleansheetSaved => throw _privateConstructorUsedError;
  dynamic get myTeamCleanSheet => throw _privateConstructorUsedError;
  dynamic get oppoTeamCleanSheet => throw _privateConstructorUsedError;
  List<TeamMatchTeamModel> get teams => throw _privateConstructorUsedError;
  TeamMatchScoreModel? get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamMatchModelCopyWith<TeamMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMatchModelCopyWith<$Res> {
  factory $TeamMatchModelCopyWith(
          TeamMatchModel value, $Res Function(TeamMatchModel) then) =
      _$TeamMatchModelCopyWithImpl<$Res, TeamMatchModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? matchId,
      String? roundId,
      bool configure,
      String? tournamentId,
      bool isDelete,
      int level,
      String? matchName,
      int seq,
      String? createdBy,
      String? createdByChild,
      String? matchDate,
      String? matchTime,
      int? matchDateTimeGmt,
      String? gameType,
      String? gameSemiType,
      String? matchType,
      String? myTeamId,
      String? myTeamName,
      String? myTeamShortName,
      String? opponentTeamId,
      String? opponentTeamName,
      String? opponentTeamShortName,
      String? country,
      String? city,
      String? stadiumName,
      String? fieldName,
      String? locationName,
      double locationLat,
      double locationLng,
      int totalTimeMins,
      String? ageGroup,
      bool referees,
      int substitutes,
      String? matchNote,
      bool active,
      String? acceptStatus,
      int? createdOn,
      String? acceptedBy,
      String? scoreStatus,
      bool myTeamScore,
      bool opponentTeamScore,
      bool penaltyScore,
      bool extraTimeScore,
      bool extraTimeSaved,
      bool penaltySaved,
      bool myTeamCard,
      bool substituteSaved,
      bool opponentTeamCard,
      bool myTeamMvp,
      bool opponentTeamMvp,
      bool myTeamRating,
      bool opponentRating,
      String? myMvpPlayerId,
      String? myMvpPlayerName,
      String? opponentMvpPlayerId,
      String? opponentMvpPlayerName,
      bool matchMvp,
      String? mvpTeamId,
      String? mvpPlayerId,
      String? mvpPlayerName,
      String? leg,
      String? round,
      List<dynamic> myPlayers,
      List<dynamic> opponentPlayers,
      dynamic myCoach,
      dynamic oppoCoach,
      dynamic myManager,
      dynamic oppoManager,
      bool mgmtSaved,
      bool penaltyNum,
      bool extraTimeNum,
      bool cleansheetSaved,
      dynamic myTeamCleanSheet,
      dynamic oppoTeamCleanSheet,
      List<TeamMatchTeamModel> teams,
      TeamMatchScoreModel? score});

  $TeamMatchScoreModelCopyWith<$Res>? get score;
}

/// @nodoc
class _$TeamMatchModelCopyWithImpl<$Res, $Val extends TeamMatchModel>
    implements $TeamMatchModelCopyWith<$Res> {
  _$TeamMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
    Object? roundId = freezed,
    Object? configure = null,
    Object? tournamentId = freezed,
    Object? isDelete = null,
    Object? level = null,
    Object? matchName = freezed,
    Object? seq = null,
    Object? createdBy = freezed,
    Object? createdByChild = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? matchDateTimeGmt = freezed,
    Object? gameType = freezed,
    Object? gameSemiType = freezed,
    Object? matchType = freezed,
    Object? myTeamId = freezed,
    Object? myTeamName = freezed,
    Object? myTeamShortName = freezed,
    Object? opponentTeamId = freezed,
    Object? opponentTeamName = freezed,
    Object? opponentTeamShortName = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? stadiumName = freezed,
    Object? fieldName = freezed,
    Object? locationName = freezed,
    Object? locationLat = null,
    Object? locationLng = null,
    Object? totalTimeMins = null,
    Object? ageGroup = freezed,
    Object? referees = null,
    Object? substitutes = null,
    Object? matchNote = freezed,
    Object? active = null,
    Object? acceptStatus = freezed,
    Object? createdOn = freezed,
    Object? acceptedBy = freezed,
    Object? scoreStatus = freezed,
    Object? myTeamScore = null,
    Object? opponentTeamScore = null,
    Object? penaltyScore = null,
    Object? extraTimeScore = null,
    Object? extraTimeSaved = null,
    Object? penaltySaved = null,
    Object? myTeamCard = null,
    Object? substituteSaved = null,
    Object? opponentTeamCard = null,
    Object? myTeamMvp = null,
    Object? opponentTeamMvp = null,
    Object? myTeamRating = null,
    Object? opponentRating = null,
    Object? myMvpPlayerId = freezed,
    Object? myMvpPlayerName = freezed,
    Object? opponentMvpPlayerId = freezed,
    Object? opponentMvpPlayerName = freezed,
    Object? matchMvp = null,
    Object? mvpTeamId = freezed,
    Object? mvpPlayerId = freezed,
    Object? mvpPlayerName = freezed,
    Object? leg = freezed,
    Object? round = freezed,
    Object? myPlayers = null,
    Object? opponentPlayers = null,
    Object? myCoach = freezed,
    Object? oppoCoach = freezed,
    Object? myManager = freezed,
    Object? oppoManager = freezed,
    Object? mgmtSaved = null,
    Object? penaltyNum = null,
    Object? extraTimeNum = null,
    Object? cleansheetSaved = null,
    Object? myTeamCleanSheet = freezed,
    Object? oppoTeamCleanSheet = freezed,
    Object? teams = null,
    Object? score = freezed,
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
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      configure: null == configure
          ? _value.configure
          : configure // ignore: cast_nullable_to_non_nullable
              as bool,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      matchName: freezed == matchName
          ? _value.matchName
          : matchName // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdByChild: freezed == createdByChild
          ? _value.createdByChild
          : createdByChild // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDateTimeGmt: freezed == matchDateTimeGmt
          ? _value.matchDateTimeGmt
          : matchDateTimeGmt // ignore: cast_nullable_to_non_nullable
              as int?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gameSemiType: freezed == gameSemiType
          ? _value.gameSemiType
          : gameSemiType // ignore: cast_nullable_to_non_nullable
              as String?,
      matchType: freezed == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamId: freezed == myTeamId
          ? _value.myTeamId
          : myTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamName: freezed == myTeamName
          ? _value.myTeamName
          : myTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamShortName: freezed == myTeamShortName
          ? _value.myTeamShortName
          : myTeamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamId: freezed == opponentTeamId
          ? _value.opponentTeamId
          : opponentTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamName: freezed == opponentTeamName
          ? _value.opponentTeamName
          : opponentTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamShortName: freezed == opponentTeamShortName
          ? _value.opponentTeamShortName
          : opponentTeamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stadiumName: freezed == stadiumName
          ? _value.stadiumName
          : stadiumName // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationLat: null == locationLat
          ? _value.locationLat
          : locationLat // ignore: cast_nullable_to_non_nullable
              as double,
      locationLng: null == locationLng
          ? _value.locationLng
          : locationLng // ignore: cast_nullable_to_non_nullable
              as double,
      totalTimeMins: null == totalTimeMins
          ? _value.totalTimeMins
          : totalTimeMins // ignore: cast_nullable_to_non_nullable
              as int,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      referees: null == referees
          ? _value.referees
          : referees // ignore: cast_nullable_to_non_nullable
              as bool,
      substitutes: null == substitutes
          ? _value.substitutes
          : substitutes // ignore: cast_nullable_to_non_nullable
              as int,
      matchNote: freezed == matchNote
          ? _value.matchNote
          : matchNote // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int?,
      acceptedBy: freezed == acceptedBy
          ? _value.acceptedBy
          : acceptedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreStatus: freezed == scoreStatus
          ? _value.scoreStatus
          : scoreStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamScore: null == myTeamScore
          ? _value.myTeamScore
          : myTeamScore // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentTeamScore: null == opponentTeamScore
          ? _value.opponentTeamScore
          : opponentTeamScore // ignore: cast_nullable_to_non_nullable
              as bool,
      penaltyScore: null == penaltyScore
          ? _value.penaltyScore
          : penaltyScore // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTimeScore: null == extraTimeScore
          ? _value.extraTimeScore
          : extraTimeScore // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTimeSaved: null == extraTimeSaved
          ? _value.extraTimeSaved
          : extraTimeSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      penaltySaved: null == penaltySaved
          ? _value.penaltySaved
          : penaltySaved // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamCard: null == myTeamCard
          ? _value.myTeamCard
          : myTeamCard // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteSaved: null == substituteSaved
          ? _value.substituteSaved
          : substituteSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentTeamCard: null == opponentTeamCard
          ? _value.opponentTeamCard
          : opponentTeamCard // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamMvp: null == myTeamMvp
          ? _value.myTeamMvp
          : myTeamMvp // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentTeamMvp: null == opponentTeamMvp
          ? _value.opponentTeamMvp
          : opponentTeamMvp // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamRating: null == myTeamRating
          ? _value.myTeamRating
          : myTeamRating // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentRating: null == opponentRating
          ? _value.opponentRating
          : opponentRating // ignore: cast_nullable_to_non_nullable
              as bool,
      myMvpPlayerId: freezed == myMvpPlayerId
          ? _value.myMvpPlayerId
          : myMvpPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      myMvpPlayerName: freezed == myMvpPlayerName
          ? _value.myMvpPlayerName
          : myMvpPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentMvpPlayerId: freezed == opponentMvpPlayerId
          ? _value.opponentMvpPlayerId
          : opponentMvpPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentMvpPlayerName: freezed == opponentMvpPlayerName
          ? _value.opponentMvpPlayerName
          : opponentMvpPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      matchMvp: null == matchMvp
          ? _value.matchMvp
          : matchMvp // ignore: cast_nullable_to_non_nullable
              as bool,
      mvpTeamId: freezed == mvpTeamId
          ? _value.mvpTeamId
          : mvpTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      mvpPlayerId: freezed == mvpPlayerId
          ? _value.mvpPlayerId
          : mvpPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      mvpPlayerName: freezed == mvpPlayerName
          ? _value.mvpPlayerName
          : mvpPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      leg: freezed == leg
          ? _value.leg
          : leg // ignore: cast_nullable_to_non_nullable
              as String?,
      round: freezed == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as String?,
      myPlayers: null == myPlayers
          ? _value.myPlayers
          : myPlayers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      opponentPlayers: null == opponentPlayers
          ? _value.opponentPlayers
          : opponentPlayers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      myCoach: freezed == myCoach
          ? _value.myCoach
          : myCoach // ignore: cast_nullable_to_non_nullable
              as dynamic,
      oppoCoach: freezed == oppoCoach
          ? _value.oppoCoach
          : oppoCoach // ignore: cast_nullable_to_non_nullable
              as dynamic,
      myManager: freezed == myManager
          ? _value.myManager
          : myManager // ignore: cast_nullable_to_non_nullable
              as dynamic,
      oppoManager: freezed == oppoManager
          ? _value.oppoManager
          : oppoManager // ignore: cast_nullable_to_non_nullable
              as dynamic,
      mgmtSaved: null == mgmtSaved
          ? _value.mgmtSaved
          : mgmtSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      penaltyNum: null == penaltyNum
          ? _value.penaltyNum
          : penaltyNum // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTimeNum: null == extraTimeNum
          ? _value.extraTimeNum
          : extraTimeNum // ignore: cast_nullable_to_non_nullable
              as bool,
      cleansheetSaved: null == cleansheetSaved
          ? _value.cleansheetSaved
          : cleansheetSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamCleanSheet: freezed == myTeamCleanSheet
          ? _value.myTeamCleanSheet
          : myTeamCleanSheet // ignore: cast_nullable_to_non_nullable
              as dynamic,
      oppoTeamCleanSheet: freezed == oppoTeamCleanSheet
          ? _value.oppoTeamCleanSheet
          : oppoTeamCleanSheet // ignore: cast_nullable_to_non_nullable
              as dynamic,
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamMatchTeamModel>,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as TeamMatchScoreModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamMatchScoreModelCopyWith<$Res>? get score {
    if (_value.score == null) {
      return null;
    }

    return $TeamMatchScoreModelCopyWith<$Res>(_value.score!, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamMatchModelImplCopyWith<$Res>
    implements $TeamMatchModelCopyWith<$Res> {
  factory _$$TeamMatchModelImplCopyWith(_$TeamMatchModelImpl value,
          $Res Function(_$TeamMatchModelImpl) then) =
      __$$TeamMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? matchId,
      String? roundId,
      bool configure,
      String? tournamentId,
      bool isDelete,
      int level,
      String? matchName,
      int seq,
      String? createdBy,
      String? createdByChild,
      String? matchDate,
      String? matchTime,
      int? matchDateTimeGmt,
      String? gameType,
      String? gameSemiType,
      String? matchType,
      String? myTeamId,
      String? myTeamName,
      String? myTeamShortName,
      String? opponentTeamId,
      String? opponentTeamName,
      String? opponentTeamShortName,
      String? country,
      String? city,
      String? stadiumName,
      String? fieldName,
      String? locationName,
      double locationLat,
      double locationLng,
      int totalTimeMins,
      String? ageGroup,
      bool referees,
      int substitutes,
      String? matchNote,
      bool active,
      String? acceptStatus,
      int? createdOn,
      String? acceptedBy,
      String? scoreStatus,
      bool myTeamScore,
      bool opponentTeamScore,
      bool penaltyScore,
      bool extraTimeScore,
      bool extraTimeSaved,
      bool penaltySaved,
      bool myTeamCard,
      bool substituteSaved,
      bool opponentTeamCard,
      bool myTeamMvp,
      bool opponentTeamMvp,
      bool myTeamRating,
      bool opponentRating,
      String? myMvpPlayerId,
      String? myMvpPlayerName,
      String? opponentMvpPlayerId,
      String? opponentMvpPlayerName,
      bool matchMvp,
      String? mvpTeamId,
      String? mvpPlayerId,
      String? mvpPlayerName,
      String? leg,
      String? round,
      List<dynamic> myPlayers,
      List<dynamic> opponentPlayers,
      dynamic myCoach,
      dynamic oppoCoach,
      dynamic myManager,
      dynamic oppoManager,
      bool mgmtSaved,
      bool penaltyNum,
      bool extraTimeNum,
      bool cleansheetSaved,
      dynamic myTeamCleanSheet,
      dynamic oppoTeamCleanSheet,
      List<TeamMatchTeamModel> teams,
      TeamMatchScoreModel? score});

  @override
  $TeamMatchScoreModelCopyWith<$Res>? get score;
}

/// @nodoc
class __$$TeamMatchModelImplCopyWithImpl<$Res>
    extends _$TeamMatchModelCopyWithImpl<$Res, _$TeamMatchModelImpl>
    implements _$$TeamMatchModelImplCopyWith<$Res> {
  __$$TeamMatchModelImplCopyWithImpl(
      _$TeamMatchModelImpl _value, $Res Function(_$TeamMatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
    Object? roundId = freezed,
    Object? configure = null,
    Object? tournamentId = freezed,
    Object? isDelete = null,
    Object? level = null,
    Object? matchName = freezed,
    Object? seq = null,
    Object? createdBy = freezed,
    Object? createdByChild = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? matchDateTimeGmt = freezed,
    Object? gameType = freezed,
    Object? gameSemiType = freezed,
    Object? matchType = freezed,
    Object? myTeamId = freezed,
    Object? myTeamName = freezed,
    Object? myTeamShortName = freezed,
    Object? opponentTeamId = freezed,
    Object? opponentTeamName = freezed,
    Object? opponentTeamShortName = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? stadiumName = freezed,
    Object? fieldName = freezed,
    Object? locationName = freezed,
    Object? locationLat = null,
    Object? locationLng = null,
    Object? totalTimeMins = null,
    Object? ageGroup = freezed,
    Object? referees = null,
    Object? substitutes = null,
    Object? matchNote = freezed,
    Object? active = null,
    Object? acceptStatus = freezed,
    Object? createdOn = freezed,
    Object? acceptedBy = freezed,
    Object? scoreStatus = freezed,
    Object? myTeamScore = null,
    Object? opponentTeamScore = null,
    Object? penaltyScore = null,
    Object? extraTimeScore = null,
    Object? extraTimeSaved = null,
    Object? penaltySaved = null,
    Object? myTeamCard = null,
    Object? substituteSaved = null,
    Object? opponentTeamCard = null,
    Object? myTeamMvp = null,
    Object? opponentTeamMvp = null,
    Object? myTeamRating = null,
    Object? opponentRating = null,
    Object? myMvpPlayerId = freezed,
    Object? myMvpPlayerName = freezed,
    Object? opponentMvpPlayerId = freezed,
    Object? opponentMvpPlayerName = freezed,
    Object? matchMvp = null,
    Object? mvpTeamId = freezed,
    Object? mvpPlayerId = freezed,
    Object? mvpPlayerName = freezed,
    Object? leg = freezed,
    Object? round = freezed,
    Object? myPlayers = null,
    Object? opponentPlayers = null,
    Object? myCoach = freezed,
    Object? oppoCoach = freezed,
    Object? myManager = freezed,
    Object? oppoManager = freezed,
    Object? mgmtSaved = null,
    Object? penaltyNum = null,
    Object? extraTimeNum = null,
    Object? cleansheetSaved = null,
    Object? myTeamCleanSheet = freezed,
    Object? oppoTeamCleanSheet = freezed,
    Object? teams = null,
    Object? score = freezed,
  }) {
    return _then(_$TeamMatchModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      configure: null == configure
          ? _value.configure
          : configure // ignore: cast_nullable_to_non_nullable
              as bool,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      matchName: freezed == matchName
          ? _value.matchName
          : matchName // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdByChild: freezed == createdByChild
          ? _value.createdByChild
          : createdByChild // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDateTimeGmt: freezed == matchDateTimeGmt
          ? _value.matchDateTimeGmt
          : matchDateTimeGmt // ignore: cast_nullable_to_non_nullable
              as int?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gameSemiType: freezed == gameSemiType
          ? _value.gameSemiType
          : gameSemiType // ignore: cast_nullable_to_non_nullable
              as String?,
      matchType: freezed == matchType
          ? _value.matchType
          : matchType // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamId: freezed == myTeamId
          ? _value.myTeamId
          : myTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamName: freezed == myTeamName
          ? _value.myTeamName
          : myTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamShortName: freezed == myTeamShortName
          ? _value.myTeamShortName
          : myTeamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamId: freezed == opponentTeamId
          ? _value.opponentTeamId
          : opponentTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamName: freezed == opponentTeamName
          ? _value.opponentTeamName
          : opponentTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamShortName: freezed == opponentTeamShortName
          ? _value.opponentTeamShortName
          : opponentTeamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stadiumName: freezed == stadiumName
          ? _value.stadiumName
          : stadiumName // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationLat: null == locationLat
          ? _value.locationLat
          : locationLat // ignore: cast_nullable_to_non_nullable
              as double,
      locationLng: null == locationLng
          ? _value.locationLng
          : locationLng // ignore: cast_nullable_to_non_nullable
              as double,
      totalTimeMins: null == totalTimeMins
          ? _value.totalTimeMins
          : totalTimeMins // ignore: cast_nullable_to_non_nullable
              as int,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      referees: null == referees
          ? _value.referees
          : referees // ignore: cast_nullable_to_non_nullable
              as bool,
      substitutes: null == substitutes
          ? _value.substitutes
          : substitutes // ignore: cast_nullable_to_non_nullable
              as int,
      matchNote: freezed == matchNote
          ? _value.matchNote
          : matchNote // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int?,
      acceptedBy: freezed == acceptedBy
          ? _value.acceptedBy
          : acceptedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreStatus: freezed == scoreStatus
          ? _value.scoreStatus
          : scoreStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamScore: null == myTeamScore
          ? _value.myTeamScore
          : myTeamScore // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentTeamScore: null == opponentTeamScore
          ? _value.opponentTeamScore
          : opponentTeamScore // ignore: cast_nullable_to_non_nullable
              as bool,
      penaltyScore: null == penaltyScore
          ? _value.penaltyScore
          : penaltyScore // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTimeScore: null == extraTimeScore
          ? _value.extraTimeScore
          : extraTimeScore // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTimeSaved: null == extraTimeSaved
          ? _value.extraTimeSaved
          : extraTimeSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      penaltySaved: null == penaltySaved
          ? _value.penaltySaved
          : penaltySaved // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamCard: null == myTeamCard
          ? _value.myTeamCard
          : myTeamCard // ignore: cast_nullable_to_non_nullable
              as bool,
      substituteSaved: null == substituteSaved
          ? _value.substituteSaved
          : substituteSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentTeamCard: null == opponentTeamCard
          ? _value.opponentTeamCard
          : opponentTeamCard // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamMvp: null == myTeamMvp
          ? _value.myTeamMvp
          : myTeamMvp // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentTeamMvp: null == opponentTeamMvp
          ? _value.opponentTeamMvp
          : opponentTeamMvp // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamRating: null == myTeamRating
          ? _value.myTeamRating
          : myTeamRating // ignore: cast_nullable_to_non_nullable
              as bool,
      opponentRating: null == opponentRating
          ? _value.opponentRating
          : opponentRating // ignore: cast_nullable_to_non_nullable
              as bool,
      myMvpPlayerId: freezed == myMvpPlayerId
          ? _value.myMvpPlayerId
          : myMvpPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      myMvpPlayerName: freezed == myMvpPlayerName
          ? _value.myMvpPlayerName
          : myMvpPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentMvpPlayerId: freezed == opponentMvpPlayerId
          ? _value.opponentMvpPlayerId
          : opponentMvpPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentMvpPlayerName: freezed == opponentMvpPlayerName
          ? _value.opponentMvpPlayerName
          : opponentMvpPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      matchMvp: null == matchMvp
          ? _value.matchMvp
          : matchMvp // ignore: cast_nullable_to_non_nullable
              as bool,
      mvpTeamId: freezed == mvpTeamId
          ? _value.mvpTeamId
          : mvpTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      mvpPlayerId: freezed == mvpPlayerId
          ? _value.mvpPlayerId
          : mvpPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      mvpPlayerName: freezed == mvpPlayerName
          ? _value.mvpPlayerName
          : mvpPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      leg: freezed == leg
          ? _value.leg
          : leg // ignore: cast_nullable_to_non_nullable
              as String?,
      round: freezed == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as String?,
      myPlayers: null == myPlayers
          ? _value._myPlayers
          : myPlayers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      opponentPlayers: null == opponentPlayers
          ? _value._opponentPlayers
          : opponentPlayers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      myCoach: freezed == myCoach
          ? _value.myCoach
          : myCoach // ignore: cast_nullable_to_non_nullable
              as dynamic,
      oppoCoach: freezed == oppoCoach
          ? _value.oppoCoach
          : oppoCoach // ignore: cast_nullable_to_non_nullable
              as dynamic,
      myManager: freezed == myManager
          ? _value.myManager
          : myManager // ignore: cast_nullable_to_non_nullable
              as dynamic,
      oppoManager: freezed == oppoManager
          ? _value.oppoManager
          : oppoManager // ignore: cast_nullable_to_non_nullable
              as dynamic,
      mgmtSaved: null == mgmtSaved
          ? _value.mgmtSaved
          : mgmtSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      penaltyNum: null == penaltyNum
          ? _value.penaltyNum
          : penaltyNum // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTimeNum: null == extraTimeNum
          ? _value.extraTimeNum
          : extraTimeNum // ignore: cast_nullable_to_non_nullable
              as bool,
      cleansheetSaved: null == cleansheetSaved
          ? _value.cleansheetSaved
          : cleansheetSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      myTeamCleanSheet: freezed == myTeamCleanSheet
          ? _value.myTeamCleanSheet
          : myTeamCleanSheet // ignore: cast_nullable_to_non_nullable
              as dynamic,
      oppoTeamCleanSheet: freezed == oppoTeamCleanSheet
          ? _value.oppoTeamCleanSheet
          : oppoTeamCleanSheet // ignore: cast_nullable_to_non_nullable
              as dynamic,
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamMatchTeamModel>,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as TeamMatchScoreModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMatchModelImpl implements _TeamMatchModel {
  const _$TeamMatchModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.matchId,
      this.roundId,
      this.configure = false,
      this.tournamentId,
      this.isDelete = false,
      this.level = 0,
      this.matchName,
      this.seq = 0,
      this.createdBy,
      this.createdByChild,
      this.matchDate,
      this.matchTime,
      this.matchDateTimeGmt,
      this.gameType,
      this.gameSemiType,
      this.matchType,
      this.myTeamId,
      this.myTeamName,
      this.myTeamShortName,
      this.opponentTeamId,
      this.opponentTeamName,
      this.opponentTeamShortName,
      this.country,
      this.city,
      this.stadiumName,
      this.fieldName,
      this.locationName,
      this.locationLat = 0.0,
      this.locationLng = 0.0,
      this.totalTimeMins = 0,
      this.ageGroup,
      this.referees = false,
      this.substitutes = 0,
      this.matchNote,
      this.active = false,
      this.acceptStatus,
      this.createdOn,
      this.acceptedBy,
      this.scoreStatus,
      this.myTeamScore = false,
      this.opponentTeamScore = false,
      this.penaltyScore = false,
      this.extraTimeScore = false,
      this.extraTimeSaved = false,
      this.penaltySaved = false,
      this.myTeamCard = false,
      this.substituteSaved = false,
      this.opponentTeamCard = false,
      this.myTeamMvp = false,
      this.opponentTeamMvp = false,
      this.myTeamRating = false,
      this.opponentRating = false,
      this.myMvpPlayerId,
      this.myMvpPlayerName,
      this.opponentMvpPlayerId,
      this.opponentMvpPlayerName,
      this.matchMvp = false,
      this.mvpTeamId,
      this.mvpPlayerId,
      this.mvpPlayerName,
      this.leg,
      this.round,
      final List<dynamic> myPlayers = const [],
      final List<dynamic> opponentPlayers = const [],
      this.myCoach,
      this.oppoCoach,
      this.myManager,
      this.oppoManager,
      this.mgmtSaved = false,
      this.penaltyNum = false,
      this.extraTimeNum = false,
      this.cleansheetSaved = false,
      this.myTeamCleanSheet,
      this.oppoTeamCleanSheet,
      final List<TeamMatchTeamModel> teams = const [],
      this.score})
      : _myPlayers = myPlayers,
        _opponentPlayers = opponentPlayers,
        _teams = teams;

  factory _$TeamMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? matchId;
  @override
  final String? roundId;
  @override
  @JsonKey()
  final bool configure;
  @override
  final String? tournamentId;
  @override
  @JsonKey()
  final bool isDelete;
  @override
  @JsonKey()
  final int level;
  @override
  final String? matchName;
  @override
  @JsonKey()
  final int seq;
  @override
  final String? createdBy;
  @override
  final String? createdByChild;
  @override
  final String? matchDate;
  @override
  final String? matchTime;
  @override
  final int? matchDateTimeGmt;
  @override
  final String? gameType;
  @override
  final String? gameSemiType;
  @override
  final String? matchType;
  @override
  final String? myTeamId;
  @override
  final String? myTeamName;
  @override
  final String? myTeamShortName;
  @override
  final String? opponentTeamId;
  @override
  final String? opponentTeamName;
  @override
  final String? opponentTeamShortName;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? stadiumName;
  @override
  final String? fieldName;
  @override
  final String? locationName;
  @override
  @JsonKey()
  final double locationLat;
  @override
  @JsonKey()
  final double locationLng;
  @override
  @JsonKey()
  final int totalTimeMins;
  @override
  final String? ageGroup;
  @override
  @JsonKey()
  final bool referees;
  @override
  @JsonKey()
  final int substitutes;
  @override
  final String? matchNote;
  @override
  @JsonKey()
  final bool active;
  @override
  final String? acceptStatus;
  @override
  final int? createdOn;
  @override
  final String? acceptedBy;
  @override
  final String? scoreStatus;
  @override
  @JsonKey()
  final bool myTeamScore;
  @override
  @JsonKey()
  final bool opponentTeamScore;
  @override
  @JsonKey()
  final bool penaltyScore;
  @override
  @JsonKey()
  final bool extraTimeScore;
  @override
  @JsonKey()
  final bool extraTimeSaved;
  @override
  @JsonKey()
  final bool penaltySaved;
  @override
  @JsonKey()
  final bool myTeamCard;
  @override
  @JsonKey()
  final bool substituteSaved;
  @override
  @JsonKey()
  final bool opponentTeamCard;
  @override
  @JsonKey()
  final bool myTeamMvp;
  @override
  @JsonKey()
  final bool opponentTeamMvp;
  @override
  @JsonKey()
  final bool myTeamRating;
  @override
  @JsonKey()
  final bool opponentRating;
  @override
  final String? myMvpPlayerId;
  @override
  final String? myMvpPlayerName;
  @override
  final String? opponentMvpPlayerId;
  @override
  final String? opponentMvpPlayerName;
  @override
  @JsonKey()
  final bool matchMvp;
  @override
  final String? mvpTeamId;
  @override
  final String? mvpPlayerId;
  @override
  final String? mvpPlayerName;
  @override
  final String? leg;
  @override
  final String? round;
  final List<dynamic> _myPlayers;
  @override
  @JsonKey()
  List<dynamic> get myPlayers {
    if (_myPlayers is EqualUnmodifiableListView) return _myPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myPlayers);
  }

  final List<dynamic> _opponentPlayers;
  @override
  @JsonKey()
  List<dynamic> get opponentPlayers {
    if (_opponentPlayers is EqualUnmodifiableListView) return _opponentPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opponentPlayers);
  }

  @override
  final dynamic myCoach;
  @override
  final dynamic oppoCoach;
  @override
  final dynamic myManager;
  @override
  final dynamic oppoManager;
  @override
  @JsonKey()
  final bool mgmtSaved;
  @override
  @JsonKey()
  final bool penaltyNum;
  @override
  @JsonKey()
  final bool extraTimeNum;
  @override
  @JsonKey()
  final bool cleansheetSaved;
  @override
  final dynamic myTeamCleanSheet;
  @override
  final dynamic oppoTeamCleanSheet;
  final List<TeamMatchTeamModel> _teams;
  @override
  @JsonKey()
  List<TeamMatchTeamModel> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  @override
  final TeamMatchScoreModel? score;

  @override
  String toString() {
    return 'TeamMatchModel(id: $id, matchId: $matchId, roundId: $roundId, configure: $configure, tournamentId: $tournamentId, isDelete: $isDelete, level: $level, matchName: $matchName, seq: $seq, createdBy: $createdBy, createdByChild: $createdByChild, matchDate: $matchDate, matchTime: $matchTime, matchDateTimeGmt: $matchDateTimeGmt, gameType: $gameType, gameSemiType: $gameSemiType, matchType: $matchType, myTeamId: $myTeamId, myTeamName: $myTeamName, myTeamShortName: $myTeamShortName, opponentTeamId: $opponentTeamId, opponentTeamName: $opponentTeamName, opponentTeamShortName: $opponentTeamShortName, country: $country, city: $city, stadiumName: $stadiumName, fieldName: $fieldName, locationName: $locationName, locationLat: $locationLat, locationLng: $locationLng, totalTimeMins: $totalTimeMins, ageGroup: $ageGroup, referees: $referees, substitutes: $substitutes, matchNote: $matchNote, active: $active, acceptStatus: $acceptStatus, createdOn: $createdOn, acceptedBy: $acceptedBy, scoreStatus: $scoreStatus, myTeamScore: $myTeamScore, opponentTeamScore: $opponentTeamScore, penaltyScore: $penaltyScore, extraTimeScore: $extraTimeScore, extraTimeSaved: $extraTimeSaved, penaltySaved: $penaltySaved, myTeamCard: $myTeamCard, substituteSaved: $substituteSaved, opponentTeamCard: $opponentTeamCard, myTeamMvp: $myTeamMvp, opponentTeamMvp: $opponentTeamMvp, myTeamRating: $myTeamRating, opponentRating: $opponentRating, myMvpPlayerId: $myMvpPlayerId, myMvpPlayerName: $myMvpPlayerName, opponentMvpPlayerId: $opponentMvpPlayerId, opponentMvpPlayerName: $opponentMvpPlayerName, matchMvp: $matchMvp, mvpTeamId: $mvpTeamId, mvpPlayerId: $mvpPlayerId, mvpPlayerName: $mvpPlayerName, leg: $leg, round: $round, myPlayers: $myPlayers, opponentPlayers: $opponentPlayers, myCoach: $myCoach, oppoCoach: $oppoCoach, myManager: $myManager, oppoManager: $oppoManager, mgmtSaved: $mgmtSaved, penaltyNum: $penaltyNum, extraTimeNum: $extraTimeNum, cleansheetSaved: $cleansheetSaved, myTeamCleanSheet: $myTeamCleanSheet, oppoTeamCleanSheet: $oppoTeamCleanSheet, teams: $teams, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.configure, configure) ||
                other.configure == configure) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.matchName, matchName) ||
                other.matchName == matchName) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdByChild, createdByChild) ||
                other.createdByChild == createdByChild) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.matchDateTimeGmt, matchDateTimeGmt) ||
                other.matchDateTimeGmt == matchDateTimeGmt) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.gameSemiType, gameSemiType) ||
                other.gameSemiType == gameSemiType) &&
            (identical(other.matchType, matchType) ||
                other.matchType == matchType) &&
            (identical(other.myTeamId, myTeamId) ||
                other.myTeamId == myTeamId) &&
            (identical(other.myTeamName, myTeamName) ||
                other.myTeamName == myTeamName) &&
            (identical(other.myTeamShortName, myTeamShortName) ||
                other.myTeamShortName == myTeamShortName) &&
            (identical(other.opponentTeamId, opponentTeamId) ||
                other.opponentTeamId == opponentTeamId) &&
            (identical(other.opponentTeamName, opponentTeamName) ||
                other.opponentTeamName == opponentTeamName) &&
            (identical(other.opponentTeamShortName, opponentTeamShortName) ||
                other.opponentTeamShortName == opponentTeamShortName) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.stadiumName, stadiumName) ||
                other.stadiumName == stadiumName) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationLat, locationLat) ||
                other.locationLat == locationLat) &&
            (identical(other.locationLng, locationLng) ||
                other.locationLng == locationLng) &&
            (identical(other.totalTimeMins, totalTimeMins) ||
                other.totalTimeMins == totalTimeMins) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.referees, referees) ||
                other.referees == referees) &&
            (identical(other.substitutes, substitutes) ||
                other.substitutes == substitutes) &&
            (identical(other.matchNote, matchNote) ||
                other.matchNote == matchNote) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.acceptStatus, acceptStatus) ||
                other.acceptStatus == acceptStatus) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.acceptedBy, acceptedBy) ||
                other.acceptedBy == acceptedBy) &&
            (identical(other.scoreStatus, scoreStatus) ||
                other.scoreStatus == scoreStatus) &&
            (identical(other.myTeamScore, myTeamScore) ||
                other.myTeamScore == myTeamScore) &&
            (identical(other.opponentTeamScore, opponentTeamScore) ||
                other.opponentTeamScore == opponentTeamScore) &&
            (identical(other.penaltyScore, penaltyScore) ||
                other.penaltyScore == penaltyScore) &&
            (identical(other.extraTimeScore, extraTimeScore) ||
                other.extraTimeScore == extraTimeScore) &&
            (identical(other.extraTimeSaved, extraTimeSaved) ||
                other.extraTimeSaved == extraTimeSaved) &&
            (identical(other.penaltySaved, penaltySaved) ||
                other.penaltySaved == penaltySaved) &&
            (identical(other.myTeamCard, myTeamCard) ||
                other.myTeamCard == myTeamCard) &&
            (identical(other.substituteSaved, substituteSaved) ||
                other.substituteSaved == substituteSaved) &&
            (identical(other.opponentTeamCard, opponentTeamCard) ||
                other.opponentTeamCard == opponentTeamCard) &&
            (identical(other.myTeamMvp, myTeamMvp) ||
                other.myTeamMvp == myTeamMvp) &&
            (identical(other.opponentTeamMvp, opponentTeamMvp) ||
                other.opponentTeamMvp == opponentTeamMvp) &&
            (identical(other.myTeamRating, myTeamRating) || other.myTeamRating == myTeamRating) &&
            (identical(other.opponentRating, opponentRating) || other.opponentRating == opponentRating) &&
            (identical(other.myMvpPlayerId, myMvpPlayerId) || other.myMvpPlayerId == myMvpPlayerId) &&
            (identical(other.myMvpPlayerName, myMvpPlayerName) || other.myMvpPlayerName == myMvpPlayerName) &&
            (identical(other.opponentMvpPlayerId, opponentMvpPlayerId) || other.opponentMvpPlayerId == opponentMvpPlayerId) &&
            (identical(other.opponentMvpPlayerName, opponentMvpPlayerName) || other.opponentMvpPlayerName == opponentMvpPlayerName) &&
            (identical(other.matchMvp, matchMvp) || other.matchMvp == matchMvp) &&
            (identical(other.mvpTeamId, mvpTeamId) || other.mvpTeamId == mvpTeamId) &&
            (identical(other.mvpPlayerId, mvpPlayerId) || other.mvpPlayerId == mvpPlayerId) &&
            (identical(other.mvpPlayerName, mvpPlayerName) || other.mvpPlayerName == mvpPlayerName) &&
            (identical(other.leg, leg) || other.leg == leg) &&
            (identical(other.round, round) || other.round == round) &&
            const DeepCollectionEquality().equals(other._myPlayers, _myPlayers) &&
            const DeepCollectionEquality().equals(other._opponentPlayers, _opponentPlayers) &&
            const DeepCollectionEquality().equals(other.myCoach, myCoach) &&
            const DeepCollectionEquality().equals(other.oppoCoach, oppoCoach) &&
            const DeepCollectionEquality().equals(other.myManager, myManager) &&
            const DeepCollectionEquality().equals(other.oppoManager, oppoManager) &&
            (identical(other.mgmtSaved, mgmtSaved) || other.mgmtSaved == mgmtSaved) &&
            (identical(other.penaltyNum, penaltyNum) || other.penaltyNum == penaltyNum) &&
            (identical(other.extraTimeNum, extraTimeNum) || other.extraTimeNum == extraTimeNum) &&
            (identical(other.cleansheetSaved, cleansheetSaved) || other.cleansheetSaved == cleansheetSaved) &&
            const DeepCollectionEquality().equals(other.myTeamCleanSheet, myTeamCleanSheet) &&
            const DeepCollectionEquality().equals(other.oppoTeamCleanSheet, oppoTeamCleanSheet) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        matchId,
        roundId,
        configure,
        tournamentId,
        isDelete,
        level,
        matchName,
        seq,
        createdBy,
        createdByChild,
        matchDate,
        matchTime,
        matchDateTimeGmt,
        gameType,
        gameSemiType,
        matchType,
        myTeamId,
        myTeamName,
        myTeamShortName,
        opponentTeamId,
        opponentTeamName,
        opponentTeamShortName,
        country,
        city,
        stadiumName,
        fieldName,
        locationName,
        locationLat,
        locationLng,
        totalTimeMins,
        ageGroup,
        referees,
        substitutes,
        matchNote,
        active,
        acceptStatus,
        createdOn,
        acceptedBy,
        scoreStatus,
        myTeamScore,
        opponentTeamScore,
        penaltyScore,
        extraTimeScore,
        extraTimeSaved,
        penaltySaved,
        myTeamCard,
        substituteSaved,
        opponentTeamCard,
        myTeamMvp,
        opponentTeamMvp,
        myTeamRating,
        opponentRating,
        myMvpPlayerId,
        myMvpPlayerName,
        opponentMvpPlayerId,
        opponentMvpPlayerName,
        matchMvp,
        mvpTeamId,
        mvpPlayerId,
        mvpPlayerName,
        leg,
        round,
        const DeepCollectionEquality().hash(_myPlayers),
        const DeepCollectionEquality().hash(_opponentPlayers),
        const DeepCollectionEquality().hash(myCoach),
        const DeepCollectionEquality().hash(oppoCoach),
        const DeepCollectionEquality().hash(myManager),
        const DeepCollectionEquality().hash(oppoManager),
        mgmtSaved,
        penaltyNum,
        extraTimeNum,
        cleansheetSaved,
        const DeepCollectionEquality().hash(myTeamCleanSheet),
        const DeepCollectionEquality().hash(oppoTeamCleanSheet),
        const DeepCollectionEquality().hash(_teams),
        score
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMatchModelImplCopyWith<_$TeamMatchModelImpl> get copyWith =>
      __$$TeamMatchModelImplCopyWithImpl<_$TeamMatchModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMatchModelImplToJson(
      this,
    );
  }
}

abstract class _TeamMatchModel implements TeamMatchModel {
  const factory _TeamMatchModel(
      {@JsonKey(name: '_id') final String? id,
      final String? matchId,
      final String? roundId,
      final bool configure,
      final String? tournamentId,
      final bool isDelete,
      final int level,
      final String? matchName,
      final int seq,
      final String? createdBy,
      final String? createdByChild,
      final String? matchDate,
      final String? matchTime,
      final int? matchDateTimeGmt,
      final String? gameType,
      final String? gameSemiType,
      final String? matchType,
      final String? myTeamId,
      final String? myTeamName,
      final String? myTeamShortName,
      final String? opponentTeamId,
      final String? opponentTeamName,
      final String? opponentTeamShortName,
      final String? country,
      final String? city,
      final String? stadiumName,
      final String? fieldName,
      final String? locationName,
      final double locationLat,
      final double locationLng,
      final int totalTimeMins,
      final String? ageGroup,
      final bool referees,
      final int substitutes,
      final String? matchNote,
      final bool active,
      final String? acceptStatus,
      final int? createdOn,
      final String? acceptedBy,
      final String? scoreStatus,
      final bool myTeamScore,
      final bool opponentTeamScore,
      final bool penaltyScore,
      final bool extraTimeScore,
      final bool extraTimeSaved,
      final bool penaltySaved,
      final bool myTeamCard,
      final bool substituteSaved,
      final bool opponentTeamCard,
      final bool myTeamMvp,
      final bool opponentTeamMvp,
      final bool myTeamRating,
      final bool opponentRating,
      final String? myMvpPlayerId,
      final String? myMvpPlayerName,
      final String? opponentMvpPlayerId,
      final String? opponentMvpPlayerName,
      final bool matchMvp,
      final String? mvpTeamId,
      final String? mvpPlayerId,
      final String? mvpPlayerName,
      final String? leg,
      final String? round,
      final List<dynamic> myPlayers,
      final List<dynamic> opponentPlayers,
      final dynamic myCoach,
      final dynamic oppoCoach,
      final dynamic myManager,
      final dynamic oppoManager,
      final bool mgmtSaved,
      final bool penaltyNum,
      final bool extraTimeNum,
      final bool cleansheetSaved,
      final dynamic myTeamCleanSheet,
      final dynamic oppoTeamCleanSheet,
      final List<TeamMatchTeamModel> teams,
      final TeamMatchScoreModel? score}) = _$TeamMatchModelImpl;

  factory _TeamMatchModel.fromJson(Map<String, dynamic> json) =
      _$TeamMatchModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get matchId;
  @override
  String? get roundId;
  @override
  bool get configure;
  @override
  String? get tournamentId;
  @override
  bool get isDelete;
  @override
  int get level;
  @override
  String? get matchName;
  @override
  int get seq;
  @override
  String? get createdBy;
  @override
  String? get createdByChild;
  @override
  String? get matchDate;
  @override
  String? get matchTime;
  @override
  int? get matchDateTimeGmt;
  @override
  String? get gameType;
  @override
  String? get gameSemiType;
  @override
  String? get matchType;
  @override
  String? get myTeamId;
  @override
  String? get myTeamName;
  @override
  String? get myTeamShortName;
  @override
  String? get opponentTeamId;
  @override
  String? get opponentTeamName;
  @override
  String? get opponentTeamShortName;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get stadiumName;
  @override
  String? get fieldName;
  @override
  String? get locationName;
  @override
  double get locationLat;
  @override
  double get locationLng;
  @override
  int get totalTimeMins;
  @override
  String? get ageGroup;
  @override
  bool get referees;
  @override
  int get substitutes;
  @override
  String? get matchNote;
  @override
  bool get active;
  @override
  String? get acceptStatus;
  @override
  int? get createdOn;
  @override
  String? get acceptedBy;
  @override
  String? get scoreStatus;
  @override
  bool get myTeamScore;
  @override
  bool get opponentTeamScore;
  @override
  bool get penaltyScore;
  @override
  bool get extraTimeScore;
  @override
  bool get extraTimeSaved;
  @override
  bool get penaltySaved;
  @override
  bool get myTeamCard;
  @override
  bool get substituteSaved;
  @override
  bool get opponentTeamCard;
  @override
  bool get myTeamMvp;
  @override
  bool get opponentTeamMvp;
  @override
  bool get myTeamRating;
  @override
  bool get opponentRating;
  @override
  String? get myMvpPlayerId;
  @override
  String? get myMvpPlayerName;
  @override
  String? get opponentMvpPlayerId;
  @override
  String? get opponentMvpPlayerName;
  @override
  bool get matchMvp;
  @override
  String? get mvpTeamId;
  @override
  String? get mvpPlayerId;
  @override
  String? get mvpPlayerName;
  @override
  String? get leg;
  @override
  String? get round;
  @override
  List<dynamic> get myPlayers;
  @override
  List<dynamic> get opponentPlayers;
  @override
  dynamic get myCoach;
  @override
  dynamic get oppoCoach;
  @override
  dynamic get myManager;
  @override
  dynamic get oppoManager;
  @override
  bool get mgmtSaved;
  @override
  bool get penaltyNum;
  @override
  bool get extraTimeNum;
  @override
  bool get cleansheetSaved;
  @override
  dynamic get myTeamCleanSheet;
  @override
  dynamic get oppoTeamCleanSheet;
  @override
  List<TeamMatchTeamModel> get teams;
  @override
  TeamMatchScoreModel? get score;
  @override
  @JsonKey(ignore: true)
  _$$TeamMatchModelImplCopyWith<_$TeamMatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamMatchTeamModel _$TeamMatchTeamModelFromJson(Map<String, dynamic> json) {
  return _TeamMatchTeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamMatchTeamModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get teamId => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamShortName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get teamImage => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'ageCat')
  String? get ageCategory => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  int? get createdOn => throw _privateConstructorUsedError;
  int get followCount => throw _privateConstructorUsedError;
  bool get archive => throw _privateConstructorUsedError;
  List<dynamic> get admins => throw _privateConstructorUsedError;
  List<dynamic> get teamPlayers => throw _privateConstructorUsedError;
  List<dynamic> get coaches => throw _privateConstructorUsedError;
  List<dynamic> get managers => throw _privateConstructorUsedError;
  bool get directTeam => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  int get ratingCounter => throw _privateConstructorUsedError;
  bool get isDelete => throw _privateConstructorUsedError;
  String? get lastUpdateBy => throw _privateConstructorUsedError;
  int? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamMatchTeamModelCopyWith<TeamMatchTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMatchTeamModelCopyWith<$Res> {
  factory $TeamMatchTeamModelCopyWith(
          TeamMatchTeamModel value, $Res Function(TeamMatchTeamModel) then) =
      _$TeamMatchTeamModelCopyWithImpl<$Res, TeamMatchTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? teamId,
      String? createdBy,
      String? teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage,
      String? country,
      String? city,
      String? gender,
      String? ageGroup,
      @JsonKey(name: 'ageCat') String? ageCategory,
      String? gameType,
      int? createdOn,
      int followCount,
      bool archive,
      List<dynamic> admins,
      List<dynamic> teamPlayers,
      List<dynamic> coaches,
      List<dynamic> managers,
      bool directTeam,
      int rating,
      int ratingCounter,
      bool isDelete,
      String? lastUpdateBy,
      int? lastUpdated});
}

/// @nodoc
class _$TeamMatchTeamModelCopyWithImpl<$Res, $Val extends TeamMatchTeamModel>
    implements $TeamMatchTeamModelCopyWith<$Res> {
  _$TeamMatchTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? createdBy = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gender = freezed,
    Object? ageGroup = freezed,
    Object? ageCategory = freezed,
    Object? gameType = freezed,
    Object? createdOn = freezed,
    Object? followCount = null,
    Object? archive = null,
    Object? admins = null,
    Object? teamPlayers = null,
    Object? coaches = null,
    Object? managers = null,
    Object? directTeam = null,
    Object? rating = null,
    Object? ratingCounter = null,
    Object? isDelete = null,
    Object? lastUpdateBy = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamShortName: freezed == teamShortName
          ? _value.teamShortName
          : teamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamImage: freezed == teamImage
          ? _value.teamImage
          : teamImage // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      ageCategory: freezed == ageCategory
          ? _value.ageCategory
          : ageCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int?,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
      archive: null == archive
          ? _value.archive
          : archive // ignore: cast_nullable_to_non_nullable
              as bool,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      teamPlayers: null == teamPlayers
          ? _value.teamPlayers
          : teamPlayers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      coaches: null == coaches
          ? _value.coaches
          : coaches // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      managers: null == managers
          ? _value.managers
          : managers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      directTeam: null == directTeam
          ? _value.directTeam
          : directTeam // ignore: cast_nullable_to_non_nullable
              as bool,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      ratingCounter: null == ratingCounter
          ? _value.ratingCounter
          : ratingCounter // ignore: cast_nullable_to_non_nullable
              as int,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdateBy: freezed == lastUpdateBy
          ? _value.lastUpdateBy
          : lastUpdateBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMatchTeamModelImplCopyWith<$Res>
    implements $TeamMatchTeamModelCopyWith<$Res> {
  factory _$$TeamMatchTeamModelImplCopyWith(_$TeamMatchTeamModelImpl value,
          $Res Function(_$TeamMatchTeamModelImpl) then) =
      __$$TeamMatchTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? teamId,
      String? createdBy,
      String? teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage,
      String? country,
      String? city,
      String? gender,
      String? ageGroup,
      @JsonKey(name: 'ageCat') String? ageCategory,
      String? gameType,
      int? createdOn,
      int followCount,
      bool archive,
      List<dynamic> admins,
      List<dynamic> teamPlayers,
      List<dynamic> coaches,
      List<dynamic> managers,
      bool directTeam,
      int rating,
      int ratingCounter,
      bool isDelete,
      String? lastUpdateBy,
      int? lastUpdated});
}

/// @nodoc
class __$$TeamMatchTeamModelImplCopyWithImpl<$Res>
    extends _$TeamMatchTeamModelCopyWithImpl<$Res, _$TeamMatchTeamModelImpl>
    implements _$$TeamMatchTeamModelImplCopyWith<$Res> {
  __$$TeamMatchTeamModelImplCopyWithImpl(_$TeamMatchTeamModelImpl _value,
      $Res Function(_$TeamMatchTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? createdBy = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gender = freezed,
    Object? ageGroup = freezed,
    Object? ageCategory = freezed,
    Object? gameType = freezed,
    Object? createdOn = freezed,
    Object? followCount = null,
    Object? archive = null,
    Object? admins = null,
    Object? teamPlayers = null,
    Object? coaches = null,
    Object? managers = null,
    Object? directTeam = null,
    Object? rating = null,
    Object? ratingCounter = null,
    Object? isDelete = null,
    Object? lastUpdateBy = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$TeamMatchTeamModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamShortName: freezed == teamShortName
          ? _value.teamShortName
          : teamShortName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamImage: freezed == teamImage
          ? _value.teamImage
          : teamImage // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      ageCategory: freezed == ageCategory
          ? _value.ageCategory
          : ageCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int?,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
      archive: null == archive
          ? _value.archive
          : archive // ignore: cast_nullable_to_non_nullable
              as bool,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      teamPlayers: null == teamPlayers
          ? _value._teamPlayers
          : teamPlayers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      coaches: null == coaches
          ? _value._coaches
          : coaches // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      managers: null == managers
          ? _value._managers
          : managers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      directTeam: null == directTeam
          ? _value.directTeam
          : directTeam // ignore: cast_nullable_to_non_nullable
              as bool,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      ratingCounter: null == ratingCounter
          ? _value.ratingCounter
          : ratingCounter // ignore: cast_nullable_to_non_nullable
              as int,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdateBy: freezed == lastUpdateBy
          ? _value.lastUpdateBy
          : lastUpdateBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMatchTeamModelImpl implements _TeamMatchTeamModel {
  const _$TeamMatchTeamModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.teamId,
      this.createdBy,
      this.teamName,
      this.teamShortName,
      @JsonKey(name: 'imageUrl') this.teamImage,
      this.country,
      this.city,
      this.gender,
      this.ageGroup,
      @JsonKey(name: 'ageCat') this.ageCategory,
      this.gameType,
      this.createdOn,
      this.followCount = 0,
      this.archive = false,
      final List<dynamic> admins = const [],
      final List<dynamic> teamPlayers = const [],
      final List<dynamic> coaches = const [],
      final List<dynamic> managers = const [],
      this.directTeam = false,
      this.rating = 0,
      this.ratingCounter = 0,
      this.isDelete = false,
      this.lastUpdateBy,
      this.lastUpdated})
      : _admins = admins,
        _teamPlayers = teamPlayers,
        _coaches = coaches,
        _managers = managers;

  factory _$TeamMatchTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchTeamModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? teamId;
  @override
  final String? createdBy;
  @override
  final String? teamName;
  @override
  final String? teamShortName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? teamImage;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? gender;
  @override
  final String? ageGroup;
  @override
  @JsonKey(name: 'ageCat')
  final String? ageCategory;
  @override
  final String? gameType;
  @override
  final int? createdOn;
  @override
  @JsonKey()
  final int followCount;
  @override
  @JsonKey()
  final bool archive;
  final List<dynamic> _admins;
  @override
  @JsonKey()
  List<dynamic> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  final List<dynamic> _teamPlayers;
  @override
  @JsonKey()
  List<dynamic> get teamPlayers {
    if (_teamPlayers is EqualUnmodifiableListView) return _teamPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamPlayers);
  }

  final List<dynamic> _coaches;
  @override
  @JsonKey()
  List<dynamic> get coaches {
    if (_coaches is EqualUnmodifiableListView) return _coaches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coaches);
  }

  final List<dynamic> _managers;
  @override
  @JsonKey()
  List<dynamic> get managers {
    if (_managers is EqualUnmodifiableListView) return _managers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_managers);
  }

  @override
  @JsonKey()
  final bool directTeam;
  @override
  @JsonKey()
  final int rating;
  @override
  @JsonKey()
  final int ratingCounter;
  @override
  @JsonKey()
  final bool isDelete;
  @override
  final String? lastUpdateBy;
  @override
  final int? lastUpdated;

  @override
  String toString() {
    return 'TeamMatchTeamModel(id: $id, teamId: $teamId, createdBy: $createdBy, teamName: $teamName, teamShortName: $teamShortName, teamImage: $teamImage, country: $country, city: $city, gender: $gender, ageGroup: $ageGroup, ageCategory: $ageCategory, gameType: $gameType, createdOn: $createdOn, followCount: $followCount, archive: $archive, admins: $admins, teamPlayers: $teamPlayers, coaches: $coaches, managers: $managers, directTeam: $directTeam, rating: $rating, ratingCounter: $ratingCounter, isDelete: $isDelete, lastUpdateBy: $lastUpdateBy, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamShortName, teamShortName) ||
                other.teamShortName == teamShortName) &&
            (identical(other.teamImage, teamImage) ||
                other.teamImage == teamImage) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.ageCategory, ageCategory) ||
                other.ageCategory == ageCategory) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.followCount, followCount) ||
                other.followCount == followCount) &&
            (identical(other.archive, archive) || other.archive == archive) &&
            const DeepCollectionEquality().equals(other._admins, _admins) &&
            const DeepCollectionEquality()
                .equals(other._teamPlayers, _teamPlayers) &&
            const DeepCollectionEquality().equals(other._coaches, _coaches) &&
            const DeepCollectionEquality().equals(other._managers, _managers) &&
            (identical(other.directTeam, directTeam) ||
                other.directTeam == directTeam) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.ratingCounter, ratingCounter) ||
                other.ratingCounter == ratingCounter) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.lastUpdateBy, lastUpdateBy) ||
                other.lastUpdateBy == lastUpdateBy) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        teamId,
        createdBy,
        teamName,
        teamShortName,
        teamImage,
        country,
        city,
        gender,
        ageGroup,
        ageCategory,
        gameType,
        createdOn,
        followCount,
        archive,
        const DeepCollectionEquality().hash(_admins),
        const DeepCollectionEquality().hash(_teamPlayers),
        const DeepCollectionEquality().hash(_coaches),
        const DeepCollectionEquality().hash(_managers),
        directTeam,
        rating,
        ratingCounter,
        isDelete,
        lastUpdateBy,
        lastUpdated
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMatchTeamModelImplCopyWith<_$TeamMatchTeamModelImpl> get copyWith =>
      __$$TeamMatchTeamModelImplCopyWithImpl<_$TeamMatchTeamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMatchTeamModelImplToJson(
      this,
    );
  }
}

abstract class _TeamMatchTeamModel implements TeamMatchTeamModel {
  const factory _TeamMatchTeamModel(
      {@JsonKey(name: '_id') final String? id,
      final String? teamId,
      final String? createdBy,
      final String? teamName,
      final String? teamShortName,
      @JsonKey(name: 'imageUrl') final String? teamImage,
      final String? country,
      final String? city,
      final String? gender,
      final String? ageGroup,
      @JsonKey(name: 'ageCat') final String? ageCategory,
      final String? gameType,
      final int? createdOn,
      final int followCount,
      final bool archive,
      final List<dynamic> admins,
      final List<dynamic> teamPlayers,
      final List<dynamic> coaches,
      final List<dynamic> managers,
      final bool directTeam,
      final int rating,
      final int ratingCounter,
      final bool isDelete,
      final String? lastUpdateBy,
      final int? lastUpdated}) = _$TeamMatchTeamModelImpl;

  factory _TeamMatchTeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamMatchTeamModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get teamId;
  @override
  String? get createdBy;
  @override
  String? get teamName;
  @override
  String? get teamShortName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get teamImage;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get gender;
  @override
  String? get ageGroup;
  @override
  @JsonKey(name: 'ageCat')
  String? get ageCategory;
  @override
  String? get gameType;
  @override
  int? get createdOn;
  @override
  int get followCount;
  @override
  bool get archive;
  @override
  List<dynamic> get admins;
  @override
  List<dynamic> get teamPlayers;
  @override
  List<dynamic> get coaches;
  @override
  List<dynamic> get managers;
  @override
  bool get directTeam;
  @override
  int get rating;
  @override
  int get ratingCounter;
  @override
  bool get isDelete;
  @override
  String? get lastUpdateBy;
  @override
  int? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$TeamMatchTeamModelImplCopyWith<_$TeamMatchTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamMatchScoreModel _$TeamMatchScoreModelFromJson(Map<String, dynamic> json) {
  return _TeamMatchScoreModel.fromJson(json);
}

/// @nodoc
mixin _$TeamMatchScoreModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get gameSemiType => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get matchId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get initiatedBy => throw _privateConstructorUsedError;
  String? get myTeamId => throw _privateConstructorUsedError;
  String? get opponentTeamId => throw _privateConstructorUsedError;
  int? get initiatedOn => throw _privateConstructorUsedError;
  int get myGoals => throw _privateConstructorUsedError;
  int get opponentGoals => throw _privateConstructorUsedError;
  int? get myEtGoals => throw _privateConstructorUsedError;
  int? get opponentEtGoals => throw _privateConstructorUsedError;
  int? get myPtGoals => throw _privateConstructorUsedError;
  int? get opponentPtGoals => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  List<dynamic> get extraTime => throw _privateConstructorUsedError;
  List<dynamic> get penalty => throw _privateConstructorUsedError;
  List<dynamic> get subs => throw _privateConstructorUsedError;
  int get myPenalty => throw _privateConstructorUsedError;
  int get opponentPenalty => throw _privateConstructorUsedError;
  int get myExtraTime => throw _privateConstructorUsedError;
  int get opponentExtraTime => throw _privateConstructorUsedError;
  String? get acceptStatus => throw _privateConstructorUsedError;
  int get responseTime => throw _privateConstructorUsedError;
  String? get responseBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamMatchScoreModelCopyWith<TeamMatchScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMatchScoreModelCopyWith<$Res> {
  factory $TeamMatchScoreModelCopyWith(
          TeamMatchScoreModel value, $Res Function(TeamMatchScoreModel) then) =
      _$TeamMatchScoreModelCopyWithImpl<$Res, TeamMatchScoreModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? gameType,
      String? gameSemiType,
      String? tournamentId,
      String? matchId,
      String? roundId,
      String? initiatedBy,
      String? myTeamId,
      String? opponentTeamId,
      int? initiatedOn,
      int myGoals,
      int opponentGoals,
      int? myEtGoals,
      int? opponentEtGoals,
      int? myPtGoals,
      int? opponentPtGoals,
      bool active,
      List<dynamic> extraTime,
      List<dynamic> penalty,
      List<dynamic> subs,
      int myPenalty,
      int opponentPenalty,
      int myExtraTime,
      int opponentExtraTime,
      String? acceptStatus,
      int responseTime,
      String? responseBy});
}

/// @nodoc
class _$TeamMatchScoreModelCopyWithImpl<$Res, $Val extends TeamMatchScoreModel>
    implements $TeamMatchScoreModelCopyWith<$Res> {
  _$TeamMatchScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gameType = freezed,
    Object? gameSemiType = freezed,
    Object? tournamentId = freezed,
    Object? matchId = freezed,
    Object? roundId = freezed,
    Object? initiatedBy = freezed,
    Object? myTeamId = freezed,
    Object? opponentTeamId = freezed,
    Object? initiatedOn = freezed,
    Object? myGoals = null,
    Object? opponentGoals = null,
    Object? myEtGoals = freezed,
    Object? opponentEtGoals = freezed,
    Object? myPtGoals = freezed,
    Object? opponentPtGoals = freezed,
    Object? active = null,
    Object? extraTime = null,
    Object? penalty = null,
    Object? subs = null,
    Object? myPenalty = null,
    Object? opponentPenalty = null,
    Object? myExtraTime = null,
    Object? opponentExtraTime = null,
    Object? acceptStatus = freezed,
    Object? responseTime = null,
    Object? responseBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gameSemiType: freezed == gameSemiType
          ? _value.gameSemiType
          : gameSemiType // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      initiatedBy: freezed == initiatedBy
          ? _value.initiatedBy
          : initiatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamId: freezed == myTeamId
          ? _value.myTeamId
          : myTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamId: freezed == opponentTeamId
          ? _value.opponentTeamId
          : opponentTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      initiatedOn: freezed == initiatedOn
          ? _value.initiatedOn
          : initiatedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      myGoals: null == myGoals
          ? _value.myGoals
          : myGoals // ignore: cast_nullable_to_non_nullable
              as int,
      opponentGoals: null == opponentGoals
          ? _value.opponentGoals
          : opponentGoals // ignore: cast_nullable_to_non_nullable
              as int,
      myEtGoals: freezed == myEtGoals
          ? _value.myEtGoals
          : myEtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentEtGoals: freezed == opponentEtGoals
          ? _value.opponentEtGoals
          : opponentEtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      myPtGoals: freezed == myPtGoals
          ? _value.myPtGoals
          : myPtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentPtGoals: freezed == opponentPtGoals
          ? _value.opponentPtGoals
          : opponentPtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTime: null == extraTime
          ? _value.extraTime
          : extraTime // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      penalty: null == penalty
          ? _value.penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      subs: null == subs
          ? _value.subs
          : subs // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      myPenalty: null == myPenalty
          ? _value.myPenalty
          : myPenalty // ignore: cast_nullable_to_non_nullable
              as int,
      opponentPenalty: null == opponentPenalty
          ? _value.opponentPenalty
          : opponentPenalty // ignore: cast_nullable_to_non_nullable
              as int,
      myExtraTime: null == myExtraTime
          ? _value.myExtraTime
          : myExtraTime // ignore: cast_nullable_to_non_nullable
              as int,
      opponentExtraTime: null == opponentExtraTime
          ? _value.opponentExtraTime
          : opponentExtraTime // ignore: cast_nullable_to_non_nullable
              as int,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      responseBy: freezed == responseBy
          ? _value.responseBy
          : responseBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMatchScoreModelImplCopyWith<$Res>
    implements $TeamMatchScoreModelCopyWith<$Res> {
  factory _$$TeamMatchScoreModelImplCopyWith(_$TeamMatchScoreModelImpl value,
          $Res Function(_$TeamMatchScoreModelImpl) then) =
      __$$TeamMatchScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? gameType,
      String? gameSemiType,
      String? tournamentId,
      String? matchId,
      String? roundId,
      String? initiatedBy,
      String? myTeamId,
      String? opponentTeamId,
      int? initiatedOn,
      int myGoals,
      int opponentGoals,
      int? myEtGoals,
      int? opponentEtGoals,
      int? myPtGoals,
      int? opponentPtGoals,
      bool active,
      List<dynamic> extraTime,
      List<dynamic> penalty,
      List<dynamic> subs,
      int myPenalty,
      int opponentPenalty,
      int myExtraTime,
      int opponentExtraTime,
      String? acceptStatus,
      int responseTime,
      String? responseBy});
}

/// @nodoc
class __$$TeamMatchScoreModelImplCopyWithImpl<$Res>
    extends _$TeamMatchScoreModelCopyWithImpl<$Res, _$TeamMatchScoreModelImpl>
    implements _$$TeamMatchScoreModelImplCopyWith<$Res> {
  __$$TeamMatchScoreModelImplCopyWithImpl(_$TeamMatchScoreModelImpl _value,
      $Res Function(_$TeamMatchScoreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gameType = freezed,
    Object? gameSemiType = freezed,
    Object? tournamentId = freezed,
    Object? matchId = freezed,
    Object? roundId = freezed,
    Object? initiatedBy = freezed,
    Object? myTeamId = freezed,
    Object? opponentTeamId = freezed,
    Object? initiatedOn = freezed,
    Object? myGoals = null,
    Object? opponentGoals = null,
    Object? myEtGoals = freezed,
    Object? opponentEtGoals = freezed,
    Object? myPtGoals = freezed,
    Object? opponentPtGoals = freezed,
    Object? active = null,
    Object? extraTime = null,
    Object? penalty = null,
    Object? subs = null,
    Object? myPenalty = null,
    Object? opponentPenalty = null,
    Object? myExtraTime = null,
    Object? opponentExtraTime = null,
    Object? acceptStatus = freezed,
    Object? responseTime = null,
    Object? responseBy = freezed,
  }) {
    return _then(_$TeamMatchScoreModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gameSemiType: freezed == gameSemiType
          ? _value.gameSemiType
          : gameSemiType // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      initiatedBy: freezed == initiatedBy
          ? _value.initiatedBy
          : initiatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      myTeamId: freezed == myTeamId
          ? _value.myTeamId
          : myTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      opponentTeamId: freezed == opponentTeamId
          ? _value.opponentTeamId
          : opponentTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      initiatedOn: freezed == initiatedOn
          ? _value.initiatedOn
          : initiatedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      myGoals: null == myGoals
          ? _value.myGoals
          : myGoals // ignore: cast_nullable_to_non_nullable
              as int,
      opponentGoals: null == opponentGoals
          ? _value.opponentGoals
          : opponentGoals // ignore: cast_nullable_to_non_nullable
              as int,
      myEtGoals: freezed == myEtGoals
          ? _value.myEtGoals
          : myEtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentEtGoals: freezed == opponentEtGoals
          ? _value.opponentEtGoals
          : opponentEtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      myPtGoals: freezed == myPtGoals
          ? _value.myPtGoals
          : myPtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentPtGoals: freezed == opponentPtGoals
          ? _value.opponentPtGoals
          : opponentPtGoals // ignore: cast_nullable_to_non_nullable
              as int?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      extraTime: null == extraTime
          ? _value._extraTime
          : extraTime // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      penalty: null == penalty
          ? _value._penalty
          : penalty // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      subs: null == subs
          ? _value._subs
          : subs // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      myPenalty: null == myPenalty
          ? _value.myPenalty
          : myPenalty // ignore: cast_nullable_to_non_nullable
              as int,
      opponentPenalty: null == opponentPenalty
          ? _value.opponentPenalty
          : opponentPenalty // ignore: cast_nullable_to_non_nullable
              as int,
      myExtraTime: null == myExtraTime
          ? _value.myExtraTime
          : myExtraTime // ignore: cast_nullable_to_non_nullable
              as int,
      opponentExtraTime: null == opponentExtraTime
          ? _value.opponentExtraTime
          : opponentExtraTime // ignore: cast_nullable_to_non_nullable
              as int,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTime: null == responseTime
          ? _value.responseTime
          : responseTime // ignore: cast_nullable_to_non_nullable
              as int,
      responseBy: freezed == responseBy
          ? _value.responseBy
          : responseBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMatchScoreModelImpl implements _TeamMatchScoreModel {
  const _$TeamMatchScoreModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.gameType,
      this.gameSemiType,
      this.tournamentId,
      this.matchId,
      this.roundId,
      this.initiatedBy,
      this.myTeamId,
      this.opponentTeamId,
      this.initiatedOn,
      this.myGoals = 0,
      this.opponentGoals = 0,
      this.myEtGoals,
      this.opponentEtGoals,
      this.myPtGoals,
      this.opponentPtGoals,
      this.active = false,
      final List<dynamic> extraTime = const [],
      final List<dynamic> penalty = const [],
      final List<dynamic> subs = const [],
      this.myPenalty = 0,
      this.opponentPenalty = 0,
      this.myExtraTime = 0,
      this.opponentExtraTime = 0,
      this.acceptStatus,
      this.responseTime = 0,
      this.responseBy})
      : _extraTime = extraTime,
        _penalty = penalty,
        _subs = subs;

  factory _$TeamMatchScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchScoreModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? gameType;
  @override
  final String? gameSemiType;
  @override
  final String? tournamentId;
  @override
  final String? matchId;
  @override
  final String? roundId;
  @override
  final String? initiatedBy;
  @override
  final String? myTeamId;
  @override
  final String? opponentTeamId;
  @override
  final int? initiatedOn;
  @override
  @JsonKey()
  final int myGoals;
  @override
  @JsonKey()
  final int opponentGoals;
  @override
  final int? myEtGoals;
  @override
  final int? opponentEtGoals;
  @override
  final int? myPtGoals;
  @override
  final int? opponentPtGoals;
  @override
  @JsonKey()
  final bool active;
  final List<dynamic> _extraTime;
  @override
  @JsonKey()
  List<dynamic> get extraTime {
    if (_extraTime is EqualUnmodifiableListView) return _extraTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extraTime);
  }

  final List<dynamic> _penalty;
  @override
  @JsonKey()
  List<dynamic> get penalty {
    if (_penalty is EqualUnmodifiableListView) return _penalty;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_penalty);
  }

  final List<dynamic> _subs;
  @override
  @JsonKey()
  List<dynamic> get subs {
    if (_subs is EqualUnmodifiableListView) return _subs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subs);
  }

  @override
  @JsonKey()
  final int myPenalty;
  @override
  @JsonKey()
  final int opponentPenalty;
  @override
  @JsonKey()
  final int myExtraTime;
  @override
  @JsonKey()
  final int opponentExtraTime;
  @override
  final String? acceptStatus;
  @override
  @JsonKey()
  final int responseTime;
  @override
  final String? responseBy;

  @override
  String toString() {
    return 'TeamMatchScoreModel(id: $id, gameType: $gameType, gameSemiType: $gameSemiType, tournamentId: $tournamentId, matchId: $matchId, roundId: $roundId, initiatedBy: $initiatedBy, myTeamId: $myTeamId, opponentTeamId: $opponentTeamId, initiatedOn: $initiatedOn, myGoals: $myGoals, opponentGoals: $opponentGoals, myEtGoals: $myEtGoals, opponentEtGoals: $opponentEtGoals, myPtGoals: $myPtGoals, opponentPtGoals: $opponentPtGoals, active: $active, extraTime: $extraTime, penalty: $penalty, subs: $subs, myPenalty: $myPenalty, opponentPenalty: $opponentPenalty, myExtraTime: $myExtraTime, opponentExtraTime: $opponentExtraTime, acceptStatus: $acceptStatus, responseTime: $responseTime, responseBy: $responseBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchScoreModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.gameSemiType, gameSemiType) ||
                other.gameSemiType == gameSemiType) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.initiatedBy, initiatedBy) ||
                other.initiatedBy == initiatedBy) &&
            (identical(other.myTeamId, myTeamId) ||
                other.myTeamId == myTeamId) &&
            (identical(other.opponentTeamId, opponentTeamId) ||
                other.opponentTeamId == opponentTeamId) &&
            (identical(other.initiatedOn, initiatedOn) ||
                other.initiatedOn == initiatedOn) &&
            (identical(other.myGoals, myGoals) || other.myGoals == myGoals) &&
            (identical(other.opponentGoals, opponentGoals) ||
                other.opponentGoals == opponentGoals) &&
            (identical(other.myEtGoals, myEtGoals) ||
                other.myEtGoals == myEtGoals) &&
            (identical(other.opponentEtGoals, opponentEtGoals) ||
                other.opponentEtGoals == opponentEtGoals) &&
            (identical(other.myPtGoals, myPtGoals) ||
                other.myPtGoals == myPtGoals) &&
            (identical(other.opponentPtGoals, opponentPtGoals) ||
                other.opponentPtGoals == opponentPtGoals) &&
            (identical(other.active, active) || other.active == active) &&
            const DeepCollectionEquality()
                .equals(other._extraTime, _extraTime) &&
            const DeepCollectionEquality().equals(other._penalty, _penalty) &&
            const DeepCollectionEquality().equals(other._subs, _subs) &&
            (identical(other.myPenalty, myPenalty) ||
                other.myPenalty == myPenalty) &&
            (identical(other.opponentPenalty, opponentPenalty) ||
                other.opponentPenalty == opponentPenalty) &&
            (identical(other.myExtraTime, myExtraTime) ||
                other.myExtraTime == myExtraTime) &&
            (identical(other.opponentExtraTime, opponentExtraTime) ||
                other.opponentExtraTime == opponentExtraTime) &&
            (identical(other.acceptStatus, acceptStatus) ||
                other.acceptStatus == acceptStatus) &&
            (identical(other.responseTime, responseTime) ||
                other.responseTime == responseTime) &&
            (identical(other.responseBy, responseBy) ||
                other.responseBy == responseBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        gameType,
        gameSemiType,
        tournamentId,
        matchId,
        roundId,
        initiatedBy,
        myTeamId,
        opponentTeamId,
        initiatedOn,
        myGoals,
        opponentGoals,
        myEtGoals,
        opponentEtGoals,
        myPtGoals,
        opponentPtGoals,
        active,
        const DeepCollectionEquality().hash(_extraTime),
        const DeepCollectionEquality().hash(_penalty),
        const DeepCollectionEquality().hash(_subs),
        myPenalty,
        opponentPenalty,
        myExtraTime,
        opponentExtraTime,
        acceptStatus,
        responseTime,
        responseBy
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMatchScoreModelImplCopyWith<_$TeamMatchScoreModelImpl> get copyWith =>
      __$$TeamMatchScoreModelImplCopyWithImpl<_$TeamMatchScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMatchScoreModelImplToJson(
      this,
    );
  }
}

abstract class _TeamMatchScoreModel implements TeamMatchScoreModel {
  const factory _TeamMatchScoreModel(
      {@JsonKey(name: '_id') final String? id,
      final String? gameType,
      final String? gameSemiType,
      final String? tournamentId,
      final String? matchId,
      final String? roundId,
      final String? initiatedBy,
      final String? myTeamId,
      final String? opponentTeamId,
      final int? initiatedOn,
      final int myGoals,
      final int opponentGoals,
      final int? myEtGoals,
      final int? opponentEtGoals,
      final int? myPtGoals,
      final int? opponentPtGoals,
      final bool active,
      final List<dynamic> extraTime,
      final List<dynamic> penalty,
      final List<dynamic> subs,
      final int myPenalty,
      final int opponentPenalty,
      final int myExtraTime,
      final int opponentExtraTime,
      final String? acceptStatus,
      final int responseTime,
      final String? responseBy}) = _$TeamMatchScoreModelImpl;

  factory _TeamMatchScoreModel.fromJson(Map<String, dynamic> json) =
      _$TeamMatchScoreModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get gameType;
  @override
  String? get gameSemiType;
  @override
  String? get tournamentId;
  @override
  String? get matchId;
  @override
  String? get roundId;
  @override
  String? get initiatedBy;
  @override
  String? get myTeamId;
  @override
  String? get opponentTeamId;
  @override
  int? get initiatedOn;
  @override
  int get myGoals;
  @override
  int get opponentGoals;
  @override
  int? get myEtGoals;
  @override
  int? get opponentEtGoals;
  @override
  int? get myPtGoals;
  @override
  int? get opponentPtGoals;
  @override
  bool get active;
  @override
  List<dynamic> get extraTime;
  @override
  List<dynamic> get penalty;
  @override
  List<dynamic> get subs;
  @override
  int get myPenalty;
  @override
  int get opponentPenalty;
  @override
  int get myExtraTime;
  @override
  int get opponentExtraTime;
  @override
  String? get acceptStatus;
  @override
  int get responseTime;
  @override
  String? get responseBy;
  @override
  @JsonKey(ignore: true)
  _$$TeamMatchScoreModelImplCopyWith<_$TeamMatchScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
