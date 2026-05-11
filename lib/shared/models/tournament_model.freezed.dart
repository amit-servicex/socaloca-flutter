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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'upcoming', 'ongoing', 'closed'
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get organizerId => throw _privateConstructorUsedError;
  String? get organizerName => throw _privateConstructorUsedError;
  int get teamsCount => throw _privateConstructorUsedError;
  bool get isFollowing => throw _privateConstructorUsedError;
  String? get format =>
      throw _privateConstructorUsedError; // 'league', 'cup_group', 'cup_knockout'
  String? get description => throw _privateConstructorUsedError;

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
      {String id,
      String name,
      String? logo,
      String? coverImage,
      String? status,
      String? startDate,
      String? endDate,
      String? country,
      String? city,
      String? organizerId,
      String? organizerName,
      int teamsCount,
      bool isFollowing,
      String? format,
      String? description});
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
    Object? id = null,
    Object? name = null,
    Object? logo = freezed,
    Object? coverImage = freezed,
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? organizerId = freezed,
    Object? organizerName = freezed,
    Object? teamsCount = null,
    Object? isFollowing = null,
    Object? format = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerName: freezed == organizerName
          ? _value.organizerName
          : organizerName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamsCount: null == teamsCount
          ? _value.teamsCount
          : teamsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
      {String id,
      String name,
      String? logo,
      String? coverImage,
      String? status,
      String? startDate,
      String? endDate,
      String? country,
      String? city,
      String? organizerId,
      String? organizerName,
      int teamsCount,
      bool isFollowing,
      String? format,
      String? description});
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
    Object? id = null,
    Object? name = null,
    Object? logo = freezed,
    Object? coverImage = freezed,
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? organizerId = freezed,
    Object? organizerName = freezed,
    Object? teamsCount = null,
    Object? isFollowing = null,
    Object? format = freezed,
    Object? description = freezed,
  }) {
    return _then(_$TournamentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerName: freezed == organizerName
          ? _value.organizerName
          : organizerName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamsCount: null == teamsCount
          ? _value.teamsCount
          : teamsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      format: freezed == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentModelImpl implements _TournamentModel {
  const _$TournamentModelImpl(
      {required this.id,
      required this.name,
      this.logo,
      this.coverImage,
      this.status,
      this.startDate,
      this.endDate,
      this.country,
      this.city,
      this.organizerId,
      this.organizerName,
      this.teamsCount = 0,
      this.isFollowing = false,
      this.format,
      this.description});

  factory _$TournamentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? logo;
  @override
  final String? coverImage;
  @override
  final String? status;
// 'upcoming', 'ongoing', 'closed'
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? organizerId;
  @override
  final String? organizerName;
  @override
  @JsonKey()
  final int teamsCount;
  @override
  @JsonKey()
  final bool isFollowing;
  @override
  final String? format;
// 'league', 'cup_group', 'cup_knockout'
  @override
  final String? description;

  @override
  String toString() {
    return 'TournamentModel(id: $id, name: $name, logo: $logo, coverImage: $coverImage, status: $status, startDate: $startDate, endDate: $endDate, country: $country, city: $city, organizerId: $organizerId, organizerName: $organizerName, teamsCount: $teamsCount, isFollowing: $isFollowing, format: $format, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.organizerName, organizerName) ||
                other.organizerName == organizerName) &&
            (identical(other.teamsCount, teamsCount) ||
                other.teamsCount == teamsCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      logo,
      coverImage,
      status,
      startDate,
      endDate,
      country,
      city,
      organizerId,
      organizerName,
      teamsCount,
      isFollowing,
      format,
      description);

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
      {required final String id,
      required final String name,
      final String? logo,
      final String? coverImage,
      final String? status,
      final String? startDate,
      final String? endDate,
      final String? country,
      final String? city,
      final String? organizerId,
      final String? organizerName,
      final int teamsCount,
      final bool isFollowing,
      final String? format,
      final String? description}) = _$TournamentModelImpl;

  factory _TournamentModel.fromJson(Map<String, dynamic> json) =
      _$TournamentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get logo;
  @override
  String? get coverImage;
  @override
  String? get status;
  @override // 'upcoming', 'ongoing', 'closed'
  String? get startDate;
  @override
  String? get endDate;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get organizerId;
  @override
  String? get organizerName;
  @override
  int get teamsCount;
  @override
  bool get isFollowing;
  @override
  String? get format;
  @override // 'league', 'cup_group', 'cup_knockout'
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$TournamentModelImplCopyWith<_$TournamentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StandingsRow _$StandingsRowFromJson(Map<String, dynamic> json) {
  return _StandingsRow.fromJson(json);
}

/// @nodoc
mixin _$StandingsRow {
  int get position => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  int get played => throw _privateConstructorUsedError;
  int get won => throw _privateConstructorUsedError;
  int get drawn => throw _privateConstructorUsedError;
  int get lost => throw _privateConstructorUsedError;
  int get goalsFor => throw _privateConstructorUsedError;
  int get goalsAgainst => throw _privateConstructorUsedError;
  int get goalDifference => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StandingsRowCopyWith<StandingsRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandingsRowCopyWith<$Res> {
  factory $StandingsRowCopyWith(
          StandingsRow value, $Res Function(StandingsRow) then) =
      _$StandingsRowCopyWithImpl<$Res, StandingsRow>;
  @useResult
  $Res call(
      {int position,
      String teamId,
      String teamName,
      String? teamLogo,
      int played,
      int won,
      int drawn,
      int lost,
      int goalsFor,
      int goalsAgainst,
      int goalDifference,
      int points});
}

/// @nodoc
class _$StandingsRowCopyWithImpl<$Res, $Val extends StandingsRow>
    implements $StandingsRowCopyWith<$Res> {
  _$StandingsRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? teamId = null,
    Object? teamName = null,
    Object? teamLogo = freezed,
    Object? played = null,
    Object? won = null,
    Object? drawn = null,
    Object? lost = null,
    Object? goalsFor = null,
    Object? goalsAgainst = null,
    Object? goalDifference = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      played: null == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as int,
      won: null == won
          ? _value.won
          : won // ignore: cast_nullable_to_non_nullable
              as int,
      drawn: null == drawn
          ? _value.drawn
          : drawn // ignore: cast_nullable_to_non_nullable
              as int,
      lost: null == lost
          ? _value.lost
          : lost // ignore: cast_nullable_to_non_nullable
              as int,
      goalsFor: null == goalsFor
          ? _value.goalsFor
          : goalsFor // ignore: cast_nullable_to_non_nullable
              as int,
      goalsAgainst: null == goalsAgainst
          ? _value.goalsAgainst
          : goalsAgainst // ignore: cast_nullable_to_non_nullable
              as int,
      goalDifference: null == goalDifference
          ? _value.goalDifference
          : goalDifference // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StandingsRowImplCopyWith<$Res>
    implements $StandingsRowCopyWith<$Res> {
  factory _$$StandingsRowImplCopyWith(
          _$StandingsRowImpl value, $Res Function(_$StandingsRowImpl) then) =
      __$$StandingsRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int position,
      String teamId,
      String teamName,
      String? teamLogo,
      int played,
      int won,
      int drawn,
      int lost,
      int goalsFor,
      int goalsAgainst,
      int goalDifference,
      int points});
}

/// @nodoc
class __$$StandingsRowImplCopyWithImpl<$Res>
    extends _$StandingsRowCopyWithImpl<$Res, _$StandingsRowImpl>
    implements _$$StandingsRowImplCopyWith<$Res> {
  __$$StandingsRowImplCopyWithImpl(
      _$StandingsRowImpl _value, $Res Function(_$StandingsRowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? teamId = null,
    Object? teamName = null,
    Object? teamLogo = freezed,
    Object? played = null,
    Object? won = null,
    Object? drawn = null,
    Object? lost = null,
    Object? goalsFor = null,
    Object? goalsAgainst = null,
    Object? goalDifference = null,
    Object? points = null,
  }) {
    return _then(_$StandingsRowImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      played: null == played
          ? _value.played
          : played // ignore: cast_nullable_to_non_nullable
              as int,
      won: null == won
          ? _value.won
          : won // ignore: cast_nullable_to_non_nullable
              as int,
      drawn: null == drawn
          ? _value.drawn
          : drawn // ignore: cast_nullable_to_non_nullable
              as int,
      lost: null == lost
          ? _value.lost
          : lost // ignore: cast_nullable_to_non_nullable
              as int,
      goalsFor: null == goalsFor
          ? _value.goalsFor
          : goalsFor // ignore: cast_nullable_to_non_nullable
              as int,
      goalsAgainst: null == goalsAgainst
          ? _value.goalsAgainst
          : goalsAgainst // ignore: cast_nullable_to_non_nullable
              as int,
      goalDifference: null == goalDifference
          ? _value.goalDifference
          : goalDifference // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StandingsRowImpl implements _StandingsRow {
  const _$StandingsRowImpl(
      {required this.position,
      required this.teamId,
      required this.teamName,
      this.teamLogo,
      this.played = 0,
      this.won = 0,
      this.drawn = 0,
      this.lost = 0,
      this.goalsFor = 0,
      this.goalsAgainst = 0,
      this.goalDifference = 0,
      this.points = 0});

  factory _$StandingsRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandingsRowImplFromJson(json);

  @override
  final int position;
  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final String? teamLogo;
  @override
  @JsonKey()
  final int played;
  @override
  @JsonKey()
  final int won;
  @override
  @JsonKey()
  final int drawn;
  @override
  @JsonKey()
  final int lost;
  @override
  @JsonKey()
  final int goalsFor;
  @override
  @JsonKey()
  final int goalsAgainst;
  @override
  @JsonKey()
  final int goalDifference;
  @override
  @JsonKey()
  final int points;

  @override
  String toString() {
    return 'StandingsRow(position: $position, teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, played: $played, won: $won, drawn: $drawn, lost: $lost, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, goalDifference: $goalDifference, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandingsRowImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.played, played) || other.played == played) &&
            (identical(other.won, won) || other.won == won) &&
            (identical(other.drawn, drawn) || other.drawn == drawn) &&
            (identical(other.lost, lost) || other.lost == lost) &&
            (identical(other.goalsFor, goalsFor) ||
                other.goalsFor == goalsFor) &&
            (identical(other.goalsAgainst, goalsAgainst) ||
                other.goalsAgainst == goalsAgainst) &&
            (identical(other.goalDifference, goalDifference) ||
                other.goalDifference == goalDifference) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      position,
      teamId,
      teamName,
      teamLogo,
      played,
      won,
      drawn,
      lost,
      goalsFor,
      goalsAgainst,
      goalDifference,
      points);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StandingsRowImplCopyWith<_$StandingsRowImpl> get copyWith =>
      __$$StandingsRowImplCopyWithImpl<_$StandingsRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandingsRowImplToJson(
      this,
    );
  }
}

abstract class _StandingsRow implements StandingsRow {
  const factory _StandingsRow(
      {required final int position,
      required final String teamId,
      required final String teamName,
      final String? teamLogo,
      final int played,
      final int won,
      final int drawn,
      final int lost,
      final int goalsFor,
      final int goalsAgainst,
      final int goalDifference,
      final int points}) = _$StandingsRowImpl;

  factory _StandingsRow.fromJson(Map<String, dynamic> json) =
      _$StandingsRowImpl.fromJson;

  @override
  int get position;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  String? get teamLogo;
  @override
  int get played;
  @override
  int get won;
  @override
  int get drawn;
  @override
  int get lost;
  @override
  int get goalsFor;
  @override
  int get goalsAgainst;
  @override
  int get goalDifference;
  @override
  int get points;
  @override
  @JsonKey(ignore: true)
  _$$StandingsRowImplCopyWith<_$StandingsRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrialModel _$TrialModelFromJson(Map<String, dynamic> json) {
  return _TrialModel.fromJson(json);
}

/// @nodoc
mixin _$TrialModel {
  String get id => throw _privateConstructorUsedError;
  String get organizerId => throw _privateConstructorUsedError;
  String get organizerName => throw _privateConstructorUsedError;
  String? get organizerLogo => throw _privateConstructorUsedError;
  String? get organizerType =>
      throw _privateConstructorUsedError; // 'club', 'academy', 'fa'
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get trialDate => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  bool get isRegistered => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrialModelCopyWith<TrialModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrialModelCopyWith<$Res> {
  factory $TrialModelCopyWith(
          TrialModel value, $Res Function(TrialModel) then) =
      _$TrialModelCopyWithImpl<$Res, TrialModel>;
  @useResult
  $Res call(
      {String id,
      String organizerId,
      String organizerName,
      String? organizerLogo,
      String? organizerType,
      String title,
      String? description,
      String? trialDate,
      String? venue,
      String? country,
      String? ageGroup,
      String? position,
      bool isRegistered});
}

/// @nodoc
class _$TrialModelCopyWithImpl<$Res, $Val extends TrialModel>
    implements $TrialModelCopyWith<$Res> {
  _$TrialModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizerId = null,
    Object? organizerName = null,
    Object? organizerLogo = freezed,
    Object? organizerType = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? trialDate = freezed,
    Object? venue = freezed,
    Object? country = freezed,
    Object? ageGroup = freezed,
    Object? position = freezed,
    Object? isRegistered = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizerId: null == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizerName: null == organizerName
          ? _value.organizerName
          : organizerName // ignore: cast_nullable_to_non_nullable
              as String,
      organizerLogo: freezed == organizerLogo
          ? _value.organizerLogo
          : organizerLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerType: freezed == organizerType
          ? _value.organizerType
          : organizerType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      trialDate: freezed == trialDate
          ? _value.trialDate
          : trialDate // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      isRegistered: null == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrialModelImplCopyWith<$Res>
    implements $TrialModelCopyWith<$Res> {
  factory _$$TrialModelImplCopyWith(
          _$TrialModelImpl value, $Res Function(_$TrialModelImpl) then) =
      __$$TrialModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizerId,
      String organizerName,
      String? organizerLogo,
      String? organizerType,
      String title,
      String? description,
      String? trialDate,
      String? venue,
      String? country,
      String? ageGroup,
      String? position,
      bool isRegistered});
}

/// @nodoc
class __$$TrialModelImplCopyWithImpl<$Res>
    extends _$TrialModelCopyWithImpl<$Res, _$TrialModelImpl>
    implements _$$TrialModelImplCopyWith<$Res> {
  __$$TrialModelImplCopyWithImpl(
      _$TrialModelImpl _value, $Res Function(_$TrialModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizerId = null,
    Object? organizerName = null,
    Object? organizerLogo = freezed,
    Object? organizerType = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? trialDate = freezed,
    Object? venue = freezed,
    Object? country = freezed,
    Object? ageGroup = freezed,
    Object? position = freezed,
    Object? isRegistered = null,
  }) {
    return _then(_$TrialModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizerId: null == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String,
      organizerName: null == organizerName
          ? _value.organizerName
          : organizerName // ignore: cast_nullable_to_non_nullable
              as String,
      organizerLogo: freezed == organizerLogo
          ? _value.organizerLogo
          : organizerLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerType: freezed == organizerType
          ? _value.organizerType
          : organizerType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      trialDate: freezed == trialDate
          ? _value.trialDate
          : trialDate // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      isRegistered: null == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrialModelImpl implements _TrialModel {
  const _$TrialModelImpl(
      {required this.id,
      required this.organizerId,
      required this.organizerName,
      this.organizerLogo,
      this.organizerType,
      required this.title,
      this.description,
      this.trialDate,
      this.venue,
      this.country,
      this.ageGroup,
      this.position,
      this.isRegistered = false});

  factory _$TrialModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrialModelImplFromJson(json);

  @override
  final String id;
  @override
  final String organizerId;
  @override
  final String organizerName;
  @override
  final String? organizerLogo;
  @override
  final String? organizerType;
// 'club', 'academy', 'fa'
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? trialDate;
  @override
  final String? venue;
  @override
  final String? country;
  @override
  final String? ageGroup;
  @override
  final String? position;
  @override
  @JsonKey()
  final bool isRegistered;

  @override
  String toString() {
    return 'TrialModel(id: $id, organizerId: $organizerId, organizerName: $organizerName, organizerLogo: $organizerLogo, organizerType: $organizerType, title: $title, description: $description, trialDate: $trialDate, venue: $venue, country: $country, ageGroup: $ageGroup, position: $position, isRegistered: $isRegistered)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrialModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.organizerName, organizerName) ||
                other.organizerName == organizerName) &&
            (identical(other.organizerLogo, organizerLogo) ||
                other.organizerLogo == organizerLogo) &&
            (identical(other.organizerType, organizerType) ||
                other.organizerType == organizerType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.trialDate, trialDate) ||
                other.trialDate == trialDate) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      organizerId,
      organizerName,
      organizerLogo,
      organizerType,
      title,
      description,
      trialDate,
      venue,
      country,
      ageGroup,
      position,
      isRegistered);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrialModelImplCopyWith<_$TrialModelImpl> get copyWith =>
      __$$TrialModelImplCopyWithImpl<_$TrialModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrialModelImplToJson(
      this,
    );
  }
}

abstract class _TrialModel implements TrialModel {
  const factory _TrialModel(
      {required final String id,
      required final String organizerId,
      required final String organizerName,
      final String? organizerLogo,
      final String? organizerType,
      required final String title,
      final String? description,
      final String? trialDate,
      final String? venue,
      final String? country,
      final String? ageGroup,
      final String? position,
      final bool isRegistered}) = _$TrialModelImpl;

  factory _TrialModel.fromJson(Map<String, dynamic> json) =
      _$TrialModelImpl.fromJson;

  @override
  String get id;
  @override
  String get organizerId;
  @override
  String get organizerName;
  @override
  String? get organizerLogo;
  @override
  String? get organizerType;
  @override // 'club', 'academy', 'fa'
  String get title;
  @override
  String? get description;
  @override
  String? get trialDate;
  @override
  String? get venue;
  @override
  String? get country;
  @override
  String? get ageGroup;
  @override
  String? get position;
  @override
  bool get isRegistered;
  @override
  @JsonKey(ignore: true)
  _$$TrialModelImplCopyWith<_$TrialModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
