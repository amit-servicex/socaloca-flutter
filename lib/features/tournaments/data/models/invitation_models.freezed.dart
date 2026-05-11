// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TournamentInviteModel _$TournamentInviteModelFromJson(
    Map<String, dynamic> json) {
  return _TournamentInviteModel.fromJson(json);
}

/// @nodoc
mixin _$TournamentInviteModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'inviteId')
  String? get inviteId => throw _privateConstructorUsedError;
  String get tournamentId => throw _privateConstructorUsedError;
  String? get tournamentName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  String? get invitedBy => throw _privateConstructorUsedError;
  String? get invitedByName => throw _privateConstructorUsedError;
  int? get invitedOn => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'pending', 'accepted', 'declined'
  String? get respondedBy => throw _privateConstructorUsedError;
  int? get respondedOn => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentInviteModelCopyWith<TournamentInviteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentInviteModelCopyWith<$Res> {
  factory $TournamentInviteModelCopyWith(TournamentInviteModel value,
          $Res Function(TournamentInviteModel) then) =
      _$TournamentInviteModelCopyWithImpl<$Res, TournamentInviteModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'inviteId') String? inviteId,
      String tournamentId,
      String? tournamentName,
      String teamId,
      String? teamName,
      String? teamLogo,
      String? invitedBy,
      String? invitedByName,
      int? invitedOn,
      String? status,
      String? respondedBy,
      int? respondedOn,
      String? message});
}

/// @nodoc
class _$TournamentInviteModelCopyWithImpl<$Res,
        $Val extends TournamentInviteModel>
    implements $TournamentInviteModelCopyWith<$Res> {
  _$TournamentInviteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? inviteId = freezed,
    Object? tournamentId = null,
    Object? tournamentName = freezed,
    Object? teamId = null,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? invitedBy = freezed,
    Object? invitedByName = freezed,
    Object? invitedOn = freezed,
    Object? status = freezed,
    Object? respondedBy = freezed,
    Object? respondedOn = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteId: freezed == inviteId
          ? _value.inviteId
          : inviteId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedBy: freezed == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedByName: freezed == invitedByName
          ? _value.invitedByName
          : invitedByName // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedOn: freezed == invitedOn
          ? _value.invitedOn
          : invitedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedBy: freezed == respondedBy
          ? _value.respondedBy
          : respondedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedOn: freezed == respondedOn
          ? _value.respondedOn
          : respondedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentInviteModelImplCopyWith<$Res>
    implements $TournamentInviteModelCopyWith<$Res> {
  factory _$$TournamentInviteModelImplCopyWith(
          _$TournamentInviteModelImpl value,
          $Res Function(_$TournamentInviteModelImpl) then) =
      __$$TournamentInviteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'inviteId') String? inviteId,
      String tournamentId,
      String? tournamentName,
      String teamId,
      String? teamName,
      String? teamLogo,
      String? invitedBy,
      String? invitedByName,
      int? invitedOn,
      String? status,
      String? respondedBy,
      int? respondedOn,
      String? message});
}

/// @nodoc
class __$$TournamentInviteModelImplCopyWithImpl<$Res>
    extends _$TournamentInviteModelCopyWithImpl<$Res,
        _$TournamentInviteModelImpl>
    implements _$$TournamentInviteModelImplCopyWith<$Res> {
  __$$TournamentInviteModelImplCopyWithImpl(_$TournamentInviteModelImpl _value,
      $Res Function(_$TournamentInviteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? inviteId = freezed,
    Object? tournamentId = null,
    Object? tournamentName = freezed,
    Object? teamId = null,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? invitedBy = freezed,
    Object? invitedByName = freezed,
    Object? invitedOn = freezed,
    Object? status = freezed,
    Object? respondedBy = freezed,
    Object? respondedOn = freezed,
    Object? message = freezed,
  }) {
    return _then(_$TournamentInviteModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteId: freezed == inviteId
          ? _value.inviteId
          : inviteId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedBy: freezed == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedByName: freezed == invitedByName
          ? _value.invitedByName
          : invitedByName // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedOn: freezed == invitedOn
          ? _value.invitedOn
          : invitedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedBy: freezed == respondedBy
          ? _value.respondedBy
          : respondedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedOn: freezed == respondedOn
          ? _value.respondedOn
          : respondedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentInviteModelImpl implements _TournamentInviteModel {
  const _$TournamentInviteModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'inviteId') this.inviteId,
      required this.tournamentId,
      this.tournamentName,
      required this.teamId,
      this.teamName,
      this.teamLogo,
      this.invitedBy,
      this.invitedByName,
      this.invitedOn,
      this.status,
      this.respondedBy,
      this.respondedOn,
      this.message});

  factory _$TournamentInviteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentInviteModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'inviteId')
  final String? inviteId;
  @override
  final String tournamentId;
  @override
  final String? tournamentName;
  @override
  final String teamId;
  @override
  final String? teamName;
  @override
  final String? teamLogo;
  @override
  final String? invitedBy;
  @override
  final String? invitedByName;
  @override
  final int? invitedOn;
  @override
  final String? status;
// 'pending', 'accepted', 'declined'
  @override
  final String? respondedBy;
  @override
  final int? respondedOn;
  @override
  final String? message;

  @override
  String toString() {
    return 'TournamentInviteModel(id: $id, inviteId: $inviteId, tournamentId: $tournamentId, tournamentName: $tournamentName, teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, invitedBy: $invitedBy, invitedByName: $invitedByName, invitedOn: $invitedOn, status: $status, respondedBy: $respondedBy, respondedOn: $respondedOn, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentInviteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inviteId, inviteId) ||
                other.inviteId == inviteId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.invitedByName, invitedByName) ||
                other.invitedByName == invitedByName) &&
            (identical(other.invitedOn, invitedOn) ||
                other.invitedOn == invitedOn) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.respondedBy, respondedBy) ||
                other.respondedBy == respondedBy) &&
            (identical(other.respondedOn, respondedOn) ||
                other.respondedOn == respondedOn) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      inviteId,
      tournamentId,
      tournamentName,
      teamId,
      teamName,
      teamLogo,
      invitedBy,
      invitedByName,
      invitedOn,
      status,
      respondedBy,
      respondedOn,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentInviteModelImplCopyWith<_$TournamentInviteModelImpl>
      get copyWith => __$$TournamentInviteModelImplCopyWithImpl<
          _$TournamentInviteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentInviteModelImplToJson(
      this,
    );
  }
}

abstract class _TournamentInviteModel implements TournamentInviteModel {
  const factory _TournamentInviteModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'inviteId') final String? inviteId,
      required final String tournamentId,
      final String? tournamentName,
      required final String teamId,
      final String? teamName,
      final String? teamLogo,
      final String? invitedBy,
      final String? invitedByName,
      final int? invitedOn,
      final String? status,
      final String? respondedBy,
      final int? respondedOn,
      final String? message}) = _$TournamentInviteModelImpl;

  factory _TournamentInviteModel.fromJson(Map<String, dynamic> json) =
      _$TournamentInviteModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'inviteId')
  String? get inviteId;
  @override
  String get tournamentId;
  @override
  String? get tournamentName;
  @override
  String get teamId;
  @override
  String? get teamName;
  @override
  String? get teamLogo;
  @override
  String? get invitedBy;
  @override
  String? get invitedByName;
  @override
  int? get invitedOn;
  @override
  String? get status;
  @override // 'pending', 'accepted', 'declined'
  String? get respondedBy;
  @override
  int? get respondedOn;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$TournamentInviteModelImplCopyWith<_$TournamentInviteModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

JoinRequestModel _$JoinRequestModelFromJson(Map<String, dynamic> json) {
  return _JoinRequestModel.fromJson(json);
}

/// @nodoc
mixin _$JoinRequestModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'requestId')
  String? get requestId => throw _privateConstructorUsedError;
  String get tournamentId => throw _privateConstructorUsedError;
  String? get tournamentName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  String? get requestedBy => throw _privateConstructorUsedError;
  String? get requestedByName => throw _privateConstructorUsedError;
  int? get requestedOn => throw _privateConstructorUsedError;
  String? get status =>
      throw _privateConstructorUsedError; // 'pending', 'accepted', 'declined'
  String? get respondedBy => throw _privateConstructorUsedError;
  int? get respondedOn => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get declineReason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinRequestModelCopyWith<JoinRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinRequestModelCopyWith<$Res> {
  factory $JoinRequestModelCopyWith(
          JoinRequestModel value, $Res Function(JoinRequestModel) then) =
      _$JoinRequestModelCopyWithImpl<$Res, JoinRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'requestId') String? requestId,
      String tournamentId,
      String? tournamentName,
      String teamId,
      String? teamName,
      String? teamLogo,
      String? requestedBy,
      String? requestedByName,
      int? requestedOn,
      String? status,
      String? respondedBy,
      int? respondedOn,
      String? message,
      String? declineReason});
}

/// @nodoc
class _$JoinRequestModelCopyWithImpl<$Res, $Val extends JoinRequestModel>
    implements $JoinRequestModelCopyWith<$Res> {
  _$JoinRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? requestId = freezed,
    Object? tournamentId = null,
    Object? tournamentName = freezed,
    Object? teamId = null,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? requestedBy = freezed,
    Object? requestedByName = freezed,
    Object? requestedOn = freezed,
    Object? status = freezed,
    Object? respondedBy = freezed,
    Object? respondedOn = freezed,
    Object? message = freezed,
    Object? declineReason = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedBy: freezed == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedByName: freezed == requestedByName
          ? _value.requestedByName
          : requestedByName // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: freezed == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedBy: freezed == respondedBy
          ? _value.respondedBy
          : respondedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedOn: freezed == respondedOn
          ? _value.respondedOn
          : respondedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      declineReason: freezed == declineReason
          ? _value.declineReason
          : declineReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JoinRequestModelImplCopyWith<$Res>
    implements $JoinRequestModelCopyWith<$Res> {
  factory _$$JoinRequestModelImplCopyWith(_$JoinRequestModelImpl value,
          $Res Function(_$JoinRequestModelImpl) then) =
      __$$JoinRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'requestId') String? requestId,
      String tournamentId,
      String? tournamentName,
      String teamId,
      String? teamName,
      String? teamLogo,
      String? requestedBy,
      String? requestedByName,
      int? requestedOn,
      String? status,
      String? respondedBy,
      int? respondedOn,
      String? message,
      String? declineReason});
}

/// @nodoc
class __$$JoinRequestModelImplCopyWithImpl<$Res>
    extends _$JoinRequestModelCopyWithImpl<$Res, _$JoinRequestModelImpl>
    implements _$$JoinRequestModelImplCopyWith<$Res> {
  __$$JoinRequestModelImplCopyWithImpl(_$JoinRequestModelImpl _value,
      $Res Function(_$JoinRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? requestId = freezed,
    Object? tournamentId = null,
    Object? tournamentName = freezed,
    Object? teamId = null,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? requestedBy = freezed,
    Object? requestedByName = freezed,
    Object? requestedOn = freezed,
    Object? status = freezed,
    Object? respondedBy = freezed,
    Object? respondedOn = freezed,
    Object? message = freezed,
    Object? declineReason = freezed,
  }) {
    return _then(_$JoinRequestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedBy: freezed == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedByName: freezed == requestedByName
          ? _value.requestedByName
          : requestedByName // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: freezed == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedBy: freezed == respondedBy
          ? _value.respondedBy
          : respondedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      respondedOn: freezed == respondedOn
          ? _value.respondedOn
          : respondedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      declineReason: freezed == declineReason
          ? _value.declineReason
          : declineReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinRequestModelImpl implements _JoinRequestModel {
  const _$JoinRequestModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'requestId') this.requestId,
      required this.tournamentId,
      this.tournamentName,
      required this.teamId,
      this.teamName,
      this.teamLogo,
      this.requestedBy,
      this.requestedByName,
      this.requestedOn,
      this.status,
      this.respondedBy,
      this.respondedOn,
      this.message,
      this.declineReason});

  factory _$JoinRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinRequestModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'requestId')
  final String? requestId;
  @override
  final String tournamentId;
  @override
  final String? tournamentName;
  @override
  final String teamId;
  @override
  final String? teamName;
  @override
  final String? teamLogo;
  @override
  final String? requestedBy;
  @override
  final String? requestedByName;
  @override
  final int? requestedOn;
  @override
  final String? status;
// 'pending', 'accepted', 'declined'
  @override
  final String? respondedBy;
  @override
  final int? respondedOn;
  @override
  final String? message;
  @override
  final String? declineReason;

  @override
  String toString() {
    return 'JoinRequestModel(id: $id, requestId: $requestId, tournamentId: $tournamentId, tournamentName: $tournamentName, teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, requestedBy: $requestedBy, requestedByName: $requestedByName, requestedOn: $requestedOn, status: $status, respondedBy: $respondedBy, respondedOn: $respondedOn, message: $message, declineReason: $declineReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.requestedBy, requestedBy) ||
                other.requestedBy == requestedBy) &&
            (identical(other.requestedByName, requestedByName) ||
                other.requestedByName == requestedByName) &&
            (identical(other.requestedOn, requestedOn) ||
                other.requestedOn == requestedOn) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.respondedBy, respondedBy) ||
                other.respondedBy == respondedBy) &&
            (identical(other.respondedOn, respondedOn) ||
                other.respondedOn == respondedOn) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.declineReason, declineReason) ||
                other.declineReason == declineReason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      requestId,
      tournamentId,
      tournamentName,
      teamId,
      teamName,
      teamLogo,
      requestedBy,
      requestedByName,
      requestedOn,
      status,
      respondedBy,
      respondedOn,
      message,
      declineReason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinRequestModelImplCopyWith<_$JoinRequestModelImpl> get copyWith =>
      __$$JoinRequestModelImplCopyWithImpl<_$JoinRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinRequestModelImplToJson(
      this,
    );
  }
}

abstract class _JoinRequestModel implements JoinRequestModel {
  const factory _JoinRequestModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'requestId') final String? requestId,
      required final String tournamentId,
      final String? tournamentName,
      required final String teamId,
      final String? teamName,
      final String? teamLogo,
      final String? requestedBy,
      final String? requestedByName,
      final int? requestedOn,
      final String? status,
      final String? respondedBy,
      final int? respondedOn,
      final String? message,
      final String? declineReason}) = _$JoinRequestModelImpl;

  factory _JoinRequestModel.fromJson(Map<String, dynamic> json) =
      _$JoinRequestModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'requestId')
  String? get requestId;
  @override
  String get tournamentId;
  @override
  String? get tournamentName;
  @override
  String get teamId;
  @override
  String? get teamName;
  @override
  String? get teamLogo;
  @override
  String? get requestedBy;
  @override
  String? get requestedByName;
  @override
  int? get requestedOn;
  @override
  String? get status;
  @override // 'pending', 'accepted', 'declined'
  String? get respondedBy;
  @override
  int? get respondedOn;
  @override
  String? get message;
  @override
  String? get declineReason;
  @override
  @JsonKey(ignore: true)
  _$$JoinRequestModelImplCopyWith<_$JoinRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamEligibilityModel _$TeamEligibilityModelFromJson(Map<String, dynamic> json) {
  return _TeamEligibilityModel.fromJson(json);
}

/// @nodoc
mixin _$TeamEligibilityModel {
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  bool get isEligible => throw _privateConstructorUsedError;
  String? get ineligibilityReason => throw _privateConstructorUsedError;
  bool get alreadyJoined => throw _privateConstructorUsedError;
  bool get alreadyRequested => throw _privateConstructorUsedError;
  bool get alreadyInvited => throw _privateConstructorUsedError;
  bool get isWithdrawn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamEligibilityModelCopyWith<TeamEligibilityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamEligibilityModelCopyWith<$Res> {
  factory $TeamEligibilityModelCopyWith(TeamEligibilityModel value,
          $Res Function(TeamEligibilityModel) then) =
      _$TeamEligibilityModelCopyWithImpl<$Res, TeamEligibilityModel>;
  @useResult
  $Res call(
      {String teamId,
      String teamName,
      String? teamLogo,
      bool isEligible,
      String? ineligibilityReason,
      bool alreadyJoined,
      bool alreadyRequested,
      bool alreadyInvited,
      bool isWithdrawn});
}

/// @nodoc
class _$TeamEligibilityModelCopyWithImpl<$Res,
        $Val extends TeamEligibilityModel>
    implements $TeamEligibilityModelCopyWith<$Res> {
  _$TeamEligibilityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? teamLogo = freezed,
    Object? isEligible = null,
    Object? ineligibilityReason = freezed,
    Object? alreadyJoined = null,
    Object? alreadyRequested = null,
    Object? alreadyInvited = null,
    Object? isWithdrawn = null,
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
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      isEligible: null == isEligible
          ? _value.isEligible
          : isEligible // ignore: cast_nullable_to_non_nullable
              as bool,
      ineligibilityReason: freezed == ineligibilityReason
          ? _value.ineligibilityReason
          : ineligibilityReason // ignore: cast_nullable_to_non_nullable
              as String?,
      alreadyJoined: null == alreadyJoined
          ? _value.alreadyJoined
          : alreadyJoined // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyRequested: null == alreadyRequested
          ? _value.alreadyRequested
          : alreadyRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyInvited: null == alreadyInvited
          ? _value.alreadyInvited
          : alreadyInvited // ignore: cast_nullable_to_non_nullable
              as bool,
      isWithdrawn: null == isWithdrawn
          ? _value.isWithdrawn
          : isWithdrawn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamEligibilityModelImplCopyWith<$Res>
    implements $TeamEligibilityModelCopyWith<$Res> {
  factory _$$TeamEligibilityModelImplCopyWith(_$TeamEligibilityModelImpl value,
          $Res Function(_$TeamEligibilityModelImpl) then) =
      __$$TeamEligibilityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String teamId,
      String teamName,
      String? teamLogo,
      bool isEligible,
      String? ineligibilityReason,
      bool alreadyJoined,
      bool alreadyRequested,
      bool alreadyInvited,
      bool isWithdrawn});
}

/// @nodoc
class __$$TeamEligibilityModelImplCopyWithImpl<$Res>
    extends _$TeamEligibilityModelCopyWithImpl<$Res, _$TeamEligibilityModelImpl>
    implements _$$TeamEligibilityModelImplCopyWith<$Res> {
  __$$TeamEligibilityModelImplCopyWithImpl(_$TeamEligibilityModelImpl _value,
      $Res Function(_$TeamEligibilityModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? teamLogo = freezed,
    Object? isEligible = null,
    Object? ineligibilityReason = freezed,
    Object? alreadyJoined = null,
    Object? alreadyRequested = null,
    Object? alreadyInvited = null,
    Object? isWithdrawn = null,
  }) {
    return _then(_$TeamEligibilityModelImpl(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      isEligible: null == isEligible
          ? _value.isEligible
          : isEligible // ignore: cast_nullable_to_non_nullable
              as bool,
      ineligibilityReason: freezed == ineligibilityReason
          ? _value.ineligibilityReason
          : ineligibilityReason // ignore: cast_nullable_to_non_nullable
              as String?,
      alreadyJoined: null == alreadyJoined
          ? _value.alreadyJoined
          : alreadyJoined // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyRequested: null == alreadyRequested
          ? _value.alreadyRequested
          : alreadyRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      alreadyInvited: null == alreadyInvited
          ? _value.alreadyInvited
          : alreadyInvited // ignore: cast_nullable_to_non_nullable
              as bool,
      isWithdrawn: null == isWithdrawn
          ? _value.isWithdrawn
          : isWithdrawn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamEligibilityModelImpl implements _TeamEligibilityModel {
  const _$TeamEligibilityModelImpl(
      {required this.teamId,
      required this.teamName,
      this.teamLogo,
      this.isEligible = true,
      this.ineligibilityReason,
      this.alreadyJoined = false,
      this.alreadyRequested = false,
      this.alreadyInvited = false,
      this.isWithdrawn = false});

  factory _$TeamEligibilityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamEligibilityModelImplFromJson(json);

  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final String? teamLogo;
  @override
  @JsonKey()
  final bool isEligible;
  @override
  final String? ineligibilityReason;
  @override
  @JsonKey()
  final bool alreadyJoined;
  @override
  @JsonKey()
  final bool alreadyRequested;
  @override
  @JsonKey()
  final bool alreadyInvited;
  @override
  @JsonKey()
  final bool isWithdrawn;

  @override
  String toString() {
    return 'TeamEligibilityModel(teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, isEligible: $isEligible, ineligibilityReason: $ineligibilityReason, alreadyJoined: $alreadyJoined, alreadyRequested: $alreadyRequested, alreadyInvited: $alreadyInvited, isWithdrawn: $isWithdrawn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamEligibilityModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.isEligible, isEligible) ||
                other.isEligible == isEligible) &&
            (identical(other.ineligibilityReason, ineligibilityReason) ||
                other.ineligibilityReason == ineligibilityReason) &&
            (identical(other.alreadyJoined, alreadyJoined) ||
                other.alreadyJoined == alreadyJoined) &&
            (identical(other.alreadyRequested, alreadyRequested) ||
                other.alreadyRequested == alreadyRequested) &&
            (identical(other.alreadyInvited, alreadyInvited) ||
                other.alreadyInvited == alreadyInvited) &&
            (identical(other.isWithdrawn, isWithdrawn) ||
                other.isWithdrawn == isWithdrawn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teamId,
      teamName,
      teamLogo,
      isEligible,
      ineligibilityReason,
      alreadyJoined,
      alreadyRequested,
      alreadyInvited,
      isWithdrawn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamEligibilityModelImplCopyWith<_$TeamEligibilityModelImpl>
      get copyWith =>
          __$$TeamEligibilityModelImplCopyWithImpl<_$TeamEligibilityModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamEligibilityModelImplToJson(
      this,
    );
  }
}

abstract class _TeamEligibilityModel implements TeamEligibilityModel {
  const factory _TeamEligibilityModel(
      {required final String teamId,
      required final String teamName,
      final String? teamLogo,
      final bool isEligible,
      final String? ineligibilityReason,
      final bool alreadyJoined,
      final bool alreadyRequested,
      final bool alreadyInvited,
      final bool isWithdrawn}) = _$TeamEligibilityModelImpl;

  factory _TeamEligibilityModel.fromJson(Map<String, dynamic> json) =
      _$TeamEligibilityModelImpl.fromJson;

  @override
  String get teamId;
  @override
  String get teamName;
  @override
  String? get teamLogo;
  @override
  bool get isEligible;
  @override
  String? get ineligibilityReason;
  @override
  bool get alreadyJoined;
  @override
  bool get alreadyRequested;
  @override
  bool get alreadyInvited;
  @override
  bool get isWithdrawn;
  @override
  @JsonKey(ignore: true)
  _$$TeamEligibilityModelImplCopyWith<_$TeamEligibilityModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WithdrawRequestModel _$WithdrawRequestModelFromJson(Map<String, dynamic> json) {
  return _WithdrawRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WithdrawRequestModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get tournamentId => throw _privateConstructorUsedError;
  String? get tournamentName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String? get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  String? get withdrawnBy => throw _privateConstructorUsedError;
  String? get withdrawnByName => throw _privateConstructorUsedError;
  int? get withdrawnOn => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  bool get approved => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  int? get approvedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WithdrawRequestModelCopyWith<WithdrawRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawRequestModelCopyWith<$Res> {
  factory $WithdrawRequestModelCopyWith(WithdrawRequestModel value,
          $Res Function(WithdrawRequestModel) then) =
      _$WithdrawRequestModelCopyWithImpl<$Res, WithdrawRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String tournamentId,
      String? tournamentName,
      String teamId,
      String? teamName,
      String? teamLogo,
      String? withdrawnBy,
      String? withdrawnByName,
      int? withdrawnOn,
      String? reason,
      bool approved,
      String? approvedBy,
      int? approvedOn});
}

/// @nodoc
class _$WithdrawRequestModelCopyWithImpl<$Res,
        $Val extends WithdrawRequestModel>
    implements $WithdrawRequestModelCopyWith<$Res> {
  _$WithdrawRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tournamentId = null,
    Object? tournamentName = freezed,
    Object? teamId = null,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? withdrawnBy = freezed,
    Object? withdrawnByName = freezed,
    Object? withdrawnOn = freezed,
    Object? reason = freezed,
    Object? approved = null,
    Object? approvedBy = freezed,
    Object? approvedOn = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      withdrawnBy: freezed == withdrawnBy
          ? _value.withdrawnBy
          : withdrawnBy // ignore: cast_nullable_to_non_nullable
              as String?,
      withdrawnByName: freezed == withdrawnByName
          ? _value.withdrawnByName
          : withdrawnByName // ignore: cast_nullable_to_non_nullable
              as String?,
      withdrawnOn: freezed == withdrawnOn
          ? _value.withdrawnOn
          : withdrawnOn // ignore: cast_nullable_to_non_nullable
              as int?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      approved: null == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedOn: freezed == approvedOn
          ? _value.approvedOn
          : approvedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawRequestModelImplCopyWith<$Res>
    implements $WithdrawRequestModelCopyWith<$Res> {
  factory _$$WithdrawRequestModelImplCopyWith(_$WithdrawRequestModelImpl value,
          $Res Function(_$WithdrawRequestModelImpl) then) =
      __$$WithdrawRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String tournamentId,
      String? tournamentName,
      String teamId,
      String? teamName,
      String? teamLogo,
      String? withdrawnBy,
      String? withdrawnByName,
      int? withdrawnOn,
      String? reason,
      bool approved,
      String? approvedBy,
      int? approvedOn});
}

/// @nodoc
class __$$WithdrawRequestModelImplCopyWithImpl<$Res>
    extends _$WithdrawRequestModelCopyWithImpl<$Res, _$WithdrawRequestModelImpl>
    implements _$$WithdrawRequestModelImplCopyWith<$Res> {
  __$$WithdrawRequestModelImplCopyWithImpl(_$WithdrawRequestModelImpl _value,
      $Res Function(_$WithdrawRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tournamentId = null,
    Object? tournamentName = freezed,
    Object? teamId = null,
    Object? teamName = freezed,
    Object? teamLogo = freezed,
    Object? withdrawnBy = freezed,
    Object? withdrawnByName = freezed,
    Object? withdrawnOn = freezed,
    Object? reason = freezed,
    Object? approved = null,
    Object? approvedBy = freezed,
    Object? approvedOn = freezed,
  }) {
    return _then(_$WithdrawRequestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: null == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentName: freezed == tournamentName
          ? _value.tournamentName
          : tournamentName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: freezed == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String?,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      withdrawnBy: freezed == withdrawnBy
          ? _value.withdrawnBy
          : withdrawnBy // ignore: cast_nullable_to_non_nullable
              as String?,
      withdrawnByName: freezed == withdrawnByName
          ? _value.withdrawnByName
          : withdrawnByName // ignore: cast_nullable_to_non_nullable
              as String?,
      withdrawnOn: freezed == withdrawnOn
          ? _value.withdrawnOn
          : withdrawnOn // ignore: cast_nullable_to_non_nullable
              as int?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      approved: null == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedOn: freezed == approvedOn
          ? _value.approvedOn
          : approvedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawRequestModelImpl implements _WithdrawRequestModel {
  const _$WithdrawRequestModelImpl(
      {@JsonKey(name: '_id') this.id,
      required this.tournamentId,
      this.tournamentName,
      required this.teamId,
      this.teamName,
      this.teamLogo,
      this.withdrawnBy,
      this.withdrawnByName,
      this.withdrawnOn,
      this.reason,
      this.approved = false,
      this.approvedBy,
      this.approvedOn});

  factory _$WithdrawRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawRequestModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String tournamentId;
  @override
  final String? tournamentName;
  @override
  final String teamId;
  @override
  final String? teamName;
  @override
  final String? teamLogo;
  @override
  final String? withdrawnBy;
  @override
  final String? withdrawnByName;
  @override
  final int? withdrawnOn;
  @override
  final String? reason;
  @override
  @JsonKey()
  final bool approved;
  @override
  final String? approvedBy;
  @override
  final int? approvedOn;

  @override
  String toString() {
    return 'WithdrawRequestModel(id: $id, tournamentId: $tournamentId, tournamentName: $tournamentName, teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, withdrawnBy: $withdrawnBy, withdrawnByName: $withdrawnByName, withdrawnOn: $withdrawnOn, reason: $reason, approved: $approved, approvedBy: $approvedBy, approvedOn: $approvedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.tournamentName, tournamentName) ||
                other.tournamentName == tournamentName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.withdrawnBy, withdrawnBy) ||
                other.withdrawnBy == withdrawnBy) &&
            (identical(other.withdrawnByName, withdrawnByName) ||
                other.withdrawnByName == withdrawnByName) &&
            (identical(other.withdrawnOn, withdrawnOn) ||
                other.withdrawnOn == withdrawnOn) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedOn, approvedOn) ||
                other.approvedOn == approvedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tournamentId,
      tournamentName,
      teamId,
      teamName,
      teamLogo,
      withdrawnBy,
      withdrawnByName,
      withdrawnOn,
      reason,
      approved,
      approvedBy,
      approvedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawRequestModelImplCopyWith<_$WithdrawRequestModelImpl>
      get copyWith =>
          __$$WithdrawRequestModelImplCopyWithImpl<_$WithdrawRequestModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WithdrawRequestModel implements WithdrawRequestModel {
  const factory _WithdrawRequestModel(
      {@JsonKey(name: '_id') final String? id,
      required final String tournamentId,
      final String? tournamentName,
      required final String teamId,
      final String? teamName,
      final String? teamLogo,
      final String? withdrawnBy,
      final String? withdrawnByName,
      final int? withdrawnOn,
      final String? reason,
      final bool approved,
      final String? approvedBy,
      final int? approvedOn}) = _$WithdrawRequestModelImpl;

  factory _WithdrawRequestModel.fromJson(Map<String, dynamic> json) =
      _$WithdrawRequestModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get tournamentId;
  @override
  String? get tournamentName;
  @override
  String get teamId;
  @override
  String? get teamName;
  @override
  String? get teamLogo;
  @override
  String? get withdrawnBy;
  @override
  String? get withdrawnByName;
  @override
  int? get withdrawnOn;
  @override
  String? get reason;
  @override
  bool get approved;
  @override
  String? get approvedBy;
  @override
  int? get approvedOn;
  @override
  @JsonKey(ignore: true)
  _$$WithdrawRequestModelImplCopyWith<_$WithdrawRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MyTournamentTeamModel _$MyTournamentTeamModelFromJson(
    Map<String, dynamic> json) {
  return _MyTournamentTeamModel.fromJson(json);
}

/// @nodoc
mixin _$MyTournamentTeamModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamId')
  String? get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get gameType => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get ageGroup => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  bool get isEligible => throw _privateConstructorUsedError;
  String? get ineligibilityReason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyTournamentTeamModelCopyWith<MyTournamentTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyTournamentTeamModelCopyWith<$Res> {
  factory $MyTournamentTeamModelCopyWith(MyTournamentTeamModel value,
          $Res Function(MyTournamentTeamModel) then) =
      _$MyTournamentTeamModelCopyWithImpl<$Res, MyTournamentTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String teamName,
      String? logo,
      String? country,
      String? city,
      String? gameType,
      String? gender,
      String? ageGroup,
      int memberCount,
      bool isEligible,
      String? ineligibilityReason});
}

/// @nodoc
class _$MyTournamentTeamModelCopyWithImpl<$Res,
        $Val extends MyTournamentTeamModel>
    implements $MyTournamentTeamModelCopyWith<$Res> {
  _$MyTournamentTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = null,
    Object? logo = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? ageGroup = freezed,
    Object? memberCount = null,
    Object? isEligible = null,
    Object? ineligibilityReason = freezed,
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
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
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
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      isEligible: null == isEligible
          ? _value.isEligible
          : isEligible // ignore: cast_nullable_to_non_nullable
              as bool,
      ineligibilityReason: freezed == ineligibilityReason
          ? _value.ineligibilityReason
          : ineligibilityReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyTournamentTeamModelImplCopyWith<$Res>
    implements $MyTournamentTeamModelCopyWith<$Res> {
  factory _$$MyTournamentTeamModelImplCopyWith(
          _$MyTournamentTeamModelImpl value,
          $Res Function(_$MyTournamentTeamModelImpl) then) =
      __$$MyTournamentTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String teamName,
      String? logo,
      String? country,
      String? city,
      String? gameType,
      String? gender,
      String? ageGroup,
      int memberCount,
      bool isEligible,
      String? ineligibilityReason});
}

/// @nodoc
class __$$MyTournamentTeamModelImplCopyWithImpl<$Res>
    extends _$MyTournamentTeamModelCopyWithImpl<$Res,
        _$MyTournamentTeamModelImpl>
    implements _$$MyTournamentTeamModelImplCopyWith<$Res> {
  __$$MyTournamentTeamModelImplCopyWithImpl(_$MyTournamentTeamModelImpl _value,
      $Res Function(_$MyTournamentTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = null,
    Object? logo = freezed,
    Object? country = freezed,
    Object? city = freezed,
    Object? gameType = freezed,
    Object? gender = freezed,
    Object? ageGroup = freezed,
    Object? memberCount = null,
    Object? isEligible = null,
    Object? ineligibilityReason = freezed,
  }) {
    return _then(_$MyTournamentTeamModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
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
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      isEligible: null == isEligible
          ? _value.isEligible
          : isEligible // ignore: cast_nullable_to_non_nullable
              as bool,
      ineligibilityReason: freezed == ineligibilityReason
          ? _value.ineligibilityReason
          : ineligibilityReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyTournamentTeamModelImpl implements _MyTournamentTeamModel {
  const _$MyTournamentTeamModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'teamId') this.teamId,
      required this.teamName,
      this.logo,
      this.country,
      this.city,
      this.gameType,
      this.gender,
      this.ageGroup,
      this.memberCount = 0,
      this.isEligible = false,
      this.ineligibilityReason});

  factory _$MyTournamentTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyTournamentTeamModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'teamId')
  final String? teamId;
  @override
  final String teamName;
  @override
  final String? logo;
  @override
  final String? country;
  @override
  final String? city;
  @override
  final String? gameType;
  @override
  final String? gender;
  @override
  final String? ageGroup;
  @override
  @JsonKey()
  final int memberCount;
  @override
  @JsonKey()
  final bool isEligible;
  @override
  final String? ineligibilityReason;

  @override
  String toString() {
    return 'MyTournamentTeamModel(id: $id, teamId: $teamId, teamName: $teamName, logo: $logo, country: $country, city: $city, gameType: $gameType, gender: $gender, ageGroup: $ageGroup, memberCount: $memberCount, isEligible: $isEligible, ineligibilityReason: $ineligibilityReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyTournamentTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.isEligible, isEligible) ||
                other.isEligible == isEligible) &&
            (identical(other.ineligibilityReason, ineligibilityReason) ||
                other.ineligibilityReason == ineligibilityReason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      teamId,
      teamName,
      logo,
      country,
      city,
      gameType,
      gender,
      ageGroup,
      memberCount,
      isEligible,
      ineligibilityReason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyTournamentTeamModelImplCopyWith<_$MyTournamentTeamModelImpl>
      get copyWith => __$$MyTournamentTeamModelImplCopyWithImpl<
          _$MyTournamentTeamModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyTournamentTeamModelImplToJson(
      this,
    );
  }
}

abstract class _MyTournamentTeamModel implements MyTournamentTeamModel {
  const factory _MyTournamentTeamModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'teamId') final String? teamId,
      required final String teamName,
      final String? logo,
      final String? country,
      final String? city,
      final String? gameType,
      final String? gender,
      final String? ageGroup,
      final int memberCount,
      final bool isEligible,
      final String? ineligibilityReason}) = _$MyTournamentTeamModelImpl;

  factory _MyTournamentTeamModel.fromJson(Map<String, dynamic> json) =
      _$MyTournamentTeamModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'teamId')
  String? get teamId;
  @override
  String get teamName;
  @override
  String? get logo;
  @override
  String? get country;
  @override
  String? get city;
  @override
  String? get gameType;
  @override
  String? get gender;
  @override
  String? get ageGroup;
  @override
  int get memberCount;
  @override
  bool get isEligible;
  @override
  String? get ineligibilityReason;
  @override
  @JsonKey(ignore: true)
  _$$MyTournamentTeamModelImplCopyWith<_$MyTournamentTeamModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvitedTeamModel _$InvitedTeamModelFromJson(Map<String, dynamic> json) {
  return _InvitedTeamModel.fromJson(json);
}

/// @nodoc
mixin _$InvitedTeamModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamId')
  String? get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get inviteStatus =>
      throw _privateConstructorUsedError; // 'pending', 'accepted', 'declined'
  int? get invitedOn => throw _privateConstructorUsedError;
  int? get respondedOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvitedTeamModelCopyWith<InvitedTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitedTeamModelCopyWith<$Res> {
  factory $InvitedTeamModelCopyWith(
          InvitedTeamModel value, $Res Function(InvitedTeamModel) then) =
      _$InvitedTeamModelCopyWithImpl<$Res, InvitedTeamModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String teamName,
      String? logo,
      String? country,
      String? inviteStatus,
      int? invitedOn,
      int? respondedOn});
}

/// @nodoc
class _$InvitedTeamModelCopyWithImpl<$Res, $Val extends InvitedTeamModel>
    implements $InvitedTeamModelCopyWith<$Res> {
  _$InvitedTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = null,
    Object? logo = freezed,
    Object? country = freezed,
    Object? inviteStatus = freezed,
    Object? invitedOn = freezed,
    Object? respondedOn = freezed,
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
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteStatus: freezed == inviteStatus
          ? _value.inviteStatus
          : inviteStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedOn: freezed == invitedOn
          ? _value.invitedOn
          : invitedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      respondedOn: freezed == respondedOn
          ? _value.respondedOn
          : respondedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitedTeamModelImplCopyWith<$Res>
    implements $InvitedTeamModelCopyWith<$Res> {
  factory _$$InvitedTeamModelImplCopyWith(_$InvitedTeamModelImpl value,
          $Res Function(_$InvitedTeamModelImpl) then) =
      __$$InvitedTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'teamId') String? teamId,
      String teamName,
      String? logo,
      String? country,
      String? inviteStatus,
      int? invitedOn,
      int? respondedOn});
}

/// @nodoc
class __$$InvitedTeamModelImplCopyWithImpl<$Res>
    extends _$InvitedTeamModelCopyWithImpl<$Res, _$InvitedTeamModelImpl>
    implements _$$InvitedTeamModelImplCopyWith<$Res> {
  __$$InvitedTeamModelImplCopyWithImpl(_$InvitedTeamModelImpl _value,
      $Res Function(_$InvitedTeamModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? teamId = freezed,
    Object? teamName = null,
    Object? logo = freezed,
    Object? country = freezed,
    Object? inviteStatus = freezed,
    Object? invitedOn = freezed,
    Object? respondedOn = freezed,
  }) {
    return _then(_$InvitedTeamModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteStatus: freezed == inviteStatus
          ? _value.inviteStatus
          : inviteStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      invitedOn: freezed == invitedOn
          ? _value.invitedOn
          : invitedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      respondedOn: freezed == respondedOn
          ? _value.respondedOn
          : respondedOn // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitedTeamModelImpl implements _InvitedTeamModel {
  const _$InvitedTeamModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'teamId') this.teamId,
      required this.teamName,
      this.logo,
      this.country,
      this.inviteStatus,
      this.invitedOn,
      this.respondedOn});

  factory _$InvitedTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitedTeamModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'teamId')
  final String? teamId;
  @override
  final String teamName;
  @override
  final String? logo;
  @override
  final String? country;
  @override
  final String? inviteStatus;
// 'pending', 'accepted', 'declined'
  @override
  final int? invitedOn;
  @override
  final int? respondedOn;

  @override
  String toString() {
    return 'InvitedTeamModel(id: $id, teamId: $teamId, teamName: $teamName, logo: $logo, country: $country, inviteStatus: $inviteStatus, invitedOn: $invitedOn, respondedOn: $respondedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitedTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.inviteStatus, inviteStatus) ||
                other.inviteStatus == inviteStatus) &&
            (identical(other.invitedOn, invitedOn) ||
                other.invitedOn == invitedOn) &&
            (identical(other.respondedOn, respondedOn) ||
                other.respondedOn == respondedOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, teamId, teamName, logo,
      country, inviteStatus, invitedOn, respondedOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitedTeamModelImplCopyWith<_$InvitedTeamModelImpl> get copyWith =>
      __$$InvitedTeamModelImplCopyWithImpl<_$InvitedTeamModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitedTeamModelImplToJson(
      this,
    );
  }
}

abstract class _InvitedTeamModel implements InvitedTeamModel {
  const factory _InvitedTeamModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'teamId') final String? teamId,
      required final String teamName,
      final String? logo,
      final String? country,
      final String? inviteStatus,
      final int? invitedOn,
      final int? respondedOn}) = _$InvitedTeamModelImpl;

  factory _InvitedTeamModel.fromJson(Map<String, dynamic> json) =
      _$InvitedTeamModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'teamId')
  String? get teamId;
  @override
  String get teamName;
  @override
  String? get logo;
  @override
  String? get country;
  @override
  String? get inviteStatus;
  @override // 'pending', 'accepted', 'declined'
  int? get invitedOn;
  @override
  int? get respondedOn;
  @override
  @JsonKey(ignore: true)
  _$$InvitedTeamModelImplCopyWith<_$InvitedTeamModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingRequestModel _$PendingRequestModelFromJson(Map<String, dynamic> json) {
  return _PendingRequestModel.fromJson(json);
}

/// @nodoc
mixin _$PendingRequestModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'requestId')
  String? get requestId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  String? get teamLogo => throw _privateConstructorUsedError;
  String? get requestedBy => throw _privateConstructorUsedError;
  String? get requestedByName => throw _privateConstructorUsedError;
  int? get requestedOn => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PendingRequestModelCopyWith<PendingRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingRequestModelCopyWith<$Res> {
  factory $PendingRequestModelCopyWith(
          PendingRequestModel value, $Res Function(PendingRequestModel) then) =
      _$PendingRequestModelCopyWithImpl<$Res, PendingRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'requestId') String? requestId,
      String teamId,
      String teamName,
      String? teamLogo,
      String? requestedBy,
      String? requestedByName,
      int? requestedOn,
      String? message});
}

/// @nodoc
class _$PendingRequestModelCopyWithImpl<$Res, $Val extends PendingRequestModel>
    implements $PendingRequestModelCopyWith<$Res> {
  _$PendingRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? requestId = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? teamLogo = freezed,
    Object? requestedBy = freezed,
    Object? requestedByName = freezed,
    Object? requestedOn = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedBy: freezed == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedByName: freezed == requestedByName
          ? _value.requestedByName
          : requestedByName // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: freezed == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PendingRequestModelImplCopyWith<$Res>
    implements $PendingRequestModelCopyWith<$Res> {
  factory _$$PendingRequestModelImplCopyWith(_$PendingRequestModelImpl value,
          $Res Function(_$PendingRequestModelImpl) then) =
      __$$PendingRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'requestId') String? requestId,
      String teamId,
      String teamName,
      String? teamLogo,
      String? requestedBy,
      String? requestedByName,
      int? requestedOn,
      String? message});
}

/// @nodoc
class __$$PendingRequestModelImplCopyWithImpl<$Res>
    extends _$PendingRequestModelCopyWithImpl<$Res, _$PendingRequestModelImpl>
    implements _$$PendingRequestModelImplCopyWith<$Res> {
  __$$PendingRequestModelImplCopyWithImpl(_$PendingRequestModelImpl _value,
      $Res Function(_$PendingRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? requestId = freezed,
    Object? teamId = null,
    Object? teamName = null,
    Object? teamLogo = freezed,
    Object? requestedBy = freezed,
    Object? requestedByName = freezed,
    Object? requestedOn = freezed,
    Object? message = freezed,
  }) {
    return _then(_$PendingRequestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      teamLogo: freezed == teamLogo
          ? _value.teamLogo
          : teamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedBy: freezed == requestedBy
          ? _value.requestedBy
          : requestedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedByName: freezed == requestedByName
          ? _value.requestedByName
          : requestedByName // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedOn: freezed == requestedOn
          ? _value.requestedOn
          : requestedOn // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingRequestModelImpl implements _PendingRequestModel {
  const _$PendingRequestModelImpl(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'requestId') this.requestId,
      required this.teamId,
      required this.teamName,
      this.teamLogo,
      this.requestedBy,
      this.requestedByName,
      this.requestedOn,
      this.message});

  factory _$PendingRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingRequestModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'requestId')
  final String? requestId;
  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final String? teamLogo;
  @override
  final String? requestedBy;
  @override
  final String? requestedByName;
  @override
  final int? requestedOn;
  @override
  final String? message;

  @override
  String toString() {
    return 'PendingRequestModel(id: $id, requestId: $requestId, teamId: $teamId, teamName: $teamName, teamLogo: $teamLogo, requestedBy: $requestedBy, requestedByName: $requestedByName, requestedOn: $requestedOn, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.teamLogo, teamLogo) ||
                other.teamLogo == teamLogo) &&
            (identical(other.requestedBy, requestedBy) ||
                other.requestedBy == requestedBy) &&
            (identical(other.requestedByName, requestedByName) ||
                other.requestedByName == requestedByName) &&
            (identical(other.requestedOn, requestedOn) ||
                other.requestedOn == requestedOn) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, requestId, teamId, teamName,
      teamLogo, requestedBy, requestedByName, requestedOn, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingRequestModelImplCopyWith<_$PendingRequestModelImpl> get copyWith =>
      __$$PendingRequestModelImplCopyWithImpl<_$PendingRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingRequestModelImplToJson(
      this,
    );
  }
}

abstract class _PendingRequestModel implements PendingRequestModel {
  const factory _PendingRequestModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'requestId') final String? requestId,
      required final String teamId,
      required final String teamName,
      final String? teamLogo,
      final String? requestedBy,
      final String? requestedByName,
      final int? requestedOn,
      final String? message}) = _$PendingRequestModelImpl;

  factory _PendingRequestModel.fromJson(Map<String, dynamic> json) =
      _$PendingRequestModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'requestId')
  String? get requestId;
  @override
  String get teamId;
  @override
  String get teamName;
  @override
  String? get teamLogo;
  @override
  String? get requestedBy;
  @override
  String? get requestedByName;
  @override
  int? get requestedOn;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$PendingRequestModelImplCopyWith<_$PendingRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
