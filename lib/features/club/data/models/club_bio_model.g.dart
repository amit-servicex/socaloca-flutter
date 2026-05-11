// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_bio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubBioModelImpl _$$ClubBioModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubBioModelImpl(
      clubDetails:
          ClubModel.fromJson(json['clubDetails'] as Map<String, dynamic>),
      trialDetails: json['trialDetails'] == null
          ? null
          : ClubTrialStatusModel.fromJson(
              json['trialDetails'] as Map<String, dynamic>),
      newsList: (json['newsList'] as List<dynamic>?)
              ?.map((e) => ClubNewsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      matchList: (json['matchList'] as List<dynamic>?)
              ?.map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      playerList: (json['playerList'] as List<dynamic>?)
              ?.map((e) => ClubPlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      teamList: (json['teamList'] as List<dynamic>?)
              ?.map((e) => ClubTeamModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sponsorList: (json['sponsorList'] as List<dynamic>?)
              ?.map((e) => ClubSponsorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClubBioModelImplToJson(_$ClubBioModelImpl instance) =>
    <String, dynamic>{
      'clubDetails': instance.clubDetails,
      'trialDetails': instance.trialDetails,
      'newsList': instance.newsList,
      'matchList': instance.matchList,
      'playerList': instance.playerList,
      'teamList': instance.teamList,
      'sponsorList': instance.sponsorList,
    };

_$ClubTrialStatusModelImpl _$$ClubTrialStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubTrialStatusModelImpl(
      trialBadge: json['trialBadge'] as bool? ?? false,
      isRegisterBtn: json['isRegisterBtn'] as bool? ?? false,
      isRegistered: json['isRegistered'] as bool? ?? false,
      isRegistrationClosed: json['isRegistrationClosed'] as bool? ?? false,
    );

Map<String, dynamic> _$$ClubTrialStatusModelImplToJson(
        _$ClubTrialStatusModelImpl instance) =>
    <String, dynamic>{
      'trialBadge': instance.trialBadge,
      'isRegisterBtn': instance.isRegisterBtn,
      'isRegistered': instance.isRegistered,
      'isRegistrationClosed': instance.isRegistrationClosed,
    };
