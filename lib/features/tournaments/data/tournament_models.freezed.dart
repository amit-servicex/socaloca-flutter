// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_models.dart';

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
  @JsonKey(name: 'rule')
  String? get rule =>
      throw _privateConstructorUsedError; // tournament type: 'league'/'cup'
  @JsonKey(name: 'tmntType')
  String? get tmntType => throw _privateConstructorUsedError;
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
  bool get withdrawable => throw _privateConstructorUsedError;
  List<BannerModel>? get banners => throw _privateConstructorUsedError;
  List<TeamModel>? get teams => throw _privateConstructorUsedError;
  List<SponsorModel>? get sponsors => throw _privateConstructorUsedError;
  ItineraryModel? get itinerary => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'rule') String? rule,
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
      List<BannerModel>? banners,
      List<TeamModel>? teams,
      List<SponsorModel>? sponsors,
      ItineraryModel? itinerary});

  $ItineraryModelCopyWith<$Res>? get itinerary;
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
    Object? rule = freezed,
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
    Object? banners = freezed,
    Object? teams = freezed,
    Object? sponsors = freezed,
    Object? itinerary = freezed,
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
      rule: freezed == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
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
      banners: freezed == banners
          ? _value.banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerModel>?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>?,
      sponsors: freezed == sponsors
          ? _value.sponsors
          : sponsors // ignore: cast_nullable_to_non_nullable
              as List<SponsorModel>?,
      itinerary: freezed == itinerary
          ? _value.itinerary
          : itinerary // ignore: cast_nullable_to_non_nullable
              as ItineraryModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItineraryModelCopyWith<$Res>? get itinerary {
    if (_value.itinerary == null) {
      return null;
    }

    return $ItineraryModelCopyWith<$Res>(_value.itinerary!, (value) {
      return _then(_value.copyWith(itinerary: value) as $Val);
    });
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
      @JsonKey(name: 'rule') String? rule,
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
      List<BannerModel>? banners,
      List<TeamModel>? teams,
      List<SponsorModel>? sponsors,
      ItineraryModel? itinerary});

  @override
  $ItineraryModelCopyWith<$Res>? get itinerary;
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
    Object? rule = freezed,
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
    Object? banners = freezed,
    Object? teams = freezed,
    Object? sponsors = freezed,
    Object? itinerary = freezed,
  }) {
    return _then(_$TournamentModelImpl(
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
      rule: freezed == rule
          ? _value.rule
          : rule // ignore: cast_nullable_to_non_nullable
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
      banners: freezed == banners
          ? _value._banners
          : banners // ignore: cast_nullable_to_non_nullable
              as List<BannerModel>?,
      teams: freezed == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamModel>?,
      sponsors: freezed == sponsors
          ? _value._sponsors
          : sponsors // ignore: cast_nullable_to_non_nullable
              as List<SponsorModel>?,
      itinerary: freezed == itinerary
          ? _value.itinerary
          : itinerary // ignore: cast_nullable_to_non_nullable
              as ItineraryModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentModelImpl implements _TournamentModel {
  const _$TournamentModelImpl(
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
      @JsonKey(name: 'rule') this.rule,
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
      final List<BannerModel>? banners,
      final List<TeamModel>? teams,
      final List<SponsorModel>? sponsors,
      this.itinerary})
      : _banners = banners,
        _teams = teams,
        _sponsors = sponsors;

  factory _$TournamentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentModelImplFromJson(json);

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
  @JsonKey(name: 'rule')
  final String? rule;
// tournament type: 'league'/'cup'
  @override
  @JsonKey(name: 'tmntType')
  final String? tmntType;
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
  final List<BannerModel>? _banners;
  @override
  List<BannerModel>? get banners {
    final value = _banners;
    if (value == null) return null;
    if (_banners is EqualUnmodifiableListView) return _banners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TeamModel>? _teams;
  @override
  List<TeamModel>? get teams {
    final value = _teams;
    if (value == null) return null;
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SponsorModel>? _sponsors;
  @override
  List<SponsorModel>? get sponsors {
    final value = _sponsors;
    if (value == null) return null;
    if (_sponsors is EqualUnmodifiableListView) return _sponsors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ItineraryModel? itinerary;

  @override
  String toString() {
    return 'TournamentModel(id: $id, tournamentId: $tournamentId, name: $name, logo: $logo, location: $location, venue: $venue, ageGroup: $ageGroup, ageCat: $ageCat, gameType: $gameType, gender: $gender, startDate: $startDate, endDate: $endDate, status: $status, rule: $rule, tmntType: $tmntType, visibility: $visibility, country: $country, confed: $confed, parentId: $parentId, createdBy: $createdBy, notes: $notes, description: $description, prize: $prize, regFee: $regFee, orgDetails: $orgDetails, fsdDate: $fsdDate, fsdTime: $fsdTime, fsdGmtMs: $fsdGmtMs, teamPlayerType: $teamPlayerType, teamPlayerLimit: $teamPlayerLimit, followCount: $followCount, isFollowing: $isFollowing, teamCount: $teamCount, matchCount: $matchCount, withdrawable: $withdrawable, banners: $banners, teams: $teams, sponsors: $sponsors, itinerary: $itinerary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentModelImpl &&
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
            (identical(other.rule, rule) || other.rule == rule) &&
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
            const DeepCollectionEquality().equals(other._banners, _banners) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._sponsors, _sponsors) &&
            (identical(other.itinerary, itinerary) ||
                other.itinerary == itinerary));
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
        rule,
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
        const DeepCollectionEquality().hash(_banners),
        const DeepCollectionEquality().hash(_teams),
        const DeepCollectionEquality().hash(_sponsors),
        itinerary
      ]);

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
      @JsonKey(name: 'rule') final String? rule,
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
      final List<BannerModel>? banners,
      final List<TeamModel>? teams,
      final List<SponsorModel>? sponsors,
      final ItineraryModel? itinerary}) = _$TournamentModelImpl;

  factory _TournamentModel.fromJson(Map<String, dynamic> json) =
      _$TournamentModelImpl.fromJson;

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
  @JsonKey(name: 'rule')
  String? get rule;
  @override // tournament type: 'league'/'cup'
  @JsonKey(name: 'tmntType')
  String? get tmntType;
  @override
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
  @override
  List<BannerModel>? get banners;
  @override
  List<TeamModel>? get teams;
  @override
  List<SponsorModel>? get sponsors;
  @override
  ItineraryModel? get itinerary;
  @override
  @JsonKey(ignore: true)
  _$$TournamentModelImplCopyWith<_$TournamentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return _BannerModel.fromJson(json);
}

/// @nodoc
mixin _$BannerModel {
  String? get imageUrl => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BannerModelCopyWith<BannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerModelCopyWith<$Res> {
  factory $BannerModelCopyWith(
          BannerModel value, $Res Function(BannerModel) then) =
      _$BannerModelCopyWithImpl<$Res, BannerModel>;
  @useResult
  $Res call({String? imageUrl, int seq, String? link});
}

/// @nodoc
class _$BannerModelCopyWithImpl<$Res, $Val extends BannerModel>
    implements $BannerModelCopyWith<$Res> {
  _$BannerModelCopyWithImpl(this._value, this._then);

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
abstract class _$$BannerModelImplCopyWith<$Res>
    implements $BannerModelCopyWith<$Res> {
  factory _$$BannerModelImplCopyWith(
          _$BannerModelImpl value, $Res Function(_$BannerModelImpl) then) =
      __$$BannerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? imageUrl, int seq, String? link});
}

/// @nodoc
class __$$BannerModelImplCopyWithImpl<$Res>
    extends _$BannerModelCopyWithImpl<$Res, _$BannerModelImpl>
    implements _$$BannerModelImplCopyWith<$Res> {
  __$$BannerModelImplCopyWithImpl(
      _$BannerModelImpl _value, $Res Function(_$BannerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? seq = null,
    Object? link = freezed,
  }) {
    return _then(_$BannerModelImpl(
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
class _$BannerModelImpl implements _BannerModel {
  const _$BannerModelImpl({this.imageUrl, this.seq = 0, this.link});

  factory _$BannerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BannerModelImplFromJson(json);

  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final int seq;
  @override
  final String? link;

  @override
  String toString() {
    return 'BannerModel(imageUrl: $imageUrl, seq: $seq, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BannerModelImpl &&
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
  _$$BannerModelImplCopyWith<_$BannerModelImpl> get copyWith =>
      __$$BannerModelImplCopyWithImpl<_$BannerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BannerModelImplToJson(
      this,
    );
  }
}

abstract class _BannerModel implements BannerModel {
  const factory _BannerModel(
      {final String? imageUrl,
      final int seq,
      final String? link}) = _$BannerModelImpl;

  factory _BannerModel.fromJson(Map<String, dynamic> json) =
      _$BannerModelImpl.fromJson;

  @override
  String? get imageUrl;
  @override
  int get seq;
  @override
  String? get link;
  @override
  @JsonKey(ignore: true)
  _$$BannerModelImplCopyWith<_$BannerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamId')
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamModelCopyWith<TeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamModelCopyWith<$Res> {
  factory $TeamModelCopyWith(TeamModel value, $Res Function(TeamModel) then) =
      _$TeamModelCopyWithImpl<$Res, TeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String? teamName,
      String? imageUrl,
      String? country});
}

/// @nodoc
class _$TeamModelCopyWithImpl<$Res, $Val extends TeamModel>
    implements $TeamModelCopyWith<$Res> {
  _$TeamModelCopyWithImpl(this._value, this._then);

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
    Object? imageUrl = freezed,
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamModelImplCopyWith<$Res>
    implements $TeamModelCopyWith<$Res> {
  factory _$$TeamModelImplCopyWith(
          _$TeamModelImpl value, $Res Function(_$TeamModelImpl) then) =
      __$$TeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String? teamName,
      String? imageUrl,
      String? country});
}

/// @nodoc
class __$$TeamModelImplCopyWithImpl<$Res>
    extends _$TeamModelCopyWithImpl<$Res, _$TeamModelImpl>
    implements _$$TeamModelImplCopyWith<$Res> {
  __$$TeamModelImplCopyWithImpl(
      _$TeamModelImpl _value, $Res Function(_$TeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? imageUrl = freezed,
    Object? country = freezed,
  }) {
    return _then(_$TeamModelImpl(
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
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
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
class _$TeamModelImpl implements _TeamModel {
  const _$TeamModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'teamId') this.teamId,
      this.teamName,
      this.imageUrl,
      this.country});

  factory _$TeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'teamId')
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? imageUrl;
  @override
  final String? country;

  @override
  String toString() {
    return 'TeamModel(id: $id, teamId: $teamId, teamName: $teamName, imageUrl: $imageUrl, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, teamId, teamName, imageUrl, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      __$$TeamModelImplCopyWithImpl<_$TeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamModelImplToJson(
      this,
    );
  }
}

abstract class _TeamModel implements TeamModel {
  const factory _TeamModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'teamId') final String? teamId,
      final String? teamName,
      final String? imageUrl,
      final String? country}) = _$TeamModelImpl;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'teamId')
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get imageUrl;
  @override
  String? get country;
  @override
  @JsonKey(ignore: true)
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SponsorModel _$SponsorModelFromJson(Map<String, dynamic> json) {
  return _SponsorModel.fromJson(json);
}

/// @nodoc
mixin _$SponsorModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SponsorModelCopyWith<SponsorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SponsorModelCopyWith<$Res> {
  factory $SponsorModelCopyWith(
          SponsorModel value, $Res Function(SponsorModel) then) =
      _$SponsorModelCopyWithImpl<$Res, SponsorModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? name,
      String? logo,
      String? website});
}

/// @nodoc
class _$SponsorModelCopyWithImpl<$Res, $Val extends SponsorModel>
    implements $SponsorModelCopyWith<$Res> {
  _$SponsorModelCopyWithImpl(this._value, this._then);

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
abstract class _$$SponsorModelImplCopyWith<$Res>
    implements $SponsorModelCopyWith<$Res> {
  factory _$$SponsorModelImplCopyWith(
          _$SponsorModelImpl value, $Res Function(_$SponsorModelImpl) then) =
      __$$SponsorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? name,
      String? logo,
      String? website});
}

/// @nodoc
class __$$SponsorModelImplCopyWithImpl<$Res>
    extends _$SponsorModelCopyWithImpl<$Res, _$SponsorModelImpl>
    implements _$$SponsorModelImplCopyWith<$Res> {
  __$$SponsorModelImplCopyWithImpl(
      _$SponsorModelImpl _value, $Res Function(_$SponsorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? logo = freezed,
    Object? website = freezed,
  }) {
    return _then(_$SponsorModelImpl(
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
class _$SponsorModelImpl implements _SponsorModel {
  const _$SponsorModelImpl(
      {@JsonKey(name: '_id') this.id, this.name, this.logo, this.website});

  factory _$SponsorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SponsorModelImplFromJson(json);

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
    return 'SponsorModel(id: $id, name: $name, logo: $logo, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SponsorModelImpl &&
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
  _$$SponsorModelImplCopyWith<_$SponsorModelImpl> get copyWith =>
      __$$SponsorModelImplCopyWithImpl<_$SponsorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SponsorModelImplToJson(
      this,
    );
  }
}

abstract class _SponsorModel implements SponsorModel {
  const factory _SponsorModel(
      {@JsonKey(name: '_id') final String? id,
      final String? name,
      final String? logo,
      final String? website}) = _$SponsorModelImpl;

  factory _SponsorModel.fromJson(Map<String, dynamic> json) =
      _$SponsorModelImpl.fromJson;

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
  _$$SponsorModelImplCopyWith<_$SponsorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItineraryModel _$ItineraryModelFromJson(Map<String, dynamic> json) {
  return _ItineraryModel.fromJson(json);
}

/// @nodoc
mixin _$ItineraryModel {
  String? get doc => throw _privateConstructorUsedError;
  bool get canView => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItineraryModelCopyWith<ItineraryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItineraryModelCopyWith<$Res> {
  factory $ItineraryModelCopyWith(
          ItineraryModel value, $Res Function(ItineraryModel) then) =
      _$ItineraryModelCopyWithImpl<$Res, ItineraryModel>;
  @useResult
  $Res call({String? doc, bool canView});
}

/// @nodoc
class _$ItineraryModelCopyWithImpl<$Res, $Val extends ItineraryModel>
    implements $ItineraryModelCopyWith<$Res> {
  _$ItineraryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = freezed,
    Object? canView = null,
  }) {
    return _then(_value.copyWith(
      doc: freezed == doc
          ? _value.doc
          : doc // ignore: cast_nullable_to_non_nullable
              as String?,
      canView: null == canView
          ? _value.canView
          : canView // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItineraryModelImplCopyWith<$Res>
    implements $ItineraryModelCopyWith<$Res> {
  factory _$$ItineraryModelImplCopyWith(_$ItineraryModelImpl value,
          $Res Function(_$ItineraryModelImpl) then) =
      __$$ItineraryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? doc, bool canView});
}

/// @nodoc
class __$$ItineraryModelImplCopyWithImpl<$Res>
    extends _$ItineraryModelCopyWithImpl<$Res, _$ItineraryModelImpl>
    implements _$$ItineraryModelImplCopyWith<$Res> {
  __$$ItineraryModelImplCopyWithImpl(
      _$ItineraryModelImpl _value, $Res Function(_$ItineraryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doc = freezed,
    Object? canView = null,
  }) {
    return _then(_$ItineraryModelImpl(
      doc: freezed == doc
          ? _value.doc
          : doc // ignore: cast_nullable_to_non_nullable
              as String?,
      canView: null == canView
          ? _value.canView
          : canView // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItineraryModelImpl implements _ItineraryModel {
  const _$ItineraryModelImpl({this.doc, this.canView = false});

  factory _$ItineraryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItineraryModelImplFromJson(json);

  @override
  final String? doc;
  @override
  @JsonKey()
  final bool canView;

  @override
  String toString() {
    return 'ItineraryModel(doc: $doc, canView: $canView)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItineraryModelImpl &&
            (identical(other.doc, doc) || other.doc == doc) &&
            (identical(other.canView, canView) || other.canView == canView));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, doc, canView);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItineraryModelImplCopyWith<_$ItineraryModelImpl> get copyWith =>
      __$$ItineraryModelImplCopyWithImpl<_$ItineraryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItineraryModelImplToJson(
      this,
    );
  }
}

abstract class _ItineraryModel implements ItineraryModel {
  const factory _ItineraryModel({final String? doc, final bool canView}) =
      _$ItineraryModelImpl;

  factory _ItineraryModel.fromJson(Map<String, dynamic> json) =
      _$ItineraryModelImpl.fromJson;

  @override
  String? get doc;
  @override
  bool get canView;
  @override
  @JsonKey(ignore: true)
  _$$ItineraryModelImplCopyWith<_$ItineraryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TournamentMatchModel _$TournamentMatchModelFromJson(Map<String, dynamic> json) {
  return _TournamentMatchModel.fromJson(json);
}

/// @nodoc
mixin _$TournamentMatchModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'matchId')
  String? get matchId => throw _privateConstructorUsedError;
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
  String? get ageGroup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentMatchModelCopyWith<TournamentMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentMatchModelCopyWith<$Res> {
  factory $TournamentMatchModelCopyWith(TournamentMatchModel value,
          $Res Function(TournamentMatchModel) then) =
      _$TournamentMatchModelCopyWithImpl<$Res, TournamentMatchModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
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
      String? ageGroup});
}

/// @nodoc
class _$TournamentMatchModelCopyWithImpl<$Res,
        $Val extends TournamentMatchModel>
    implements $TournamentMatchModelCopyWith<$Res> {
  _$TournamentMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentMatchModelImplCopyWith<$Res>
    implements $TournamentMatchModelCopyWith<$Res> {
  factory _$$TournamentMatchModelImplCopyWith(_$TournamentMatchModelImpl value,
          $Res Function(_$TournamentMatchModelImpl) then) =
      __$$TournamentMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'matchId') String? matchId,
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
      String? ageGroup});
}

/// @nodoc
class __$$TournamentMatchModelImplCopyWithImpl<$Res>
    extends _$TournamentMatchModelCopyWithImpl<$Res, _$TournamentMatchModelImpl>
    implements _$$TournamentMatchModelImplCopyWith<$Res> {
  __$$TournamentMatchModelImplCopyWithImpl(_$TournamentMatchModelImpl _value,
      $Res Function(_$TournamentMatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? matchId = freezed,
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
  }) {
    return _then(_$TournamentMatchModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      matchId: freezed == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentMatchModelImpl implements _TournamentMatchModel {
  const _$TournamentMatchModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'matchId') this.matchId,
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
      this.ageGroup});

  factory _$TournamentMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentMatchModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'matchId')
  final String? matchId;
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

  @override
  String toString() {
    return 'TournamentMatchModel(id: $id, matchId: $matchId, homeTeamId: $homeTeamId, homeTeamName: $homeTeamName, homeTeamLogo: $homeTeamLogo, awayTeamId: $awayTeamId, awayTeamName: $awayTeamName, awayTeamLogo: $awayTeamLogo, homeScore: $homeScore, awayScore: $awayScore, status: $status, matchDate: $matchDate, matchDateMs: $matchDateMs, venue: $venue, gameType: $gameType, ageGroup: $ageGroup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentMatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
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
                other.ageGroup == ageGroup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      matchId,
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
      ageGroup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentMatchModelImplCopyWith<_$TournamentMatchModelImpl>
      get copyWith =>
          __$$TournamentMatchModelImplCopyWithImpl<_$TournamentMatchModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentMatchModelImplToJson(
      this,
    );
  }
}

abstract class _TournamentMatchModel implements TournamentMatchModel {
  const factory _TournamentMatchModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'matchId') final String? matchId,
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
      final String? ageGroup}) = _$TournamentMatchModelImpl;

  factory _TournamentMatchModel.fromJson(Map<String, dynamic> json) =
      _$TournamentMatchModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'matchId')
  String? get matchId;
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
  @override
  @JsonKey(ignore: true)
  _$$TournamentMatchModelImplCopyWith<_$TournamentMatchModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PointsTableEntry _$PointsTableEntryFromJson(Map<String, dynamic> json) {
  return _PointsTableEntry.fromJson(json);
}

/// @nodoc
mixin _$PointsTableEntry {
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointsTableEntryCopyWith<PointsTableEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsTableEntryCopyWith<$Res> {
  factory $PointsTableEntryCopyWith(
          PointsTableEntry value, $Res Function(PointsTableEntry) then) =
      _$PointsTableEntryCopyWithImpl<$Res, PointsTableEntry>;
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
      @JsonKey(name: 'pts') int points});
}

/// @nodoc
class _$PointsTableEntryCopyWithImpl<$Res, $Val extends PointsTableEntry>
    implements $PointsTableEntryCopyWith<$Res> {
  _$PointsTableEntryCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointsTableEntryImplCopyWith<$Res>
    implements $PointsTableEntryCopyWith<$Res> {
  factory _$$PointsTableEntryImplCopyWith(_$PointsTableEntryImpl value,
          $Res Function(_$PointsTableEntryImpl) then) =
      __$$PointsTableEntryImplCopyWithImpl<$Res>;
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
      @JsonKey(name: 'pts') int points});
}

/// @nodoc
class __$$PointsTableEntryImplCopyWithImpl<$Res>
    extends _$PointsTableEntryCopyWithImpl<$Res, _$PointsTableEntryImpl>
    implements _$$PointsTableEntryImplCopyWith<$Res> {
  __$$PointsTableEntryImplCopyWithImpl(_$PointsTableEntryImpl _value,
      $Res Function(_$PointsTableEntryImpl) _then)
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
  }) {
    return _then(_$PointsTableEntryImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsTableEntryImpl implements _PointsTableEntry {
  const _$PointsTableEntryImpl(
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
      @JsonKey(name: 'pts') this.points = 0});

  factory _$PointsTableEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsTableEntryImplFromJson(json);

  @override
  final String? teamId;
  @override
  final String? teamName;
  @override
  final String? teamLogo;
  @override
  @JsonKey()
  final int seq;
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
  String toString() {
    return 'PointsTableEntry(teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, seq: $seq, played: $played, won: $won, drawn: $drawn, lost: $lost, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, goalDifference: $goalDifference, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsTableEntryImpl &&
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
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, teamId, teamName, teamLogo, seq,
      played, won, drawn, lost, goalsFor, goalsAgainst, goalDifference, points);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsTableEntryImplCopyWith<_$PointsTableEntryImpl> get copyWith =>
      __$$PointsTableEntryImplCopyWithImpl<_$PointsTableEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsTableEntryImplToJson(
      this,
    );
  }
}

abstract class _PointsTableEntry implements PointsTableEntry {
  const factory _PointsTableEntry(
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
      @JsonKey(name: 'pts') final int points}) = _$PointsTableEntryImpl;

  factory _PointsTableEntry.fromJson(Map<String, dynamic> json) =
      _$PointsTableEntryImpl.fromJson;

  @override
  String? get teamId;
  @override
  String? get teamName;
  @override
  String? get teamLogo;
  @override
  int get seq;
  @override
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
  @JsonKey(ignore: true)
  _$$PointsTableEntryImplCopyWith<_$PointsTableEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerStatEntry _$PlayerStatEntryFromJson(Map<String, dynamic> json) {
  return _PlayerStatEntry.fromJson(json);
}

/// @nodoc
mixin _$PlayerStatEntry {
  String? get userId => throw _privateConstructorUsedError;
  String? get playerName => throw _privateConstructorUsedError;
  String? get playerImage => throw _privateConstructorUsedError;
  String? get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  int get yellowCards => throw _privateConstructorUsedError;
  int get redCards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerStatEntryCopyWith<PlayerStatEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatEntryCopyWith<$Res> {
  factory $PlayerStatEntryCopyWith(
          PlayerStatEntry value, $Res Function(PlayerStatEntry) then) =
      _$PlayerStatEntryCopyWithImpl<$Res, PlayerStatEntry>;
  @useResult
  $Res call(
      {String? userId,
      String? playerName,
      String? playerImage,
      String? teamId,
      String? teamName,
      int count,
      int yellowCards,
      int redCards});
}

/// @nodoc
class _$PlayerStatEntryCopyWithImpl<$Res, $Val extends PlayerStatEntry>
    implements $PlayerStatEntryCopyWith<$Res> {
  _$PlayerStatEntryCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStatEntryImplCopyWith<$Res>
    implements $PlayerStatEntryCopyWith<$Res> {
  factory _$$PlayerStatEntryImplCopyWith(_$PlayerStatEntryImpl value,
          $Res Function(_$PlayerStatEntryImpl) then) =
      __$$PlayerStatEntryImplCopyWithImpl<$Res>;
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
      int redCards});
}

/// @nodoc
class __$$PlayerStatEntryImplCopyWithImpl<$Res>
    extends _$PlayerStatEntryCopyWithImpl<$Res, _$PlayerStatEntryImpl>
    implements _$$PlayerStatEntryImplCopyWith<$Res> {
  __$$PlayerStatEntryImplCopyWithImpl(
      _$PlayerStatEntryImpl _value, $Res Function(_$PlayerStatEntryImpl) _then)
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
  }) {
    return _then(_$PlayerStatEntryImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatEntryImpl implements _PlayerStatEntry {
  const _$PlayerStatEntryImpl(
      {this.userId,
      this.playerName,
      this.playerImage,
      this.teamId,
      this.teamName,
      this.count = 0,
      this.yellowCards = 0,
      this.redCards = 0});

  factory _$PlayerStatEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatEntryImplFromJson(json);

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
  @override
  @JsonKey()
  final int yellowCards;
  @override
  @JsonKey()
  final int redCards;

  @override
  String toString() {
    return 'PlayerStatEntry(userId: $userId, playerName: $playerName, playerImage: $playerImage, teamId: $teamId, teamName: $teamName, count: $count, yellowCards: $yellowCards, redCards: $redCards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatEntryImpl &&
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
                other.redCards == redCards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, playerName, playerImage,
      teamId, teamName, count, yellowCards, redCards);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatEntryImplCopyWith<_$PlayerStatEntryImpl> get copyWith =>
      __$$PlayerStatEntryImplCopyWithImpl<_$PlayerStatEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatEntryImplToJson(
      this,
    );
  }
}

abstract class _PlayerStatEntry implements PlayerStatEntry {
  const factory _PlayerStatEntry(
      {final String? userId,
      final String? playerName,
      final String? playerImage,
      final String? teamId,
      final String? teamName,
      final int count,
      final int yellowCards,
      final int redCards}) = _$PlayerStatEntryImpl;

  factory _PlayerStatEntry.fromJson(Map<String, dynamic> json) =
      _$PlayerStatEntryImpl.fromJson;

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
  @override
  int get yellowCards;
  @override
  int get redCards;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStatEntryImplCopyWith<_$PlayerStatEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
