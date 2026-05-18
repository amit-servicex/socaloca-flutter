// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_trial_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubTrialModel _$ClubTrialModelFromJson(Map<String, dynamic> json) {
  return _ClubTrialModel.fromJson(json);
}

/// @nodoc
mixin _$ClubTrialModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get trialId => throw _privateConstructorUsedError;
  String? get clubId => throw _privateConstructorUsedError;
  String? get faId => throw _privateConstructorUsedError;
  String? get trialType => throw _privateConstructorUsedError;
  String? get trialName => throw _privateConstructorUsedError;
  String? get registerDateFrom => throw _privateConstructorUsedError;
  String? get registerDateTo => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get registerDateFromGmt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get registerDateToGmt => throw _privateConstructorUsedError;
  String? get trialDateFrom => throw _privateConstructorUsedError;
  String? get trialDateTo => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get trialDateFromGmt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get trialDateToGmt => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get brief => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get trialVenue => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get ageFrom => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get ageTo => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readDouble)
  double get lat => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readDouble)
  double get lng => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _readInt)
  int get cost => throw _privateConstructorUsedError;
  bool get isDelete => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  ClubTrialOrgModel? get clubDetails => throw _privateConstructorUsedError;
  ClubTrialOrgModel? get academyDetails => throw _privateConstructorUsedError;
  ClubTrialStatusModel? get trialStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubTrialModelCopyWith<ClubTrialModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubTrialModelCopyWith<$Res> {
  factory $ClubTrialModelCopyWith(
          ClubTrialModel value, $Res Function(ClubTrialModel) then) =
      _$ClubTrialModelCopyWithImpl<$Res, ClubTrialModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? trialId,
      String? clubId,
      String? faId,
      String? trialType,
      String? trialName,
      String? registerDateFrom,
      String? registerDateTo,
      @JsonKey(fromJson: _readInt) int registerDateFromGmt,
      @JsonKey(fromJson: _readInt) int registerDateToGmt,
      String? trialDateFrom,
      String? trialDateTo,
      @JsonKey(fromJson: _readInt) int trialDateFromGmt,
      @JsonKey(fromJson: _readInt) int trialDateToGmt,
      String? currency,
      String? gender,
      String? brief,
      String? location,
      String? trialVenue,
      @JsonKey(fromJson: _readInt) int ageFrom,
      @JsonKey(fromJson: _readInt) int ageTo,
      @JsonKey(fromJson: _readDouble) double lat,
      @JsonKey(fromJson: _readDouble) double lng,
      @JsonKey(fromJson: _readInt) int cost,
      bool isDelete,
      bool active,
      ClubTrialOrgModel? clubDetails,
      ClubTrialOrgModel? academyDetails,
      ClubTrialStatusModel? trialStatus});

  $ClubTrialOrgModelCopyWith<$Res>? get clubDetails;
  $ClubTrialOrgModelCopyWith<$Res>? get academyDetails;
  $ClubTrialStatusModelCopyWith<$Res>? get trialStatus;
}

/// @nodoc
class _$ClubTrialModelCopyWithImpl<$Res, $Val extends ClubTrialModel>
    implements $ClubTrialModelCopyWith<$Res> {
  _$ClubTrialModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trialId = freezed,
    Object? clubId = freezed,
    Object? faId = freezed,
    Object? trialType = freezed,
    Object? trialName = freezed,
    Object? registerDateFrom = freezed,
    Object? registerDateTo = freezed,
    Object? registerDateFromGmt = null,
    Object? registerDateToGmt = null,
    Object? trialDateFrom = freezed,
    Object? trialDateTo = freezed,
    Object? trialDateFromGmt = null,
    Object? trialDateToGmt = null,
    Object? currency = freezed,
    Object? gender = freezed,
    Object? brief = freezed,
    Object? location = freezed,
    Object? trialVenue = freezed,
    Object? ageFrom = null,
    Object? ageTo = null,
    Object? lat = null,
    Object? lng = null,
    Object? cost = null,
    Object? isDelete = null,
    Object? active = null,
    Object? clubDetails = freezed,
    Object? academyDetails = freezed,
    Object? trialStatus = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      trialId: freezed == trialId
          ? _value.trialId
          : trialId // ignore: cast_nullable_to_non_nullable
              as String?,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String?,
      faId: freezed == faId
          ? _value.faId
          : faId // ignore: cast_nullable_to_non_nullable
              as String?,
      trialType: freezed == trialType
          ? _value.trialType
          : trialType // ignore: cast_nullable_to_non_nullable
              as String?,
      trialName: freezed == trialName
          ? _value.trialName
          : trialName // ignore: cast_nullable_to_non_nullable
              as String?,
      registerDateFrom: freezed == registerDateFrom
          ? _value.registerDateFrom
          : registerDateFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      registerDateTo: freezed == registerDateTo
          ? _value.registerDateTo
          : registerDateTo // ignore: cast_nullable_to_non_nullable
              as String?,
      registerDateFromGmt: null == registerDateFromGmt
          ? _value.registerDateFromGmt
          : registerDateFromGmt // ignore: cast_nullable_to_non_nullable
              as int,
      registerDateToGmt: null == registerDateToGmt
          ? _value.registerDateToGmt
          : registerDateToGmt // ignore: cast_nullable_to_non_nullable
              as int,
      trialDateFrom: freezed == trialDateFrom
          ? _value.trialDateFrom
          : trialDateFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      trialDateTo: freezed == trialDateTo
          ? _value.trialDateTo
          : trialDateTo // ignore: cast_nullable_to_non_nullable
              as String?,
      trialDateFromGmt: null == trialDateFromGmt
          ? _value.trialDateFromGmt
          : trialDateFromGmt // ignore: cast_nullable_to_non_nullable
              as int,
      trialDateToGmt: null == trialDateToGmt
          ? _value.trialDateToGmt
          : trialDateToGmt // ignore: cast_nullable_to_non_nullable
              as int,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      brief: freezed == brief
          ? _value.brief
          : brief // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      trialVenue: freezed == trialVenue
          ? _value.trialVenue
          : trialVenue // ignore: cast_nullable_to_non_nullable
              as String?,
      ageFrom: null == ageFrom
          ? _value.ageFrom
          : ageFrom // ignore: cast_nullable_to_non_nullable
              as int,
      ageTo: null == ageTo
          ? _value.ageTo
          : ageTo // ignore: cast_nullable_to_non_nullable
              as int,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      clubDetails: freezed == clubDetails
          ? _value.clubDetails
          : clubDetails // ignore: cast_nullable_to_non_nullable
              as ClubTrialOrgModel?,
      academyDetails: freezed == academyDetails
          ? _value.academyDetails
          : academyDetails // ignore: cast_nullable_to_non_nullable
              as ClubTrialOrgModel?,
      trialStatus: freezed == trialStatus
          ? _value.trialStatus
          : trialStatus // ignore: cast_nullable_to_non_nullable
              as ClubTrialStatusModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubTrialOrgModelCopyWith<$Res>? get clubDetails {
    if (_value.clubDetails == null) {
      return null;
    }

    return $ClubTrialOrgModelCopyWith<$Res>(_value.clubDetails!, (value) {
      return _then(_value.copyWith(clubDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubTrialOrgModelCopyWith<$Res>? get academyDetails {
    if (_value.academyDetails == null) {
      return null;
    }

    return $ClubTrialOrgModelCopyWith<$Res>(_value.academyDetails!, (value) {
      return _then(_value.copyWith(academyDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubTrialStatusModelCopyWith<$Res>? get trialStatus {
    if (_value.trialStatus == null) {
      return null;
    }

    return $ClubTrialStatusModelCopyWith<$Res>(_value.trialStatus!, (value) {
      return _then(_value.copyWith(trialStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClubTrialModelImplCopyWith<$Res>
    implements $ClubTrialModelCopyWith<$Res> {
  factory _$$ClubTrialModelImplCopyWith(_$ClubTrialModelImpl value,
          $Res Function(_$ClubTrialModelImpl) then) =
      __$$ClubTrialModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? trialId,
      String? clubId,
      String? faId,
      String? trialType,
      String? trialName,
      String? registerDateFrom,
      String? registerDateTo,
      @JsonKey(fromJson: _readInt) int registerDateFromGmt,
      @JsonKey(fromJson: _readInt) int registerDateToGmt,
      String? trialDateFrom,
      String? trialDateTo,
      @JsonKey(fromJson: _readInt) int trialDateFromGmt,
      @JsonKey(fromJson: _readInt) int trialDateToGmt,
      String? currency,
      String? gender,
      String? brief,
      String? location,
      String? trialVenue,
      @JsonKey(fromJson: _readInt) int ageFrom,
      @JsonKey(fromJson: _readInt) int ageTo,
      @JsonKey(fromJson: _readDouble) double lat,
      @JsonKey(fromJson: _readDouble) double lng,
      @JsonKey(fromJson: _readInt) int cost,
      bool isDelete,
      bool active,
      ClubTrialOrgModel? clubDetails,
      ClubTrialOrgModel? academyDetails,
      ClubTrialStatusModel? trialStatus});

  @override
  $ClubTrialOrgModelCopyWith<$Res>? get clubDetails;
  @override
  $ClubTrialOrgModelCopyWith<$Res>? get academyDetails;
  @override
  $ClubTrialStatusModelCopyWith<$Res>? get trialStatus;
}

/// @nodoc
class __$$ClubTrialModelImplCopyWithImpl<$Res>
    extends _$ClubTrialModelCopyWithImpl<$Res, _$ClubTrialModelImpl>
    implements _$$ClubTrialModelImplCopyWith<$Res> {
  __$$ClubTrialModelImplCopyWithImpl(
      _$ClubTrialModelImpl _value, $Res Function(_$ClubTrialModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? trialId = freezed,
    Object? clubId = freezed,
    Object? faId = freezed,
    Object? trialType = freezed,
    Object? trialName = freezed,
    Object? registerDateFrom = freezed,
    Object? registerDateTo = freezed,
    Object? registerDateFromGmt = null,
    Object? registerDateToGmt = null,
    Object? trialDateFrom = freezed,
    Object? trialDateTo = freezed,
    Object? trialDateFromGmt = null,
    Object? trialDateToGmt = null,
    Object? currency = freezed,
    Object? gender = freezed,
    Object? brief = freezed,
    Object? location = freezed,
    Object? trialVenue = freezed,
    Object? ageFrom = null,
    Object? ageTo = null,
    Object? lat = null,
    Object? lng = null,
    Object? cost = null,
    Object? isDelete = null,
    Object? active = null,
    Object? clubDetails = freezed,
    Object? academyDetails = freezed,
    Object? trialStatus = freezed,
  }) {
    return _then(_$ClubTrialModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      trialId: freezed == trialId
          ? _value.trialId
          : trialId // ignore: cast_nullable_to_non_nullable
              as String?,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String?,
      faId: freezed == faId
          ? _value.faId
          : faId // ignore: cast_nullable_to_non_nullable
              as String?,
      trialType: freezed == trialType
          ? _value.trialType
          : trialType // ignore: cast_nullable_to_non_nullable
              as String?,
      trialName: freezed == trialName
          ? _value.trialName
          : trialName // ignore: cast_nullable_to_non_nullable
              as String?,
      registerDateFrom: freezed == registerDateFrom
          ? _value.registerDateFrom
          : registerDateFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      registerDateTo: freezed == registerDateTo
          ? _value.registerDateTo
          : registerDateTo // ignore: cast_nullable_to_non_nullable
              as String?,
      registerDateFromGmt: null == registerDateFromGmt
          ? _value.registerDateFromGmt
          : registerDateFromGmt // ignore: cast_nullable_to_non_nullable
              as int,
      registerDateToGmt: null == registerDateToGmt
          ? _value.registerDateToGmt
          : registerDateToGmt // ignore: cast_nullable_to_non_nullable
              as int,
      trialDateFrom: freezed == trialDateFrom
          ? _value.trialDateFrom
          : trialDateFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      trialDateTo: freezed == trialDateTo
          ? _value.trialDateTo
          : trialDateTo // ignore: cast_nullable_to_non_nullable
              as String?,
      trialDateFromGmt: null == trialDateFromGmt
          ? _value.trialDateFromGmt
          : trialDateFromGmt // ignore: cast_nullable_to_non_nullable
              as int,
      trialDateToGmt: null == trialDateToGmt
          ? _value.trialDateToGmt
          : trialDateToGmt // ignore: cast_nullable_to_non_nullable
              as int,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      brief: freezed == brief
          ? _value.brief
          : brief // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      trialVenue: freezed == trialVenue
          ? _value.trialVenue
          : trialVenue // ignore: cast_nullable_to_non_nullable
              as String?,
      ageFrom: null == ageFrom
          ? _value.ageFrom
          : ageFrom // ignore: cast_nullable_to_non_nullable
              as int,
      ageTo: null == ageTo
          ? _value.ageTo
          : ageTo // ignore: cast_nullable_to_non_nullable
              as int,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      isDelete: null == isDelete
          ? _value.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      clubDetails: freezed == clubDetails
          ? _value.clubDetails
          : clubDetails // ignore: cast_nullable_to_non_nullable
              as ClubTrialOrgModel?,
      academyDetails: freezed == academyDetails
          ? _value.academyDetails
          : academyDetails // ignore: cast_nullable_to_non_nullable
              as ClubTrialOrgModel?,
      trialStatus: freezed == trialStatus
          ? _value.trialStatus
          : trialStatus // ignore: cast_nullable_to_non_nullable
              as ClubTrialStatusModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubTrialModelImpl extends _ClubTrialModel {
  const _$ClubTrialModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.trialId,
      this.clubId,
      this.faId,
      this.trialType,
      this.trialName,
      this.registerDateFrom,
      this.registerDateTo,
      @JsonKey(fromJson: _readInt) this.registerDateFromGmt = 0,
      @JsonKey(fromJson: _readInt) this.registerDateToGmt = 0,
      this.trialDateFrom,
      this.trialDateTo,
      @JsonKey(fromJson: _readInt) this.trialDateFromGmt = 0,
      @JsonKey(fromJson: _readInt) this.trialDateToGmt = 0,
      this.currency,
      this.gender,
      this.brief,
      this.location,
      this.trialVenue,
      @JsonKey(fromJson: _readInt) this.ageFrom = 0,
      @JsonKey(fromJson: _readInt) this.ageTo = 0,
      @JsonKey(fromJson: _readDouble) this.lat = 0,
      @JsonKey(fromJson: _readDouble) this.lng = 0,
      @JsonKey(fromJson: _readInt) this.cost = 0,
      this.isDelete = false,
      this.active = false,
      this.clubDetails,
      this.academyDetails,
      this.trialStatus})
      : super._();

  factory _$ClubTrialModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubTrialModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? trialId;
  @override
  final String? clubId;
  @override
  final String? faId;
  @override
  final String? trialType;
  @override
  final String? trialName;
  @override
  final String? registerDateFrom;
  @override
  final String? registerDateTo;
  @override
  @JsonKey(fromJson: _readInt)
  final int registerDateFromGmt;
  @override
  @JsonKey(fromJson: _readInt)
  final int registerDateToGmt;
  @override
  final String? trialDateFrom;
  @override
  final String? trialDateTo;
  @override
  @JsonKey(fromJson: _readInt)
  final int trialDateFromGmt;
  @override
  @JsonKey(fromJson: _readInt)
  final int trialDateToGmt;
  @override
  final String? currency;
  @override
  final String? gender;
  @override
  final String? brief;
  @override
  final String? location;
  @override
  final String? trialVenue;
  @override
  @JsonKey(fromJson: _readInt)
  final int ageFrom;
  @override
  @JsonKey(fromJson: _readInt)
  final int ageTo;
  @override
  @JsonKey(fromJson: _readDouble)
  final double lat;
  @override
  @JsonKey(fromJson: _readDouble)
  final double lng;
  @override
  @JsonKey(fromJson: _readInt)
  final int cost;
  @override
  @JsonKey()
  final bool isDelete;
  @override
  @JsonKey()
  final bool active;
  @override
  final ClubTrialOrgModel? clubDetails;
  @override
  final ClubTrialOrgModel? academyDetails;
  @override
  final ClubTrialStatusModel? trialStatus;

  @override
  String toString() {
    return 'ClubTrialModel(id: $id, trialId: $trialId, clubId: $clubId, faId: $faId, trialType: $trialType, trialName: $trialName, registerDateFrom: $registerDateFrom, registerDateTo: $registerDateTo, registerDateFromGmt: $registerDateFromGmt, registerDateToGmt: $registerDateToGmt, trialDateFrom: $trialDateFrom, trialDateTo: $trialDateTo, trialDateFromGmt: $trialDateFromGmt, trialDateToGmt: $trialDateToGmt, currency: $currency, gender: $gender, brief: $brief, location: $location, trialVenue: $trialVenue, ageFrom: $ageFrom, ageTo: $ageTo, lat: $lat, lng: $lng, cost: $cost, isDelete: $isDelete, active: $active, clubDetails: $clubDetails, academyDetails: $academyDetails, trialStatus: $trialStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubTrialModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.trialId, trialId) || other.trialId == trialId) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.faId, faId) || other.faId == faId) &&
            (identical(other.trialType, trialType) ||
                other.trialType == trialType) &&
            (identical(other.trialName, trialName) ||
                other.trialName == trialName) &&
            (identical(other.registerDateFrom, registerDateFrom) ||
                other.registerDateFrom == registerDateFrom) &&
            (identical(other.registerDateTo, registerDateTo) ||
                other.registerDateTo == registerDateTo) &&
            (identical(other.registerDateFromGmt, registerDateFromGmt) ||
                other.registerDateFromGmt == registerDateFromGmt) &&
            (identical(other.registerDateToGmt, registerDateToGmt) ||
                other.registerDateToGmt == registerDateToGmt) &&
            (identical(other.trialDateFrom, trialDateFrom) ||
                other.trialDateFrom == trialDateFrom) &&
            (identical(other.trialDateTo, trialDateTo) ||
                other.trialDateTo == trialDateTo) &&
            (identical(other.trialDateFromGmt, trialDateFromGmt) ||
                other.trialDateFromGmt == trialDateFromGmt) &&
            (identical(other.trialDateToGmt, trialDateToGmt) ||
                other.trialDateToGmt == trialDateToGmt) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.brief, brief) || other.brief == brief) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.trialVenue, trialVenue) ||
                other.trialVenue == trialVenue) &&
            (identical(other.ageFrom, ageFrom) || other.ageFrom == ageFrom) &&
            (identical(other.ageTo, ageTo) || other.ageTo == ageTo) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.clubDetails, clubDetails) ||
                other.clubDetails == clubDetails) &&
            (identical(other.academyDetails, academyDetails) ||
                other.academyDetails == academyDetails) &&
            (identical(other.trialStatus, trialStatus) ||
                other.trialStatus == trialStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        trialId,
        clubId,
        faId,
        trialType,
        trialName,
        registerDateFrom,
        registerDateTo,
        registerDateFromGmt,
        registerDateToGmt,
        trialDateFrom,
        trialDateTo,
        trialDateFromGmt,
        trialDateToGmt,
        currency,
        gender,
        brief,
        location,
        trialVenue,
        ageFrom,
        ageTo,
        lat,
        lng,
        cost,
        isDelete,
        active,
        clubDetails,
        academyDetails,
        trialStatus
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubTrialModelImplCopyWith<_$ClubTrialModelImpl> get copyWith =>
      __$$ClubTrialModelImplCopyWithImpl<_$ClubTrialModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubTrialModelImplToJson(
      this,
    );
  }
}

abstract class _ClubTrialModel extends ClubTrialModel {
  const factory _ClubTrialModel(
      {@JsonKey(name: '_id') final String? id,
      final String? trialId,
      final String? clubId,
      final String? faId,
      final String? trialType,
      final String? trialName,
      final String? registerDateFrom,
      final String? registerDateTo,
      @JsonKey(fromJson: _readInt) final int registerDateFromGmt,
      @JsonKey(fromJson: _readInt) final int registerDateToGmt,
      final String? trialDateFrom,
      final String? trialDateTo,
      @JsonKey(fromJson: _readInt) final int trialDateFromGmt,
      @JsonKey(fromJson: _readInt) final int trialDateToGmt,
      final String? currency,
      final String? gender,
      final String? brief,
      final String? location,
      final String? trialVenue,
      @JsonKey(fromJson: _readInt) final int ageFrom,
      @JsonKey(fromJson: _readInt) final int ageTo,
      @JsonKey(fromJson: _readDouble) final double lat,
      @JsonKey(fromJson: _readDouble) final double lng,
      @JsonKey(fromJson: _readInt) final int cost,
      final bool isDelete,
      final bool active,
      final ClubTrialOrgModel? clubDetails,
      final ClubTrialOrgModel? academyDetails,
      final ClubTrialStatusModel? trialStatus}) = _$ClubTrialModelImpl;
  const _ClubTrialModel._() : super._();

  factory _ClubTrialModel.fromJson(Map<String, dynamic> json) =
      _$ClubTrialModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get trialId;
  @override
  String? get clubId;
  @override
  String? get faId;
  @override
  String? get trialType;
  @override
  String? get trialName;
  @override
  String? get registerDateFrom;
  @override
  String? get registerDateTo;
  @override
  @JsonKey(fromJson: _readInt)
  int get registerDateFromGmt;
  @override
  @JsonKey(fromJson: _readInt)
  int get registerDateToGmt;
  @override
  String? get trialDateFrom;
  @override
  String? get trialDateTo;
  @override
  @JsonKey(fromJson: _readInt)
  int get trialDateFromGmt;
  @override
  @JsonKey(fromJson: _readInt)
  int get trialDateToGmt;
  @override
  String? get currency;
  @override
  String? get gender;
  @override
  String? get brief;
  @override
  String? get location;
  @override
  String? get trialVenue;
  @override
  @JsonKey(fromJson: _readInt)
  int get ageFrom;
  @override
  @JsonKey(fromJson: _readInt)
  int get ageTo;
  @override
  @JsonKey(fromJson: _readDouble)
  double get lat;
  @override
  @JsonKey(fromJson: _readDouble)
  double get lng;
  @override
  @JsonKey(fromJson: _readInt)
  int get cost;
  @override
  bool get isDelete;
  @override
  bool get active;
  @override
  ClubTrialOrgModel? get clubDetails;
  @override
  ClubTrialOrgModel? get academyDetails;
  @override
  ClubTrialStatusModel? get trialStatus;
  @override
  @JsonKey(ignore: true)
  _$$ClubTrialModelImplCopyWith<_$ClubTrialModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubTrialOrgModel _$ClubTrialOrgModelFromJson(Map<String, dynamic> json) {
  return _ClubTrialOrgModel.fromJson(json);
}

/// @nodoc
mixin _$ClubTrialOrgModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String? get clubId => throw _privateConstructorUsedError;
  String? get academyId => throw _privateConstructorUsedError;
  String? get clubName => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubTrialOrgModelCopyWith<ClubTrialOrgModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubTrialOrgModelCopyWith<$Res> {
  factory $ClubTrialOrgModelCopyWith(
          ClubTrialOrgModel value, $Res Function(ClubTrialOrgModel) then) =
      _$ClubTrialOrgModelCopyWithImpl<$Res, ClubTrialOrgModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? clubId,
      String? academyId,
      String? clubName,
      String? name,
      String? email,
      String? imageUrl});
}

/// @nodoc
class _$ClubTrialOrgModelCopyWithImpl<$Res, $Val extends ClubTrialOrgModel>
    implements $ClubTrialOrgModelCopyWith<$Res> {
  _$ClubTrialOrgModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clubId = freezed,
    Object? academyId = freezed,
    Object? clubName = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String?,
      academyId: freezed == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as String?,
      clubName: freezed == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubTrialOrgModelImplCopyWith<$Res>
    implements $ClubTrialOrgModelCopyWith<$Res> {
  factory _$$ClubTrialOrgModelImplCopyWith(_$ClubTrialOrgModelImpl value,
          $Res Function(_$ClubTrialOrgModelImpl) then) =
      __$$ClubTrialOrgModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String? clubId,
      String? academyId,
      String? clubName,
      String? name,
      String? email,
      String? imageUrl});
}

/// @nodoc
class __$$ClubTrialOrgModelImplCopyWithImpl<$Res>
    extends _$ClubTrialOrgModelCopyWithImpl<$Res, _$ClubTrialOrgModelImpl>
    implements _$$ClubTrialOrgModelImplCopyWith<$Res> {
  __$$ClubTrialOrgModelImplCopyWithImpl(_$ClubTrialOrgModelImpl _value,
      $Res Function(_$ClubTrialOrgModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clubId = freezed,
    Object? academyId = freezed,
    Object? clubName = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$ClubTrialOrgModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clubId: freezed == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String?,
      academyId: freezed == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as String?,
      clubName: freezed == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubTrialOrgModelImpl extends _ClubTrialOrgModel {
  const _$ClubTrialOrgModelImpl(
      {@JsonKey(name: '_id') this.id,
      this.clubId,
      this.academyId,
      this.clubName,
      this.name,
      this.email,
      this.imageUrl})
      : super._();

  factory _$ClubTrialOrgModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubTrialOrgModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String? clubId;
  @override
  final String? academyId;
  @override
  final String? clubName;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ClubTrialOrgModel(id: $id, clubId: $clubId, academyId: $academyId, clubName: $clubName, name: $name, email: $email, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubTrialOrgModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.academyId, academyId) ||
                other.academyId == academyId) &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, clubId, academyId, clubName, name, email, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubTrialOrgModelImplCopyWith<_$ClubTrialOrgModelImpl> get copyWith =>
      __$$ClubTrialOrgModelImplCopyWithImpl<_$ClubTrialOrgModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubTrialOrgModelImplToJson(
      this,
    );
  }
}

abstract class _ClubTrialOrgModel extends ClubTrialOrgModel {
  const factory _ClubTrialOrgModel(
      {@JsonKey(name: '_id') final String? id,
      final String? clubId,
      final String? academyId,
      final String? clubName,
      final String? name,
      final String? email,
      final String? imageUrl}) = _$ClubTrialOrgModelImpl;
  const _ClubTrialOrgModel._() : super._();

  factory _ClubTrialOrgModel.fromJson(Map<String, dynamic> json) =
      _$ClubTrialOrgModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String? get clubId;
  @override
  String? get academyId;
  @override
  String? get clubName;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$ClubTrialOrgModelImplCopyWith<_$ClubTrialOrgModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubTrialStatusModel _$ClubTrialStatusModelFromJson(Map<String, dynamic> json) {
  return _ClubTrialStatusModel.fromJson(json);
}

/// @nodoc
mixin _$ClubTrialStatusModel {
  bool get expire => throw _privateConstructorUsedError;
  bool get canRegister => throw _privateConstructorUsedError;
  bool get live => throw _privateConstructorUsedError;
  bool get registered => throw _privateConstructorUsedError;

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
  $Res call({bool expire, bool canRegister, bool live, bool registered});
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
    Object? expire = null,
    Object? canRegister = null,
    Object? live = null,
    Object? registered = null,
  }) {
    return _then(_value.copyWith(
      expire: null == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as bool,
      canRegister: null == canRegister
          ? _value.canRegister
          : canRegister // ignore: cast_nullable_to_non_nullable
              as bool,
      live: null == live
          ? _value.live
          : live // ignore: cast_nullable_to_non_nullable
              as bool,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
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
  $Res call({bool expire, bool canRegister, bool live, bool registered});
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
    Object? expire = null,
    Object? canRegister = null,
    Object? live = null,
    Object? registered = null,
  }) {
    return _then(_$ClubTrialStatusModelImpl(
      expire: null == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as bool,
      canRegister: null == canRegister
          ? _value.canRegister
          : canRegister // ignore: cast_nullable_to_non_nullable
              as bool,
      live: null == live
          ? _value.live
          : live // ignore: cast_nullable_to_non_nullable
              as bool,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubTrialStatusModelImpl implements _ClubTrialStatusModel {
  const _$ClubTrialStatusModelImpl(
      {this.expire = false,
      this.canRegister = false,
      this.live = false,
      this.registered = false});

  factory _$ClubTrialStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubTrialStatusModelImplFromJson(json);

  @override
  @JsonKey()
  final bool expire;
  @override
  @JsonKey()
  final bool canRegister;
  @override
  @JsonKey()
  final bool live;
  @override
  @JsonKey()
  final bool registered;

  @override
  String toString() {
    return 'ClubTrialStatusModel(expire: $expire, canRegister: $canRegister, live: $live, registered: $registered)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubTrialStatusModelImpl &&
            (identical(other.expire, expire) || other.expire == expire) &&
            (identical(other.canRegister, canRegister) ||
                other.canRegister == canRegister) &&
            (identical(other.live, live) || other.live == live) &&
            (identical(other.registered, registered) ||
                other.registered == registered));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, expire, canRegister, live, registered);

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
      {final bool expire,
      final bool canRegister,
      final bool live,
      final bool registered}) = _$ClubTrialStatusModelImpl;

  factory _ClubTrialStatusModel.fromJson(Map<String, dynamic> json) =
      _$ClubTrialStatusModelImpl.fromJson;

  @override
  bool get expire;
  @override
  bool get canRegister;
  @override
  bool get live;
  @override
  bool get registered;
  @override
  @JsonKey(ignore: true)
  _$$ClubTrialStatusModelImplCopyWith<_$ClubTrialStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
