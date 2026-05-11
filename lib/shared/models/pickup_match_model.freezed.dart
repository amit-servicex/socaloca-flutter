// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pickup_match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PickupMatchModel _$PickupMatchModelFromJson(Map<String, dynamic> json) {
  return _PickupMatchModel.fromJson(json);
}

/// @nodoc
mixin _$PickupMatchModel {
  String get id => throw _privateConstructorUsedError;
  String get hostId => throw _privateConstructorUsedError;
  String get hostName => throw _privateConstructorUsedError;
  String? get hostImage => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get matchDate => throw _privateConstructorUsedError;
  String? get matchTime => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  int get totalSlots => throw _privateConstructorUsedError;
  int get filledSlots => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'open', 'full', 'cancelled'
  bool get hasRequested => throw _privateConstructorUsedError;
  bool get isAccepted => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  String? get skillLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PickupMatchModelCopyWith<PickupMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupMatchModelCopyWith<$Res> {
  factory $PickupMatchModelCopyWith(
          PickupMatchModel value, $Res Function(PickupMatchModel) then) =
      _$PickupMatchModelCopyWithImpl<$Res, PickupMatchModel>;
  @useResult
  $Res call(
      {String id,
      String hostId,
      String hostName,
      String? hostImage,
      String title,
      String? venue,
      String? matchDate,
      String? matchTime,
      String? country,
      String? city,
      double? latitude,
      double? longitude,
      int totalSlots,
      int filledSlots,
      String status,
      bool hasRequested,
      bool isAccepted,
      String? description,
      String? ageGroup,
      String? skillLevel});
}

/// @nodoc
class _$PickupMatchModelCopyWithImpl<$Res, $Val extends PickupMatchModel>
    implements $PickupMatchModelCopyWith<$Res> {
  _$PickupMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostId = null,
    Object? hostName = null,
    Object? hostImage = freezed,
    Object? title = null,
    Object? venue = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? totalSlots = null,
    Object? filledSlots = null,
    Object? status = null,
    Object? hasRequested = null,
    Object? isAccepted = null,
    Object? description = freezed,
    Object? ageGroup = freezed,
    Object? skillLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostId: null == hostId
          ? _value.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String,
      hostName: null == hostName
          ? _value.hostName
          : hostName // ignore: cast_nullable_to_non_nullable
              as String,
      hostImage: freezed == hostImage
          ? _value.hostImage
          : hostImage // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      totalSlots: null == totalSlots
          ? _value.totalSlots
          : totalSlots // ignore: cast_nullable_to_non_nullable
              as int,
      filledSlots: null == filledSlots
          ? _value.filledSlots
          : filledSlots // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hasRequested: null == hasRequested
          ? _value.hasRequested
          : hasRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      isAccepted: null == isAccepted
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      skillLevel: freezed == skillLevel
          ? _value.skillLevel
          : skillLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PickupMatchModelImplCopyWith<$Res>
    implements $PickupMatchModelCopyWith<$Res> {
  factory _$$PickupMatchModelImplCopyWith(_$PickupMatchModelImpl value,
          $Res Function(_$PickupMatchModelImpl) then) =
      __$$PickupMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String hostId,
      String hostName,
      String? hostImage,
      String title,
      String? venue,
      String? matchDate,
      String? matchTime,
      String? country,
      String? city,
      double? latitude,
      double? longitude,
      int totalSlots,
      int filledSlots,
      String status,
      bool hasRequested,
      bool isAccepted,
      String? description,
      String? ageGroup,
      String? skillLevel});
}

/// @nodoc
class __$$PickupMatchModelImplCopyWithImpl<$Res>
    extends _$PickupMatchModelCopyWithImpl<$Res, _$PickupMatchModelImpl>
    implements _$$PickupMatchModelImplCopyWith<$Res> {
  __$$PickupMatchModelImplCopyWithImpl(_$PickupMatchModelImpl _value,
      $Res Function(_$PickupMatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hostId = null,
    Object? hostName = null,
    Object? hostImage = freezed,
    Object? title = null,
    Object? venue = freezed,
    Object? matchDate = freezed,
    Object? matchTime = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? totalSlots = null,
    Object? filledSlots = null,
    Object? status = null,
    Object? hasRequested = null,
    Object? isAccepted = null,
    Object? description = freezed,
    Object? ageGroup = freezed,
    Object? skillLevel = freezed,
  }) {
    return _then(_$PickupMatchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hostId: null == hostId
          ? _value.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String,
      hostName: null == hostName
          ? _value.hostName
          : hostName // ignore: cast_nullable_to_non_nullable
              as String,
      hostImage: freezed == hostImage
          ? _value.hostImage
          : hostImage // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      venue: freezed == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String?,
      matchDate: freezed == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as String?,
      matchTime: freezed == matchTime
          ? _value.matchTime
          : matchTime // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      totalSlots: null == totalSlots
          ? _value.totalSlots
          : totalSlots // ignore: cast_nullable_to_non_nullable
              as int,
      filledSlots: null == filledSlots
          ? _value.filledSlots
          : filledSlots // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hasRequested: null == hasRequested
          ? _value.hasRequested
          : hasRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      isAccepted: null == isAccepted
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      skillLevel: freezed == skillLevel
          ? _value.skillLevel
          : skillLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupMatchModelImpl implements _PickupMatchModel {
  const _$PickupMatchModelImpl(
      {required this.id,
      required this.hostId,
      required this.hostName,
      this.hostImage,
      required this.title,
      this.venue,
      this.matchDate,
      this.matchTime,
      this.country,
      this.city,
      this.latitude,
      this.longitude,
      this.totalSlots = 0,
      this.filledSlots = 0,
      this.status = 'open',
      this.hasRequested = false,
      this.isAccepted = false,
      this.description,
      this.ageGroup,
      this.skillLevel});

  factory _$PickupMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupMatchModelImplFromJson(json);

  @override
  final String id;
  @override
  final String hostId;
  @override
  final String hostName;
  @override
  final String? hostImage;
  @override
  final String title;
  @override
  final String? venue;
  @override
  final String? matchDate;
  @override
  final String? matchTime;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final int totalSlots;
  @override
  @JsonKey()
  final int filledSlots;
  @override
  @JsonKey()
  final String status;
// 'open', 'full', 'cancelled'
  @override
  @JsonKey()
  final bool hasRequested;
  @override
  @JsonKey()
  final bool isAccepted;
  @override
  final String? description;
  @override
  final String? ageGroup;
  @override
  final String? skillLevel;

  @override
  String toString() {
    return 'PickupMatchModel(id: $id, hostId: $hostId, hostName: $hostName, hostImage: $hostImage, title: $title, venue: $venue, matchDate: $matchDate, matchTime: $matchTime, country: $country, city: $city, latitude: $latitude, longitude: $longitude, totalSlots: $totalSlots, filledSlots: $filledSlots, status: $status, hasRequested: $hasRequested, isAccepted: $isAccepted, description: $description, ageGroup: $ageGroup, skillLevel: $skillLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupMatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.hostName, hostName) ||
                other.hostName == hostName) &&
            (identical(other.hostImage, hostImage) ||
                other.hostImage == hostImage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchTime, matchTime) ||
                other.matchTime == matchTime) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.totalSlots, totalSlots) ||
                other.totalSlots == totalSlots) &&
            (identical(other.filledSlots, filledSlots) ||
                other.filledSlots == filledSlots) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hasRequested, hasRequested) ||
                other.hasRequested == hasRequested) &&
            (identical(other.isAccepted, isAccepted) ||
                other.isAccepted == isAccepted) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        hostId,
        hostName,
        hostImage,
        title,
        venue,
        matchDate,
        matchTime,
        country,
        city,
        latitude,
        longitude,
        totalSlots,
        filledSlots,
        status,
        hasRequested,
        isAccepted,
        description,
        ageGroup,
        skillLevel
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupMatchModelImplCopyWith<_$PickupMatchModelImpl> get copyWith =>
      __$$PickupMatchModelImplCopyWithImpl<_$PickupMatchModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupMatchModelImplToJson(
      this,
    );
  }
}

abstract class _PickupMatchModel implements PickupMatchModel {
  const factory _PickupMatchModel(
      {required final String id,
      required final String hostId,
      required final String hostName,
      final String? hostImage,
      required final String title,
      final String? venue,
      final String? matchDate,
      final String? matchTime,
      final String? country,
      final String? city,
      final double? latitude,
      final double? longitude,
      final int totalSlots,
      final int filledSlots,
      final String status,
      final bool hasRequested,
      final bool isAccepted,
      final String? description,
      final String? ageGroup,
      final String? skillLevel}) = _$PickupMatchModelImpl;

  factory _PickupMatchModel.fromJson(Map<String, dynamic> json) =
      _$PickupMatchModelImpl.fromJson;

  @override
  String get id;
  @override
  String get hostId;
  @override
  String get hostName;
  @override
  String? get hostImage;
  @override
  String get title;
  @override
  String? get venue;
  @override
  String? get matchDate;
  @override
  String? get matchTime;
  @override
  String? get country;
  @override
  String? get city;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  int get totalSlots;
  @override
  int get filledSlots;
  @override
  String get status;
  @override // 'open', 'full', 'cancelled'
  bool get hasRequested;
  @override
  bool get isAccepted;
  @override
  String? get description;
  @override
  String? get ageGroup;
  @override
  String? get skillLevel;
  @override
  @JsonKey(ignore: true)
  _$$PickupMatchModelImplCopyWith<_$PickupMatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
