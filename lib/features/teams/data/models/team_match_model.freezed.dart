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
  String? get matchId => throw _privateConstructorUsedError;
  String? get matchDate => throw _privateConstructorUsedError;
  String? get matchTime => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
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
      {String? matchId,
      String? matchDate,
      String? matchTime,
      String? gameType,
      String? country,
      String? city,
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
    Object? matchId = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? gameType = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? teams = null,
    Object? score = freezed,
  }) {
    return _then(_value.copyWith(
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String? matchId,
      String? matchDate,
      String? matchTime,
      String? gameType,
      String? country,
      String? city,
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
    Object? matchId = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? gameType = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? teams = null,
    Object? score = freezed,
  }) {
    return _then(_$TeamMatchModelImpl(
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {this.matchId,
      this.matchDate,
      this.matchTime,
      this.gameType,
      this.country,
      this.city,
      final List<TeamMatchTeamModel> teams = const [],
      this.score})
      : _teams = teams;

  factory _$TeamMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchModelImplFromJson(json);

  @override
  final String? matchId;
  @override
  final String? matchDate;
  @override
  final String? matchTime;
  @override
  final String? gameType;
  @override
  final String? country;
  @override
  final String? city;
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
    return 'TeamMatchModel(matchId: $matchId, matchDate: $matchDate, matchTime: $matchTime, gameType: $gameType, country: $country, city: $city, teams: $teams, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchModelImpl &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      matchId,
      matchDate,
      matchTime,
      gameType,
      country,
      city,
      const DeepCollectionEquality().hash(_teams),
      score);

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
      {final String? matchId,
      final String? matchDate,
      final String? matchTime,
      final String? gameType,
      final String? country,
      final String? city,
      final List<TeamMatchTeamModel> teams,
      final TeamMatchScoreModel? score}) = _$TeamMatchModelImpl;

  factory _TeamMatchModel.fromJson(Map<String, dynamic> json) =
      _$TeamMatchModelImpl.fromJson;

  @override
  String? get matchId;
  @override
  String? get matchDate;
  @override
  String? get matchTime;
  @override
  String? get gameType;
  @override
  String? get country;
  @override
  String? get city;
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
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamShortName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get teamImage => throw _privateConstructorUsedError;

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
      {String? teamId,
      String? teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage});
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
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
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
      teamImage: freezed == teamImage
          ? _value.teamImage
          : teamImage // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String? teamId,
      String? teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage});
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
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
  }) {
    return _then(_$TeamMatchTeamModelImpl(
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
      teamImage: freezed == teamImage
          ? _value.teamImage
          : teamImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMatchTeamModelImpl implements _TeamMatchTeamModel {
  const _$TeamMatchTeamModelImpl(
      {this.teamId,
      this.teamName,
      this.teamShortName,
      @JsonKey(name: 'imageUrl') this.teamImage});

  factory _$TeamMatchTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchTeamModelImplFromJson(json);

  @override
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? teamShortName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? teamImage;

  @override
  String toString() {
    return 'TeamMatchTeamModel(teamId: $teamId, teamName: $teamName, teamShortName: $teamShortName, teamImage: $teamImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchTeamModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamShortName, teamShortName) ||
                other.teamShortName == teamShortName) &&
            (identical(other.teamImage, teamImage) ||
                other.teamImage == teamImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, teamId, teamName, teamShortName, teamImage);

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
          {final String? teamId,
          final String? teamName,
          final String? teamShortName,
          @JsonKey(name: 'imageUrl') final String? teamImage}) =
      _$TeamMatchTeamModelImpl;

  factory _TeamMatchTeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamMatchTeamModelImpl.fromJson;

  @override
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get teamShortName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get teamImage;
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
  int get team1 => throw _privateConstructorUsedError;
  int get team2 => throw _privateConstructorUsedError;

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
  $Res call({int team1, int team2});
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
    Object? team1 = null,
    Object? team2 = null,
  }) {
    return _then(_value.copyWith(
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as int,
      team2: null == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int team1, int team2});
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
    Object? team1 = null,
    Object? team2 = null,
  }) {
    return _then(_$TeamMatchScoreModelImpl(
      team1: null == team1
          ? _value.team1
          : team1 // ignore: cast_nullable_to_non_nullable
              as int,
      team2: null == team2
          ? _value.team2
          : team2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMatchScoreModelImpl implements _TeamMatchScoreModel {
  const _$TeamMatchScoreModelImpl({this.team1 = 0, this.team2 = 0});

  factory _$TeamMatchScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMatchScoreModelImplFromJson(json);

  @override
  @JsonKey()
  final int team1;
  @override
  @JsonKey()
  final int team2;

  @override
  String toString() {
    return 'TeamMatchScoreModel(team1: $team1, team2: $team2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMatchScoreModelImpl &&
            (identical(other.team1, team1) || other.team1 == team1) &&
            (identical(other.team2, team2) || other.team2 == team2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, team1, team2);

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
  const factory _TeamMatchScoreModel({final int team1, final int team2}) =
      _$TeamMatchScoreModelImpl;

  factory _TeamMatchScoreModel.fromJson(Map<String, dynamic> json) =
      _$TeamMatchScoreModelImpl.fromJson;

  @override
  int get team1;
  @override
  int get team2;
  @override
  @JsonKey(ignore: true)
  _$$TeamMatchScoreModelImplCopyWith<_$TeamMatchScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
