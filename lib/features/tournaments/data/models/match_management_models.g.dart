// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_management_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchScoreModelImpl _$$MatchScoreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchScoreModelImpl(
      matchId: json['matchId'] as String,
      homeScore: (json['homeScore'] as num).toInt(),
      awayScore: (json['awayScore'] as num).toInt(),
      homeExtraTimeScore: (json['homeExtraTimeScore'] as num?)?.toInt(),
      awayExtraTimeScore: (json['awayExtraTimeScore'] as num?)?.toInt(),
      homePenaltyScore: (json['homePenaltyScore'] as num?)?.toInt(),
      awayPenaltyScore: (json['awayPenaltyScore'] as num?)?.toInt(),
      winnerId: json['winnerId'] as String?,
      status: json['status'] as String?,
      submittedBy: json['submittedBy'] as String?,
      submittedOn: (json['submittedOn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchScoreModelImplToJson(
        _$MatchScoreModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'homeExtraTimeScore': instance.homeExtraTimeScore,
      'awayExtraTimeScore': instance.awayExtraTimeScore,
      'homePenaltyScore': instance.homePenaltyScore,
      'awayPenaltyScore': instance.awayPenaltyScore,
      'winnerId': instance.winnerId,
      'status': instance.status,
      'submittedBy': instance.submittedBy,
      'submittedOn': instance.submittedOn,
    };

_$MatchGoalModelImpl _$$MatchGoalModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchGoalModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      minute: (json['minute'] as num).toInt(),
      isOwnGoal: json['isOwnGoal'] as bool? ?? false,
      isPenalty: json['isPenalty'] as bool? ?? false,
      assistPlayerId: json['assistPlayerId'] as String?,
      assistPlayerName: json['assistPlayerName'] as String?,
    );

Map<String, dynamic> _$$MatchGoalModelImplToJson(
        _$MatchGoalModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'minute': instance.minute,
      'isOwnGoal': instance.isOwnGoal,
      'isPenalty': instance.isPenalty,
      'assistPlayerId': instance.assistPlayerId,
      'assistPlayerName': instance.assistPlayerName,
    };

_$MatchCardModelImpl _$$MatchCardModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchCardModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      cardType: json['cardType'] as String,
      minute: (json['minute'] as num).toInt(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$MatchCardModelImplToJson(
        _$MatchCardModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'cardType': instance.cardType,
      'minute': instance.minute,
      'reason': instance.reason,
    };

_$MatchMVPModelImpl _$$MatchMVPModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchMVPModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      selectedBy: json['selectedBy'] as String?,
      selectedOn: (json['selectedOn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchMVPModelImplToJson(_$MatchMVPModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'selectedBy': instance.selectedBy,
      'selectedOn': instance.selectedOn,
    };

_$MatchPlayerModelImpl _$$MatchPlayerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchPlayerModelImpl(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String,
      position: json['position'] as String?,
      jerseyNumber: json['jerseyNumber'] as String?,
      isStarting: json['isStarting'] as bool? ?? false,
      isPlaying: json['isPlaying'] as bool? ?? false,
      minuteIn: (json['minuteIn'] as num?)?.toInt(),
      minuteOut: (json['minuteOut'] as num?)?.toInt(),
      replacedPlayerId: json['replacedPlayerId'] as String?,
    );

Map<String, dynamic> _$$MatchPlayerModelImplToJson(
        _$MatchPlayerModelImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'position': instance.position,
      'jerseyNumber': instance.jerseyNumber,
      'isStarting': instance.isStarting,
      'isPlaying': instance.isPlaying,
      'minuteIn': instance.minuteIn,
      'minuteOut': instance.minuteOut,
      'replacedPlayerId': instance.replacedPlayerId,
    };

_$MatchSquadModelImpl _$$MatchSquadModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchSquadModelImpl(
      matchId: json['matchId'] as String,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      startingXI: (json['startingXI'] as List<dynamic>?)
              ?.map((e) => MatchPlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      substitutes: (json['substitutes'] as List<dynamic>?)
              ?.map((e) => MatchPlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MatchSquadModelImplToJson(
        _$MatchSquadModelImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'startingXI': instance.startingXI,
      'substitutes': instance.substitutes,
    };

_$MatchDetailsModelImpl _$$MatchDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchDetailsModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      tournamentName: json['tournamentName'] as String?,
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
      scoreData: json['scoreData'] == null
          ? null
          : MatchScoreModel.fromJson(json['scoreData'] as Map<String, dynamic>),
      goals: (json['goals'] as List<dynamic>?)
              ?.map((e) => MatchGoalModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cards: (json['cards'] as List<dynamic>?)
              ?.map((e) => MatchCardModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      mvp: json['mvp'] == null
          ? null
          : MatchMVPModel.fromJson(json['mvp'] as Map<String, dynamic>),
      homeSquad: json['homeSquad'] == null
          ? null
          : MatchSquadModel.fromJson(json['homeSquad'] as Map<String, dynamic>),
      awaySquad: json['awaySquad'] == null
          ? null
          : MatchSquadModel.fromJson(json['awaySquad'] as Map<String, dynamic>),
      canManage: json['canManage'] as bool? ?? false,
      canEditScore: json['canEditScore'] as bool? ?? false,
      canAcceptScore: json['canAcceptScore'] as bool? ?? false,
    );

Map<String, dynamic> _$$MatchDetailsModelImplToJson(
        _$MatchDetailsModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'tournamentId': instance.tournamentId,
      'tournamentName': instance.tournamentName,
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
      'scoreData': instance.scoreData,
      'goals': instance.goals,
      'cards': instance.cards,
      'mvp': instance.mvp,
      'homeSquad': instance.homeSquad,
      'awaySquad': instance.awaySquad,
      'canManage': instance.canManage,
      'canEditScore': instance.canEditScore,
      'canAcceptScore': instance.canAcceptScore,
    };

_$MatchPhotoModelImpl _$$MatchPhotoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchPhotoModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String?,
      uploadedBy: json['uploadedBy'] as String?,
      uploadedOn: (json['uploadedOn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchPhotoModelImplToJson(
        _$MatchPhotoModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'uploadedBy': instance.uploadedBy,
      'uploadedOn': instance.uploadedOn,
    };

_$MatchVideoModelImpl _$$MatchVideoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchVideoModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      uploadedBy: json['uploadedBy'] as String?,
      uploadedOn: (json['uploadedOn'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MatchVideoModelImplToJson(
        _$MatchVideoModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'title': instance.title,
      'description': instance.description,
      'uploadedBy': instance.uploadedBy,
      'uploadedOn': instance.uploadedOn,
      'duration': instance.duration,
    };

_$MatchRatingModelImpl _$$MatchRatingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchRatingModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      playerImage: json['playerImage'] as String?,
      teamId: json['teamId'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratedBy: json['ratedBy'] as String?,
      ratedOn: (json['ratedOn'] as num?)?.toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$MatchRatingModelImplToJson(
        _$MatchRatingModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerImage': instance.playerImage,
      'teamId': instance.teamId,
      'rating': instance.rating,
      'ratedBy': instance.ratedBy,
      'ratedOn': instance.ratedOn,
      'comment': instance.comment,
    };

_$SubstitutionModelImpl _$$SubstitutionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubstitutionModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String,
      teamId: json['teamId'] as String,
      playerInId: json['playerInId'] as String,
      playerInName: json['playerInName'] as String,
      playerOutId: json['playerOutId'] as String,
      playerOutName: json['playerOutName'] as String,
      minute: (json['minute'] as num).toInt(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$SubstitutionModelImplToJson(
        _$SubstitutionModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'teamId': instance.teamId,
      'playerInId': instance.playerInId,
      'playerInName': instance.playerInName,
      'playerOutId': instance.playerOutId,
      'playerOutName': instance.playerOutName,
      'minute': instance.minute,
      'reason': instance.reason,
    };
