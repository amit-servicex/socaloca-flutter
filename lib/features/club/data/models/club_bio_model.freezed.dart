// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_bio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubBioModel _$ClubBioModelFromJson(Map<String, dynamic> json) {
  return _ClubBioModel.fromJson(json);
}

/// @nodoc
mixin _$ClubBioModel {
  ClubModel get clubDetails => throw _privateConstructorUsedError;
  ClubTrialStatusModel? get trialDetails => throw _privateConstructorUsedError;
  List<ClubNewsModel> get newsList => throw _privateConstructorUsedError;
  List<MatchModel> get matchList => throw _privateConstructorUsedError;
  List<ClubPlayerModel> get playerList => throw _privateConstructorUsedError;
  List<ClubTeamModel> get teamList => throw _privateConstructorUsedError;
  List<ClubSponsorModel> get sponsorList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubBioModelCopyWith<ClubBioModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubBioModelCopyWith<$Res> {
  factory $ClubBioModelCopyWith(
          ClubBioModel value, $Res Function(ClubBioModel) then) =
      _$ClubBioModelCopyWithImpl<$Res, ClubBioModel>;
  @useResult
  $Res call(
      {ClubModel clubDetails,
      ClubTrialStatusModel? trialDetails,
      List<ClubNewsModel> newsList,
      List<MatchModel> matchList,
      List<ClubPlayerModel> playerList,
      List<ClubTeamModel> teamList,
      List<ClubSponsorModel> sponsorList});

  $ClubModelCopyWith<$Res> get clubDetails;
  $ClubTrialStatusModelCopyWith<$Res>? get trialDetails;
}

/// @nodoc
class _$ClubBioModelCopyWithImpl<$Res, $Val extends ClubBioModel>
    implements $ClubBioModelCopyWith<$Res> {
  _$ClubBioModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubDetails = null,
    Object? trialDetails = freezed,
    Object? newsList = null,
    Object? matchList = null,
    Object? playerList = null,
    Object? teamList = null,
    Object? sponsorList = null,
  }) {
    return _then(_value.copyWith(
      clubDetails: null == clubDetails
          ? _value.clubDetails
          : clubDetails // ignore: cast_nullable_to_non_nullable
              as ClubModel,
      trialDetails: freezed == trialDetails
          ? _value.trialDetails
          : trialDetails // ignore: cast_nullable_to_non_nullable
              as ClubTrialStatusModel?,
      newsList: null == newsList
          ? _value.newsList
          : newsList // ignore: cast_nullable_to_non_nullable
              as List<ClubNewsModel>,
      matchList: null == matchList
          ? _value.matchList
          : matchList // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      playerList: null == playerList
          ? _value.playerList
          : playerList // ignore: cast_nullable_to_non_nullable
              as List<ClubPlayerModel>,
      teamList: null == teamList
          ? _value.teamList
          : teamList // ignore: cast_nullable_to_non_nullable
              as List<ClubTeamModel>,
      sponsorList: null == sponsorList
          ? _value.sponsorList
          : sponsorList // ignore: cast_nullable_to_non_nullable
              as List<ClubSponsorModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubModelCopyWith<$Res> get clubDetails {
    return $ClubModelCopyWith<$Res>(_value.clubDetails, (value) {
      return _then(_value.copyWith(clubDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubTrialStatusModelCopyWith<$Res>? get trialDetails {
    if (_value.trialDetails == null) {
      return null;
    }

    return $ClubTrialStatusModelCopyWith<$Res>(_value.trialDetails!, (value) {
      return _then(_value.copyWith(trialDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClubBioModelImplCopyWith<$Res>
    implements $ClubBioModelCopyWith<$Res> {
  factory _$$ClubBioModelImplCopyWith(
          _$ClubBioModelImpl value, $Res Function(_$ClubBioModelImpl) then) =
      __$$ClubBioModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ClubModel clubDetails,
      ClubTrialStatusModel? trialDetails,
      List<ClubNewsModel> newsList,
      List<MatchModel> matchList,
      List<ClubPlayerModel> playerList,
      List<ClubTeamModel> teamList,
      List<ClubSponsorModel> sponsorList});

  @override
  $ClubModelCopyWith<$Res> get clubDetails;
  @override
  $ClubTrialStatusModelCopyWith<$Res>? get trialDetails;
}

/// @nodoc
class __$$ClubBioModelImplCopyWithImpl<$Res>
    extends _$ClubBioModelCopyWithImpl<$Res, _$ClubBioModelImpl>
    implements _$$ClubBioModelImplCopyWith<$Res> {
  __$$ClubBioModelImplCopyWithImpl(
      _$ClubBioModelImpl _value, $Res Function(_$ClubBioModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubDetails = null,
    Object? trialDetails = freezed,
    Object? newsList = null,
    Object? matchList = null,
    Object? playerList = null,
    Object? teamList = null,
    Object? sponsorList = null,
  }) {
    return _then(_$ClubBioModelImpl(
      clubDetails: null == clubDetails
          ? _value.clubDetails
          : clubDetails // ignore: cast_nullable_to_non_nullable
              as ClubModel,
      trialDetails: freezed == trialDetails
          ? _value.trialDetails
          : trialDetails // ignore: cast_nullable_to_non_nullable
              as ClubTrialStatusModel?,
      newsList: null == newsList
          ? _value._newsList
          : newsList // ignore: cast_nullable_to_non_nullable
              as List<ClubNewsModel>,
      matchList: null == matchList
          ? _value._matchList
          : matchList // ignore: cast_nullable_to_non_nullable
              as List<MatchModel>,
      playerList: null == playerList
          ? _value._playerList
          : playerList // ignore: cast_nullable_to_non_nullable
              as List<ClubPlayerModel>,
      teamList: null == teamList
          ? _value._teamList
          : teamList // ignore: cast_nullable_to_non_nullable
              as List<ClubTeamModel>,
      sponsorList: null == sponsorList
          ? _value._sponsorList
          : sponsorList // ignore: cast_nullable_to_non_nullable
              as List<ClubSponsorModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubBioModelImpl implements _ClubBioModel {
  const _$ClubBioModelImpl(
      {required this.clubDetails,
      this.trialDetails,
      final List<ClubNewsModel> newsList = const [],
      final List<MatchModel> matchList = const [],
      final List<ClubPlayerModel> playerList = const [],
      final List<ClubTeamModel> teamList = const [],
      final List<ClubSponsorModel> sponsorList = const []})
      : _newsList = newsList,
        _matchList = matchList,
        _playerList = playerList,
        _teamList = teamList,
        _sponsorList = sponsorList;

  factory _$ClubBioModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubBioModelImplFromJson(json);

  @override
  final ClubModel clubDetails;
  @override
  final ClubTrialStatusModel? trialDetails;
  final List<ClubNewsModel> _newsList;
  @override
  @JsonKey()
  List<ClubNewsModel> get newsList {
    if (_newsList is EqualUnmodifiableListView) return _newsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newsList);
  }

  final List<MatchModel> _matchList;
  @override
  @JsonKey()
  List<MatchModel> get matchList {
    if (_matchList is EqualUnmodifiableListView) return _matchList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchList);
  }

  final List<ClubPlayerModel> _playerList;
  @override
  @JsonKey()
  List<ClubPlayerModel> get playerList {
    if (_playerList is EqualUnmodifiableListView) return _playerList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerList);
  }

  final List<ClubTeamModel> _teamList;
  @override
  @JsonKey()
  List<ClubTeamModel> get teamList {
    if (_teamList is EqualUnmodifiableListView) return _teamList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamList);
  }

  final List<ClubSponsorModel> _sponsorList;
  @override
  @JsonKey()
  List<ClubSponsorModel> get sponsorList {
    if (_sponsorList is EqualUnmodifiableListView) return _sponsorList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sponsorList);
  }

  @override
  String toString() {
    return 'ClubBioModel(clubDetails: $clubDetails, trialDetails: $trialDetails, newsList: $newsList, matchList: $matchList, playerList: $playerList, teamList: $teamList, sponsorList: $sponsorList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubBioModelImpl &&
            (identical(other.clubDetails, clubDetails) ||
                other.clubDetails == clubDetails) &&
            (identical(other.trialDetails, trialDetails) ||
                other.trialDetails == trialDetails) &&
            const DeepCollectionEquality().equals(other._newsList, _newsList) &&
            const DeepCollectionEquality()
                .equals(other._matchList, _matchList) &&
            const DeepCollectionEquality()
                .equals(other._playerList, _playerList) &&
            const DeepCollectionEquality().equals(other._teamList, _teamList) &&
            const DeepCollectionEquality()
                .equals(other._sponsorList, _sponsorList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clubDetails,
      trialDetails,
      const DeepCollectionEquality().hash(_newsList),
      const DeepCollectionEquality().hash(_matchList),
      const DeepCollectionEquality().hash(_playerList),
      const DeepCollectionEquality().hash(_teamList),
      const DeepCollectionEquality().hash(_sponsorList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubBioModelImplCopyWith<_$ClubBioModelImpl> get copyWith =>
      __$$ClubBioModelImplCopyWithImpl<_$ClubBioModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubBioModelImplToJson(
      this,
    );
  }
}

abstract class _ClubBioModel implements ClubBioModel {
  const factory _ClubBioModel(
      {required final ClubModel clubDetails,
      final ClubTrialStatusModel? trialDetails,
      final List<ClubNewsModel> newsList,
      final List<MatchModel> matchList,
      final List<ClubPlayerModel> playerList,
      final List<ClubTeamModel> teamList,
      final List<ClubSponsorModel> sponsorList}) = _$ClubBioModelImpl;

  factory _ClubBioModel.fromJson(Map<String, dynamic> json) =
      _$ClubBioModelImpl.fromJson;

  @override
  ClubModel get clubDetails;
  @override
  ClubTrialStatusModel? get trialDetails;
  @override
  List<ClubNewsModel> get newsList;
  @override
  List<MatchModel> get matchList;
  @override
  List<ClubPlayerModel> get playerList;
  @override
  List<ClubTeamModel> get teamList;
  @override
  List<ClubSponsorModel> get sponsorList;
  @override
  @JsonKey(ignore: true)
  _$$ClubBioModelImplCopyWith<_$ClubBioModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubTrialStatusModel _$ClubTrialStatusModelFromJson(Map<String, dynamic> json) {
  return _ClubTrialStatusModel.fromJson(json);
}

/// @nodoc
mixin _$ClubTrialStatusModel {
  bool get trialBadge => throw _privateConstructorUsedError;
  bool get isRegisterBtn => throw _privateConstructorUsedError;
  bool get isRegistered => throw _privateConstructorUsedError;
  bool get isRegistrationClosed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubTrialStatusModelCopyWith<ClubTrialStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubTrialStatusModelCopyWith<$Res> {
  factory $ClubTrialStatusModelCopyWith(ClubTrialStatusModel value,
          $Res Function(ClubTrialStatusModel) then) =
      _$ClubTrialStatusModelCopyWithImpl<$Res, ClubTrialStatusModel>;
  @useResult
  $Res call(
      {bool trialBadge,
      bool isRegisterBtn,
      bool isRegistered,
      bool isRegistrationClosed});
}

/// @nodoc
class _$ClubTrialStatusModelCopyWithImpl<$Res,
        $Val extends ClubTrialStatusModel>
    implements $ClubTrialStatusModelCopyWith<$Res> {
  _$ClubTrialStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trialBadge = null,
    Object? isRegisterBtn = null,
    Object? isRegistered = null,
    Object? isRegistrationClosed = null,
  }) {
    return _then(_value.copyWith(
      trialBadge: null == trialBadge
          ? _value.trialBadge
          : trialBadge // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegisterBtn: null == isRegisterBtn
          ? _value.isRegisterBtn
          : isRegisterBtn // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegistered: null == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegistrationClosed: null == isRegistrationClosed
          ? _value.isRegistrationClosed
          : isRegistrationClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubTrialStatusModelImplCopyWith<$Res>
    implements $ClubTrialStatusModelCopyWith<$Res> {
  factory _$$ClubTrialStatusModelImplCopyWith(_$ClubTrialStatusModelImpl value,
          $Res Function(_$ClubTrialStatusModelImpl) then) =
      __$$ClubTrialStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool trialBadge,
      bool isRegisterBtn,
      bool isRegistered,
      bool isRegistrationClosed});
}

/// @nodoc
class __$$ClubTrialStatusModelImplCopyWithImpl<$Res>
    extends _$ClubTrialStatusModelCopyWithImpl<$Res, _$ClubTrialStatusModelImpl>
    implements _$$ClubTrialStatusModelImplCopyWith<$Res> {
  __$$ClubTrialStatusModelImplCopyWithImpl(_$ClubTrialStatusModelImpl _value,
      $Res Function(_$ClubTrialStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trialBadge = null,
    Object? isRegisterBtn = null,
    Object? isRegistered = null,
    Object? isRegistrationClosed = null,
  }) {
    return _then(_$ClubTrialStatusModelImpl(
      trialBadge: null == trialBadge
          ? _value.trialBadge
          : trialBadge // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegisterBtn: null == isRegisterBtn
          ? _value.isRegisterBtn
          : isRegisterBtn // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegistered: null == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      isRegistrationClosed: null == isRegistrationClosed
          ? _value.isRegistrationClosed
          : isRegistrationClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubTrialStatusModelImpl implements _ClubTrialStatusModel {
  const _$ClubTrialStatusModelImpl(
      {this.trialBadge = false,
      this.isRegisterBtn = false,
      this.isRegistered = false,
      this.isRegistrationClosed = false});

  factory _$ClubTrialStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubTrialStatusModelImplFromJson(json);

  @override
  @JsonKey()
  final bool trialBadge;
  @override
  @JsonKey()
  final bool isRegisterBtn;
  @override
  @JsonKey()
  final bool isRegistered;
  @override
  @JsonKey()
  final bool isRegistrationClosed;

  @override
  String toString() {
    return 'ClubTrialStatusModel(trialBadge: $trialBadge, isRegisterBtn: $isRegisterBtn, isRegistered: $isRegistered, isRegistrationClosed: $isRegistrationClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubTrialStatusModelImpl &&
            (identical(other.trialBadge, trialBadge) ||
                other.trialBadge == trialBadge) &&
            (identical(other.isRegisterBtn, isRegisterBtn) ||
                other.isRegisterBtn == isRegisterBtn) &&
            (identical(other.isRegistered, isRegistered) ||
                other.isRegistered == isRegistered) &&
            (identical(other.isRegistrationClosed, isRegistrationClosed) ||
                other.isRegistrationClosed == isRegistrationClosed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, trialBadge, isRegisterBtn,
      isRegistered, isRegistrationClosed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubTrialStatusModelImplCopyWith<_$ClubTrialStatusModelImpl>
      get copyWith =>
          __$$ClubTrialStatusModelImplCopyWithImpl<_$ClubTrialStatusModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubTrialStatusModelImplToJson(
      this,
    );
  }
}

abstract class _ClubTrialStatusModel implements ClubTrialStatusModel {
  const factory _ClubTrialStatusModel(
      {final bool trialBadge,
      final bool isRegisterBtn,
      final bool isRegistered,
      final bool isRegistrationClosed}) = _$ClubTrialStatusModelImpl;

  factory _ClubTrialStatusModel.fromJson(Map<String, dynamic> json) =
      _$ClubTrialStatusModelImpl.fromJson;

  @override
  bool get trialBadge;
  @override
  bool get isRegisterBtn;
  @override
  bool get isRegistered;
  @override
  bool get isRegistrationClosed;
  @override
  @JsonKey(ignore: true)
  _$$ClubTrialStatusModelImplCopyWith<_$ClubTrialStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
