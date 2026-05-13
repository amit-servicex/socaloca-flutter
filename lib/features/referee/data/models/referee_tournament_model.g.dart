// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referee_tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefereeTournamentModelImpl _$$RefereeTournamentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RefereeTournamentModelImpl(
      tournamentId: json['tournamentId'] as String?,
      tournamentName: json['tournamentName'] as String?,
      tournamentImage: json['tournamentImage'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      venue: json['venue'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      organiserName: json['organiserName'] as String?,
      ageGroup: json['ageGroup'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$RefereeTournamentModelImplToJson(
        _$RefereeTournamentModelImpl instance) =>
    <String, dynamic>{
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
      'tournamentImage': instance.tournamentImage,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'venue': instance.venue,
      'country': instance.country,
      'city': instance.city,
      'organiserName': instance.organiserName,
      'ageGroup': instance.ageGroup,
      'status': instance.status,
    };
