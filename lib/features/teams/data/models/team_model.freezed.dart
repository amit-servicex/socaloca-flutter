// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) {
  return _TeamModel.fromJson(json);
}

/// @nodoc
mixin _$TeamModel {
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
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
  int get memberCount => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get createdOn => throw _privateConstructorUsedError;

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
      {String teamId,
      String teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage,
      String? country,
      String? city,
      String? gameType,
      String? gender,
      @JsonKey(name: 'ageCat') String? ageCategory,
      String? ageGroup,
      int memberCount,
      double rating,
      int createdOn});
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
    Object? teamId = null,
    Object? teamName = null,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? ageCategory = freezed,
    Object? ageGroup = freezed,
    Object? memberCount = null,
    Object? rating = null,
    Object? createdOn = null,
  }) {
    return _then(_value.copyWith(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$TeamModelImplCopyWith<$Res>
    implements $TeamModelCopyWith<$Res> {
  factory _$$TeamModelImplCopyWith(
          _$TeamModelImpl value, $Res Function(_$TeamModelImpl) then) =
      __$$TeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String teamId,
      String teamName,
      String? teamShortName,
      @JsonKey(name: 'imageUrl') String? teamImage,
      String? country,
      String? city,
      String? gameType,
      String? gender,
      @JsonKey(name: 'ageCat') String? ageCategory,
      String? ageGroup,
      int memberCount,
      double rating,
      int createdOn});
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
    Object? teamId = null,
    Object? teamName = null,
    Object? teamShortName = freezed,
    Object? teamImage = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? ageCategory = freezed,
    Object? ageGroup = freezed,
    Object? memberCount = null,
    Object? rating = null,
    Object? createdOn = null,
  }) {
    return _then(_$TeamModelImpl(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$TeamModelImpl implements _TeamModel {
  const _$TeamModelImpl(
      {required this.teamId,
      required this.teamName,
      this.teamShortName,
      @JsonKey(name: 'imageUrl') this.teamImage,
      this.country,
      this.city,
      this.gameType,
      this.gender,
      @JsonKey(name: 'ageCat') this.ageCategory,
      this.ageGroup,
      this.memberCount = 0,
      this.rating = 0.0,
      this.createdOn = 0});

  factory _$TeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamModelImplFromJson(json);

  @override
  final String teamId;
  @override
  final String teamName;
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
    return 'TeamModel(teamId: $teamId, teamName: $teamName, teamShortName: $teamShortName, teamImage: $teamImage, country: $country, city: $city, gameType: $gameType, gender: $gender, ageCategory: $ageCategory, ageGroup: $ageGroup, memberCount: $memberCount, rating: $rating, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamModelImpl &&
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
      memberCount,
      rating,
      createdOn);

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
      {required final String teamId,
      required final String teamName,
      final String? teamShortName,
      @JsonKey(name: 'imageUrl') final String? teamImage,
      final String? country,
      final String? city,
      final String? gameType,
      final String? gender,
      @JsonKey(name: 'ageCat') final String? ageCategory,
      final String? ageGroup,
      final int memberCount,
      final double rating,
      final int createdOn}) = _$TeamModelImpl;

  factory _TeamModel.fromJson(Map<String, dynamic> json) =
      _$TeamModelImpl.fromJson;

  @override
  String get teamId;
  @override
  String get teamName;
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
  int get memberCount;
  @override
  double get rating;
  @override
  int get createdOn;
  @override
  @JsonKey(ignore: true)
  _$$TeamModelImplCopyWith<_$TeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
