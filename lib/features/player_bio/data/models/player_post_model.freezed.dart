// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostMediaSource _$PostMediaSourceFromJson(Map<String, dynamic> json) {
  return _PostMediaSource.fromJson(json);
}

/// @nodoc
mixin _$PostMediaSource {
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail')
  String? get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostMediaSourceCopyWith<PostMediaSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostMediaSourceCopyWith<$Res> {
  factory $PostMediaSourceCopyWith(
          PostMediaSource value, $Res Function(PostMediaSource) then) =
      _$PostMediaSourceCopyWithImpl<$Res, PostMediaSource>;
  @useResult
  $Res call(
      {@JsonKey(name: 'url') String? url,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'thumbnail') String? thumbnail});
}

/// @nodoc
class _$PostMediaSourceCopyWithImpl<$Res, $Val extends PostMediaSource>
    implements $PostMediaSourceCopyWith<$Res> {
  _$PostMediaSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? type = freezed,
    Object? thumbnail = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostMediaSourceImplCopyWith<$Res>
    implements $PostMediaSourceCopyWith<$Res> {
  factory _$$PostMediaSourceImplCopyWith(_$PostMediaSourceImpl value,
          $Res Function(_$PostMediaSourceImpl) then) =
      __$$PostMediaSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'url') String? url,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'thumbnail') String? thumbnail});
}

/// @nodoc
class __$$PostMediaSourceImplCopyWithImpl<$Res>
    extends _$PostMediaSourceCopyWithImpl<$Res, _$PostMediaSourceImpl>
    implements _$$PostMediaSourceImplCopyWith<$Res> {
  __$$PostMediaSourceImplCopyWithImpl(
      _$PostMediaSourceImpl _value, $Res Function(_$PostMediaSourceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? type = freezed,
    Object? thumbnail = freezed,
  }) {
    return _then(_$PostMediaSourceImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostMediaSourceImpl implements _PostMediaSource {
  const _$PostMediaSourceImpl(
      {@JsonKey(name: 'url') this.url,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'thumbnail') this.thumbnail});

  factory _$PostMediaSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostMediaSourceImplFromJson(json);

  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'thumbnail')
  final String? thumbnail;

  @override
  String toString() {
    return 'PostMediaSource(url: $url, type: $type, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostMediaSourceImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, type, thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostMediaSourceImplCopyWith<_$PostMediaSourceImpl> get copyWith =>
      __$$PostMediaSourceImplCopyWithImpl<_$PostMediaSourceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostMediaSourceImplToJson(
      this,
    );
  }
}

abstract class _PostMediaSource implements PostMediaSource {
  const factory _PostMediaSource(
          {@JsonKey(name: 'url') final String? url,
          @JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'thumbnail') final String? thumbnail}) =
      _$PostMediaSourceImpl;

  factory _PostMediaSource.fromJson(Map<String, dynamic> json) =
      _$PostMediaSourceImpl.fromJson;

  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'thumbnail')
  String? get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$PostMediaSourceImplCopyWith<_$PostMediaSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerPostModel _$PlayerPostModelFromJson(Map<String, dynamic> json) {
  return _PlayerPostModel.fromJson(json);
}

/// @nodoc
mixin _$PlayerPostModel {
  @JsonKey(name: 'postId')
  String? get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'addedOn')
  int? get addedOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'likeCount')
  int? get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'commentCount')
  int? get commentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'shareCount')
  int? get shareCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sources')
  List<PostMediaSource>? get sources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerPostModelCopyWith<PlayerPostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerPostModelCopyWith<$Res> {
  factory $PlayerPostModelCopyWith(
          PlayerPostModel value, $Res Function(PlayerPostModel) then) =
      _$PlayerPostModelCopyWithImpl<$Res, PlayerPostModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'postId') String? postId,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'addedOn') int? addedOn,
      @JsonKey(name: 'likeCount') int? likeCount,
      @JsonKey(name: 'commentCount') int? commentCount,
      @JsonKey(name: 'shareCount') int? shareCount,
      @JsonKey(name: 'sources') List<PostMediaSource>? sources});
}

/// @nodoc
class _$PlayerPostModelCopyWithImpl<$Res, $Val extends PlayerPostModel>
    implements $PlayerPostModelCopyWith<$Res> {
  _$PlayerPostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? text = freezed,
    Object? addedOn = freezed,
    Object? likeCount = freezed,
    Object? commentCount = freezed,
    Object? shareCount = freezed,
    Object? sources = freezed,
  }) {
    return _then(_value.copyWith(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentCount: freezed == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int?,
      shareCount: freezed == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int?,
      sources: freezed == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<PostMediaSource>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerPostModelImplCopyWith<$Res>
    implements $PlayerPostModelCopyWith<$Res> {
  factory _$$PlayerPostModelImplCopyWith(_$PlayerPostModelImpl value,
          $Res Function(_$PlayerPostModelImpl) then) =
      __$$PlayerPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'postId') String? postId,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'addedOn') int? addedOn,
      @JsonKey(name: 'likeCount') int? likeCount,
      @JsonKey(name: 'commentCount') int? commentCount,
      @JsonKey(name: 'shareCount') int? shareCount,
      @JsonKey(name: 'sources') List<PostMediaSource>? sources});
}

/// @nodoc
class __$$PlayerPostModelImplCopyWithImpl<$Res>
    extends _$PlayerPostModelCopyWithImpl<$Res, _$PlayerPostModelImpl>
    implements _$$PlayerPostModelImplCopyWith<$Res> {
  __$$PlayerPostModelImplCopyWithImpl(
      _$PlayerPostModelImpl _value, $Res Function(_$PlayerPostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? text = freezed,
    Object? addedOn = freezed,
    Object? likeCount = freezed,
    Object? commentCount = freezed,
    Object? shareCount = freezed,
    Object? sources = freezed,
  }) {
    return _then(_$PlayerPostModelImpl(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      addedOn: freezed == addedOn
          ? _value.addedOn
          : addedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      likeCount: freezed == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentCount: freezed == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int?,
      shareCount: freezed == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int?,
      sources: freezed == sources
          ? _value._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<PostMediaSource>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerPostModelImpl implements _PlayerPostModel {
  const _$PlayerPostModelImpl(
      {@JsonKey(name: 'postId') this.postId,
      @JsonKey(name: 'text') this.text,
      @JsonKey(name: 'addedOn') this.addedOn,
      @JsonKey(name: 'likeCount') this.likeCount,
      @JsonKey(name: 'commentCount') this.commentCount,
      @JsonKey(name: 'shareCount') this.shareCount,
      @JsonKey(name: 'sources') final List<PostMediaSource>? sources})
      : _sources = sources;

  factory _$PlayerPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerPostModelImplFromJson(json);

  @override
  @JsonKey(name: 'postId')
  final String? postId;
  @override
  @JsonKey(name: 'text')
  final String? text;
  @override
  @JsonKey(name: 'addedOn')
  final int? addedOn;
  @override
  @JsonKey(name: 'likeCount')
  final int? likeCount;
  @override
  @JsonKey(name: 'commentCount')
  final int? commentCount;
  @override
  @JsonKey(name: 'shareCount')
  final int? shareCount;
  final List<PostMediaSource>? _sources;
  @override
  @JsonKey(name: 'sources')
  List<PostMediaSource>? get sources {
    final value = _sources;
    if (value == null) return null;
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PlayerPostModel(postId: $postId, text: $text, addedOn: $addedOn, likeCount: $likeCount, commentCount: $commentCount, shareCount: $shareCount, sources: $sources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerPostModelImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.addedOn, addedOn) || other.addedOn == addedOn) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            const DeepCollectionEquality().equals(other._sources, _sources));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, postId, text, addedOn, likeCount,
      commentCount, shareCount, const DeepCollectionEquality().hash(_sources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerPostModelImplCopyWith<_$PlayerPostModelImpl> get copyWith =>
      __$$PlayerPostModelImplCopyWithImpl<_$PlayerPostModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerPostModelImplToJson(
      this,
    );
  }
}

abstract class _PlayerPostModel implements PlayerPostModel {
  const factory _PlayerPostModel(
          {@JsonKey(name: 'postId') final String? postId,
          @JsonKey(name: 'text') final String? text,
          @JsonKey(name: 'addedOn') final int? addedOn,
          @JsonKey(name: 'likeCount') final int? likeCount,
          @JsonKey(name: 'commentCount') final int? commentCount,
          @JsonKey(name: 'shareCount') final int? shareCount,
          @JsonKey(name: 'sources') final List<PostMediaSource>? sources}) =
      _$PlayerPostModelImpl;

  factory _PlayerPostModel.fromJson(Map<String, dynamic> json) =
      _$PlayerPostModelImpl.fromJson;

  @override
  @JsonKey(name: 'postId')
  String? get postId;
  @override
  @JsonKey(name: 'text')
  String? get text;
  @override
  @JsonKey(name: 'addedOn')
  int? get addedOn;
  @override
  @JsonKey(name: 'likeCount')
  int? get likeCount;
  @override
  @JsonKey(name: 'commentCount')
  int? get commentCount;
  @override
  @JsonKey(name: 'shareCount')
  int? get shareCount;
  @override
  @JsonKey(name: 'sources')
  List<PostMediaSource>? get sources;
  @override
  @JsonKey(ignore: true)
  _$$PlayerPostModelImplCopyWith<_$PlayerPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
