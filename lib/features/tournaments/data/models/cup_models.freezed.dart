// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cup_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TournamentCupModel _$TournamentCupModelFromJson(Map<String, dynamic> json) {
  return _TournamentCupModel.fromJson(json);
}

/// @nodoc
mixin _$TournamentCupModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tournamentId')
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'ageCat')
  String? get ageCat => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'init', 'fixture', 'live', 'end'
  @JsonKey(name: 'tmntType')
  String? get tmntType => throw _privateConstructorUsedError; // Should be 'CUP'
  String? get visibility =>
      throw _privateConstructorUsedError; // 'local' or 'global'
  String? get country => throw _privateConstructorUsedError;
  String? get confed => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get prize => throw _privateConstructorUsedError;
  @JsonKey(name: 'regFee')
  String? get regFee => throw _privateConstructorUsedError;
  String? get orgDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'fsdDate')
  String? get fsdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'fsdTime')
  String? get fsdTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'fsdGmtMs')
  int get fsdGmtMs => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamPlayerType')
  String? get teamPlayerType => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamPlayerLimit')
  int get teamPlayerLimit => throw _privateConstructorUsedError;
  int get followCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'following')
  bool get isFollowing => throw _privateConstructorUsedError;
  int get teamCount => throw _privateConstructorUsedError;
  int get matchCount => throw _privateConstructorUsedError;
  bool get withdrawable =>
      throw _privateConstructorUsedError; // Cup-specific fields
  int get rounds =>
      throw _privateConstructorUsedError; // Number of knockout rounds
  int? get lastUpdated => throw _privateConstructorUsedError; // Timestamp
  int? get startedOn =>
      throw _privateConstructorUsedError; // Timestamp when cup started
  String? get startedBy =>
      throw _privateConstructorUsedError; // User ID who started it
  String? get updatedBy =>
      throw _privateConstructorUsedError; // User ID of last updater
// Related data
  List<CupBannerModel>? get banners => throw _privateConstructorUsedError;
  List<CupTeamModel>? get teams => throw _privateConstructorUsedError;
  List<CupSponsorModel>? get sponsors => throw _privateConstructorUsedError;
  List<CupRoundModel>? get roundsList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentCupModelCopyWith<TournamentCupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentCupModelCopyWith<$Res> {
  factory $TournamentCupModelCopyWith(
          TournamentCupModel value, $Res Function(TournamentCupModel) then) =
      _$TournamentCupModelCopyWithImpl<$Res, TournamentCupModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'tournamentId') String? tournamentId,
      String? name,
      String? logo,
      String? location,
      String? venue,
      String? ageGroup,
      @JsonKey(name: 'ageCat') String? ageCat,
      String? gameType,
      String? gender,
      String? startDate,
      String? endDate,
      String? status,
      @JsonKey(name: 'tmntType') String? tmntType,
      String? visibility,
      String? country,
      String? confed,
      String? parentId,
      String? createdBy,
      String? notes,
      String? description,
      String? prize,
      @JsonKey(name: 'regFee') String? regFee,
      String? orgDetails,
      @JsonKey(name: 'fsdDate') String? fsdDate,
      @JsonKey(name: 'fsdTime') String? fsdTime,
      @JsonKey(name: 'fsdGmtMs') int fsdGmtMs,
      @JsonKey(name: 'teamPlayerType') String? teamPlayerType,
      @JsonKey(name: 'teamPlayerLimit') int teamPlayerLimit,
      int followCount,
      @JsonKey(name: 'following') bool isFollowing,
      int teamCount,
      int matchCount,
      bool withdrawable,
      int rounds,
      int? lastUpdated,
      int? startedOn,
      String? startedBy,
      String? updatedBy,
      List<CupBannerModel>? banners,
      List<CupTeamModel>? teams,
      List<CupSponsorModel>? sponsors,
      List<CupRoundModel>? roundsList});
}

/// @nodoc
class _$TournamentCupModelCopyWithImpl<$Res, $Val extends TournamentCupModel>
    implements $TournamentCupModelCopyWith<$Res> {
  _$TournamentCupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tournamentId = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? location = freezed,
    Object? venue = freezed,
    Object? ageGroup = freezed,
    Object? ageCat = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = freezed,
    Object? tmntType = freezed,
    Object? visibility = freezed,
    Object? country = freezed,
    Object? confed = freezed,
    Object? parentId = freezed,
    Object? createdBy = freezed,
    Object? notes = freezed,
    Object? description = freezed,
    Object? prize = freezed,
    Object? regFee = freezed,
    Object? orgDetails = freezed,
    Object? fsdDate = freezed,
    Object? fsdTime = freezed,
    Object? fsdGmtMs = null,
    Object? teamPlayerType = freezed,
    Object? teamPlayerLimit = null,
    Object? followCount = null,
    Object? isFollowing = null,
    Object? teamCount = null,
    Object? matchCount = null,
    Object? withdrawable = null,
    Object? rounds = null,
    Object? lastUpdated = freezed,
    Object? startedOn = freezed,
    Object? startedBy = freezed,
    Object? updatedBy = freezed,
    Object? banners = freezed,
    Object? teams = freezed,
    Object? sponsors = freezed,
    Object? roundsList = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      ageCat: freezed == ageCat
          ? _value.ageCat
          : ageCat // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tmntType: freezed == tmntType
          ? _value.tmntType
          : tmntType // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      confed: freezed == confed
          ? _value.confed
          : confed // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      prize: freezed == prize
          ? _value.prize
          : prize // ignore: cast_nullable_to_non_nullable
              as String?,
      regFee: freezed == regFee
          ? _value.regFee
          : regFee // ignore: cast_nullable_to_non_nullable
              as String?,
      orgDetails: freezed == orgDetails
          ? _value.orgDetails
          : orgDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      fsdDate: freezed == fsdDate
          ? _value.fsdDate
          : fsdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      fsdTime: freezed == fsdTime
          ? _value.fsdTime
          : fsdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      fsdGmtMs: null == fsdGmtMs
          ? _value.fsdGmtMs
          : fsdGmtMs // ignore: cast_nullable_to_non_nullable
              as int,
      teamPlayerType: freezed == teamPlayerType
          ? _value.teamPlayerType
          : teamPlayerType // ignore: cast_nullable_to_non_nullable
              as String?,
      teamPlayerLimit: null == teamPlayerLimit
          ? _value.teamPlayerLimit
          : teamPlayerLimit // ignore: cast_nullable_to_non_nullable
              as int,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      teamCount: null == teamCount
          ? _value.teamCount
          : teamCount // ignore: cast_nullable_to_non_nullable
              as int,
      matchCount: null == matchCount
          ? _value.matchCount
          : matchCount // ignore: cast_nullable_to_non_nullable
              as int,
      withdrawable: null == withdrawable
          ? _value.withdrawable
          : withdrawable // ignore: cast_nullable_to_non_nullable
              as bool,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
      startedOn: freezed == startedOn
          ? _value.startedOn
          : startedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      startedBy: freezed == startedBy
          ? _value.startedBy
          : startedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      banners: freezed == banners
          ? _value.banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<CupBannerModel>?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<CupTeamModel>?,
      sponsors: freezed == sponsors
          ? _value.sponsors
          : sponsors // ignore: cast_nullable_to_non_nullable
              as List<CupSponsorModel>?,
      roundsList: freezed == roundsList
          ? _value.roundsList
          : roundsList // ignore: cast_nullable_to_non_nullable
              as List<CupRoundModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentCupModelImplCopyWith<$Res>
    implements $TournamentCupModelCopyWith<$Res> {
  factory _$$TournamentCupModelImplCopyWith(_$TournamentCupModelImpl value,
          $Res Function(_$TournamentCupModelImpl) then) =
      __$$TournamentCupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'tournamentId') String? tournamentId,
      String? name,
      String? logo,
      String? location,
      String? venue,
      String? ageGroup,
      @JsonKey(name: 'ageCat') String? ageCat,
      String? gameType,
      String? gender,
      String? startDate,
      String? endDate,
      String? status,
      @JsonKey(name: 'tmntType') String? tmntType,
      String? visibility,
      String? country,
      String? confed,
      String? parentId,
      String? createdBy,
      String? notes,
      String? description,
      String? prize,
      @JsonKey(name: 'regFee') String? regFee,
      String? orgDetails,
      @JsonKey(name: 'fsdDate') String? fsdDate,
      @JsonKey(name: 'fsdTime') String? fsdTime,
      @JsonKey(name: 'fsdGmtMs') int fsdGmtMs,
      @JsonKey(name: 'teamPlayerType') String? teamPlayerType,
      @JsonKey(name: 'teamPlayerLimit') int teamPlayerLimit,
      int followCount,
      @JsonKey(name: 'following') bool isFollowing,
      int teamCount,
      int matchCount,
      bool withdrawable,
      int rounds,
      int? lastUpdated,
      int? startedOn,
      String? startedBy,
      String? updatedBy,
      List<CupBannerModel>? banners,
      List<CupTeamModel>? teams,
      List<CupSponsorModel>? sponsors,
      List<CupRoundModel>? roundsList});
}

/// @nodoc
class __$$TournamentCupModelImplCopyWithImpl<$Res>
    extends _$TournamentCupModelCopyWithImpl<$Res, _$TournamentCupModelImpl>
    implements _$$TournamentCupModelImplCopyWith<$Res> {
  __$$TournamentCupModelImplCopyWithImpl(_$TournamentCupModelImpl _value,
      $Res Function(_$TournamentCupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tournamentId = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? location = freezed,
    Object? venue = freezed,
    Object? ageGroup = freezed,
    Object? ageCat = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = freezed,
    Object? tmntType = freezed,
    Object? visibility = freezed,
    Object? country = freezed,
    Object? confed = freezed,
    Object? parentId = freezed,
    Object? createdBy = freezed,
    Object? notes = freezed,
    Object? description = freezed,
    Object? prize = freezed,
    Object? regFee = freezed,
    Object? orgDetails = freezed,
    Object? fsdDate = freezed,
    Object? fsdTime = freezed,
    Object? fsdGmtMs = null,
    Object? teamPlayerType = freezed,
    Object? teamPlayerLimit = null,
    Object? followCount = null,
    Object? isFollowing = null,
    Object? teamCount = null,
    Object? matchCount = null,
    Object? withdrawable = null,
    Object? rounds = null,
    Object? lastUpdated = freezed,
    Object? startedOn = freezed,
    Object? startedBy = freezed,
    Object? updatedBy = freezed,
    Object? banners = freezed,
    Object? teams = freezed,
    Object? sponsors = freezed,
    Object? roundsList = freezed,
  }) {
    return _then(_$TournamentCupModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      ageCat: freezed == ageCat
          ? _value.ageCat
          : ageCat // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tmntType: freezed == tmntType
          ? _value.tmntType
          : tmntType // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      confed: freezed == confed
          ? _value.confed
          : confed // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      prize: freezed == prize
          ? _value.prize
          : prize // ignore: cast_nullable_to_non_nullable
              as String?,
      regFee: freezed == regFee
          ? _value.regFee
          : regFee // ignore: cast_nullable_to_non_nullable
              as String?,
      orgDetails: freezed == orgDetails
          ? _value.orgDetails
          : orgDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      fsdDate: freezed == fsdDate
          ? _value.fsdDate
          : fsdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      fsdTime: freezed == fsdTime
          ? _value.fsdTime
          : fsdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      fsdGmtMs: null == fsdGmtMs
          ? _value.fsdGmtMs
          : fsdGmtMs // ignore: cast_nullable_to_non_nullable
              as int,
      teamPlayerType: freezed == teamPlayerType
          ? _value.teamPlayerType
          : teamPlayerType // ignore: cast_nullable_to_non_nullable
              as String?,
      teamPlayerLimit: null == teamPlayerLimit
          ? _value.teamPlayerLimit
          : teamPlayerLimit // ignore: cast_nullable_to_non_nullable
              as int,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
      teamCount: null == teamCount
          ? _value.teamCount
          : teamCount // ignore: cast_nullable_to_non_nullable
              as int,
      matchCount: null == matchCount
          ? _value.matchCount
          : matchCount // ignore: cast_nullable_to_non_nullable
              as int,
      withdrawable: null == withdrawable
          ? _value.withdrawable
          : withdrawable // ignore: cast_nullable_to_non_nullable
              as bool,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as int?,
      startedOn: freezed == startedOn
          ? _value.startedOn
          : startedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      startedBy: freezed == startedBy
          ? _value.startedBy
          : startedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      banners: freezed == banners
          ? _value._banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<CupBannerModel>?,
      teams: freezed == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<CupTeamModel>?,
      sponsors: freezed == sponsors
          ? _value._sponsors
          : sponsors // ignore: cast_nullable_to_non_nullable
              as List<CupSponsorModel>?,
      roundsList: freezed == roundsList
          ? _value._roundsList
          : roundsList // ignore: cast_nullable_to_non_nullable
              as List<CupRoundModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentCupModelImpl implements _TournamentCupModel {
  const _$TournamentCupModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'tournamentId') this.tournamentId,
      this.name,
      this.logo,
      this.location,
      this.venue,
      this.ageGroup,
      @JsonKey(name: 'ageCat') this.ageCat,
      this.gameType,
      this.gender,
      this.startDate,
      this.endDate,
      this.status,
      @JsonKey(name: 'tmntType') this.tmntType,
      this.visibility,
      this.country,
      this.confed,
      this.parentId,
      this.createdBy,
      this.notes,
      this.description,
      this.prize,
      @JsonKey(name: 'regFee') this.regFee,
      this.orgDetails,
      @JsonKey(name: 'fsdDate') this.fsdDate,
      @JsonKey(name: 'fsdTime') this.fsdTime,
      @JsonKey(name: 'fsdGmtMs') this.fsdGmtMs = 0,
      @JsonKey(name: 'teamPlayerType') this.teamPlayerType,
      @JsonKey(name: 'teamPlayerLimit') this.teamPlayerLimit = 0,
      this.followCount = 0,
      @JsonKey(name: 'following') this.isFollowing = false,
      this.teamCount = 0,
      this.matchCount = 0,
      this.withdrawable = false,
      this.rounds = 0,
      this.lastUpdated,
      this.startedOn,
      this.startedBy,
      this.updatedBy,
      final List<CupBannerModel>? banners,
      final List<CupTeamModel>? teams,
      final List<CupSponsorModel>? sponsors,
      final List<CupRoundModel>? roundsList})
      : _banners = banners,
        _teams = teams,
        _sponsors = sponsors,
        _roundsList = roundsList;

  factory _$TournamentCupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentCupModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'tournamentId')
  final String? tournamentId;
  @override
  final String? name;
  @override
  final String? logo;
  @override
  final String? location;
  @override
  final String? venue;
  @override
  final String? ageGroup;
  @override
  @JsonKey(name: 'ageCat')
  final String? ageCat;
  @override
  final String? gameType;
  @override
  final String? gender;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? status;
// 'init', 'fixture', 'live', 'end'
  @override
  @JsonKey(name: 'tmntType')
  final String? tmntType;
// Should be 'CUP'
  @override
  final String? visibility;
// 'local' or 'global'
  @override
  final String? country;
  @override
  final String? confed;
  @override
  final String? parentId;
  @override
  final String? createdBy;
  @override
  final String? notes;
  @override
  final String? description;
  @override
  final String? prize;
  @override
  @JsonKey(name: 'regFee')
  final String? regFee;
  @override
  final String? orgDetails;
  @override
  @JsonKey(name: 'fsdDate')
  final String? fsdDate;
  @override
  @JsonKey(name: 'fsdTime')
  final String? fsdTime;
  @override
  @JsonKey(name: 'fsdGmtMs')
  final int fsdGmtMs;
  @override
  @JsonKey(name: 'teamPlayerType')
  final String? teamPlayerType;
  @override
  @JsonKey(name: 'teamPlayerLimit')
  final int teamPlayerLimit;
  @override
  @JsonKey()
  final int followCount;
  @override
  @JsonKey(name: 'following')
  final bool isFollowing;
  @override
  @JsonKey()
  final int teamCount;
  @override
  @JsonKey()
  final int matchCount;
  @override
  @JsonKey()
  final bool withdrawable;
// Cup-specific fields
  @override
  @JsonKey()
  final int rounds;
// Number of knockout rounds
  @override
  final int? lastUpdated;
// Timestamp
  @override
  final int? startedOn;
// Timestamp when cup started
  @override
  final String? startedBy;
// User ID who started it
  @override
  final String? updatedBy;
// User ID of last updater
// Related data
  final List<CupBannerModel>? _banners;
// User ID of last updater
// Related data
  @override
  List<CupBannerModel>? get banners {
    final value = _banners;
    if (value == null) return null;
    if (_banners is EqualUnmodifiableListView) return _banners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CupTeamModel>? _teams;
  @override
  List<CupTeamModel>? get teams {
    final value = _teams;
    if (value == null) return null;
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CupSponsorModel>? _sponsors;
  @override
  List<CupSponsorModel>? get sponsors {
    final value = _sponsors;
    if (value == null) return null;
    if (_sponsors is EqualUnmodifiableListView) return _sponsors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CupRoundModel>? _roundsList;
  @override
  List<CupRoundModel>? get roundsList {
    final value = _roundsList;
    if (value == null) return null;
    if (_roundsList is EqualUnmodifiableListView) return _roundsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TournamentCupModel(id: $id, tournamentId: $tournamentId, name: $name, logo: $logo, location: $location, venue: $venue, ageGroup: $ageGroup, ageCat: $ageCat, gameType: $gameType, gender: $gender, startDate: $startDate, endDate: $endDate, status: $status, tmntType: $tmntType, visibility: $visibility, country: $country, confed: $confed, parentId: $parentId, createdBy: $createdBy, notes: $notes, description: $description, prize: $prize, regFee: $regFee, orgDetails: $orgDetails, fsdDate: $fsdDate, fsdTime: $fsdTime, fsdGmtMs: $fsdGmtMs, teamPlayerType: $teamPlayerType, teamPlayerLimit: $teamPlayerLimit, followCount: $followCount, isFollowing: $isFollowing, teamCount: $teamCount, matchCount: $matchCount, withdrawable: $withdrawable, rounds: $rounds, lastUpdated: $lastUpdated, startedOn: $startedOn, startedBy: $startedBy, updatedBy: $updatedBy, banners: $banners, teams: $teams, sponsors: $sponsors, roundsList: $roundsList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentCupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.ageCat, ageCat) || other.ageCat == ageCat) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tmntType, tmntType) ||
                other.tmntType == tmntType) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.confed, confed) || other.confed == confed) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.prize, prize) || other.prize == prize) &&
            (identical(other.regFee, regFee) || other.regFee == regFee) &&
            (identical(other.orgDetails, orgDetails) ||
                other.orgDetails == orgDetails) &&
            (identical(other.fsdDate, fsdDate) || other.fsdDate == fsdDate) &&
            (identical(other.fsdTime, fsdTime) || other.fsdTime == fsdTime) &&
            (identical(other.fsdGmtMs, fsdGmtMs) ||
                other.fsdGmtMs == fsdGmtMs) &&
            (identical(other.teamPlayerType, teamPlayerType) ||
                other.teamPlayerType == teamPlayerType) &&
            (identical(other.teamPlayerLimit, teamPlayerLimit) ||
                other.teamPlayerLimit == teamPlayerLimit) &&
            (identical(other.followCount, followCount) ||
                other.followCount == followCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.teamCount, teamCount) ||
                other.teamCount == teamCount) &&
            (identical(other.matchCount, matchCount) ||
                other.matchCount == matchCount) &&
            (identical(other.withdrawable, withdrawable) ||
                other.withdrawable == withdrawable) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.startedOn, startedOn) ||
                other.startedOn == startedOn) &&
            (identical(other.startedBy, startedBy) ||
                other.startedBy == startedBy) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            const DeepCollectionEquality().equals(other._banners, _banners) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._sponsors, _sponsors) &&
            const DeepCollectionEquality()
                .equals(other._roundsList, _roundsList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        tournamentId,
        name,
        logo,
        location,
        venue,
        ageGroup,
        ageCat,
        gameType,
        gender,
        startDate,
        endDate,
        status,
        tmntType,
        visibility,
        country,
        confed,
        parentId,
        createdBy,
        notes,
        description,
        prize,
        regFee,
        orgDetails,
        fsdDate,
        fsdTime,
        fsdGmtMs,
        teamPlayerType,
        teamPlayerLimit,
        followCount,
        isFollowing,
        teamCount,
        matchCount,
        withdrawable,
        rounds,
        lastUpdated,
        startedOn,
        startedBy,
        updatedBy,
        const DeepCollectionEquality().hash(_banners),
        const DeepCollectionEquality().hash(_teams),
        const DeepCollectionEquality().hash(_sponsors),
        const DeepCollectionEquality().hash(_roundsList)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentCupModelImplCopyWith<_$TournamentCupModelImpl> get copyWith =>
      __$$TournamentCupModelImplCopyWithImpl<_$TournamentCupModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentCupModelImplToJson(
      this,
    );
  }
}

abstract class _TournamentCupModel implements TournamentCupModel {
  const factory _TournamentCupModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'tournamentId') final String? tournamentId,
      final String? name,
      final String? logo,
      final String? location,
      final String? venue,
      final String? ageGroup,
      @JsonKey(name: 'ageCat') final String? ageCat,
      final String? gameType,
      final String? gender,
      final String? startDate,
      final String? endDate,
      final String? status,
      @JsonKey(name: 'tmntType') final String? tmntType,
      final String? visibility,
      final String? country,
      final String? confed,
      final String? parentId,
      final String? createdBy,
      final String? notes,
      final String? description,
      final String? prize,
      @JsonKey(name: 'regFee') final String? regFee,
      final String? orgDetails,
      @JsonKey(name: 'fsdDate') final String? fsdDate,
      @JsonKey(name: 'fsdTime') final String? fsdTime,
      @JsonKey(name: 'fsdGmtMs') final int fsdGmtMs,
      @JsonKey(name: 'teamPlayerType') final String? teamPlayerType,
      @JsonKey(name: 'teamPlayerLimit') final int teamPlayerLimit,
      final int followCount,
      @JsonKey(name: 'following') final bool isFollowing,
      final int teamCount,
      final int matchCount,
      final bool withdrawable,
      final int rounds,
      final int? lastUpdated,
      final int? startedOn,
      final String? startedBy,
      final String? updatedBy,
      final List<CupBannerModel>? banners,
      final List<CupTeamModel>? teams,
      final List<CupSponsorModel>? sponsors,
      final List<CupRoundModel>? roundsList}) = _$TournamentCupModelImpl;

  factory _TournamentCupModel.fromJson(Map<String, dynamic> json) =
      _$TournamentCupModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'tournamentId')
  String? get tournamentId;
  @override
  String? get name;
  @override
  String? get logo;
  @override
  String? get location;
  @override
  String? get venue;
  @override
  String? get ageGroup;
  @override
  @JsonKey(name: 'ageCat')
  String? get ageCat;
  @override
  String? get gameType;
  @override
  String? get gender;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  String? get status;
  @override // 'init', 'fixture', 'live', 'end'
  @JsonKey(name: 'tmntType')
  String? get tmntType;
  @override // Should be 'CUP'
  String? get visibility;
  @override // 'local' or 'global'
  String? get country;
  @override
  String? get confed;
  @override
  String? get parentId;
  @override
  String? get createdBy;
  @override
  String? get notes;
  @override
  String? get description;
  @override
  String? get prize;
  @override
  @JsonKey(name: 'regFee')
  String? get regFee;
  @override
  String? get orgDetails;
  @override
  @JsonKey(name: 'fsdDate')
  String? get fsdDate;
  @override
  @JsonKey(name: 'fsdTime')
  String? get fsdTime;
  @override
  @JsonKey(name: 'fsdGmtMs')
  int get fsdGmtMs;
  @override
  @JsonKey(name: 'teamPlayerType')
  String? get teamPlayerType;
  @override
  @JsonKey(name: 'teamPlayerLimit')
  int get teamPlayerLimit;
  @override
  int get followCount;
  @override
  @JsonKey(name: 'following')
  bool get isFollowing;
  @override
  int get teamCount;
  @override
  int get matchCount;
  @override
  bool get withdrawable;
  @override // Cup-specific fields
  int get rounds;
  @override // Number of knockout rounds
  int? get lastUpdated;
  @override // Timestamp
  int? get startedOn;
  @override // Timestamp when cup started
  String? get startedBy;
  @override // User ID who started it
  String? get updatedBy;
  @override // User ID of last updater
// Related data
  List<CupBannerModel>? get banners;
  @override
  List<CupTeamModel>? get teams;
  @override
  List<CupSponsorModel>? get sponsors;
  @override
  List<CupRoundModel>? get roundsList;
  @override
  @JsonKey(ignore: true)
  _$$TournamentCupModelImplCopyWith<_$TournamentCupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupRoundModel _$CupRoundModelFromJson(Map<String, dynamic> json) {
  return _CupRoundModel.fromJson(json);
}

/// @nodoc
mixin _$CupRoundModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get roundName =>
      throw _privateConstructorUsedError; // e.g., "Group Stage", "Quarter Final", "Semi Final"
  String? get mode =>
      throw _privateConstructorUsedError; // 'GROUP' or 'KNOCKOUT'
  String? get tie => throw _privateConstructorUsedError; // Tie-breaking rule
  String? get seq => throw _privateConstructorUsedError; // Sequence order
  String? get count =>
      throw _privateConstructorUsedError; // Number of teams/groups
  String? get level =>
      throw _privateConstructorUsedError; // Bracket depth level
  bool get isExtraTime =>
      throw _privateConstructorUsedError; // Extra time enabled
  bool get isPenalty =>
      throw _privateConstructorUsedError; // Penalty shootout enabled
  String? get addedBy =>
      throw _privateConstructorUsedError; // User ID who added round
  String? get addedOn => throw _privateConstructorUsedError; // Timestamp added
  bool get isDelete => throw _privateConstructorUsedError; // Soft-delete flag
  List<CupGroupModel>? get groups => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupRoundModelCopyWith<CupRoundModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupRoundModelCopyWith<$Res> {
  factory $CupRoundModelCopyWith(
          CupRoundModel value, $Res Function(CupRoundModel) then) =
      _$CupRoundModelCopyWithImpl<$Res, CupRoundModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? roundId,
      String? tournamentId,
      String? roundName,
      String? mode,
      String? tie,
      String? seq,
      String? count,
      String? level,
      bool isExtraTime,
      bool isPenalty,
      String? addedBy,
      String? addedOn,
      bool isDelete,
      List<CupGroupModel>? groups});
}

/// @nodoc
class _$CupRoundModelCopyWithImpl<$Res, $Val extends CupRoundModel>
    implements $CupRoundModelCopyWith<$Res> {
  _$CupRoundModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roundId = freezed,
    Object? tournamentId = freezed,
    Object? roundName = freezed,
    Object? mode = freezed,
    Object? tie = freezed,
    Object? seq = freezed,
    Object? count = freezed,
    Object? level = freezed,
    Object? isExtraTime = null,
    Object? isPenalty = null,
    Object? addedBy = freezed,
    Object? addedOn = freezed,
    Object? isDelete = null,
    Object? groups = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundName: freezed == roundName
          ? _value.roundName
          : roundName // ignore: cast_nullable_to_non_nullable
              as String?,
      mode: freezed == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String?,
      tie: freezed == tie
          ? _value.tie
          : tie // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      isExtraTime: null == isExtraTime
          ? _value.isExtraTime
          : isExtraTime // ignore: cast_nullable_to_non_nullable
              as bool,
      isPenalty: null == isPenalty
          ? _value.isPenalty
          : isPenalty // ignore: cast_nullable_to_non_nullable
              as bool,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      groups: freezed == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<CupGroupModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupRoundModelImplCopyWith<$Res>
    implements $CupRoundModelCopyWith<$Res> {
  factory _$$CupRoundModelImplCopyWith(
          _$CupRoundModelImpl value, $Res Function(_$CupRoundModelImpl) then) =
      __$$CupRoundModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? roundId,
      String? tournamentId,
      String? roundName,
      String? mode,
      String? tie,
      String? seq,
      String? count,
      String? level,
      bool isExtraTime,
      bool isPenalty,
      String? addedBy,
      String? addedOn,
      bool isDelete,
      List<CupGroupModel>? groups});
}

/// @nodoc
class __$$CupRoundModelImplCopyWithImpl<$Res>
    extends _$CupRoundModelCopyWithImpl<$Res, _$CupRoundModelImpl>
    implements _$$CupRoundModelImplCopyWith<$Res> {
  __$$CupRoundModelImplCopyWithImpl(
      _$CupRoundModelImpl _value, $Res Function(_$CupRoundModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roundId = freezed,
    Object? tournamentId = freezed,
    Object? roundName = freezed,
    Object? mode = freezed,
    Object? tie = freezed,
    Object? seq = freezed,
    Object? count = freezed,
    Object? level = freezed,
    Object? isExtraTime = null,
    Object? isPenalty = null,
    Object? addedBy = freezed,
    Object? addedOn = freezed,
    Object? isDelete = null,
    Object? groups = freezed,
  }) {
    return _then(_$CupRoundModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundName: freezed == roundName
          ? _value.roundName
          : roundName // ignore: cast_nullable_to_non_nullable
              as String?,
      mode: freezed == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String?,
      tie: freezed == tie
          ? _value.tie
          : tie // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      isExtraTime: null == isExtraTime
          ? _value.isExtraTime
          : isExtraTime // ignore: cast_nullable_to_non_nullable
              as bool,
      isPenalty: null == isPenalty
          ? _value.isPenalty
          : isPenalty // ignore: cast_nullable_to_non_nullable
              as bool,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      groups: freezed == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<CupGroupModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupRoundModelImpl implements _CupRoundModel {
  const _$CupRoundModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.roundId,
      this.tournamentId,
      this.roundName,
      this.mode,
      this.tie,
      this.seq,
      this.count,
      this.level,
      this.isExtraTime = false,
      this.isPenalty = false,
      this.addedBy,
      this.addedOn,
      this.isDelete = false,
      final List<CupGroupModel>? groups})
      : _groups = groups;

  factory _$CupRoundModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupRoundModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? roundId;
  @override
  final String? tournamentId;
  @override
  final String? roundName;
// e.g., "Group Stage", "Quarter Final", "Semi Final"
  @override
  final String? mode;
// 'GROUP' or 'KNOCKOUT'
  @override
  final String? tie;
// Tie-breaking rule
  @override
  final String? seq;
// Sequence order
  @override
  final String? count;
// Number of teams/groups
  @override
  final String? level;
// Bracket depth level
  @override
  @JsonKey()
  final bool isExtraTime;
// Extra time enabled
  @override
  @JsonKey()
  final bool isPenalty;
// Penalty shootout enabled
  @override
  final String? addedBy;
// User ID who added round
  @override
  final String? addedOn;
// Timestamp added
  @override
  @JsonKey()
  final bool isDelete;
// Soft-delete flag
  final List<CupGroupModel>? _groups;
// Soft-delete flag
  @override
  List<CupGroupModel>? get groups {
    final value = _groups;
    if (value == null) return null;
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CupRoundModel(id: $id, roundId: $roundId, tournamentId: $tournamentId, roundName: $roundName, mode: $mode, tie: $tie, seq: $seq, count: $count, level: $level, isExtraTime: $isExtraTime, isPenalty: $isPenalty, addedBy: $addedBy, addedOn: $addedOn, isDelete: $isDelete, groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupRoundModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.roundName, roundName) ||
                other.roundName == roundName) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.tie, tie) || other.tie == tie) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.isExtraTime, isExtraTime) ||
                other.isExtraTime == isExtraTime) &&
            (identical(other.isPenalty, isPenalty) ||
                other.isPenalty == isPenalty) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roundId,
      tournamentId,
      roundName,
      mode,
      tie,
      seq,
      count,
      level,
      isExtraTime,
      isPenalty,
      addedBy,
      addedOn,
      isDelete,
      const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupRoundModelImplCopyWith<_$CupRoundModelImpl> get copyWith =>
      __$$CupRoundModelImplCopyWithImpl<_$CupRoundModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupRoundModelImplToJson(
      this,
    );
  }
}

abstract class _CupRoundModel implements CupRoundModel {
  const factory _CupRoundModel(
      {@JsonKey(name: '_id') final String? id,
      final String? roundId,
      final String? tournamentId,
      final String? roundName,
      final String? mode,
      final String? tie,
      final String? seq,
      final String? count,
      final String? level,
      final bool isExtraTime,
      final bool isPenalty,
      final String? addedBy,
      final String? addedOn,
      final bool isDelete,
      final List<CupGroupModel>? groups}) = _$CupRoundModelImpl;

  factory _CupRoundModel.fromJson(Map<String, dynamic> json) =
      _$CupRoundModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get roundId;
  @override
  String? get tournamentId;
  @override
  String? get roundName;
  @override // e.g., "Group Stage", "Quarter Final", "Semi Final"
  String? get mode;
  @override // 'GROUP' or 'KNOCKOUT'
  String? get tie;
  @override // Tie-breaking rule
  String? get seq;
  @override // Sequence order
  String? get count;
  @override // Number of teams/groups
  String? get level;
  @override // Bracket depth level
  bool get isExtraTime;
  @override // Extra time enabled
  bool get isPenalty;
  @override // Penalty shootout enabled
  String? get addedBy;
  @override // User ID who added round
  String? get addedOn;
  @override // Timestamp added
  bool get isDelete;
  @override // Soft-delete flag
  List<CupGroupModel>? get groups;
  @override
  @JsonKey(ignore: true)
  _$$CupRoundModelImplCopyWith<_$CupRoundModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupGroupModel _$CupGroupModelFromJson(Map<String, dynamic> json) {
  return _CupGroupModel.fromJson(json);
}

/// @nodoc
mixin _$CupGroupModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get groupName =>
      throw _privateConstructorUsedError; // e.g., "Group A", "Group B"
  String? get mode => throw _privateConstructorUsedError; // Match mode
  String? get status => throw _privateConstructorUsedError; // Group status
  String? get level => throw _privateConstructorUsedError; // Level in bracket
  String? get seq => throw _privateConstructorUsedError; // Sequence order
  String? get fixture => throw _privateConstructorUsedError; // Fixture format
  bool get isDelete => throw _privateConstructorUsedError; // Soft-delete flag
  List<CupLeagueModel> get leg1 =>
      throw _privateConstructorUsedError; // First leg matches
  List<CupLeagueModel> get leg2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupGroupModelCopyWith<CupGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupGroupModelCopyWith<$Res> {
  factory $CupGroupModelCopyWith(
          CupGroupModel value, $Res Function(CupGroupModel) then) =
      _$CupGroupModelCopyWithImpl<$Res, CupGroupModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? groupId,
      String? roundId,
      String? tournamentId,
      String? groupName,
      String? mode,
      String? status,
      String? level,
      String? seq,
      String? fixture,
      bool isDelete,
      List<CupLeagueModel> leg1,
      List<CupLeagueModel> leg2});
}

/// @nodoc
class _$CupGroupModelCopyWithImpl<$Res, $Val extends CupGroupModel>
    implements $CupGroupModelCopyWith<$Res> {
  _$CupGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? groupId = freezed,
    Object? roundId = freezed,
    Object? tournamentId = freezed,
    Object? groupName = freezed,
    Object? mode = freezed,
    Object? status = freezed,
    Object? level = freezed,
    Object? seq = freezed,
    Object? fixture = freezed,
    Object? isDelete = null,
    Object? leg1 = null,
    Object? leg2 = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      mode: freezed == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as String?,
      fixture: freezed == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      leg1: null == leg1
          ? _value.leg1
          : leg1 // ignore: cast_nullable_to_non_nullable
              as List<CupLeagueModel>,
      leg2: null == leg2
          ? _value.leg2
          : leg2 // ignore: cast_nullable_to_non_nullable
              as List<CupLeagueModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupGroupModelImplCopyWith<$Res>
    implements $CupGroupModelCopyWith<$Res> {
  factory _$$CupGroupModelImplCopyWith(
          _$CupGroupModelImpl value, $Res Function(_$CupGroupModelImpl) then) =
      __$$CupGroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? groupId,
      String? roundId,
      String? tournamentId,
      String? groupName,
      String? mode,
      String? status,
      String? level,
      String? seq,
      String? fixture,
      bool isDelete,
      List<CupLeagueModel> leg1,
      List<CupLeagueModel> leg2});
}

/// @nodoc
class __$$CupGroupModelImplCopyWithImpl<$Res>
    extends _$CupGroupModelCopyWithImpl<$Res, _$CupGroupModelImpl>
    implements _$$CupGroupModelImplCopyWith<$Res> {
  __$$CupGroupModelImplCopyWithImpl(
      _$CupGroupModelImpl _value, $Res Function(_$CupGroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? groupId = freezed,
    Object? roundId = freezed,
    Object? tournamentId = freezed,
    Object? groupName = freezed,
    Object? mode = freezed,
    Object? status = freezed,
    Object? level = freezed,
    Object? seq = freezed,
    Object? fixture = freezed,
    Object? isDelete = null,
    Object? leg1 = null,
    Object? leg2 = null,
  }) {
    return _then(_$CupGroupModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
      mode: freezed == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as String?,
      fixture: freezed == fixture
          ? _value.fixture
          : fixture // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      leg1: null == leg1
          ? _value._leg1
          : leg1 // ignore: cast_nullable_to_non_nullable
              as List<CupLeagueModel>,
      leg2: null == leg2
          ? _value._leg2
          : leg2 // ignore: cast_nullable_to_non_nullable
              as List<CupLeagueModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupGroupModelImpl implements _CupGroupModel {
  const _$CupGroupModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.groupId,
      this.roundId,
      this.tournamentId,
      this.groupName,
      this.mode,
      this.status,
      this.level,
      this.seq,
      this.fixture,
      this.isDelete = false,
      final List<CupLeagueModel> leg1 = const [],
      final List<CupLeagueModel> leg2 = const []})
      : _leg1 = leg1,
        _leg2 = leg2;

  factory _$CupGroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupGroupModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? groupId;
  @override
  final String? roundId;
  @override
  final String? tournamentId;
  @override
  final String? groupName;
// e.g., "Group A", "Group B"
  @override
  final String? mode;
// Match mode
  @override
  final String? status;
// Group status
  @override
  final String? level;
// Level in bracket
  @override
  final String? seq;
// Sequence order
  @override
  final String? fixture;
// Fixture format
  @override
  @JsonKey()
  final bool isDelete;
// Soft-delete flag
  final List<CupLeagueModel> _leg1;
// Soft-delete flag
  @override
  @JsonKey()
  List<CupLeagueModel> get leg1 {
    if (_leg1 is EqualUnmodifiableListView) return _leg1;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leg1);
  }

// First leg matches
  final List<CupLeagueModel> _leg2;
// First leg matches
  @override
  @JsonKey()
  List<CupLeagueModel> get leg2 {
    if (_leg2 is EqualUnmodifiableListView) return _leg2;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leg2);
  }

  @override
  String toString() {
    return 'CupGroupModel(id: $id, groupId: $groupId, roundId: $roundId, tournamentId: $tournamentId, groupName: $groupName, mode: $mode, status: $status, level: $level, seq: $seq, fixture: $fixture, isDelete: $isDelete, leg1: $leg1, leg2: $leg2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupGroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.fixture, fixture) || other.fixture == fixture) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            const DeepCollectionEquality().equals(other._leg1, _leg1) &&
            const DeepCollectionEquality().equals(other._leg2, _leg2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      roundId,
      tournamentId,
      groupName,
      mode,
      status,
      level,
      seq,
      fixture,
      isDelete,
      const DeepCollectionEquality().hash(_leg1),
      const DeepCollectionEquality().hash(_leg2));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupGroupModelImplCopyWith<_$CupGroupModelImpl> get copyWith =>
      __$$CupGroupModelImplCopyWithImpl<_$CupGroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupGroupModelImplToJson(
      this,
    );
  }
}

abstract class _CupGroupModel implements CupGroupModel {
  const factory _CupGroupModel(
      {@JsonKey(name: '_id') final String? id,
      final String? groupId,
      final String? roundId,
      final String? tournamentId,
      final String? groupName,
      final String? mode,
      final String? status,
      final String? level,
      final String? seq,
      final String? fixture,
      final bool isDelete,
      final List<CupLeagueModel> leg1,
      final List<CupLeagueModel> leg2}) = _$CupGroupModelImpl;

  factory _CupGroupModel.fromJson(Map<String, dynamic> json) =
      _$CupGroupModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get groupId;
  @override
  String? get roundId;
  @override
  String? get tournamentId;
  @override
  String? get groupName;
  @override // e.g., "Group A", "Group B"
  String? get mode;
  @override // Match mode
  String? get status;
  @override // Group status
  String? get level;
  @override // Level in bracket
  String? get seq;
  @override // Sequence order
  String? get fixture;
  @override // Fixture format
  bool get isDelete;
  @override // Soft-delete flag
  List<CupLeagueModel> get leg1;
  @override // First leg matches
  List<CupLeagueModel> get leg2;
  @override
  @JsonKey(ignore: true)
  _$$CupGroupModelImplCopyWith<_$CupGroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupLeagueModel _$CupLeagueModelFromJson(Map<String, dynamic> json) {
  return _CupLeagueModel.fromJson(json);
}

/// @nodoc
mixin _$CupLeagueModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String? get matchId => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;
  String? get homeTeamId => throw _privateConstructorUsedError;
  String? get homeTeamName => throw _privateConstructorUsedError;
  String? get homeTeamLogo => throw _privateConstructorUsedError;
  String? get awayTeamId => throw _privateConstructorUsedError;
  String? get awayTeamName => throw _privateConstructorUsedError;
  String? get awayTeamLogo => throw _privateConstructorUsedError;
  int? get homeScore => throw _privateConstructorUsedError;
  int? get awayScore => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'upcoming', 'live', 'end'
  String? get matchDate => throw _privateConstructorUsedError;
  int get matchDateMs => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  String? get leg => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupLeagueModelCopyWith<CupLeagueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupLeagueModelCopyWith<$Res> {
  factory $CupLeagueModelCopyWith(
          CupLeagueModel value, $Res Function(CupLeagueModel) then) =
      _$CupLeagueModelCopyWithImpl<$Res, CupLeagueModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
      String? tournamentId,
      String? roundId,
      String? groupId,
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
      String? leg});
}

/// @nodoc
class _$CupLeagueModelCopyWithImpl<$Res, $Val extends CupLeagueModel>
    implements $CupLeagueModelCopyWith<$Res> {
  _$CupLeagueModelCopyWithImpl(this._value, this._then);

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
    Object? roundId = freezed,
    Object? groupId = freezed,
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
    Object? leg = freezed,
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
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
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
      leg: freezed == leg
          ? _value.leg
          : leg // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupLeagueModelImplCopyWith<$Res>
    implements $CupLeagueModelCopyWith<$Res> {
  factory _$$CupLeagueModelImplCopyWith(_$CupLeagueModelImpl value,
          $Res Function(_$CupLeagueModelImpl) then) =
      __$$CupLeagueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
      String? tournamentId,
      String? roundId,
      String? groupId,
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
      String? leg});
}

/// @nodoc
class __$$CupLeagueModelImplCopyWithImpl<$Res>
    extends _$CupLeagueModelCopyWithImpl<$Res, _$CupLeagueModelImpl>
    implements _$$CupLeagueModelImplCopyWith<$Res> {
  __$$CupLeagueModelImplCopyWithImpl(
      _$CupLeagueModelImpl _value, $Res Function(_$CupLeagueModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
    Object? tournamentId = freezed,
    Object? roundId = freezed,
    Object? groupId = freezed,
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
    Object? leg = freezed,
  }) {
    return _then(_$CupLeagueModelImpl(
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
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
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
      leg: freezed == leg
          ? _value.leg
          : leg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupLeagueModelImpl implements _CupLeagueModel {
  const _$CupLeagueModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') this.matchId,
      this.tournamentId,
      this.roundId,
      this.groupId,
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
      this.leg});

  factory _$CupLeagueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupLeagueModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String? matchId;
  @override
  final String? tournamentId;
  @override
  final String? roundId;
  @override
  final String? groupId;
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
// 'upcoming', 'live', 'end'
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
  @override
  final String? leg;

  @override
  String toString() {
    return 'CupLeagueModel(id: $id, matchId: $matchId, tournamentId: $tournamentId, roundId: $roundId, groupId: $groupId, homeTeamId: $homeTeamId, homeTeamName: $homeTeamName, homeTeamLogo: $homeTeamLogo, awayTeamId: $awayTeamId, awayTeamName: $awayTeamName, awayTeamLogo: $awayTeamLogo, homeScore: $homeScore, awayScore: $awayScore, status: $status, matchDate: $matchDate, matchDateMs: $matchDateMs, venue: $venue, gameType: $gameType, ageGroup: $ageGroup, leg: $leg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupLeagueModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
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
            (identical(other.leg, leg) || other.leg == leg));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        matchId,
        tournamentId,
        roundId,
        groupId,
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
        leg
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupLeagueModelImplCopyWith<_$CupLeagueModelImpl> get copyWith =>
      __$$CupLeagueModelImplCopyWithImpl<_$CupLeagueModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupLeagueModelImplToJson(
      this,
    );
  }
}

abstract class _CupLeagueModel implements CupLeagueModel {
  const factory _CupLeagueModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') final String? matchId,
      final String? tournamentId,
      final String? roundId,
      final String? groupId,
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
      final String? leg}) = _$CupLeagueModelImpl;

  factory _CupLeagueModel.fromJson(Map<String, dynamic> json) =
      _$CupLeagueModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String? get matchId;
  @override
  String? get tournamentId;
  @override
  String? get roundId;
  @override
  String? get groupId;
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
  @override // 'upcoming', 'live', 'end'
  String? get matchDate;
  @override
  int get matchDateMs;
  @override
  String? get venue;
  @override
  String? get gameType;
  @override
  String? get ageGroup;
  @override
  String? get leg;
  @override
  @JsonKey(ignore: true)
  _$$CupLeagueModelImplCopyWith<_$CupLeagueModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupMatchModel _$CupMatchModelFromJson(Map<String, dynamic> json) {
  return _CupMatchModel.fromJson(json);
}

/// @nodoc
mixin _$CupMatchModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String? get matchId => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get homeTeamId => throw _privateConstructorUsedError;
  String? get homeTeamName => throw _privateConstructorUsedError;
  String? get homeTeamShortName => throw _privateConstructorUsedError;
  String? get homeTeamLogo => throw _privateConstructorUsedError;
  String? get awayTeamId => throw _privateConstructorUsedError;
  String? get awayTeamName => throw _privateConstructorUsedError;
  String? get awayTeamShortName => throw _privateConstructorUsedError;
  String? get awayTeamLogo => throw _privateConstructorUsedError;
  int? get homeScore => throw _privateConstructorUsedError;
  int? get awayScore => throw _privateConstructorUsedError;
  int? get homeExtraTimeScore => throw _privateConstructorUsedError;
  int? get awayExtraTimeScore => throw _privateConstructorUsedError;
  int? get homePenaltyScore => throw _privateConstructorUsedError;
  int? get awayPenaltyScore => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;
  String? get winnerName => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get scoreStatus => throw _privateConstructorUsedError;
  String? get acceptStatus => throw _privateConstructorUsedError;
  String? get gameSemiType => throw _privateConstructorUsedError;
  String? get matchDate => throw _privateConstructorUsedError;
  String? get matchTime => throw _privateConstructorUsedError;
  String? get matchName => throw _privateConstructorUsedError;
  int get matchDateMs => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get fieldName => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  String? get seq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupMatchModelCopyWith<CupMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupMatchModelCopyWith<$Res> {
  factory $CupMatchModelCopyWith(
          CupMatchModel value, $Res Function(CupMatchModel) then) =
      _$CupMatchModelCopyWithImpl<$Res, CupMatchModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
      String? tournamentId,
      String? roundId,
      String? homeTeamId,
      String? homeTeamName,
      String? homeTeamShortName,
      String? homeTeamLogo,
      String? awayTeamId,
      String? awayTeamName,
      String? awayTeamShortName,
      String? awayTeamLogo,
      int? homeScore,
      int? awayScore,
      int? homeExtraTimeScore,
      int? awayExtraTimeScore,
      int? homePenaltyScore,
      int? awayPenaltyScore,
      String? winnerId,
      String? winnerName,
      String? status,
      String? scoreStatus,
      String? acceptStatus,
      String? gameSemiType,
      String? matchDate,
      String? matchTime,
      String? matchName,
      int matchDateMs,
      String? venue,
      String? city,
      String? fieldName,
      String? gameType,
      String? ageGroup,
      String? level,
      String? seq});
}

/// @nodoc
class _$CupMatchModelCopyWithImpl<$Res, $Val extends CupMatchModel>
    implements $CupMatchModelCopyWith<$Res> {
  _$CupMatchModelCopyWithImpl(this._value, this._then);

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
    Object? roundId = freezed,
    Object? homeTeamId = freezed,
    Object? homeTeamName = freezed,
    Object? homeTeamShortName = freezed,
    Object? homeTeamLogo = freezed,
    Object? awayTeamId = freezed,
    Object? awayTeamName = freezed,
    Object? awayTeamShortName = freezed,
    Object? awayTeamLogo = freezed,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
    Object? homeExtraTimeScore = freezed,
    Object? awayExtraTimeScore = freezed,
    Object? homePenaltyScore = freezed,
    Object? awayPenaltyScore = freezed,
    Object? winnerId = freezed,
    Object? winnerName = freezed,
    Object? status = freezed,
    Object? scoreStatus = freezed,
    Object? acceptStatus = freezed,
    Object? gameSemiType = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? matchName = freezed,
    Object? matchDateMs = null,
    Object? venue = freezed,
    Object? city = freezed,
    Object? fieldName = freezed,
    Object? gameType = freezed,
    Object? ageGroup = freezed,
    Object? level = freezed,
    Object? seq = freezed,
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
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamId: freezed == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamName: freezed == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamShortName: freezed == homeTeamShortName
          ? _value.homeTeamShortName
          : homeTeamShortName // ignore: cast_nullable_to_non_nullable
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
      awayTeamShortName: freezed == awayTeamShortName
          ? _value.awayTeamShortName
          : awayTeamShortName // ignore: cast_nullable_to_non_nullable
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
      winnerName: freezed == winnerName
          ? _value.winnerName
          : winnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreStatus: freezed == scoreStatus
          ? _value.scoreStatus
          : scoreStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      gameSemiType: freezed == gameSemiType
          ? _value.gameSemiType
          : gameSemiType // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      matchName: freezed == matchName
          ? _value.matchName
          : matchName // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDateMs: null == matchDateMs
          ? _value.matchDateMs
          : matchDateMs // ignore: cast_nullable_to_non_nullable
              as int,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupMatchModelImplCopyWith<$Res>
    implements $CupMatchModelCopyWith<$Res> {
  factory _$$CupMatchModelImplCopyWith(
          _$CupMatchModelImpl value, $Res Function(_$CupMatchModelImpl) then) =
      __$$CupMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
      String? tournamentId,
      String? roundId,
      String? homeTeamId,
      String? homeTeamName,
      String? homeTeamShortName,
      String? homeTeamLogo,
      String? awayTeamId,
      String? awayTeamName,
      String? awayTeamShortName,
      String? awayTeamLogo,
      int? homeScore,
      int? awayScore,
      int? homeExtraTimeScore,
      int? awayExtraTimeScore,
      int? homePenaltyScore,
      int? awayPenaltyScore,
      String? winnerId,
      String? winnerName,
      String? status,
      String? scoreStatus,
      String? acceptStatus,
      String? gameSemiType,
      String? matchDate,
      String? matchTime,
      String? matchName,
      int matchDateMs,
      String? venue,
      String? city,
      String? fieldName,
      String? gameType,
      String? ageGroup,
      String? level,
      String? seq});
}

/// @nodoc
class __$$CupMatchModelImplCopyWithImpl<$Res>
    extends _$CupMatchModelCopyWithImpl<$Res, _$CupMatchModelImpl>
    implements _$$CupMatchModelImplCopyWith<$Res> {
  __$$CupMatchModelImplCopyWithImpl(
      _$CupMatchModelImpl _value, $Res Function(_$CupMatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
    Object? tournamentId = freezed,
    Object? roundId = freezed,
    Object? homeTeamId = freezed,
    Object? homeTeamName = freezed,
    Object? homeTeamShortName = freezed,
    Object? homeTeamLogo = freezed,
    Object? awayTeamId = freezed,
    Object? awayTeamName = freezed,
    Object? awayTeamShortName = freezed,
    Object? awayTeamLogo = freezed,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
    Object? homeExtraTimeScore = freezed,
    Object? awayExtraTimeScore = freezed,
    Object? homePenaltyScore = freezed,
    Object? awayPenaltyScore = freezed,
    Object? winnerId = freezed,
    Object? winnerName = freezed,
    Object? status = freezed,
    Object? scoreStatus = freezed,
    Object? acceptStatus = freezed,
    Object? gameSemiType = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? matchName = freezed,
    Object? matchDateMs = null,
    Object? venue = freezed,
    Object? city = freezed,
    Object? fieldName = freezed,
    Object? gameType = freezed,
    Object? ageGroup = freezed,
    Object? level = freezed,
    Object? seq = freezed,
  }) {
    return _then(_$CupMatchModelImpl(
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
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamId: freezed == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamName: freezed == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamShortName: freezed == homeTeamShortName
          ? _value.homeTeamShortName
          : homeTeamShortName // ignore: cast_nullable_to_non_nullable
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
      awayTeamShortName: freezed == awayTeamShortName
          ? _value.awayTeamShortName
          : awayTeamShortName // ignore: cast_nullable_to_non_nullable
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
      winnerName: freezed == winnerName
          ? _value.winnerName
          : winnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreStatus: freezed == scoreStatus
          ? _value.scoreStatus
          : scoreStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptStatus: freezed == acceptStatus
          ? _value.acceptStatus
          : acceptStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      gameSemiType: freezed == gameSemiType
          ? _value.gameSemiType
          : gameSemiType // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      matchName: freezed == matchName
          ? _value.matchName
          : matchName // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDateMs: null == matchDateMs
          ? _value.matchDateMs
          : matchDateMs // ignore: cast_nullable_to_non_nullable
              as int,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldName: freezed == fieldName
          ? _value.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      gameType: freezed == gameType
          ? _value.gameType
          : gameType // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupMatchModelImpl implements _CupMatchModel {
  const _$CupMatchModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') this.matchId,
      this.tournamentId,
      this.roundId,
      this.homeTeamId,
      this.homeTeamName,
      this.homeTeamShortName,
      this.homeTeamLogo,
      this.awayTeamId,
      this.awayTeamName,
      this.awayTeamShortName,
      this.awayTeamLogo,
      this.homeScore,
      this.awayScore,
      this.homeExtraTimeScore,
      this.awayExtraTimeScore,
      this.homePenaltyScore,
      this.awayPenaltyScore,
      this.winnerId,
      this.winnerName,
      this.status,
      this.scoreStatus,
      this.acceptStatus,
      this.gameSemiType,
      this.matchDate,
      this.matchTime,
      this.matchName,
      this.matchDateMs = 0,
      this.venue,
      this.city,
      this.fieldName,
      this.gameType,
      this.ageGroup,
      this.level,
      this.seq});

  factory _$CupMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupMatchModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String? matchId;
  @override
  final String? tournamentId;
  @override
  final String? roundId;
  @override
  final String? homeTeamId;
  @override
  final String? homeTeamName;
  @override
  final String? homeTeamShortName;
  @override
  final String? homeTeamLogo;
  @override
  final String? awayTeamId;
  @override
  final String? awayTeamName;
  @override
  final String? awayTeamShortName;
  @override
  final String? awayTeamLogo;
  @override
  final int? homeScore;
  @override
  final int? awayScore;
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
  final String? winnerName;
  @override
  final String? status;
  @override
  final String? scoreStatus;
  @override
  final String? acceptStatus;
  @override
  final String? gameSemiType;
  @override
  final String? matchDate;
  @override
  final String? matchTime;
  @override
  final String? matchName;
  @override
  @JsonKey()
  final int matchDateMs;
  @override
  final String? venue;
  @override
  final String? city;
  @override
  final String? fieldName;
  @override
  final String? gameType;
  @override
  final String? ageGroup;
  @override
  final String? level;
  @override
  final String? seq;

  @override
  String toString() {
    return 'CupMatchModel(id: $id, matchId: $matchId, tournamentId: $tournamentId, roundId: $roundId, homeTeamId: $homeTeamId, homeTeamName: $homeTeamName, homeTeamShortName: $homeTeamShortName, homeTeamLogo: $homeTeamLogo, awayTeamId: $awayTeamId, awayTeamName: $awayTeamName, awayTeamShortName: $awayTeamShortName, awayTeamLogo: $awayTeamLogo, homeScore: $homeScore, awayScore: $awayScore, homeExtraTimeScore: $homeExtraTimeScore, awayExtraTimeScore: $awayExtraTimeScore, homePenaltyScore: $homePenaltyScore, awayPenaltyScore: $awayPenaltyScore, winnerId: $winnerId, winnerName: $winnerName, status: $status, scoreStatus: $scoreStatus, acceptStatus: $acceptStatus, gameSemiType: $gameSemiType, matchDate: $matchDate, matchTime: $matchTime, matchName: $matchName, matchDateMs: $matchDateMs, venue: $venue, city: $city, fieldName: $fieldName, gameType: $gameType, ageGroup: $ageGroup, level: $level, seq: $seq)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupMatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.homeTeamName, homeTeamName) ||
                other.homeTeamName == homeTeamName) &&
            (identical(other.homeTeamShortName, homeTeamShortName) ||
                other.homeTeamShortName == homeTeamShortName) &&
            (identical(other.homeTeamLogo, homeTeamLogo) ||
                other.homeTeamLogo == homeTeamLogo) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
            (identical(other.awayTeamName, awayTeamName) ||
                other.awayTeamName == awayTeamName) &&
            (identical(other.awayTeamShortName, awayTeamShortName) ||
                other.awayTeamShortName == awayTeamShortName) &&
            (identical(other.awayTeamLogo, awayTeamLogo) ||
                other.awayTeamLogo == awayTeamLogo) &&
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
            (identical(other.winnerName, winnerName) ||
                other.winnerName == winnerName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scoreStatus, scoreStatus) ||
                other.scoreStatus == scoreStatus) &&
            (identical(other.acceptStatus, acceptStatus) ||
                other.acceptStatus == acceptStatus) &&
            (identical(other.gameSemiType, gameSemiType) ||
                other.gameSemiType == gameSemiType) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.matchName, matchName) ||
                other.matchName == matchName) &&
            (identical(other.matchDateMs, matchDateMs) ||
                other.matchDateMs == matchDateMs) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.seq, seq) || other.seq == seq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        matchId,
        tournamentId,
        roundId,
        homeTeamId,
        homeTeamName,
        homeTeamShortName,
        homeTeamLogo,
        awayTeamId,
        awayTeamName,
        awayTeamShortName,
        awayTeamLogo,
        homeScore,
        awayScore,
        homeExtraTimeScore,
        awayExtraTimeScore,
        homePenaltyScore,
        awayPenaltyScore,
        winnerId,
        winnerName,
        status,
        scoreStatus,
        acceptStatus,
        gameSemiType,
        matchDate,
        matchTime,
        matchName,
        matchDateMs,
        venue,
        city,
        fieldName,
        gameType,
        ageGroup,
        level,
        seq
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupMatchModelImplCopyWith<_$CupMatchModelImpl> get copyWith =>
      __$$CupMatchModelImplCopyWithImpl<_$CupMatchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupMatchModelImplToJson(
      this,
    );
  }
}

abstract class _CupMatchModel implements CupMatchModel {
  const factory _CupMatchModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') final String? matchId,
      final String? tournamentId,
      final String? roundId,
      final String? homeTeamId,
      final String? homeTeamName,
      final String? homeTeamShortName,
      final String? homeTeamLogo,
      final String? awayTeamId,
      final String? awayTeamName,
      final String? awayTeamShortName,
      final String? awayTeamLogo,
      final int? homeScore,
      final int? awayScore,
      final int? homeExtraTimeScore,
      final int? awayExtraTimeScore,
      final int? homePenaltyScore,
      final int? awayPenaltyScore,
      final String? winnerId,
      final String? winnerName,
      final String? status,
      final String? scoreStatus,
      final String? acceptStatus,
      final String? gameSemiType,
      final String? matchDate,
      final String? matchTime,
      final String? matchName,
      final int matchDateMs,
      final String? venue,
      final String? city,
      final String? fieldName,
      final String? gameType,
      final String? ageGroup,
      final String? level,
      final String? seq}) = _$CupMatchModelImpl;

  factory _CupMatchModel.fromJson(Map<String, dynamic> json) =
      _$CupMatchModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String? get matchId;
  @override
  String? get tournamentId;
  @override
  String? get roundId;
  @override
  String? get homeTeamId;
  @override
  String? get homeTeamName;
  @override
  String? get homeTeamShortName;
  @override
  String? get homeTeamLogo;
  @override
  String? get awayTeamId;
  @override
  String? get awayTeamName;
  @override
  String? get awayTeamShortName;
  @override
  String? get awayTeamLogo;
  @override
  int? get homeScore;
  @override
  int? get awayScore;
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
  String? get winnerName;
  @override
  String? get status;
  @override
  String? get scoreStatus;
  @override
  String? get acceptStatus;
  @override
  String? get gameSemiType;
  @override
  String? get matchDate;
  @override
  String? get matchTime;
  @override
  String? get matchName;
  @override
  int get matchDateMs;
  @override
  String? get venue;
  @override
  String? get city;
  @override
  String? get fieldName;
  @override
  String? get gameType;
  @override
  String? get ageGroup;
  @override
  String? get level;
  @override
  String? get seq;
  @override
  @JsonKey(ignore: true)
  _$$CupMatchModelImplCopyWith<_$CupMatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupGroupPointTableEntry _$CupGroupPointTableEntryFromJson(
    Map<String, dynamic> json) {
  return _CupGroupPointTableEntry.fromJson(json);
}

/// @nodoc
mixin _$CupGroupPointTableEntry {
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError; // Position
  int get played => throw _privateConstructorUsedError;
  @JsonKey(name: 'win')
  int get won => throw _privateConstructorUsedError;
  @JsonKey(name: 'draw')
  int get drawn => throw _privateConstructorUsedError;
  @JsonKey(name: 'loss')
  int get lost => throw _privateConstructorUsedError;
  @JsonKey(name: 'gf')
  int get goalsFor => throw _privateConstructorUsedError;
  @JsonKey(name: 'ga')
  int get goalsAgainst => throw _privateConstructorUsedError;
  @JsonKey(name: 'gd')
  int get goalDifference => throw _privateConstructorUsedError;
  @JsonKey(name: 'pts')
  int get points => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupGroupPointTableEntryCopyWith<CupGroupPointTableEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupGroupPointTableEntryCopyWith<$Res> {
  factory $CupGroupPointTableEntryCopyWith(CupGroupPointTableEntry value,
          $Res Function(CupGroupPointTableEntry) then) =
      _$CupGroupPointTableEntryCopyWithImpl<$Res, CupGroupPointTableEntry>;
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamLogo,
      int seq,
      int played,
      @JsonKey(name: 'win') int won,
      @JsonKey(name: 'draw') int drawn,
      @JsonKey(name: 'loss') int lost,
      @JsonKey(name: 'gf') int goalsFor,
      @JsonKey(name: 'ga') int goalsAgainst,
      @JsonKey(name: 'gd') int goalDifference,
      @JsonKey(name: 'pts') int points,
      String? groupId,
      String? roundId});
}

/// @nodoc
class _$CupGroupPointTableEntryCopyWithImpl<$Res,
        $Val extends CupGroupPointTableEntry>
    implements $CupGroupPointTableEntryCopyWith<$Res> {
  _$CupGroupPointTableEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? seq = null,
    Object? played = null,
    Object? won = null,
    Object? drawn = null,
    Object? lost = null,
    Object? goalsFor = null,
    Object? goalsAgainst = null,
    Object? goalDifference = null,
    Object? points = null,
    Object? groupId = freezed,
    Object? roundId = freezed,
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
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupGroupPointTableEntryImplCopyWith<$Res>
    implements $CupGroupPointTableEntryCopyWith<$Res> {
  factory _$$CupGroupPointTableEntryImplCopyWith(
          _$CupGroupPointTableEntryImpl value,
          $Res Function(_$CupGroupPointTableEntryImpl) then) =
      __$$CupGroupPointTableEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? teamId,
      String? teamName,
      String? teamLogo,
      int seq,
      int played,
      @JsonKey(name: 'win') int won,
      @JsonKey(name: 'draw') int drawn,
      @JsonKey(name: 'loss') int lost,
      @JsonKey(name: 'gf') int goalsFor,
      @JsonKey(name: 'ga') int goalsAgainst,
      @JsonKey(name: 'gd') int goalDifference,
      @JsonKey(name: 'pts') int points,
      String? groupId,
      String? roundId});
}

/// @nodoc
class __$$CupGroupPointTableEntryImplCopyWithImpl<$Res>
    extends _$CupGroupPointTableEntryCopyWithImpl<$Res,
        _$CupGroupPointTableEntryImpl>
    implements _$$CupGroupPointTableEntryImplCopyWith<$Res> {
  __$$CupGroupPointTableEntryImplCopyWithImpl(
      _$CupGroupPointTableEntryImpl _value,
      $Res Function(_$CupGroupPointTableEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? seq = null,
    Object? played = null,
    Object? won = null,
    Object? drawn = null,
    Object? lost = null,
    Object? goalsFor = null,
    Object? goalsAgainst = null,
    Object? goalDifference = null,
    Object? points = null,
    Object? groupId = freezed,
    Object? roundId = freezed,
  }) {
    return _then(_$CupGroupPointTableEntryImpl(
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupGroupPointTableEntryImpl implements _CupGroupPointTableEntry {
  const _$CupGroupPointTableEntryImpl(
      {this.teamId,
      this.teamName,
      this.teamLogo,
      this.seq = 0,
      this.played = 0,
      @JsonKey(name: 'win') this.won = 0,
      @JsonKey(name: 'draw') this.drawn = 0,
      @JsonKey(name: 'loss') this.lost = 0,
      @JsonKey(name: 'gf') this.goalsFor = 0,
      @JsonKey(name: 'ga') this.goalsAgainst = 0,
      @JsonKey(name: 'gd') this.goalDifference = 0,
      @JsonKey(name: 'pts') this.points = 0,
      this.groupId,
      this.roundId});

  factory _$CupGroupPointTableEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupGroupPointTableEntryImplFromJson(json);

  @override
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? teamLogo;
  @override
  @JsonKey()
  final int seq;
// Position
  @override
  @JsonKey()
  final int played;
  @override
  @JsonKey(name: 'win')
  final int won;
  @override
  @JsonKey(name: 'draw')
  final int drawn;
  @override
  @JsonKey(name: 'loss')
  final int lost;
  @override
  @JsonKey(name: 'gf')
  final int goalsFor;
  @override
  @JsonKey(name: 'ga')
  final int goalsAgainst;
  @override
  @JsonKey(name: 'gd')
  final int goalDifference;
  @override
  @JsonKey(name: 'pts')
  final int points;
  @override
  final String? groupId;
  @override
  final String? roundId;

  @override
  String toString() {
    return 'CupGroupPointTableEntry(teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, seq: $seq, played: $played, won: $won, drawn: $drawn, lost: $lost, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, goalDifference: $goalDifference, points: $points, groupId: $groupId, roundId: $roundId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupGroupPointTableEntryImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.seq, seq) || other.seq == seq) &&
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
            (identical(other.points, points) || other.points == points) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teamId,
      teamName,
      teamLogo,
      seq,
      played,
      won,
      drawn,
      lost,
      goalsFor,
      goalsAgainst,
      goalDifference,
      points,
      groupId,
      roundId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupGroupPointTableEntryImplCopyWith<_$CupGroupPointTableEntryImpl>
      get copyWith => __$$CupGroupPointTableEntryImplCopyWithImpl<
          _$CupGroupPointTableEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupGroupPointTableEntryImplToJson(
      this,
    );
  }
}

abstract class _CupGroupPointTableEntry implements CupGroupPointTableEntry {
  const factory _CupGroupPointTableEntry(
      {final String? teamId,
      final String? teamName,
      final String? teamLogo,
      final int seq,
      final int played,
      @JsonKey(name: 'win') final int won,
      @JsonKey(name: 'draw') final int drawn,
      @JsonKey(name: 'loss') final int lost,
      @JsonKey(name: 'gf') final int goalsFor,
      @JsonKey(name: 'ga') final int goalsAgainst,
      @JsonKey(name: 'gd') final int goalDifference,
      @JsonKey(name: 'pts') final int points,
      final String? groupId,
      final String? roundId}) = _$CupGroupPointTableEntryImpl;

  factory _CupGroupPointTableEntry.fromJson(Map<String, dynamic> json) =
      _$CupGroupPointTableEntryImpl.fromJson;

  @override
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get teamLogo;
  @override
  int get seq;
  @override // Position
  int get played;
  @override
  @JsonKey(name: 'win')
  int get won;
  @override
  @JsonKey(name: 'draw')
  int get drawn;
  @override
  @JsonKey(name: 'loss')
  int get lost;
  @override
  @JsonKey(name: 'gf')
  int get goalsFor;
  @override
  @JsonKey(name: 'ga')
  int get goalsAgainst;
  @override
  @JsonKey(name: 'gd')
  int get goalDifference;
  @override
  @JsonKey(name: 'pts')
  int get points;
  @override
  String? get groupId;
  @override
  String? get roundId;
  @override
  @JsonKey(ignore: true)
  _$$CupGroupPointTableEntryImplCopyWith<_$CupGroupPointTableEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CupBannerModel _$CupBannerModelFromJson(Map<String, dynamic> json) {
  return _CupBannerModel.fromJson(json);
}

/// @nodoc
mixin _$CupBannerModel {
  String? get imageUrl => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupBannerModelCopyWith<CupBannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupBannerModelCopyWith<$Res> {
  factory $CupBannerModelCopyWith(
          CupBannerModel value, $Res Function(CupBannerModel) then) =
      _$CupBannerModelCopyWithImpl<$Res, CupBannerModel>;
  @useResult
  $Res call({String? imageUrl, int seq, String? link});
}

/// @nodoc
class _$CupBannerModelCopyWithImpl<$Res, $Val extends CupBannerModel>
    implements $CupBannerModelCopyWith<$Res> {
  _$CupBannerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? seq = null,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupBannerModelImplCopyWith<$Res>
    implements $CupBannerModelCopyWith<$Res> {
  factory _$$CupBannerModelImplCopyWith(_$CupBannerModelImpl value,
          $Res Function(_$CupBannerModelImpl) then) =
      __$$CupBannerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? imageUrl, int seq, String? link});
}

/// @nodoc
class __$$CupBannerModelImplCopyWithImpl<$Res>
    extends _$CupBannerModelCopyWithImpl<$Res, _$CupBannerModelImpl>
    implements _$$CupBannerModelImplCopyWith<$Res> {
  __$$CupBannerModelImplCopyWithImpl(
      _$CupBannerModelImpl _value, $Res Function(_$CupBannerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? seq = null,
    Object? link = freezed,
  }) {
    return _then(_$CupBannerModelImpl(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupBannerModelImpl implements _CupBannerModel {
  const _$CupBannerModelImpl({this.imageUrl, this.seq = 0, this.link});

  factory _$CupBannerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupBannerModelImplFromJson(json);

  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int seq;
  @override
  final String? link;

  @override
  String toString() {
    return 'CupBannerModel(imageUrl: $imageUrl, seq: $seq, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupBannerModelImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, seq, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupBannerModelImplCopyWith<_$CupBannerModelImpl> get copyWith =>
      __$$CupBannerModelImplCopyWithImpl<_$CupBannerModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupBannerModelImplToJson(
      this,
    );
  }
}

abstract class _CupBannerModel implements CupBannerModel {
  const factory _CupBannerModel(
      {final String? imageUrl,
      final int seq,
      final String? link}) = _$CupBannerModelImpl;

  factory _CupBannerModel.fromJson(Map<String, dynamic> json) =
      _$CupBannerModelImpl.fromJson;

  @override
  String? get imageUrl;
  @override
  int get seq;
  @override
  String? get link;
  @override
  @JsonKey(ignore: true)
  _$$CupBannerModelImplCopyWith<_$CupBannerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupTeamModel _$CupTeamModelFromJson(Map<String, dynamic> json) {
  return _CupTeamModel.fromJson(json);
}

/// @nodoc
mixin _$CupTeamModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamId')
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupTeamModelCopyWith<CupTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupTeamModelCopyWith<$Res> {
  factory $CupTeamModelCopyWith(
          CupTeamModel value, $Res Function(CupTeamModel) then) =
      _$CupTeamModelCopyWithImpl<$Res, CupTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String? teamName,
      String? logo,
      String? country});
}

/// @nodoc
class _$CupTeamModelCopyWithImpl<$Res, $Val extends CupTeamModel>
    implements $CupTeamModelCopyWith<$Res> {
  _$CupTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? logo = freezed,
    Object? country = freezed,
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
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupTeamModelImplCopyWith<$Res>
    implements $CupTeamModelCopyWith<$Res> {
  factory _$$CupTeamModelImplCopyWith(
          _$CupTeamModelImpl value, $Res Function(_$CupTeamModelImpl) then) =
      __$$CupTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String? teamName,
      String? logo,
      String? country});
}

/// @nodoc
class __$$CupTeamModelImplCopyWithImpl<$Res>
    extends _$CupTeamModelCopyWithImpl<$Res, _$CupTeamModelImpl>
    implements _$$CupTeamModelImplCopyWith<$Res> {
  __$$CupTeamModelImplCopyWithImpl(
      _$CupTeamModelImpl _value, $Res Function(_$CupTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? logo = freezed,
    Object? country = freezed,
  }) {
    return _then(_$CupTeamModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupTeamModelImpl implements _CupTeamModel {
  const _$CupTeamModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'teamId') this.teamId,
      this.teamName,
      this.logo,
      this.country});

  factory _$CupTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupTeamModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'teamId')
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? logo;
  @override
  final String? country;

  @override
  String toString() {
    return 'CupTeamModel(id: $id, teamId: $teamId, teamName: $teamName, logo: $logo, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, teamId, teamName, logo, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupTeamModelImplCopyWith<_$CupTeamModelImpl> get copyWith =>
      __$$CupTeamModelImplCopyWithImpl<_$CupTeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupTeamModelImplToJson(
      this,
    );
  }
}

abstract class _CupTeamModel implements CupTeamModel {
  const factory _CupTeamModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'teamId') final String? teamId,
      final String? teamName,
      final String? logo,
      final String? country}) = _$CupTeamModelImpl;

  factory _CupTeamModel.fromJson(Map<String, dynamic> json) =
      _$CupTeamModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'teamId')
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get logo;
  @override
  String? get country;
  @override
  @JsonKey(ignore: true)
  _$$CupTeamModelImplCopyWith<_$CupTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupSponsorModel _$CupSponsorModelFromJson(Map<String, dynamic> json) {
  return _CupSponsorModel.fromJson(json);
}

/// @nodoc
mixin _$CupSponsorModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupSponsorModelCopyWith<CupSponsorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupSponsorModelCopyWith<$Res> {
  factory $CupSponsorModelCopyWith(
          CupSponsorModel value, $Res Function(CupSponsorModel) then) =
      _$CupSponsorModelCopyWithImpl<$Res, CupSponsorModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? name,
      String? logo,
      String? website});
}

/// @nodoc
class _$CupSponsorModelCopyWithImpl<$Res, $Val extends CupSponsorModel>
    implements $CupSponsorModelCopyWith<$Res> {
  _$CupSponsorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? website = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupSponsorModelImplCopyWith<$Res>
    implements $CupSponsorModelCopyWith<$Res> {
  factory _$$CupSponsorModelImplCopyWith(_$CupSponsorModelImpl value,
          $Res Function(_$CupSponsorModelImpl) then) =
      __$$CupSponsorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? name,
      String? logo,
      String? website});
}

/// @nodoc
class __$$CupSponsorModelImplCopyWithImpl<$Res>
    extends _$CupSponsorModelCopyWithImpl<$Res, _$CupSponsorModelImpl>
    implements _$$CupSponsorModelImplCopyWith<$Res> {
  __$$CupSponsorModelImplCopyWithImpl(
      _$CupSponsorModelImpl _value, $Res Function(_$CupSponsorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? website = freezed,
  }) {
    return _then(_$CupSponsorModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupSponsorModelImpl implements _CupSponsorModel {
  const _$CupSponsorModelImpl(
      {@JsonKey(name: '_id') this.id, this.name, this.logo, this.website});

  factory _$CupSponsorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupSponsorModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? name;
  @override
  final String? logo;
  @override
  final String? website;

  @override
  String toString() {
    return 'CupSponsorModel(id: $id, name: $name, logo: $logo, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupSponsorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, logo, website);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupSponsorModelImplCopyWith<_$CupSponsorModelImpl> get copyWith =>
      __$$CupSponsorModelImplCopyWithImpl<_$CupSponsorModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupSponsorModelImplToJson(
      this,
    );
  }
}

abstract class _CupSponsorModel implements CupSponsorModel {
  const factory _CupSponsorModel(
      {@JsonKey(name: '_id') final String? id,
      final String? name,
      final String? logo,
      final String? website}) = _$CupSponsorModelImpl;

  factory _CupSponsorModel.fromJson(Map<String, dynamic> json) =
      _$CupSponsorModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get name;
  @override
  String? get logo;
  @override
  String? get website;
  @override
  @JsonKey(ignore: true)
  _$$CupSponsorModelImplCopyWith<_$CupSponsorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CupPlayerStatEntry _$CupPlayerStatEntryFromJson(Map<String, dynamic> json) {
  return _CupPlayerStatEntry.fromJson(json);
}

/// @nodoc
mixin _$CupPlayerStatEntry {
  String? get userId => throw _privateConstructorUsedError;
  String? get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  int get count =>
      throw _privateConstructorUsedError; // Goals, assists, or MOM count
  int get yellowCards => throw _privateConstructorUsedError;
  int get redCards => throw _privateConstructorUsedError;
  String? get roundId => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CupPlayerStatEntryCopyWith<CupPlayerStatEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CupPlayerStatEntryCopyWith<$Res> {
  factory $CupPlayerStatEntryCopyWith(
          CupPlayerStatEntry value, $Res Function(CupPlayerStatEntry) then) =
      _$CupPlayerStatEntryCopyWithImpl<$Res, CupPlayerStatEntry>;
  @useResult
  $Res call(
      {String? userId,
      String? playerName,
      String? playerImage,
      String? teamId,
      String? teamName,
      int count,
      int yellowCards,
      int redCards,
      String? roundId,
      String? groupId});
}

/// @nodoc
class _$CupPlayerStatEntryCopyWithImpl<$Res, $Val extends CupPlayerStatEntry>
    implements $CupPlayerStatEntryCopyWith<$Res> {
  _$CupPlayerStatEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? playerName = freezed,
    Object? playerImage = freezed,
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? count = null,
    Object? yellowCards = null,
    Object? redCards = null,
    Object? roundId = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      playerName: freezed == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String?,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      yellowCards: null == yellowCards
          ? _value.yellowCards
          : yellowCards // ignore: cast_nullable_to_non_nullable
              as int,
      redCards: null == redCards
          ? _value.redCards
          : redCards // ignore: cast_nullable_to_non_nullable
              as int,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CupPlayerStatEntryImplCopyWith<$Res>
    implements $CupPlayerStatEntryCopyWith<$Res> {
  factory _$$CupPlayerStatEntryImplCopyWith(_$CupPlayerStatEntryImpl value,
          $Res Function(_$CupPlayerStatEntryImpl) then) =
      __$$CupPlayerStatEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? playerName,
      String? playerImage,
      String? teamId,
      String? teamName,
      int count,
      int yellowCards,
      int redCards,
      String? roundId,
      String? groupId});
}

/// @nodoc
class __$$CupPlayerStatEntryImplCopyWithImpl<$Res>
    extends _$CupPlayerStatEntryCopyWithImpl<$Res, _$CupPlayerStatEntryImpl>
    implements _$$CupPlayerStatEntryImplCopyWith<$Res> {
  __$$CupPlayerStatEntryImplCopyWithImpl(_$CupPlayerStatEntryImpl _value,
      $Res Function(_$CupPlayerStatEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? playerName = freezed,
    Object? playerImage = freezed,
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? count = null,
    Object? yellowCards = null,
    Object? redCards = null,
    Object? roundId = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_$CupPlayerStatEntryImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      playerName: freezed == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String?,
      playerImage: freezed == playerImage
          ? _value.playerImage
          : playerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      yellowCards: null == yellowCards
          ? _value.yellowCards
          : yellowCards // ignore: cast_nullable_to_non_nullable
              as int,
      redCards: null == redCards
          ? _value.redCards
          : redCards // ignore: cast_nullable_to_non_nullable
              as int,
      roundId: freezed == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CupPlayerStatEntryImpl implements _CupPlayerStatEntry {
  const _$CupPlayerStatEntryImpl(
      {this.userId,
      this.playerName,
      this.playerImage,
      this.teamId,
      this.teamName,
      this.count = 0,
      this.yellowCards = 0,
      this.redCards = 0,
      this.roundId,
      this.groupId});

  factory _$CupPlayerStatEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CupPlayerStatEntryImplFromJson(json);

  @override
  final String? userId;
  @override
  final String? playerName;
  @override
  final String? playerImage;
  @override
  final String? teamId;
  @override
  final String? teamName;
  @override
  @JsonKey()
  final int count;
// Goals, assists, or MOM count
  @override
  @JsonKey()
  final int yellowCards;
  @override
  @JsonKey()
  final int redCards;
  @override
  final String? roundId;
  @override
  final String? groupId;

  @override
  String toString() {
    return 'CupPlayerStatEntry(userId: $userId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, teamName: $teamName, count: $count, yellowCards: $yellowCards, redCards: $redCards, roundId: $roundId, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CupPlayerStatEntryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerImage, playerImage) ||
                other.playerImage == playerImage) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.yellowCards, yellowCards) ||
                other.yellowCards == yellowCards) &&
            (identical(other.redCards, redCards) ||
                other.redCards == redCards) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, playerName, playerImage,
      teamId, teamName, count, yellowCards, redCards, roundId, groupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CupPlayerStatEntryImplCopyWith<_$CupPlayerStatEntryImpl> get copyWith =>
      __$$CupPlayerStatEntryImplCopyWithImpl<_$CupPlayerStatEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CupPlayerStatEntryImplToJson(
      this,
    );
  }
}

abstract class _CupPlayerStatEntry implements CupPlayerStatEntry {
  const factory _CupPlayerStatEntry(
      {final String? userId,
      final String? playerName,
      final String? playerImage,
      final String? teamId,
      final String? teamName,
      final int count,
      final int yellowCards,
      final int redCards,
      final String? roundId,
      final String? groupId}) = _$CupPlayerStatEntryImpl;

  factory _CupPlayerStatEntry.fromJson(Map<String, dynamic> json) =
      _$CupPlayerStatEntryImpl.fromJson;

  @override
  String? get userId;
  @override
  String? get playerName;
  @override
  String? get playerImage;
  @override
  String? get teamId;
  @override
  String? get teamName;
  @override
  int get count;
  @override // Goals, assists, or MOM count
  int get yellowCards;
  @override
  int get redCards;
  @override
  String? get roundId;
  @override
  String? get groupId;
  @override
  @JsonKey(ignore: true)
  _$$CupPlayerStatEntryImplCopyWith<_$CupPlayerStatEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
