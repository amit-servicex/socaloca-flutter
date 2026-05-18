import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_user_model.freezed.dart';
part 'club_user_model.g.dart';

/// ClubUser — stored in SharedPreferences key 'Msai1Q_club' after club login.
/// Mirrors Android GlobalDataService.clubUser / ClubUser.java.
@freezed
class ClubUserModel with _$ClubUserModel {
  const factory ClubUserModel({
    @JsonKey(name: 'clubId') String? clubId,
    @JsonKey(name: 'clubName') String? clubName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'coverImage') String? coverImage,
    @JsonKey(name: 'nickName') String? nickName,
    @JsonKey(name: 'formedYear') String? formedIn,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'stadium') String? stadium,
    @JsonKey(name: 'manager') String? manager,
    @JsonKey(name: 'league') String? league,
    @JsonKey(name: 'competitions') String? competitions,
    @JsonKey(name: 'website') String? website,
    @JsonKey(name: 'followCount') int? followCount,

    /// 'PLATINUM' | 'GOLD' | 'SILVER' | null
    @JsonKey(name: 'partnerType') String? partnerType,
    @JsonKey(name: 'isPartner') bool? isPartner,
    @JsonKey(name: 'liveTrial') bool? liveTrial,
    @JsonKey(name: 'homeKit') String? homeKit,
    @JsonKey(name: 'awayKit') String? awayKit,
    @JsonKey(name: 'thirdKit') String? thirdKit,
    // Login credentials (stored from club login response)
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'adminBy') String? adminBy,
    @JsonKey(name: 'accepted') String? accepted,
  }) = _ClubUserModel;

  factory ClubUserModel.fromJson(Map<String, dynamic> json) =>
      _$ClubUserModelFromJson(json);
}
