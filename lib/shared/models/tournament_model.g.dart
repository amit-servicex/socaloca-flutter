// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentModelImpl _$$TournamentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      coverImage: json['coverImage'] as String?,
      status: json['status'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      organizerId: json['organizerId'] as String?,
      organizerName: json['organizerName'] as String?,
      teamsCount: (json['teamsCount'] as num?)?.toInt() ?? 0,
      isFollowing: json['isFollowing'] as bool? ?? false,
      format: json['format'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TournamentModelImplToJson(
        _$TournamentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'coverImage': instance.coverImage,
      'status': instance.status,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'country': instance.country,
      'city': instance.city,
      'organizerId': instance.organizerId,
      'organizerName': instance.organizerName,
      'teamsCount': instance.teamsCount,
      'isFollowing': instance.isFollowing,
      'format': instance.format,
      'description': instance.description,
    };

_$StandingsRowImpl _$$StandingsRowImplFromJson(Map<String, dynamic> json) =>
    _$StandingsRowImpl(
      position: (json['position'] as num).toInt(),
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      teamLogo: json['teamLogo'] as String?,
      played: (json['played'] as num?)?.toInt() ?? 0,
      won: (json['won'] as num?)?.toInt() ?? 0,
      drawn: (json['drawn'] as num?)?.toInt() ?? 0,
      lost: (json['lost'] as num?)?.toInt() ?? 0,
      goalsFor: (json['goalsFor'] as num?)?.toInt() ?? 0,
      goalsAgainst: (json['goalsAgainst'] as num?)?.toInt() ?? 0,
      goalDifference: (json['goalDifference'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StandingsRowImplToJson(_$StandingsRowImpl instance) =>
    <String, dynamic>{
      'position': instance.position,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'played': instance.played,
      'won': instance.won,
      'drawn': instance.drawn,
      'lost': instance.lost,
      'goalsFor': instance.goalsFor,
      'goalsAgainst': instance.goalsAgainst,
      'goalDifference': instance.goalDifference,
      'points': instance.points,
    };

_$TrialModelImpl _$$TrialModelImplFromJson(Map<String, dynamic> json) =>
    _$TrialModelImpl(
      id: json['id'] as String,
      organizerId: json['organizerId'] as String,
      organizerName: json['organizerName'] as String,
      organizerLogo: json['organizerLogo'] as String?,
      organizerType: json['organizerType'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      trialDate: json['trialDate'] as String?,
      venue: json['venue'] as String?,
      country: json['country'] as String?,
      ageGroup: json['ageGroup'] as String?,
      position: json['position'] as String?,
      isRegistered: json['isRegistered'] as bool? ?? false,
    );

Map<String, dynamic> _$$TrialModelImplToJson(_$TrialModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizerId': instance.organizerId,
      'organizerName': instance.organizerName,
      'organizerLogo': instance.organizerLogo,
      'organizerType': instance.organizerType,
      'title': instance.title,
      'description': instance.description,
      'trialDate': instance.trialDate,
      'venue': instance.venue,
      'country': instance.country,
      'ageGroup': instance.ageGroup,
      'position': instance.position,
      'isRegistered': instance.isRegistered,
    };
