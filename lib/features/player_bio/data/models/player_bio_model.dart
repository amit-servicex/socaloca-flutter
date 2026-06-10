import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_bio_model.freezed.dart';
part 'player_bio_model.g.dart';

int? _toInt(dynamic v) =>
    v == null ? null : (v is num ? v.toInt() : int.tryParse(v.toString()));

Map<String, dynamic> _sanitizeBioJson(Map<String, dynamic> json) => {
      ...json,
      'yearOfBirth': _toInt(json['yearOfBirth']),
      'height': _toInt(json['height']),
      'postCount': _toInt(json['postCount']),
      'likeCount': _toInt(json['likeCount']),
      'followCount': _toInt(json['followCount']),
      'followingCount': _toInt(json['followingCount']),
      'lastOnline': _toInt(json['lastOnline']),
    };

/// Model for player bio data from getPlayerBio API
@freezed
class PlayerBioModel with _$PlayerBioModel {
  const factory PlayerBioModel({
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'profileName') String? profileName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'playPosition') String? playPosition,
    @JsonKey(name: 'playPositionType') String? playPositionType,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'countryIso') String? countryIso,
    @JsonKey(name: 'nationality') String? nationality,
    @JsonKey(name: 'nationalityIso') String? nationalityIso,
    @JsonKey(name: 'preferredJersey') String? preferredJersey,
    @JsonKey(name: 'height') int? height,
    @JsonKey(name: 'preferredFoot') String? preferredFoot,
    @JsonKey(name: 'playLevel') String? playLevel,
    @JsonKey(name: 'jerseySize') String? jerseySize,
    @JsonKey(name: 'shoeSize') String? shoeSize,
    @JsonKey(name: 'shoeSizeUnit') String? shoeSizeUnit,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'dob') String? dob,
    @JsonKey(name: 'yearOfBirth') int? yearOfBirth,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'aboutMe') String? aboutMe,
    @JsonKey(name: 'postCount') int? postCount,
    @JsonKey(name: 'likeCount') int? likeCount,
    @JsonKey(name: 'followCount') int? followCount,
    @JsonKey(name: 'followingCount') int? followingCount,
    @JsonKey(name: 'followedByMe') bool? followedByMe,
    @JsonKey(name: 'likedByMe') bool? likedByMe,
    @JsonKey(name: 'isOnline') bool? isOnline,
    @JsonKey(name: 'lastOnline') int? lastOnline,
    @JsonKey(name: 'isVerifyBadge') bool? isVerifyBadge,
    @JsonKey(name: 'sclId') String? sclId,
    @JsonKey(name: 'ghaId') String? ghaId,
    @JsonKey(name: 'isPlayer') bool? isPlayer,
    @JsonKey(name: 'isCoach') bool? isCoach,
    @JsonKey(name: 'isAdmin') bool? isAdmin,
    @JsonKey(name: 'isFan') bool? isFan,
    @JsonKey(name: 'isReferee') bool? isReferee,
    @JsonKey(name: 'brands') List<String>? brands,
    @JsonKey(name: 'leagueFollow') String? leagueFollow,
    @JsonKey(name: 'teamFollow') String? teamFollow,
  }) = _PlayerBioModel;

  factory PlayerBioModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerBioModelFromJson(_sanitizeBioJson(json));
}
