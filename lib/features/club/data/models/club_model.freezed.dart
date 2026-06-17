// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) {
  return _ClubModel.fromJson(json);
}

/// @nodoc
mixin _$ClubModel {
  String get clubId => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get clubName => throw _privateConstructorUsedError;
  String? get partnerType =>
      throw _privateConstructorUsedError; // "platinum" | "gold" | "silver" | "nopartner"
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get nickName => throw _privateConstructorUsedError;
  String? get formedYear => throw _privateConstructorUsedError;
  String? get manager => throw _privateConstructorUsedError;
  String? get confed => throw _privateConstructorUsedError;
  String? get league => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get homeKit => throw _privateConstructorUsedError;
  String? get awayKit => throw _privateConstructorUsedError;
  String? get thirdKit => throw _privateConstructorUsedError;
  String? get orgFifaId => throw _privateConstructorUsedError;
  bool get following => throw _privateConstructorUsedError;
  bool get trialBadge => throw _privateConstructorUsedError;
  bool get isPartner => throw _privateConstructorUsedError;
  int get followCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get plan => throw _privateConstructorUsedError;
  List<StadiumModel> get stadiums => throw _privateConstructorUsedError;
  List<String> get comps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubModelCopyWith<ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubModelCopyWith<$Res> {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) then) =
      _$ClubModelCopyWithImpl<$Res, ClubModel>;
  @useResult
  $Res call(
      {String clubId,
      @JsonKey(name: '_id') String? id,
      String clubName,
      String? partnerType,
      String? country,
      String? city,
      String? nickName,
      String? formedYear,
      String? manager,
      String? confed,
      String? league,
      String? website,
      String? imageUrl,
      String? homeKit,
      String? awayKit,
      String? thirdKit,
      String? orgFifaId,
      bool following,
      bool trialBadge,
      bool isPartner,
      int followCount,
      int likeCount,
      int plan,
      List<StadiumModel> stadiums,
      List<String> comps});
}

/// @nodoc
class _$ClubModelCopyWithImpl<$Res, $Val extends ClubModel>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubId = null,
    Object? id = freezed,
    Object? clubName = null,
    Object? partnerType = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? nickName = freezed,
    Object? formedYear = freezed,
    Object? manager = freezed,
    Object? confed = freezed,
    Object? league = freezed,
    Object? website = freezed,
    Object? imageUrl = freezed,
    Object? homeKit = freezed,
    Object? awayKit = freezed,
    Object? thirdKit = freezed,
    Object? orgFifaId = freezed,
    Object? following = null,
    Object? trialBadge = null,
    Object? isPartner = null,
    Object? followCount = null,
    Object? likeCount = null,
    Object? plan = null,
    Object? stadiums = null,
    Object? comps = null,
  }) {
    return _then(_value.copyWith(
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      partnerType: freezed == partnerType
          ? _value.partnerType
          : partnerType // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
      formedYear: freezed == formedYear
          ? _value.formedYear
          : formedYear // ignore: cast_nullable_to_non_nullable
              as String?,
      manager: freezed == manager
          ? _value.manager
          : manager // ignore: cast_nullable_to_non_nullable
              as String?,
      confed: freezed == confed
          ? _value.confed
          : confed // ignore: cast_nullable_to_non_nullable
              as String?,
      league: freezed == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      homeKit: freezed == homeKit
          ? _value.homeKit
          : homeKit // ignore: cast_nullable_to_non_nullable
              as String?,
      awayKit: freezed == awayKit
          ? _value.awayKit
          : awayKit // ignore: cast_nullable_to_non_nullable
              as String?,
      thirdKit: freezed == thirdKit
          ? _value.thirdKit
          : thirdKit // ignore: cast_nullable_to_non_nullable
              as String?,
      orgFifaId: freezed == orgFifaId
          ? _value.orgFifaId
          : orgFifaId // ignore: cast_nullable_to_non_nullable
              as String?,
      following: null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as bool,
      trialBadge: null == trialBadge
          ? _value.trialBadge
          : trialBadge // ignore: cast_nullable_to_non_nullable
              as bool,
      isPartner: null == isPartner
          ? _value.isPartner
          : isPartner // ignore: cast_nullable_to_non_nullable
              as bool,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as int,
      stadiums: null == stadiums
          ? _value.stadiums
          : stadiums // ignore: cast_nullable_to_non_nullable
              as List<StadiumModel>,
      comps: null == comps
          ? _value.comps
          : comps // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubModelImplCopyWith<$Res>
    implements $ClubModelCopyWith<$Res> {
  factory _$$ClubModelImplCopyWith(
          _$ClubModelImpl value, $Res Function(_$ClubModelImpl) then) =
      __$$ClubModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clubId,
      @JsonKey(name: '_id') String? id,
      String clubName,
      String? partnerType,
      String? country,
      String? city,
      String? nickName,
      String? formedYear,
      String? manager,
      String? confed,
      String? league,
      String? website,
      String? imageUrl,
      String? homeKit,
      String? awayKit,
      String? thirdKit,
      String? orgFifaId,
      bool following,
      bool trialBadge,
      bool isPartner,
      int followCount,
      int likeCount,
      int plan,
      List<StadiumModel> stadiums,
      List<String> comps});
}

/// @nodoc
class __$$ClubModelImplCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$ClubModelImpl>
    implements _$$ClubModelImplCopyWith<$Res> {
  __$$ClubModelImplCopyWithImpl(
      _$ClubModelImpl _value, $Res Function(_$ClubModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubId = null,
    Object? id = freezed,
    Object? clubName = null,
    Object? partnerType = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? nickName = freezed,
    Object? formedYear = freezed,
    Object? manager = freezed,
    Object? confed = freezed,
    Object? league = freezed,
    Object? website = freezed,
    Object? imageUrl = freezed,
    Object? homeKit = freezed,
    Object? awayKit = freezed,
    Object? thirdKit = freezed,
    Object? orgFifaId = freezed,
    Object? following = null,
    Object? trialBadge = null,
    Object? isPartner = null,
    Object? followCount = null,
    Object? likeCount = null,
    Object? plan = null,
    Object? stadiums = null,
    Object? comps = null,
  }) {
    return _then(_$ClubModelImpl(
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      partnerType: freezed == partnerType
          ? _value.partnerType
          : partnerType // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
      formedYear: freezed == formedYear
          ? _value.formedYear
          : formedYear // ignore: cast_nullable_to_non_nullable
              as String?,
      manager: freezed == manager
          ? _value.manager
          : manager // ignore: cast_nullable_to_non_nullable
              as String?,
      confed: freezed == confed
          ? _value.confed
          : confed // ignore: cast_nullable_to_non_nullable
              as String?,
      league: freezed == league
          ? _value.league
          : league // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      homeKit: freezed == homeKit
          ? _value.homeKit
          : homeKit // ignore: cast_nullable_to_non_nullable
              as String?,
      awayKit: freezed == awayKit
          ? _value.awayKit
          : awayKit // ignore: cast_nullable_to_non_nullable
              as String?,
      thirdKit: freezed == thirdKit
          ? _value.thirdKit
          : thirdKit // ignore: cast_nullable_to_non_nullable
              as String?,
      orgFifaId: freezed == orgFifaId
          ? _value.orgFifaId
          : orgFifaId // ignore: cast_nullable_to_non_nullable
              as String?,
      following: null == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as bool,
      trialBadge: null == trialBadge
          ? _value.trialBadge
          : trialBadge // ignore: cast_nullable_to_non_nullable
              as bool,
      isPartner: null == isPartner
          ? _value.isPartner
          : isPartner // ignore: cast_nullable_to_non_nullable
              as bool,
      followCount: null == followCount
          ? _value.followCount
          : followCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as int,
      stadiums: null == stadiums
          ? _value._stadiums
          : stadiums // ignore: cast_nullable_to_non_nullable
              as List<StadiumModel>,
      comps: null == comps
          ? _value._comps
          : comps // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubModelImpl implements _ClubModel {
  const _$ClubModelImpl(
      {required this.clubId,
      @JsonKey(name: '_id') this.id,
      required this.clubName,
      this.partnerType,
      this.country,
      this.city,
      this.nickName,
      this.formedYear,
      this.manager,
      this.confed,
      this.league,
      this.website,
      this.imageUrl,
      this.homeKit,
      this.awayKit,
      this.thirdKit,
      this.orgFifaId,
      this.following = false,
      this.trialBadge = false,
      this.isPartner = false,
      this.followCount = 0,
      this.likeCount = 0,
      this.plan = 0,
      final List<StadiumModel> stadiums = const [],
      final List<String> comps = const []})
      : _stadiums = stadiums,
        _comps = comps;

  factory _$ClubModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubModelImplFromJson(json);

  @override
  final String clubId;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String clubName;
  @override
  final String? partnerType;
// "platinum" | "gold" | "silver" | "nopartner"
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? nickName;
  @override
  final String? formedYear;
  @override
  final String? manager;
  @override
  final String? confed;
  @override
  final String? league;
  @override
  final String? website;
  @override
  final String? imageUrl;
  @override
  final String? homeKit;
  @override
  final String? awayKit;
  @override
  final String? thirdKit;
  @override
  final String? orgFifaId;
  @override
  @JsonKey()
  final bool following;
  @override
  @JsonKey()
  final bool trialBadge;
  @override
  @JsonKey()
  final bool isPartner;
  @override
  @JsonKey()
  final int followCount;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int plan;
  final List<StadiumModel> _stadiums;
  @override
  @JsonKey()
  List<StadiumModel> get stadiums {
    if (_stadiums is EqualUnmodifiableListView) return _stadiums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stadiums);
  }

  final List<String> _comps;
  @override
  @JsonKey()
  List<String> get comps {
    if (_comps is EqualUnmodifiableListView) return _comps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comps);
  }

  @override
  String toString() {
    return 'ClubModel(clubId: $clubId, id: $id, clubName: $clubName, partnerType: $partnerType, country: $country, city: $city, nickName: $nickName, formedYear: $formedYear, manager: $manager, confed: $confed, league: $league, website: $website, imageUrl: $imageUrl, homeKit: $homeKit, awayKit: $awayKit, thirdKit: $thirdKit, orgFifaId: $orgFifaId, following: $following, trialBadge: $trialBadge, isPartner: $isPartner, followCount: $followCount, likeCount: $likeCount, plan: $plan, stadiums: $stadiums, comps: $comps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubModelImpl &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            (identical(other.partnerType, partnerType) ||
                other.partnerType == partnerType) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName) &&
            (identical(other.formedYear, formedYear) ||
                other.formedYear == formedYear) &&
            (identical(other.manager, manager) || other.manager == manager) &&
            (identical(other.confed, confed) || other.confed == confed) &&
            (identical(other.league, league) || other.league == league) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.homeKit, homeKit) || other.homeKit == homeKit) &&
            (identical(other.awayKit, awayKit) || other.awayKit == awayKit) &&
            (identical(other.thirdKit, thirdKit) ||
                other.thirdKit == thirdKit) &&
            (identical(other.orgFifaId, orgFifaId) ||
                other.orgFifaId == orgFifaId) &&
            (identical(other.following, following) ||
                other.following == following) &&
            (identical(other.trialBadge, trialBadge) ||
                other.trialBadge == trialBadge) &&
            (identical(other.isPartner, isPartner) ||
                other.isPartner == isPartner) &&
            (identical(other.followCount, followCount) ||
                other.followCount == followCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            const DeepCollectionEquality().equals(other._stadiums, _stadiums) &&
            const DeepCollectionEquality().equals(other._comps, _comps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        clubId,
        id,
        clubName,
        partnerType,
        country,
        city,
        nickName,
        formedYear,
        manager,
        confed,
        league,
        website,
        imageUrl,
        homeKit,
        awayKit,
        thirdKit,
        orgFifaId,
        following,
        trialBadge,
        isPartner,
        followCount,
        likeCount,
        plan,
        const DeepCollectionEquality().hash(_stadiums),
        const DeepCollectionEquality().hash(_comps)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      __$$ClubModelImplCopyWithImpl<_$ClubModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubModelImplToJson(
      this,
    );
  }
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel(
      {required final String clubId,
      @JsonKey(name: '_id') final String? id,
      required final String clubName,
      final String? partnerType,
      final String? country,
      final String? city,
      final String? nickName,
      final String? formedYear,
      final String? manager,
      final String? confed,
      final String? league,
      final String? website,
      final String? imageUrl,
      final String? homeKit,
      final String? awayKit,
      final String? thirdKit,
      final String? orgFifaId,
      final bool following,
      final bool trialBadge,
      final bool isPartner,
      final int followCount,
      final int likeCount,
      final int plan,
      final List<StadiumModel> stadiums,
      final List<String> comps}) = _$ClubModelImpl;

  factory _ClubModel.fromJson(Map<String, dynamic> json) =
      _$ClubModelImpl.fromJson;

  @override
  String get clubId;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get clubName;
  @override
  String? get partnerType;
  @override // "platinum" | "gold" | "silver" | "nopartner"
  String? get country;
  @override
  String? get city;
  @override
  String? get nickName;
  @override
  String? get formedYear;
  @override
  String? get manager;
  @override
  String? get confed;
  @override
  String? get league;
  @override
  String? get website;
  @override
  String? get imageUrl;
  @override
  String? get homeKit;
  @override
  String? get awayKit;
  @override
  String? get thirdKit;
  @override
  String? get orgFifaId;
  @override
  bool get following;
  @override
  bool get trialBadge;
  @override
  bool get isPartner;
  @override
  int get followCount;
  @override
  int get likeCount;
  @override
  int get plan;
  @override
  List<StadiumModel> get stadiums;
  @override
  List<String> get comps;
  @override
  @JsonKey(ignore: true)
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StadiumModel _$StadiumModelFromJson(Map<String, dynamic> json) {
  return _StadiumModel.fromJson(json);
}

/// @nodoc
mixin _$StadiumModel {
  String? get name => throw _privateConstructorUsedError;
  int get seq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StadiumModelCopyWith<StadiumModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StadiumModelCopyWith<$Res> {
  factory $StadiumModelCopyWith(
          StadiumModel value, $Res Function(StadiumModel) then) =
      _$StadiumModelCopyWithImpl<$Res, StadiumModel>;
  @useResult
  $Res call({String? name, int seq});
}

/// @nodoc
class _$StadiumModelCopyWithImpl<$Res, $Val extends StadiumModel>
    implements $StadiumModelCopyWith<$Res> {
  _$StadiumModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? seq = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StadiumModelImplCopyWith<$Res>
    implements $StadiumModelCopyWith<$Res> {
  factory _$$StadiumModelImplCopyWith(
          _$StadiumModelImpl value, $Res Function(_$StadiumModelImpl) then) =
      __$$StadiumModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, int seq});
}

/// @nodoc
class __$$StadiumModelImplCopyWithImpl<$Res>
    extends _$StadiumModelCopyWithImpl<$Res, _$StadiumModelImpl>
    implements _$$StadiumModelImplCopyWith<$Res> {
  __$$StadiumModelImplCopyWithImpl(
      _$StadiumModelImpl _value, $Res Function(_$StadiumModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? seq = null,
  }) {
    return _then(_$StadiumModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: null == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StadiumModelImpl implements _StadiumModel {
  const _$StadiumModelImpl({this.name, this.seq = 0});

  factory _$StadiumModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StadiumModelImplFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey()
  final int seq;

  @override
  String toString() {
    return 'StadiumModel(name: $name, seq: $seq)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StadiumModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.seq, seq) || other.seq == seq));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, seq);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StadiumModelImplCopyWith<_$StadiumModelImpl> get copyWith =>
      __$$StadiumModelImplCopyWithImpl<_$StadiumModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StadiumModelImplToJson(
      this,
    );
  }
}

abstract class _StadiumModel implements StadiumModel {
  const factory _StadiumModel({final String? name, final int seq}) =
      _$StadiumModelImpl;

  factory _StadiumModel.fromJson(Map<String, dynamic> json) =
      _$StadiumModelImpl.fromJson;

  @override
  String? get name;
  @override
  int get seq;
  @override
  @JsonKey(ignore: true)
  _$$StadiumModelImplCopyWith<_$StadiumModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
