// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cup_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TournamentCupModelImpl _$$TournamentCupModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentCupModelImpl(
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
      rounds: (json['rounds'] as num?)?.toInt() ?? 0,
      lastUpdated: (json['lastUpdated'] as num?)?.toInt(),
      startedOn: (json['startedOn'] as num?)?.toInt(),
      startedBy: json['startedBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => CupBannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => CupTeamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsors: (json['sponsors'] as List<dynamic>?)
          ?.map((e) => CupSponsorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      roundsList: (json['roundsList'] as List<dynamic>?)
          ?.map((e) => CupRoundModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TournamentCupModelImplToJson(
        _$TournamentCupModelImpl instance) =>
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
      'rounds': instance.rounds,
      'lastUpdated': instance.lastUpdated,
      'startedOn': instance.startedOn,
      'startedBy': instance.startedBy,
      'updatedBy': instance.updatedBy,
      'banners': instance.banners,
      'teams': instance.teams,
      'sponsors': instance.sponsors,
      'roundsList': instance.roundsList,
    };

_$CupRoundModelImpl _$$CupRoundModelImplFromJson(Map<String, dynamic> json) =>
    _$CupRoundModelImpl(
      id: json['_id'] as String?,
      roundId: json['roundId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      roundName: json['roundName'] as String?,
      mode: json['mode'] as String?,
      tie: json['tie'] as String?,
      seq: json['seq'] as String?,
      count: json['count'] as String?,
      level: json['level'] as String?,
      isExtraTime: json['isExtraTime'] as bool? ?? false,
      isPenalty: json['isPenalty'] as bool? ?? false,
      addedBy: json['addedBy'] as String?,
      addedOn: json['addedOn'] as String?,
      isDelete: json['isDelete'] as bool? ?? false,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => CupGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CupRoundModelImplToJson(_$CupRoundModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'roundId': instance.roundId,
      'tournamentId': instance.tournamentId,
      'roundName': instance.roundName,
      'mode': instance.mode,
      'tie': instance.tie,
      'seq': instance.seq,
      'count': instance.count,
      'level': instance.level,
      'isExtraTime': instance.isExtraTime,
      'isPenalty': instance.isPenalty,
      'addedBy': instance.addedBy,
      'addedOn': instance.addedOn,
      'isDelete': instance.isDelete,
      'groups': instance.groups,
    };

_$CupGroupModelImpl _$$CupGroupModelImplFromJson(Map<String, dynamic> json) =>
    _$CupGroupModelImpl(
      id: json['_id'] as String?,
      groupId: json['groupId'] as String?,
      roundId: json['roundId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      groupName: json['groupName'] as String?,
      mode: json['mode'] as String?,
      status: json['status'] as String?,
      level: json['level'] as String?,
      seq: json['seq'] as String?,
      fixture: json['fixture'] as String?,
      isDelete: json['isDelete'] as bool? ?? false,
      leg1: (json['leg1'] as List<dynamic>?)
              ?.map((e) => CupLeagueModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      leg2: (json['leg2'] as List<dynamic>?)
              ?.map((e) => CupLeagueModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CupGroupModelImplToJson(_$CupGroupModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'groupId': instance.groupId,
      'roundId': instance.roundId,
      'tournamentId': instance.tournamentId,
      'groupName': instance.groupName,
      'mode': instance.mode,
      'status': instance.status,
      'level': instance.level,
      'seq': instance.seq,
      'fixture': instance.fixture,
      'isDelete': instance.isDelete,
      'leg1': instance.leg1,
      'leg2': instance.leg2,
    };

_$CupLeagueModelImpl _$$CupLeagueModelImplFromJson(Map<String, dynamic> json) =>
    _$CupLeagueModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      roundId: json['roundId'] as String?,
      groupId: json['groupId'] as String?,
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
      leg: json['leg'] as String?,
    );

Map<String, dynamic> _$$CupLeagueModelImplToJson(
        _$CupLeagueModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'tournamentId': instance.tournamentId,
      'roundId': instance.roundId,
      'groupId': instance.groupId,
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
      'leg': instance.leg,
    };

_$CupMatchModelImpl _$$CupMatchModelImplFromJson(Map<String, dynamic> json) =>
    _$CupMatchModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      roundId: json['roundId'] as String?,
      homeTeamId: json['homeTeamId'] as String?,
      homeTeamName: json['homeTeamName'] as String?,
      homeTeamShortName: json['homeTeamShortName'] as String?,
      homeTeamLogo: json['homeTeamLogo'] as String?,
      awayTeamId: json['awayTeamId'] as String?,
      awayTeamName: json['awayTeamName'] as String?,
      awayTeamShortName: json['awayTeamShortName'] as String?,
      awayTeamLogo: json['awayTeamLogo'] as String?,
      homeScore: (json['homeScore'] as num?)?.toInt(),
      awayScore: (json['awayScore'] as num?)?.toInt(),
      homeExtraTimeScore: (json['homeExtraTimeScore'] as num?)?.toInt(),
      awayExtraTimeScore: (json['awayExtraTimeScore'] as num?)?.toInt(),
      homePenaltyScore: (json['homePenaltyScore'] as num?)?.toInt(),
      awayPenaltyScore: (json['awayPenaltyScore'] as num?)?.toInt(),
      winnerId: json['winnerId'] as String?,
      winnerName: json['winnerName'] as String?,
      status: json['status'] as String?,
      scoreStatus: json['scoreStatus'] as String?,
      acceptStatus: json['acceptStatus'] as String?,
      gameSemiType: json['gameSemiType'] as String?,
      matchDate: json['matchDate'] as String?,
      matchTime: json['matchTime'] as String?,
      matchName: json['matchName'] as String?,
      matchDateMs: (json['matchDateMs'] as num?)?.toInt() ?? 0,
      venue: json['venue'] as String?,
      city: json['city'] as String?,
      fieldName: json['fieldName'] as String?,
      gameType: json['gameType'] as String?,
      ageGroup: json['ageGroup'] as String?,
      level: json['level'] as String?,
      seq: json['seq'] as String?,
    );

Map<String, dynamic> _$$CupMatchModelImplToJson(_$CupMatchModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'tournamentId': instance.tournamentId,
      'roundId': instance.roundId,
      'homeTeamId': instance.homeTeamId,
      'homeTeamName': instance.homeTeamName,
      'homeTeamShortName': instance.homeTeamShortName,
      'homeTeamLogo': instance.homeTeamLogo,
      'awayTeamId': instance.awayTeamId,
      'awayTeamName': instance.awayTeamName,
      'awayTeamShortName': instance.awayTeamShortName,
      'awayTeamLogo': instance.awayTeamLogo,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'homeExtraTimeScore': instance.homeExtraTimeScore,
      'awayExtraTimeScore': instance.awayExtraTimeScore,
      'homePenaltyScore': instance.homePenaltyScore,
      'awayPenaltyScore': instance.awayPenaltyScore,
      'winnerId': instance.winnerId,
      'winnerName': instance.winnerName,
      'status': instance.status,
      'scoreStatus': instance.scoreStatus,
      'acceptStatus': instance.acceptStatus,
      'gameSemiType': instance.gameSemiType,
      'matchDate': instance.matchDate,
      'matchTime': instance.matchTime,
      'matchName': instance.matchName,
      'matchDateMs': instance.matchDateMs,
      'venue': instance.venue,
      'city': instance.city,
      'fieldName': instance.fieldName,
      'gameType': instance.gameType,
      'ageGroup': instance.ageGroup,
      'level': instance.level,
      'seq': instance.seq,
    };

_$CupGroupPointTableEntryImpl _$$CupGroupPointTableEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$CupGroupPointTableEntryImpl(
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
      groupId: json['groupId'] as String?,
      roundId: json['roundId'] as String?,
    );

Map<String, dynamic> _$$CupGroupPointTableEntryImplToJson(
        _$CupGroupPointTableEntryImpl instance) =>
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
      'groupId': instance.groupId,
      'roundId': instance.roundId,
    };

_$CupBannerModelImpl _$$CupBannerModelImplFromJson(Map<String, dynamic> json) =>
    _$CupBannerModelImpl(
      imageUrl: json['imageUrl'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$$CupBannerModelImplToJson(
        _$CupBannerModelImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'seq': instance.seq,
      'link': instance.link,
    };

_$CupTeamModelImpl _$$CupTeamModelImplFromJson(Map<String, dynamic> json) =>
    _$CupTeamModelImpl(
      id: json['_id'] as String?,
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      logo: json['logo'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$CupTeamModelImplToJson(_$CupTeamModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'logo': instance.logo,
      'country': instance.country,
    };

_$CupSponsorModelImpl _$$CupSponsorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CupSponsorModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$$CupSponsorModelImplToJson(
        _$CupSponsorModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'website': instance.website,
    };

_$CupPlayerStatEntryImpl _$$CupPlayerStatEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$CupPlayerStatEntryImpl(
      userId: json['userId'] as String?,
      playerName: json['playerName'] as String?,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String?,
      teamName: json['teamName'] as String?,
      count: (json['count'] as num?)?.toInt() ?? 0,
      yellowCards: (json['yellowCards'] as num?)?.toInt() ?? 0,
      redCards: (json['redCards'] as num?)?.toInt() ?? 0,
      roundId: json['roundId'] as String?,
      groupId: json['groupId'] as String?,
    );

Map<String, dynamic> _$$CupPlayerStatEntryImplToJson(
        _$CupPlayerStatEntryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'count': instance.count,
      'yellowCards': instance.yellowCards,
      'redCards': instance.redCards,
      'roundId': instance.roundId,
      'groupId': instance.groupId,
    };
