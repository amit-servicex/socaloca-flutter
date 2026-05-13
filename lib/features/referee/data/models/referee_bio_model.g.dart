// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referee_bio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefereeBioModelImpl _$$RefereeBioModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RefereeBioModelImpl(
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileName: json['profileName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      coverImage: json['coverImage'] as String?,
      isVerifyBadge: json['isVerifyBadge'] as bool?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      nationality: json['nationality'] as String?,
      aboutMe: json['aboutMe'] as String?,
      isOnline: json['isOnline'] as bool?,
      postCount: (json['postCount'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      followCount: (json['followCount'] as num?)?.toInt(),
      followingCount: (json['followingCount'] as num?)?.toInt(),
      ftOfficiated: json['ftOfficiated'] as String?,
      ftRedCards: json['ftRedCards'] as String?,
      ftYellowCards: json['ftYellowCards'] as String?,
      ftMatchesYear: json['ftMatchesYear'] as String?,
      ftPastYears: json['ftPastYears'] as String?,
      fsOfficiated: json['fsOfficiated'] as String?,
      fsRedCards: json['fsRedCards'] as String?,
      fsYellowCards: json['fsYellowCards'] as String?,
      fsMatchesYear: json['fsMatchesYear'] as String?,
      fsPastYears: json['fsPastYears'] as String?,
    );

Map<String, dynamic> _$$RefereeBioModelImplToJson(
        _$RefereeBioModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileName': instance.profileName,
      'imageUrl': instance.imageUrl,
      'coverImage': instance.coverImage,
      'isVerifyBadge': instance.isVerifyBadge,
      'country': instance.country,
      'city': instance.city,
      'nationality': instance.nationality,
      'aboutMe': instance.aboutMe,
      'isOnline': instance.isOnline,
      'postCount': instance.postCount,
      'likeCount': instance.likeCount,
      'followCount': instance.followCount,
      'followingCount': instance.followingCount,
      'ftOfficiated': instance.ftOfficiated,
      'ftRedCards': instance.ftRedCards,
      'ftYellowCards': instance.ftYellowCards,
      'ftMatchesYear': instance.ftMatchesYear,
      'ftPastYears': instance.ftPastYears,
      'fsOfficiated': instance.fsOfficiated,
      'fsRedCards': instance.fsRedCards,
      'fsYellowCards': instance.fsYellowCards,
      'fsMatchesYear': instance.fsMatchesYear,
      'fsPastYears': instance.fsPastYears,
    };

_$RefereeActivityModelImpl _$$RefereeActivityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RefereeActivityModelImpl(
      matchId: json['matchId'] as String?,
      tournamentName: json['tournamentName'] as String?,
      roundName: json['roundName'] as String?,
      teamA: json['teamA'] as String?,
      teamAScore: json['teamAScore'] as String?,
      teamB: json['teamB'] as String?,
      teamBScore: json['teamBScore'] as String?,
      matchDate: json['matchDate'] as String?,
      venue: json['venue'] as String?,
      redCardsGiven: (json['redCardsGiven'] as num?)?.toInt(),
      yellowCardsGiven: (json['yellowCardsGiven'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RefereeActivityModelImplToJson(
        _$RefereeActivityModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'tournamentName': instance.tournamentName,
      'roundName': instance.roundName,
      'teamA': instance.teamA,
      'teamAScore': instance.teamAScore,
      'teamB': instance.teamB,
      'teamBScore': instance.teamBScore,
      'matchDate': instance.matchDate,
      'venue': instance.venue,
      'redCardsGiven': instance.redCardsGiven,
      'yellowCardsGiven': instance.yellowCardsGiven,
    };
