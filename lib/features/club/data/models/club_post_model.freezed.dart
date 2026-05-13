// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubPostModel _$ClubPostModelFromJson(Map<String, dynamic> json) {
  return _ClubPostModel.fromJson(json);
}

/// @nodoc
mixin _$ClubPostModel {
  @JsonKey(name: 'postId')
  String? get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'videoUrl')
  String? get videoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'postCaption')
  String? get postCaption => throw _privateConstructorUsedError;
  @JsonKey(name: 'timestamp')
  int? get timestamp => throw _privateConstructorUsedError;
  @JsonKey(name: 'likeCount')
  int? get likeCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubPostModelCopyWith<ClubPostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubPostModelCopyWith<$Res> {
  factory $ClubPostModelCopyWith(
          ClubPostModel value, $Res Function(ClubPostModel) then) =
      _$ClubPostModelCopyWithImpl<$Res, ClubPostModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'postId') String? postId,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'videoUrl') String? videoUrl,
      @JsonKey(name: 'postCaption') String? postCaption,
      @JsonKey(name: 'timestamp') int? timestamp,
      @JsonKey(name: 'likeCount') int? likeCount});
}

/// @nodoc
class _$ClubPostModelCopyWithImpl<$Res, $Val extends ClubPostModel>
    implements $ClubPostModelCopyWith<$Res> {
  _$ClubPostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? postCaption = freezed,
    Object? timestamp = freezed,
    Object? likeCount = freezed,
  }) {
    return _then(_value.copyWith(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      postCaption: freezed == postCaption
          ? _value.postCaption
          : postCaption // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubPostModelImplCopyWith<$Res>
    implements $ClubPostModelCopyWith<$Res> {
  factory _$$ClubPostModelImplCopyWith(
          _$ClubPostModelImpl value, $Res Function(_$ClubPostModelImpl) then) =
      __$$ClubPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'postId') String? postId,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'videoUrl') String? videoUrl,
      @JsonKey(name: 'postCaption') String? postCaption,
      @JsonKey(name: 'timestamp') int? timestamp,
      @JsonKey(name: 'likeCount') int? likeCount});
}

/// @nodoc
class __$$ClubPostModelImplCopyWithImpl<$Res>
    extends _$ClubPostModelCopyWithImpl<$Res, _$ClubPostModelImpl>
    implements _$$ClubPostModelImplCopyWith<$Res> {
  __$$ClubPostModelImplCopyWithImpl(
      _$ClubPostModelImpl _value, $Res Function(_$ClubPostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? postCaption = freezed,
    Object? timestamp = freezed,
    Object? likeCount = freezed,
  }) {
    return _then(_$ClubPostModelImpl(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      postCaption: freezed == postCaption
          ? _value.postCaption
          : postCaption // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int?,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubPostModelImpl implements _ClubPostModel {
  const _$ClubPostModelImpl(
      {@JsonKey(name: 'postId') this.postId,
      @JsonKey(name: 'imageUrl') this.imageUrl,
      @JsonKey(name: 'videoUrl') this.videoUrl,
      @JsonKey(name: 'postCaption') this.postCaption,
      @JsonKey(name: 'timestamp') this.timestamp,
      @JsonKey(name: 'likeCount') this.likeCount});

  factory _$ClubPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubPostModelImplFromJson(json);

  @override
  @JsonKey(name: 'postId')
  final String? postId;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'videoUrl')
  final String? videoUrl;
  @override
  @JsonKey(name: 'postCaption')
  final String? postCaption;
  @override
  @JsonKey(name: 'timestamp')
  final int? timestamp;
  @override
  @JsonKey(name: 'likeCount')
  final int? likeCount;

  @override
  String toString() {
    return 'ClubPostModel(postId: $postId, imageUrl: $imageUrl, videoUrl: $videoUrl, postCaption: $postCaption, timestamp: $timestamp, likeCount: $likeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubPostModelImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.postCaption, postCaption) ||
                other.postCaption == postCaption) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, postId, imageUrl, videoUrl,
      postCaption, timestamp, likeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubPostModelImplCopyWith<_$ClubPostModelImpl> get copyWith =>
      __$$ClubPostModelImplCopyWithImpl<_$ClubPostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubPostModelImplToJson(
      this,
    );
  }
}

abstract class _ClubPostModel implements ClubPostModel {
  const factory _ClubPostModel(
      {@JsonKey(name: 'postId') final String? postId,
      @JsonKey(name: 'imageUrl') final String? imageUrl,
      @JsonKey(name: 'videoUrl') final String? videoUrl,
      @JsonKey(name: 'postCaption') final String? postCaption,
      @JsonKey(name: 'timestamp') final int? timestamp,
      @JsonKey(name: 'likeCount') final int? likeCount}) = _$ClubPostModelImpl;

  factory _ClubPostModel.fromJson(Map<String, dynamic> json) =
      _$ClubPostModelImpl.fromJson;

  @override
  @JsonKey(name: 'postId')
  String? get postId;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'videoUrl')
  String? get videoUrl;
  @override
  @JsonKey(name: 'postCaption')
  String? get postCaption;
  @override
  @JsonKey(name: 'timestamp')
  int? get timestamp;
  @override
  @JsonKey(name: 'likeCount')
  int? get likeCount;
  @override
  @JsonKey(ignore: true)
  _$$ClubPostModelImplCopyWith<_$ClubPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
