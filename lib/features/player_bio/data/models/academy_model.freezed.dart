// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AcademyModel _$AcademyModelFromJson(Map<String, dynamic> json) {
  return _AcademyModel.fromJson(json);
}

/// @nodoc
mixin _$AcademyModel {
  @JsonKey(name: 'academyId')
  String? get academyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AcademyModelCopyWith<AcademyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademyModelCopyWith<$Res> {
  factory $AcademyModelCopyWith(
          AcademyModel value, $Res Function(AcademyModel) then) =
      _$AcademyModelCopyWithImpl<$Res, AcademyModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'academyId') String? academyId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'imageUrl') String? imageUrl});
}

/// @nodoc
class _$AcademyModelCopyWithImpl<$Res, $Val extends AcademyModel>
    implements $AcademyModelCopyWith<$Res> {
  _$AcademyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academyId = freezed,
    Object? name = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      academyId: freezed == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcademyModelImplCopyWith<$Res>
    implements $AcademyModelCopyWith<$Res> {
  factory _$$AcademyModelImplCopyWith(
          _$AcademyModelImpl value, $Res Function(_$AcademyModelImpl) then) =
      __$$AcademyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'academyId') String? academyId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'imageUrl') String? imageUrl});
}

/// @nodoc
class __$$AcademyModelImplCopyWithImpl<$Res>
    extends _$AcademyModelCopyWithImpl<$Res, _$AcademyModelImpl>
    implements _$$AcademyModelImplCopyWith<$Res> {
  __$$AcademyModelImplCopyWithImpl(
      _$AcademyModelImpl _value, $Res Function(_$AcademyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academyId = freezed,
    Object? name = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$AcademyModelImpl(
      academyId: freezed == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$AcademyModelImpl implements _AcademyModel {
  const _$AcademyModelImpl(
      {@JsonKey(name: 'academyId') this.academyId,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'imageUrl') this.imageUrl});

  factory _$AcademyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcademyModelImplFromJson(json);

  @override
  @JsonKey(name: 'academyId')
  final String? academyId;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @override
  String toString() {
    return 'AcademyModel(academyId: $academyId, name: $name, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademyModelImpl &&
            (identical(other.academyId, academyId) ||
                other.academyId == academyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, academyId, name, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademyModelImplCopyWith<_$AcademyModelImpl> get copyWith =>
      __$$AcademyModelImplCopyWithImpl<_$AcademyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcademyModelImplToJson(
      this,
    );
  }
}

abstract class _AcademyModel implements AcademyModel {
  const factory _AcademyModel(
      {@JsonKey(name: 'academyId') final String? academyId,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'imageUrl') final String? imageUrl}) = _$AcademyModelImpl;

  factory _AcademyModel.fromJson(Map<String, dynamic> json) =
      _$AcademyModelImpl.fromJson;

  @override
  @JsonKey(name: 'academyId')
  String? get academyId;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$AcademyModelImplCopyWith<_$AcademyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
