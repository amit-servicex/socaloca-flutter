// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentModelImpl _$$TournamentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentModelImpl(
      id: json['_id'] as String?,
      tournamentId: json['tournamentId'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      location: json['location'] as String?,
      venue: json['venue'] as String?,
      ageGroup: json['ageGroup'] as String?,
      ageCat: json['ageCat'] as String?,
      gameType: json['gameType'] as String?,
      gender: json['gender'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
      rule: json['rule'] as String?,
      tmntType: json['tmntType'] as String?,
      visibility: json['visibility'] as String?,
      country: json['country'] as String?,
      confed: json['confed'] as String?,
      parentId: json['parentId'] as String?,
      createdBy: json['createdBy'] as String?,
      notes: json['notes'] as String?,
      description: json['description'] as String?,
      prize: json['prize'] as String?,
      regFee: json['regFee'] as String?,
      orgDetails: json['orgDetails'] as String?,
      fsdDate: json['fsdDate'] as String?,
      fsdTime: json['fsdTime'] as String?,
      fsdGmtMs: (json['fsdGmtMs'] as num?)?.toInt() ?? 0,
      teamPlayerType: json['teamPlayerType'] as String?,
      teamPlayerLimit: (json['teamPlayerLimit'] as num?)?.toInt() ?? 0,
      followCount: (json['followCount'] as num?)?.toInt() ?? 0,
      isFollowing: json['following'] as bool? ?? false,
      teamCount: (json['teamCount'] as num?)?.toInt() ?? 0,
      matchCount: (json['matchCount'] as num?)?.toInt() ?? 0,
      withdrawable: json['withdrawable'] as bool? ?? false,
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsors: (json['sponsors'] as List<dynamic>?)
          ?.map((e) => SponsorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      itinerary: json['itinerary'] == null
          ? null
          : ItineraryModel.fromJson(json['itinerary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TournamentModelImplToJson(
        _$TournamentModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tournamentId': instance.tournamentId,
      'name': instance.name,
      'logo': instance.logo,
      'location': instance.location,
      'venue': instance.venue,
      'ageGroup': instance.ageGroup,
      'ageCat': instance.ageCat,
      'gameType': instance.gameType,
      'gender': instance.gender,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'rule': instance.rule,
      'tmntType': instance.tmntType,
      'visibility': instance.visibility,
      'country': instance.country,
      'confed': instance.confed,
      'parentId': instance.parentId,
      'createdBy': instance.createdBy,
      'notes': instance.notes,
      'description': instance.description,
      'prize': instance.prize,
      'regFee': instance.regFee,
      'orgDetails': instance.orgDetails,
      'fsdDate': instance.fsdDate,
      'fsdTime': instance.fsdTime,
      'fsdGmtMs': instance.fsdGmtMs,
      'teamPlayerType': instance.teamPlayerType,
      'teamPlayerLimit': instance.teamPlayerLimit,
      'followCount': instance.followCount,
      'following': instance.isFollowing,
      'teamCount': instance.teamCount,
      'matchCount': instance.matchCount,
      'withdrawable': instance.withdrawable,
      'banners': instance.banners,
      'teams': instance.teams,
      'sponsors': instance.sponsors,
      'itinerary': instance.itinerary,
    };

_$BannerModelImpl _$$BannerModelImplFromJson(Map<String, dynamic> json) =>
    _$BannerModelImpl(
      imageUrl: json['imageUrl'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$$BannerModelImplToJson(_$BannerModelImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'seq': instance.seq,
      'link': instance.link,
    };

_$SponsorModelImpl _$$SponsorModelImplFromJson(Map<String, dynamic> json) =>
    _$SponsorModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$$SponsorModelImplToJson(_$SponsorModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'website': instance.website,
    };

_$ItineraryModelImpl _$$ItineraryModelImplFromJson(Map<String, dynamic> json) =>
    _$ItineraryModelImpl(
      doc: json['doc'] as String?,
      canView: json['canView'] as bool? ?? false,
    );

Map<String, dynamic> _$$ItineraryModelImplToJson(
        _$ItineraryModelImpl instance) =>
    <String, dynamic>{
      'doc': instance.doc,
      'canView': instance.canView,
    };

_$TournamentMatchModelImpl _$$TournamentMatchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentMatchModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String?,
      homeTeamId: json['homeTeamId'] as String?,
      homeTeamName: json['homeTeamName'] as String?,
      homeTeamLogo: json['homeTeamLogo'] as String?,
      awayTeamId: json['awayTeamId'] as String?,
      awayTeamName: json['awayTeamName'] as String?,
      awayTeamLogo: json['awayTeamLogo'] as String?,
      homeScore: (json['homeScore'] as num?)?.toInt(),
      awayScore: (json['awayScore'] as num?)?.toInt(),
      status: json['status'] as String?,
      matchDate: json['matchDate'] as String?,
      matchDateMs: (json['matchDateMs'] as num?)?.toInt() ?? 0,
      venue: json['venue'] as String?,
      gameType: json['gameType'] as String?,
      ageGroup: json['ageGroup'] as String?,
    );

Map<String, dynamic> _$$TournamentMatchModelImplToJson(
        _$TournamentMatchModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'homeTeamId': instance.homeTeamId,
      'homeTeamName': instance.homeTeamName,
      'homeTeamLogo': instance.homeTeamLogo,
      'awayTeamId': instance.awayTeamId,
      'awayTeamName': instance.awayTeamName,
      'awayTeamLogo': instance.awayTeamLogo,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'status': instance.status,
      'matchDate': instance.matchDate,
      'matchDateMs': instance.matchDateMs,
      'venue': instance.venue,
      'gameType': instance.gameType,
      'ageGroup': instance.ageGroup,
    };

_$PointsTableEntryImpl _$$PointsTableEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$PointsTableEntryImpl(
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      teamLogo: json['teamLogo'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      played: (json['played'] as num?)?.toInt() ?? 0,
      won: (json['win'] as num?)?.toInt() ?? 0,
      drawn: (json['draw'] as num?)?.toInt() ?? 0,
      lost: (json['loss'] as num?)?.toInt() ?? 0,
      goalsFor: (json['gf'] as num?)?.toInt() ?? 0,
      goalsAgainst: (json['ga'] as num?)?.toInt() ?? 0,
      goalDifference: (json['gd'] as num?)?.toInt() ?? 0,
      points: (json['pts'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PointsTableEntryImplToJson(
        _$PointsTableEntryImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamLogo': instance.teamLogo,
      'seq': instance.seq,
      'played': instance.played,
      'win': instance.won,
      'draw': instance.drawn,
      'loss': instance.lost,
      'gf': instance.goalsFor,
      'ga': instance.goalsAgainst,
      'gd': instance.goalDifference,
      'pts': instance.points,
    };

_$PlayerStatEntryImpl _$$PlayerStatEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerStatEntryImpl(
      userId: json['userId'] as String?,
      playerName: json['playerName'] as String?,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      count: (json['count'] as num?)?.toInt() ?? 0,
      yellowCards: (json['yellowCards'] as num?)?.toInt() ?? 0,
      redCards: (json['redCards'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PlayerStatEntryImplToJson(
        _$PlayerStatEntryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'count': instance.count,
      'yellowCards': instance.yellowCards,
      'redCards': instance.redCards,
    };
