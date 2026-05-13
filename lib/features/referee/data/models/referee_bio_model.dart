import 'package:freezed_annotation/freezed_annotation.dart';

part 'referee_bio_model.freezed.dart';
part 'referee_bio_model.g.dart';

/// Referee-specific bio/profile data from getRefBio API.
@freezed
class RefereeBioModel with _$RefereeBioModel {
  const factory RefereeBioModel({
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'profileName') String? profileName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'coverImage') String? coverImage,
    @JsonKey(name: 'isVerifyBadge') bool? isVerifyBadge,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'nationality') String? nationality,
    @JsonKey(name: 'aboutMe') String? aboutMe,
    @JsonKey(name: 'isOnline') bool? isOnline,
    @JsonKey(name: 'postCount') int? postCount,
    @JsonKey(name: 'likeCount') int? likeCount,
    @JsonKey(name: 'followCount') int? followCount,
    @JsonKey(name: 'followingCount') int? followingCount,
    // Football stats
    @JsonKey(name: 'ftOfficiated') String? ftOfficiated,
    @JsonKey(name: 'ftRedCards') String? ftRedCards,
    @JsonKey(name: 'ftYellowCards') String? ftYellowCards,
    @JsonKey(name: 'ftMatchesYear') String? ftMatchesYear,
    @JsonKey(name: 'ftPastYears') String? ftPastYears,
    // Futsal stats
    @JsonKey(name: 'fsOfficiated') String? fsOfficiated,
    @JsonKey(name: 'fsRedCards') String? fsRedCards,
    @JsonKey(name: 'fsYellowCards') String? fsYellowCards,
    @JsonKey(name: 'fsMatchesYear') String? fsMatchesYear,
    @JsonKey(name: 'fsPastYears') String? fsPastYears,
  }) = _RefereeBioModel;

  factory RefereeBioModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeBioModelFromJson(json);
}

/// One entry in the referee's match activity history.
@freezed
class RefereeActivityModel with _$RefereeActivityModel {
  const factory RefereeActivityModel({
    @JsonKey(name: 'matchId') String? matchId,
    @JsonKey(name: 'tournamentName') String? tournamentName,
    @JsonKey(name: 'roundName') String? roundName,
    @JsonKey(name: 'teamA') String? teamA,
    @JsonKey(name: 'teamAScore') String? teamAScore,
    @JsonKey(name: 'teamB') String? teamB,
    @JsonKey(name: 'teamBScore') String? teamBScore,
    @JsonKey(name: 'matchDate') String? matchDate,
    @JsonKey(name: 'venue') String? venue,
    @JsonKey(name: 'redCardsGiven') int? redCardsGiven,
    @JsonKey(name: 'yellowCardsGiven') int? yellowCardsGiven,
  }) = _RefereeActivityModel;

  factory RefereeActivityModel.fromJson(Map<String, dynamic> json) =>
      _$RefereeActivityModelFromJson(json);
}
