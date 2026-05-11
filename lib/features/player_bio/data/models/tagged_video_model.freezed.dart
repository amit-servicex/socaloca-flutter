// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tagged_video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaggedVideoAcademyModel _$TaggedVideoAcademyModelFromJson(
    Map<String, dynamic> json) {
  return _TaggedVideoAcademyModel.fromJson(json);
}

/// @nodoc
mixin _$TaggedVideoAcademyModel {
  @JsonKey(name: 'academyId')
  String? get academyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaggedVideoAcademyModelCopyWith<TaggedVideoAcademyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaggedVideoAcademyModelCopyWith<$Res> {
  factory $TaggedVideoAcademyModelCopyWith(TaggedVideoAcademyModel value,
          $Res Function(TaggedVideoAcademyModel) then) =
      _$TaggedVideoAcademyModelCopyWithImpl<$Res, TaggedVideoAcademyModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'academyId') String? academyId,
      @JsonKey(name: 'name') String? name});
}

/// @nodoc
class _$TaggedVideoAcademyModelCopyWithImpl<$Res,
        $Val extends TaggedVideoAcademyModel>
    implements $TaggedVideoAcademyModelCopyWith<$Res> {
  _$TaggedVideoAcademyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academyId = freezed,
    Object? name = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaggedVideoAcademyModelImplCopyWith<$Res>
    implements $TaggedVideoAcademyModelCopyWith<$Res> {
  factory _$$TaggedVideoAcademyModelImplCopyWith(
          _$TaggedVideoAcademyModelImpl value,
          $Res Function(_$TaggedVideoAcademyModelImpl) then) =
      __$$TaggedVideoAcademyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'academyId') String? academyId,
      @JsonKey(name: 'name') String? name});
}

/// @nodoc
class __$$TaggedVideoAcademyModelImplCopyWithImpl<$Res>
    extends _$TaggedVideoAcademyModelCopyWithImpl<$Res,
        _$TaggedVideoAcademyModelImpl>
    implements _$$TaggedVideoAcademyModelImplCopyWith<$Res> {
  __$$TaggedVideoAcademyModelImplCopyWithImpl(
      _$TaggedVideoAcademyModelImpl _value,
      $Res Function(_$TaggedVideoAcademyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academyId = freezed,
    Object? name = freezed,
  }) {
    return _then(_$TaggedVideoAcademyModelImpl(
      academyId: freezed == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaggedVideoAcademyModelImpl implements _TaggedVideoAcademyModel {
  const _$TaggedVideoAcademyModelImpl(
      {@JsonKey(name: 'academyId') this.academyId,
      @JsonKey(name: 'name') this.name});

  factory _$TaggedVideoAcademyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaggedVideoAcademyModelImplFromJson(json);

  @override
  @JsonKey(name: 'academyId')
  final String? academyId;
  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  String toString() {
    return 'TaggedVideoAcademyModel(academyId: $academyId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaggedVideoAcademyModelImpl &&
            (identical(other.academyId, academyId) ||
                other.academyId == academyId) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, academyId, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaggedVideoAcademyModelImplCopyWith<_$TaggedVideoAcademyModelImpl>
      get copyWith => __$$TaggedVideoAcademyModelImplCopyWithImpl<
          _$TaggedVideoAcademyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaggedVideoAcademyModelImplToJson(
      this,
    );
  }
}

abstract class _TaggedVideoAcademyModel implements TaggedVideoAcademyModel {
  const factory _TaggedVideoAcademyModel(
          {@JsonKey(name: 'academyId') final String? academyId,
          @JsonKey(name: 'name') final String? name}) =
      _$TaggedVideoAcademyModelImpl;

  factory _TaggedVideoAcademyModel.fromJson(Map<String, dynamic> json) =
      _$TaggedVideoAcademyModelImpl.fromJson;

  @override
  @JsonKey(name: 'academyId')
  String? get academyId;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$TaggedVideoAcademyModelImplCopyWith<_$TaggedVideoAcademyModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TaggedVideoModel _$TaggedVideoModelFromJson(Map<String, dynamic> json) {
  return _TaggedVideoModel.fromJson(json);
}

/// @nodoc
mixin _$TaggedVideoModel {
  @JsonKey(name: 'postId')
  String? get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail')
  String? get thumbnail => throw _privateConstructorUsedError;
  @JsonKey(name: 'addedOn')
  int? get addedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String>? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'academy')
  TaggedVideoAcademyModel? get academy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaggedVideoModelCopyWith<TaggedVideoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaggedVideoModelCopyWith<$Res> {
  factory $TaggedVideoModelCopyWith(
          TaggedVideoModel value, $Res Function(TaggedVideoModel) then) =
      _$TaggedVideoModelCopyWithImpl<$Res, TaggedVideoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'postId') String? postId,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'thumbnail') String? thumbnail,
      @JsonKey(name: 'addedOn') int? addedOn,
      @JsonKey(name: 'tags') List<String>? tags,
      @JsonKey(name: 'academy') TaggedVideoAcademyModel? academy});

  $TaggedVideoAcademyModelCopyWith<$Res>? get academy;
}

/// @nodoc
class _$TaggedVideoModelCopyWithImpl<$Res, $Val extends TaggedVideoModel>
    implements $TaggedVideoModelCopyWith<$Res> {
  _$TaggedVideoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? url = freezed,
    Object? thumbnail = freezed,
    Object? addedOn = freezed,
    Object? tags = freezed,
    Object? academy = freezed,
  }) {
    return _then(_value.copyWith(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      academy: freezed == academy
          ? _value.academy
          : academy // ignore: cast_nullable_to_non_nullable
              as TaggedVideoAcademyModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaggedVideoAcademyModelCopyWith<$Res>? get academy {
    if (_value.academy == null) {
      return null;
    }

    return $TaggedVideoAcademyModelCopyWith<$Res>(_value.academy!, (value) {
      return _then(_value.copyWith(academy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaggedVideoModelImplCopyWith<$Res>
    implements $TaggedVideoModelCopyWith<$Res> {
  factory _$$TaggedVideoModelImplCopyWith(_$TaggedVideoModelImpl value,
          $Res Function(_$TaggedVideoModelImpl) then) =
      __$$TaggedVideoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'postId') String? postId,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'thumbnail') String? thumbnail,
      @JsonKey(name: 'addedOn') int? addedOn,
      @JsonKey(name: 'tags') List<String>? tags,
      @JsonKey(name: 'academy') TaggedVideoAcademyModel? academy});

  @override
  $TaggedVideoAcademyModelCopyWith<$Res>? get academy;
}

/// @nodoc
class __$$TaggedVideoModelImplCopyWithImpl<$Res>
    extends _$TaggedVideoModelCopyWithImpl<$Res, _$TaggedVideoModelImpl>
    implements _$$TaggedVideoModelImplCopyWith<$Res> {
  __$$TaggedVideoModelImplCopyWithImpl(_$TaggedVideoModelImpl _value,
      $Res Function(_$TaggedVideoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? url = freezed,
    Object? thumbnail = freezed,
    Object? addedOn = freezed,
    Object? tags = freezed,
    Object? academy = freezed,
  }) {
    return _then(_$TaggedVideoModelImpl(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      academy: freezed == academy
          ? _value.academy
          : academy // ignore: cast_nullable_to_non_nullable
              as TaggedVideoAcademyModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaggedVideoModelImpl implements _TaggedVideoModel {
  const _$TaggedVideoModelImpl(
      {@JsonKey(name: 'postId') this.postId,
      @JsonKey(name: 'url') this.url,
      @JsonKey(name: 'thumbnail') this.thumbnail,
      @JsonKey(name: 'addedOn') this.addedOn,
      @JsonKey(name: 'tags') final List<String>? tags,
      @JsonKey(name: 'academy') this.academy})
      : _tags = tags;

  factory _$TaggedVideoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaggedVideoModelImplFromJson(json);

  @override
  @JsonKey(name: 'postId')
  final String? postId;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'thumbnail')
  final String? thumbnail;
  @override
  @JsonKey(name: 'addedOn')
  final int? addedOn;
  final List<String>? _tags;
  @override
  @JsonKey(name: 'tags')
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'academy')
  final TaggedVideoAcademyModel? academy;

  @override
  String toString() {
    return 'TaggedVideoModel(postId: $postId, url: $url, thumbnail: $thumbnail, addedOn: $addedOn, tags: $tags, academy: $academy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaggedVideoModelImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.academy, academy) || other.academy == academy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, postId, url, thumbnail, addedOn,
      const DeepCollectionEquality().hash(_tags), academy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaggedVideoModelImplCopyWith<_$TaggedVideoModelImpl> get copyWith =>
      __$$TaggedVideoModelImplCopyWithImpl<_$TaggedVideoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaggedVideoModelImplToJson(
      this,
    );
  }
}

abstract class _TaggedVideoModel implements TaggedVideoModel {
  const factory _TaggedVideoModel(
          {@JsonKey(name: 'postId') final String? postId,
          @JsonKey(name: 'url') final String? url,
          @JsonKey(name: 'thumbnail') final String? thumbnail,
          @JsonKey(name: 'addedOn') final int? addedOn,
          @JsonKey(name: 'tags') final List<String>? tags,
          @JsonKey(name: 'academy') final TaggedVideoAcademyModel? academy}) =
      _$TaggedVideoModelImpl;

  factory _TaggedVideoModel.fromJson(Map<String, dynamic> json) =
      _$TaggedVideoModelImpl.fromJson;

  @override
  @JsonKey(name: 'postId')
  String? get postId;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'thumbnail')
  String? get thumbnail;
  @override
  @JsonKey(name: 'addedOn')
  int? get addedOn;
  @override
  @JsonKey(name: 'tags')
  List<String>? get tags;
  @override
  @JsonKey(name: 'academy')
  TaggedVideoAcademyModel? get academy;
  @override
  @JsonKey(ignore: true)
  _$$TaggedVideoModelImplCopyWith<_$TaggedVideoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
