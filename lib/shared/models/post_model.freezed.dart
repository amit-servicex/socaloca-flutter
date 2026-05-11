// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  String get id => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String? get authorImage => throw _privateConstructorUsedError;
  String? get authorType => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get videoThumb => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  int get commentsCount => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get postType =>
      throw _privateConstructorUsedError; // 'user', 'club', 'academy', 'fa', 'confed', 'spon', 'charity'
  String? get language => throw _privateConstructorUsedError;
  String? get translatedText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String id,
      String authorId,
      String authorName,
      String? authorImage,
      String? authorType,
      String? text,
      List<String> images,
      String? videoUrl,
      String? videoThumb,
      int likesCount,
      int commentsCount,
      bool isLiked,
      bool isBlocked,
      String? createdAt,
      String? postType,
      String? language,
      String? translatedText});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImage = freezed,
    Object? authorType = freezed,
    Object? text = freezed,
    Object? images = null,
    Object? videoUrl = freezed,
    Object? videoThumb = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? isLiked = null,
    Object? isBlocked = null,
    Object? createdAt = freezed,
    Object? postType = freezed,
    Object? language = freezed,
    Object? translatedText = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      authorType: freezed == authorType
          ? _value.authorType
          : authorType // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoThumb: freezed == videoThumb
          ? _value.videoThumb
          : videoThumb // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      postType: freezed == postType
          ? _value.postType
          : postType // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      translatedText: freezed == translatedText
          ? _value.translatedText
          : translatedText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      String authorName,
      String? authorImage,
      String? authorType,
      String? text,
      List<String> images,
      String? videoUrl,
      String? videoThumb,
      int likesCount,
      int commentsCount,
      bool isLiked,
      bool isBlocked,
      String? createdAt,
      String? postType,
      String? language,
      String? translatedText});
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImage = freezed,
    Object? authorType = freezed,
    Object? text = freezed,
    Object? images = null,
    Object? videoUrl = freezed,
    Object? videoThumb = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? isLiked = null,
    Object? isBlocked = null,
    Object? createdAt = freezed,
    Object? postType = freezed,
    Object? language = freezed,
    Object? translatedText = freezed,
  }) {
    return _then(_$PostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      authorType: freezed == authorType
          ? _value.authorType
          : authorType // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoThumb: freezed == videoThumb
          ? _value.videoThumb
          : videoThumb // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      postType: freezed == postType
          ? _value.postType
          : postType // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      translatedText: freezed == translatedText
          ? _value.translatedText
          : translatedText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostModelImpl implements _PostModel {
  const _$PostModelImpl(
      {required this.id,
      required this.authorId,
      required this.authorName,
      this.authorImage,
      this.authorType,
      this.text,
      final List<String> images = const [],
      this.videoUrl,
      this.videoThumb,
      this.likesCount = 0,
      this.commentsCount = 0,
      this.isLiked = false,
      this.isBlocked = false,
      this.createdAt,
      this.postType,
      this.language,
      this.translatedText})
      : _images = images;

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  @override
  final String id;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String? authorImage;
  @override
  final String? authorType;
  @override
  final String? text;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String? videoUrl;
  @override
  final String? videoThumb;
  @override
  @JsonKey()
  final int likesCount;
  @override
  @JsonKey()
  final int commentsCount;
  @override
  @JsonKey()
  final bool isLiked;
  @override
  @JsonKey()
  final bool isBlocked;
  @override
  final String? createdAt;
  @override
  final String? postType;
// 'user', 'club', 'academy', 'fa', 'confed', 'spon', 'charity'
  @override
  final String? language;
  @override
  final String? translatedText;

  @override
  String toString() {
    return 'PostModel(id: $id, authorId: $authorId, authorName: $authorName, authorImage: $authorImage, authorType: $authorType, text: $text, images: $images, videoUrl: $videoUrl, videoThumb: $videoThumb, likesCount: $likesCount, commentsCount: $commentsCount, isLiked: $isLiked, isBlocked: $isBlocked, createdAt: $createdAt, postType: $postType, language: $language, translatedText: $translatedText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorImage, authorImage) ||
                other.authorImage == authorImage) &&
            (identical(other.authorType, authorType) ||
                other.authorType == authorType) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.videoThumb, videoThumb) ||
                other.videoThumb == videoThumb) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.translatedText, translatedText) ||
                other.translatedText == translatedText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      authorName,
      authorImage,
      authorType,
      text,
      const DeepCollectionEquality().hash(_images),
      videoUrl,
      videoThumb,
      likesCount,
      commentsCount,
      isLiked,
      isBlocked,
      createdAt,
      postType,
      language,
      translatedText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  const factory _PostModel(
      {required final String id,
      required final String authorId,
      required final String authorName,
      final String? authorImage,
      final String? authorType,
      final String? text,
      final List<String> images,
      final String? videoUrl,
      final String? videoThumb,
      final int likesCount,
      final int commentsCount,
      final bool isLiked,
      final bool isBlocked,
      final String? createdAt,
      final String? postType,
      final String? language,
      final String? translatedText}) = _$PostModelImpl;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override
  String get id;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String? get authorImage;
  @override
  String? get authorType;
  @override
  String? get text;
  @override
  List<String> get images;
  @override
  String? get videoUrl;
  @override
  String? get videoThumb;
  @override
  int get likesCount;
  @override
  int get commentsCount;
  @override
  bool get isLiked;
  @override
  bool get isBlocked;
  @override
  String? get createdAt;
  @override
  String? get postType;
  @override // 'user', 'club', 'academy', 'fa', 'confed', 'spon', 'charity'
  String? get language;
  @override
  String? get translatedText;
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  String get id => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String? get authorImage => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  int get repliesCount => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  List<CommentModel> get replies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) then) =
      _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call(
      {String id,
      String postId,
      String authorId,
      String authorName,
      String? authorImage,
      String text,
      int likesCount,
      bool isLiked,
      int repliesCount,
      String? createdAt,
      List<CommentModel> replies});
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImage = freezed,
    Object? text = null,
    Object? likesCount = null,
    Object? isLiked = null,
    Object? repliesCount = null,
    Object? createdAt = freezed,
    Object? replies = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      repliesCount: null == repliesCount
          ? _value.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
          _$CommentModelImpl value, $Res Function(_$CommentModelImpl) then) =
      __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      String authorId,
      String authorName,
      String? authorImage,
      String text,
      int likesCount,
      bool isLiked,
      int repliesCount,
      String? createdAt,
      List<CommentModel> replies});
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
      _$CommentModelImpl _value, $Res Function(_$CommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorImage = freezed,
    Object? text = null,
    Object? likesCount = null,
    Object? isLiked = null,
    Object? repliesCount = null,
    Object? createdAt = freezed,
    Object? replies = null,
  }) {
    return _then(_$CommentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      repliesCount: null == repliesCount
          ? _value.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      replies: null == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentModelImpl implements _CommentModel {
  const _$CommentModelImpl(
      {required this.id,
      required this.postId,
      required this.authorId,
      required this.authorName,
      this.authorImage,
      required this.text,
      this.likesCount = 0,
      this.isLiked = false,
      this.repliesCount = 0,
      this.createdAt,
      final List<CommentModel> replies = const []})
      : _replies = replies;

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String? authorImage;
  @override
  final String text;
  @override
  @JsonKey()
  final int likesCount;
  @override
  @JsonKey()
  final bool isLiked;
  @override
  @JsonKey()
  final int repliesCount;
  @override
  final String? createdAt;
  final List<CommentModel> _replies;
  @override
  @JsonKey()
  List<CommentModel> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  String toString() {
    return 'CommentModel(id: $id, postId: $postId, authorId: $authorId, authorName: $authorName, authorImage: $authorImage, text: $text, likesCount: $likesCount, isLiked: $isLiked, repliesCount: $repliesCount, createdAt: $createdAt, replies: $replies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorImage, authorImage) ||
                other.authorImage == authorImage) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._replies, _replies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      postId,
      authorId,
      authorName,
      authorImage,
      text,
      likesCount,
      isLiked,
      repliesCount,
      createdAt,
      const DeepCollectionEquality().hash(_replies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(
      this,
    );
  }
}

abstract class _CommentModel implements CommentModel {
  const factory _CommentModel(
      {required final String id,
      required final String postId,
      required final String authorId,
      required final String authorName,
      final String? authorImage,
      required final String text,
      final int likesCount,
      final bool isLiked,
      final int repliesCount,
      final String? createdAt,
      final List<CommentModel> replies}) = _$CommentModelImpl;

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String? get authorImage;
  @override
  String get text;
  @override
  int get likesCount;
  @override
  bool get isLiked;
  @override
  int get repliesCount;
  @override
  String? get createdAt;
  @override
  List<CommentModel> get replies;
  @override
  @JsonKey(ignore: true)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
