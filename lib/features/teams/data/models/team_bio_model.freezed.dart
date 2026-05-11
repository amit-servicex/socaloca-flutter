// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_bio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamBioModel _$TeamBioModelFromJson(Map<String, dynamic> json) {
  return _TeamBioModel.fromJson(json);
}

/// @nodoc
mixin _$TeamBioModel {
  TeamDetailsModel get teamDetails => throw _privateConstructorUsedError;
  List<TeamPlayerModel> get players => throw _privateConstructorUsedError;
  List<TeamMatchModel> get recentMatches => throw _privateConstructorUsedError;
  RatingDetailsModel? get ratingDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamBioModelCopyWith<TeamBioModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamBioModelCopyWith<$Res> {
  factory $TeamBioModelCopyWith(
          TeamBioModel value, $Res Function(TeamBioModel) then) =
      _$TeamBioModelCopyWithImpl<$Res, TeamBioModel>;
  @useResult
  $Res call(
      {TeamDetailsModel teamDetails,
      List<TeamPlayerModel> players,
      List<TeamMatchModel> recentMatches,
      RatingDetailsModel? ratingDetails});

  $TeamDetailsModelCopyWith<$Res> get teamDetails;
  $RatingDetailsModelCopyWith<$Res>? get ratingDetails;
}

/// @nodoc
class _$TeamBioModelCopyWithImpl<$Res, $Val extends TeamBioModel>
    implements $TeamBioModelCopyWith<$Res> {
  _$TeamBioModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamDetails = null,
    Object? players = null,
    Object? recentMatches = null,
    Object? ratingDetails = freezed,
  }) {
    return _then(_value.copyWith(
      teamDetails: null == teamDetails
          ? _value.teamDetails
          : teamDetails // ignore: cast_nullable_to_non_nullable
              as TeamDetailsModel,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<TeamPlayerModel>,
      recentMatches: null == recentMatches
          ? _value.recentMatches
          : recentMatches // ignore: cast_nullable_to_non_nullable
              as List<TeamMatchModel>,
      ratingDetails: freezed == ratingDetails
          ? _value.ratingDetails
          : ratingDetails // ignore: cast_nullable_to_non_nullable
              as RatingDetailsModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamDetailsModelCopyWith<$Res> get teamDetails {
    return $TeamDetailsModelCopyWith<$Res>(_value.teamDetails, (value) {
      return _then(_value.copyWith(teamDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RatingDetailsModelCopyWith<$Res>? get ratingDetails {
    if (_value.ratingDetails == null) {
      return null;
    }

    return $RatingDetailsModelCopyWith<$Res>(_value.ratingDetails!, (value) {
      return _then(_value.copyWith(ratingDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamBioModelImplCopyWith<$Res>
    implements $TeamBioModelCopyWith<$Res> {
  factory _$$TeamBioModelImplCopyWith(
          _$TeamBioModelImpl value, $Res Function(_$TeamBioModelImpl) then) =
      __$$TeamBioModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TeamDetailsModel teamDetails,
      List<TeamPlayerModel> players,
      List<TeamMatchModel> recentMatches,
      RatingDetailsModel? ratingDetails});

  @override
  $TeamDetailsModelCopyWith<$Res> get teamDetails;
  @override
  $RatingDetailsModelCopyWith<$Res>? get ratingDetails;
}

/// @nodoc
class __$$TeamBioModelImplCopyWithImpl<$Res>
    extends _$TeamBioModelCopyWithImpl<$Res, _$TeamBioModelImpl>
    implements _$$TeamBioModelImplCopyWith<$Res> {
  __$$TeamBioModelImplCopyWithImpl(
      _$TeamBioModelImpl _value, $Res Function(_$TeamBioModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamDetails = null,
    Object? players = null,
    Object? recentMatches = null,
    Object? ratingDetails = freezed,
  }) {
    return _then(_$TeamBioModelImpl(
      teamDetails: null == teamDetails
          ? _value.teamDetails
          : teamDetails // ignore: cast_nullable_to_non_nullable
              as TeamDetailsModel,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<TeamPlayerModel>,
      recentMatches: null == recentMatches
          ? _value._recentMatches
          : recentMatches // ignore: cast_nullable_to_non_nullable
              as List<TeamMatchModel>,
      ratingDetails: freezed == ratingDetails
          ? _value.ratingDetails
          : ratingDetails // ignore: cast_nullable_to_non_nullable
              as RatingDetailsModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamBioModelImpl implements _TeamBioModel {
  const _$TeamBioModelImpl(
      {required this.teamDetails,
      final List<TeamPlayerModel> players = const [],
      final List<TeamMatchModel> recentMatches = const [],
      this.ratingDetails})
      : _players = players,
        _recentMatches = recentMatches;

  factory _$TeamBioModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamBioModelImplFromJson(json);

  @override
  final TeamDetailsModel teamDetails;
  final List<TeamPlayerModel> _players;
  @override
  @JsonKey()
  List<TeamPlayerModel> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<TeamMatchModel> _recentMatches;
  @override
  @JsonKey()
  List<TeamMatchModel> get recentMatches {
    if (_recentMatches is EqualUnmodifiableListView) return _recentMatches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentMatches);
  }

  @override
  final RatingDetailsModel? ratingDetails;

  @override
  String toString() {
    return 'TeamBioModel(teamDetails: $teamDetails, players: $players, recentMatches: $recentMatches, ratingDetails: $ratingDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamBioModelImpl &&
            (identical(other.teamDetails, teamDetails) ||
                other.teamDetails == teamDetails) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._recentMatches, _recentMatches) &&
            (identical(other.ratingDetails, ratingDetails) ||
                other.ratingDetails == ratingDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teamDetails,
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_recentMatches),
      ratingDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamBioModelImplCopyWith<_$TeamBioModelImpl> get copyWith =>
      __$$TeamBioModelImplCopyWithImpl<_$TeamBioModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamBioModelImplToJson(
      this,
    );
  }
}

abstract class _TeamBioModel implements TeamBioModel {
  const factory _TeamBioModel(
      {required final TeamDetailsModel teamDetails,
      final List<TeamPlayerModel> players,
      final List<TeamMatchModel> recentMatches,
      final RatingDetailsModel? ratingDetails}) = _$TeamBioModelImpl;

  factory _TeamBioModel.fromJson(Map<String, dynamic> json) =
      _$TeamBioModelImpl.fromJson;

  @override
  TeamDetailsModel get teamDetails;
  @override
  List<TeamPlayerModel> get players;
  @override
  List<TeamMatchModel> get recentMatches;
  @override
  RatingDetailsModel? get ratingDetails;
  @override
  @JsonKey(ignore: true)
  _$$TeamBioModelImplCopyWith<_$TeamBioModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamDetailsModel _$TeamDetailsModelFromJson(Map<String, dynamic> json) {
  return _TeamDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$TeamDetailsModel {
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamShortName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get teamImage => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'ageCat')
  String? get ageCategory => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  String? get coachName => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get createdOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamDetailsModelCopyWith<TeamDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamDetailsModelCopyWith<$Res> {
  factory $TeamDetailsModelCopyWith(
          TeamDetailsModel value, $Res Function(TeamDetailsModel) then) =
      _$TeamDetailsModelCopyWithImpl<$Res, TeamDetailsModel>;
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage,
      String? country,
      String? city,
      String? gameType,
      String? gender,
      @JsonKey(name: 'ageCat') String? ageCategory,
      String? ageGroup,
      String? coachName,
      int memberCount,
      double rating,
      int createdOn});
}

/// @nodoc
class _$TeamDetailsModelCopyWithImpl<$Res, $Val extends TeamDetailsModel>
    implements $TeamDetailsModelCopyWith<$Res> {
  _$TeamDetailsModelCopyWithImpl(this._value, this._then);

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
    Object? country = freezed,
    Object? city = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? ageCategory = freezed,
    Object? ageGroup = freezed,
    Object? coachName = freezed,
    Object? memberCount = null,
    Object? rating = null,
    Object? createdOn = null,
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
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      ageCategory: freezed == ageCategory
          ? _value.ageCategory
          : ageCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      coachName: freezed == coachName
          ? _value.coachName
          : coachName // ignore: cast_nullable_to_non_nullable
              as String?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamDetailsModelImplCopyWith<$Res>
    implements $TeamDetailsModelCopyWith<$Res> {
  factory _$$TeamDetailsModelImplCopyWith(_$TeamDetailsModelImpl value,
          $Res Function(_$TeamDetailsModelImpl) then) =
      __$$TeamDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage,
      String? country,
      String? city,
      String? gameType,
      String? gender,
      @JsonKey(name: 'ageCat') String? ageCategory,
      String? ageGroup,
      String? coachName,
      int memberCount,
      double rating,
      int createdOn});
}

/// @nodoc
class __$$TeamDetailsModelImplCopyWithImpl<$Res>
    extends _$TeamDetailsModelCopyWithImpl<$Res, _$TeamDetailsModelImpl>
    implements _$$TeamDetailsModelImplCopyWith<$Res> {
  __$$TeamDetailsModelImplCopyWithImpl(_$TeamDetailsModelImpl _value,
      $Res Function(_$TeamDetailsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? ageCategory = freezed,
    Object? ageGroup = freezed,
    Object? coachName = freezed,
    Object? memberCount = null,
    Object? rating = null,
    Object? createdOn = null,
  }) {
    return _then(_$TeamDetailsModelImpl(
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
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      ageCategory: freezed == ageCategory
          ? _value.ageCategory
          : ageCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      coachName: freezed == coachName
          ? _value.coachName
          : coachName // ignore: cast_nullable_to_non_nullable
              as String?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      createdOn: null == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamDetailsModelImpl implements _TeamDetailsModel {
  const _$TeamDetailsModelImpl(
      {this.teamId,
      this.teamName,
      this.teamShortName,
      @JsonKey(name: 'imageUrl') this.teamImage,
      this.country,
      this.city,
      this.gameType,
      this.gender,
      @JsonKey(name: 'ageCat') this.ageCategory,
      this.ageGroup,
      this.coachName,
      this.memberCount = 0,
      this.rating = 0.0,
      this.createdOn = 0});

  factory _$TeamDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamDetailsModelImplFromJson(json);

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
  final String? country;
  @override
  final String? city;
  @override
  final String? gameType;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'ageCat')
  final String? ageCategory;
  @override
  final String? ageGroup;
  @override
  final String? coachName;
  @override
  @JsonKey()
  final int memberCount;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int createdOn;

  @override
  String toString() {
    return 'TeamDetailsModel(teamId: $teamId, teamName: $teamName, teamShortName: $teamShortName, teamImage: $teamImage, country: $country, city: $city, gameType: $gameType, gender: $gender, ageCategory: $ageCategory, ageGroup: $ageGroup, coachName: $coachName, memberCount: $memberCount, rating: $rating, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamDetailsModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamShortName, teamShortName) ||
                other.teamShortName == teamShortName) &&
            (identical(other.teamImage, teamImage) ||
                other.teamImage == teamImage) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.ageCategory, ageCategory) ||
                other.ageCategory == ageCategory) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.coachName, coachName) ||
                other.coachName == coachName) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teamId,
      teamName,
      teamShortName,
      teamImage,
      country,
      city,
      gameType,
      gender,
      ageCategory,
      ageGroup,
      coachName,
      memberCount,
      rating,
      createdOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamDetailsModelImplCopyWith<_$TeamDetailsModelImpl> get copyWith =>
      __$$TeamDetailsModelImplCopyWithImpl<_$TeamDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _TeamDetailsModel implements TeamDetailsModel {
  const factory _TeamDetailsModel(
      {final String? teamId,
      final String? teamName,
      final String? teamShortName,
      @JsonKey(name: 'imageUrl') final String? teamImage,
      final String? country,
      final String? city,
      final String? gameType,
      final String? gender,
      @JsonKey(name: 'ageCat') final String? ageCategory,
      final String? ageGroup,
      final String? coachName,
      final int memberCount,
      final double rating,
      final int createdOn}) = _$TeamDetailsModelImpl;

  factory _TeamDetailsModel.fromJson(Map<String, dynamic> json) =
      _$TeamDetailsModelImpl.fromJson;

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
  String? get country;
  @override
  String? get city;
  @override
  String? get gameType;
  @override
  String? get gender;
  @override
  @JsonKey(name: 'ageCat')
  String? get ageCategory;
  @override
  String? get ageGroup;
  @override
  String? get coachName;
  @override
  int get memberCount;
  @override
  double get rating;
  @override
  int get createdOn;
  @override
  @JsonKey(ignore: true)
  _$$TeamDetailsModelImplCopyWith<_$TeamDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingDetailsModel _$RatingDetailsModelFromJson(Map<String, dynamic> json) {
  return _RatingDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$RatingDetailsModel {
  @JsonKey(name: 'avgTeamWork')
  int get teamWork => throw _privateConstructorUsedError;
  @JsonKey(name: 'avgTechnical')
  int get technical => throw _privateConstructorUsedError;
  @JsonKey(name: 'avgAggressiveness')
  int get aggressiveness => throw _privateConstructorUsedError;
  @JsonKey(name: 'avgTactical')
  int get tactical => throw _privateConstructorUsedError;
  @JsonKey(name: 'avgOverall')
  int get overall => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatingDetailsModelCopyWith<RatingDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingDetailsModelCopyWith<$Res> {
  factory $RatingDetailsModelCopyWith(
          RatingDetailsModel value, $Res Function(RatingDetailsModel) then) =
      _$RatingDetailsModelCopyWithImpl<$Res, RatingDetailsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'avgTeamWork') int teamWork,
      @JsonKey(name: 'avgTechnical') int technical,
      @JsonKey(name: 'avgAggressiveness') int aggressiveness,
      @JsonKey(name: 'avgTactical') int tactical,
      @JsonKey(name: 'avgOverall') int overall});
}

/// @nodoc
class _$RatingDetailsModelCopyWithImpl<$Res, $Val extends RatingDetailsModel>
    implements $RatingDetailsModelCopyWith<$Res> {
  _$RatingDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamWork = null,
    Object? technical = null,
    Object? aggressiveness = null,
    Object? tactical = null,
    Object? overall = null,
  }) {
    return _then(_value.copyWith(
      teamWork: null == teamWork
          ? _value.teamWork
          : teamWork // ignore: cast_nullable_to_non_nullable
              as int,
      technical: null == technical
          ? _value.technical
          : technical // ignore: cast_nullable_to_non_nullable
              as int,
      aggressiveness: null == aggressiveness
          ? _value.aggressiveness
          : aggressiveness // ignore: cast_nullable_to_non_nullable
              as int,
      tactical: null == tactical
          ? _value.tactical
          : tactical // ignore: cast_nullable_to_non_nullable
              as int,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatingDetailsModelImplCopyWith<$Res>
    implements $RatingDetailsModelCopyWith<$Res> {
  factory _$$RatingDetailsModelImplCopyWith(_$RatingDetailsModelImpl value,
          $Res Function(_$RatingDetailsModelImpl) then) =
      __$$RatingDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'avgTeamWork') int teamWork,
      @JsonKey(name: 'avgTechnical') int technical,
      @JsonKey(name: 'avgAggressiveness') int aggressiveness,
      @JsonKey(name: 'avgTactical') int tactical,
      @JsonKey(name: 'avgOverall') int overall});
}

/// @nodoc
class __$$RatingDetailsModelImplCopyWithImpl<$Res>
    extends _$RatingDetailsModelCopyWithImpl<$Res, _$RatingDetailsModelImpl>
    implements _$$RatingDetailsModelImplCopyWith<$Res> {
  __$$RatingDetailsModelImplCopyWithImpl(_$RatingDetailsModelImpl _value,
      $Res Function(_$RatingDetailsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamWork = null,
    Object? technical = null,
    Object? aggressiveness = null,
    Object? tactical = null,
    Object? overall = null,
  }) {
    return _then(_$RatingDetailsModelImpl(
      teamWork: null == teamWork
          ? _value.teamWork
          : teamWork // ignore: cast_nullable_to_non_nullable
              as int,
      technical: null == technical
          ? _value.technical
          : technical // ignore: cast_nullable_to_non_nullable
              as int,
      aggressiveness: null == aggressiveness
          ? _value.aggressiveness
          : aggressiveness // ignore: cast_nullable_to_non_nullable
              as int,
      tactical: null == tactical
          ? _value.tactical
          : tactical // ignore: cast_nullable_to_non_nullable
              as int,
      overall: null == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingDetailsModelImpl implements _RatingDetailsModel {
  const _$RatingDetailsModelImpl(
      {@JsonKey(name: 'avgTeamWork') this.teamWork = 0,
      @JsonKey(name: 'avgTechnical') this.technical = 0,
      @JsonKey(name: 'avgAggressiveness') this.aggressiveness = 0,
      @JsonKey(name: 'avgTactical') this.tactical = 0,
      @JsonKey(name: 'avgOverall') this.overall = 0});

  factory _$RatingDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: 'avgTeamWork')
  final int teamWork;
  @override
  @JsonKey(name: 'avgTechnical')
  final int technical;
  @override
  @JsonKey(name: 'avgAggressiveness')
  final int aggressiveness;
  @override
  @JsonKey(name: 'avgTactical')
  final int tactical;
  @override
  @JsonKey(name: 'avgOverall')
  final int overall;

  @override
  String toString() {
    return 'RatingDetailsModel(teamWork: $teamWork, technical: $technical, aggressiveness: $aggressiveness, tactical: $tactical, overall: $overall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingDetailsModelImpl &&
            (identical(other.teamWork, teamWork) ||
                other.teamWork == teamWork) &&
            (identical(other.technical, technical) ||
                other.technical == technical) &&
            (identical(other.aggressiveness, aggressiveness) ||
                other.aggressiveness == aggressiveness) &&
            (identical(other.tactical, tactical) ||
                other.tactical == tactical) &&
            (identical(other.overall, overall) || other.overall == overall));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, teamWork, technical, aggressiveness, tactical, overall);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingDetailsModelImplCopyWith<_$RatingDetailsModelImpl> get copyWith =>
      __$$RatingDetailsModelImplCopyWithImpl<_$RatingDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _RatingDetailsModel implements RatingDetailsModel {
  const factory _RatingDetailsModel(
          {@JsonKey(name: 'avgTeamWork') final int teamWork,
          @JsonKey(name: 'avgTechnical') final int technical,
          @JsonKey(name: 'avgAggressiveness') final int aggressiveness,
          @JsonKey(name: 'avgTactical') final int tactical,
          @JsonKey(name: 'avgOverall') final int overall}) =
      _$RatingDetailsModelImpl;

  factory _RatingDetailsModel.fromJson(Map<String, dynamic> json) =
      _$RatingDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: 'avgTeamWork')
  int get teamWork;
  @override
  @JsonKey(name: 'avgTechnical')
  int get technical;
  @override
  @JsonKey(name: 'avgAggressiveness')
  int get aggressiveness;
  @override
  @JsonKey(name: 'avgTactical')
  int get tactical;
  @override
  @JsonKey(name: 'avgOverall')
  int get overall;
  @override
  @JsonKey(ignore: true)
  _$$RatingDetailsModelImplCopyWith<_$RatingDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamPlayerModel _$TeamPlayerModelFromJson(Map<String, dynamic> json) {
  return _TeamPlayerModel.fromJson(json);
}

/// @nodoc
mixin _$TeamPlayerModel {
  String? get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get profileImage => throw _privateConstructorUsedError;
  String? get playPosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamJerseyNo')
  String? get jerseyNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamPlayerModelCopyWith<TeamPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamPlayerModelCopyWith<$Res> {
  factory $TeamPlayerModelCopyWith(
          TeamPlayerModel value, $Res Function(TeamPlayerModel) then) =
      _$TeamPlayerModelCopyWithImpl<$Res, TeamPlayerModel>;
  @useResult
  $Res call(
      {String? userId,
      String? firstName,
      String? lastName,
      @JsonKey(name: 'imageUrl') String? profileImage,
      String? playPosition,
      @JsonKey(name: 'teamJerseyNo') String? jerseyNumber});
}

/// @nodoc
class _$TeamPlayerModelCopyWithImpl<$Res, $Val extends TeamPlayerModel>
    implements $TeamPlayerModelCopyWith<$Res> {
  _$TeamPlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? profileImage = freezed,
    Object? playPosition = freezed,
    Object? jerseyNumber = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      playPosition: freezed == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamPlayerModelImplCopyWith<$Res>
    implements $TeamPlayerModelCopyWith<$Res> {
  factory _$$TeamPlayerModelImplCopyWith(_$TeamPlayerModelImpl value,
          $Res Function(_$TeamPlayerModelImpl) then) =
      __$$TeamPlayerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? firstName,
      String? lastName,
      @JsonKey(name: 'imageUrl') String? profileImage,
      String? playPosition,
      @JsonKey(name: 'teamJerseyNo') String? jerseyNumber});
}

/// @nodoc
class __$$TeamPlayerModelImplCopyWithImpl<$Res>
    extends _$TeamPlayerModelCopyWithImpl<$Res, _$TeamPlayerModelImpl>
    implements _$$TeamPlayerModelImplCopyWith<$Res> {
  __$$TeamPlayerModelImplCopyWithImpl(
      _$TeamPlayerModelImpl _value, $Res Function(_$TeamPlayerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? profileImage = freezed,
    Object? playPosition = freezed,
    Object? jerseyNumber = freezed,
  }) {
    return _then(_$TeamPlayerModelImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      playPosition: freezed == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamPlayerModelImpl implements _TeamPlayerModel {
  const _$TeamPlayerModelImpl(
      {this.userId,
      this.firstName,
      this.lastName,
      @JsonKey(name: 'imageUrl') this.profileImage,
      this.playPosition,
      @JsonKey(name: 'teamJerseyNo') this.jerseyNumber});

  factory _$TeamPlayerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamPlayerModelImplFromJson(json);

  @override
  final String? userId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? profileImage;
  @override
  final String? playPosition;
  @override
  @JsonKey(name: 'teamJerseyNo')
  final String? jerseyNumber;

  @override
  String toString() {
    return 'TeamPlayerModel(userId: $userId, firstName: $firstName, lastName: $lastName, profileImage: $profileImage, playPosition: $playPosition, jerseyNumber: $jerseyNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamPlayerModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.playPosition, playPosition) ||
                other.playPosition == playPosition) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, firstName, lastName,
      profileImage, playPosition, jerseyNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamPlayerModelImplCopyWith<_$TeamPlayerModelImpl> get copyWith =>
      __$$TeamPlayerModelImplCopyWithImpl<_$TeamPlayerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamPlayerModelImplToJson(
      this,
    );
  }
}

abstract class _TeamPlayerModel implements TeamPlayerModel {
  const factory _TeamPlayerModel(
          {final String? userId,
          final String? firstName,
          final String? lastName,
          @JsonKey(name: 'imageUrl') final String? profileImage,
          final String? playPosition,
          @JsonKey(name: 'teamJerseyNo') final String? jerseyNumber}) =
      _$TeamPlayerModelImpl;

  factory _TeamPlayerModel.fromJson(Map<String, dynamic> json) =
      _$TeamPlayerModelImpl.fromJson;

  @override
  String? get userId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get profileImage;
  @override
  String? get playPosition;
  @override
  @JsonKey(name: 'teamJerseyNo')
  String? get jerseyNumber;
  @override
  @JsonKey(ignore: true)
  _$$TeamPlayerModelImplCopyWith<_$TeamPlayerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
