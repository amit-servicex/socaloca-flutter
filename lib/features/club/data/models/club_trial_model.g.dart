// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_trial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubTrialModelImpl _$$ClubTrialModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubTrialModelImpl(
      trialId: json['trialId'] as String?,
      clubName: json['clubName'] as String?,
      location: json['location'] as String?,
      ageGroup: json['ageGroup'] as String?,
      startDate: json['startDate'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$ClubTrialModelImplToJson(
        _$ClubTrialModelImpl instance) =>
    <String, dynamic>{
      'trialId': instance.trialId,
      'clubName': instance.clubName,
      'location': instance.location,
      'ageGroup': instance.ageGroup,
      'startDate': instance.startDate,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
