// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_new_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedNewTeamModel _$FeedNewTeamModelFromJson(Map<String, dynamic> json) {
  return _FeedNewTeamModel.fromJson(json);
}

/// @nodoc
mixin _$FeedNewTeamModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamId')
  String? get teamId => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamName')
  String? get teamName => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get teamLogo => throw _privateConstructorUsedError;
  @JsonKey(name: 'country')
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'city')
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'memberCount')
  int get memberCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdOn')
  int? get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'gameType')
  String? get teamType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedNewTeamModelCopyWith<FeedNewTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedNewTeamModelCopyWith<$Res> {
  factory $FeedNewTeamModelCopyWith(
          FeedNewTeamModel value, $Res Function(FeedNewTeamModel) then) =
      _$FeedNewTeamModelCopyWithImpl<$Res, FeedNewTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      @JsonKey(name: 'teamName') String? teamName,
      @JsonKey(name: 'imageUrl') String? teamLogo,
      @JsonKey(name: 'country') String? country,
      @JsonKey(name: 'city') String? city,
      @JsonKey(name: 'memberCount') int memberCount,
      @JsonKey(name: 'createdOn') int? createdOn,
      @JsonKey(name: 'gameType') String? teamType});
}

/// @nodoc
class _$FeedNewTeamModelCopyWithImpl<$Res, $Val extends FeedNewTeamModel>
    implements $FeedNewTeamModelCopyWith<$Res> {
  _$FeedNewTeamModelCopyWithImpl(this._value, this._then);

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
    Object? teamLogo = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? memberCount = null,
    Object? createdOn = freezed,
    Object? teamType = freezed,
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
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int?,
      teamType: freezed == teamType
          ? _value.teamType
          : teamType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedNewTeamModelImplCopyWith<$Res>
    implements $FeedNewTeamModelCopyWith<$Res> {
  factory _$$FeedNewTeamModelImplCopyWith(_$FeedNewTeamModelImpl value,
          $Res Function(_$FeedNewTeamModelImpl) then) =
      __$$FeedNewTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      @JsonKey(name: 'teamName') String? teamName,
      @JsonKey(name: 'imageUrl') String? teamLogo,
      @JsonKey(name: 'country') String? country,
      @JsonKey(name: 'city') String? city,
      @JsonKey(name: 'memberCount') int memberCount,
      @JsonKey(name: 'createdOn') int? createdOn,
      @JsonKey(name: 'gameType') String? teamType});
}

/// @nodoc
class __$$FeedNewTeamModelImplCopyWithImpl<$Res>
    extends _$FeedNewTeamModelCopyWithImpl<$Res, _$FeedNewTeamModelImpl>
    implements _$$FeedNewTeamModelImplCopyWith<$Res> {
  __$$FeedNewTeamModelImplCopyWithImpl(_$FeedNewTeamModelImpl _value,
      $Res Function(_$FeedNewTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? memberCount = null,
    Object? createdOn = freezed,
    Object? teamType = freezed,
  }) {
    return _then(_$FeedNewTeamModelImpl(
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
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as int?,
      teamType: freezed == teamType
          ? _value.teamType
          : teamType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedNewTeamModelImpl implements _FeedNewTeamModel {
  const _$FeedNewTeamModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'teamId') this.teamId,
      @JsonKey(name: 'teamName') this.teamName,
      @JsonKey(name: 'imageUrl') this.teamLogo,
      @JsonKey(name: 'country') this.country,
      @JsonKey(name: 'city') this.city,
      @JsonKey(name: 'memberCount') this.memberCount = 0,
      @JsonKey(name: 'createdOn') this.createdOn,
      @JsonKey(name: 'gameType') this.teamType});

  factory _$FeedNewTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedNewTeamModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'teamId')
  final String? teamId;
  @override
  @JsonKey(name: 'teamName')
  final String? teamName;
  @override
  @JsonKey(name: 'imageUrl')
  final String? teamLogo;
  @override
  @JsonKey(name: 'country')
  final String? country;
  @override
  @JsonKey(name: 'city')
  final String? city;
  @override
  @JsonKey(name: 'memberCount')
  final int memberCount;
  @override
  @JsonKey(name: 'createdOn')
  final int? createdOn;
  @override
  @JsonKey(name: 'gameType')
  final String? teamType;

  @override
  String toString() {
    return 'FeedNewTeamModel(id: $id, teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, country: $country, city: $city, memberCount: $memberCount, createdOn: $createdOn, teamType: $teamType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedNewTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.teamType, teamType) ||
                other.teamType == teamType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, teamId, teamName, teamLogo,
      country, city, memberCount, createdOn, teamType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedNewTeamModelImplCopyWith<_$FeedNewTeamModelImpl> get copyWith =>
      __$$FeedNewTeamModelImplCopyWithImpl<_$FeedNewTeamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedNewTeamModelImplToJson(
      this,
    );
  }
}

abstract class _FeedNewTeamModel implements FeedNewTeamModel {
  const factory _FeedNewTeamModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'teamId') final String? teamId,
          @JsonKey(name: 'teamName') final String? teamName,
          @JsonKey(name: 'imageUrl') final String? teamLogo,
          @JsonKey(name: 'country') final String? country,
          @JsonKey(name: 'city') final String? city,
          @JsonKey(name: 'memberCount') final int memberCount,
          @JsonKey(name: 'createdOn') final int? createdOn,
          @JsonKey(name: 'gameType') final String? teamType}) =
      _$FeedNewTeamModelImpl;

  factory _FeedNewTeamModel.fromJson(Map<String, dynamic> json) =
      _$FeedNewTeamModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'teamId')
  String? get teamId;
  @override
  @JsonKey(name: 'teamName')
  String? get teamName;
  @override
  @JsonKey(name: 'imageUrl')
  String? get teamLogo;
  @override
  @JsonKey(name: 'country')
  String? get country;
  @override
  @JsonKey(name: 'city')
  String? get city;
  @override
  @JsonKey(name: 'memberCount')
  int get memberCount;
  @override
  @JsonKey(name: 'createdOn')
  int? get createdOn;
  @override
  @JsonKey(name: 'gameType')
  String? get teamType;
  @override
  @JsonKey(ignore: true)
  _$$FeedNewTeamModelImplCopyWith<_$FeedNewTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
