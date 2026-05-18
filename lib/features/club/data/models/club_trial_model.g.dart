// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_trial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubTrialModelImpl _$$ClubTrialModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubTrialModelImpl(
      id: json['_id'] as String?,
      trialId: json['trialId'] as String?,
      clubId: json['clubId'] as String?,
      faId: json['faId'] as String?,
      trialType: json['trialType'] as String?,
      trialName: json['trialName'] as String?,
      registerDateFrom: json['registerDateFrom'] as String?,
      registerDateTo: json['registerDateTo'] as String?,
      registerDateFromGmt: json['registerDateFromGmt'] == null
          ? 0
          : _readInt(json['registerDateFromGmt']),
      registerDateToGmt: json['registerDateToGmt'] == null
          ? 0
          : _readInt(json['registerDateToGmt']),
      trialDateFrom: json['trialDateFrom'] as String?,
      trialDateTo: json['trialDateTo'] as String?,
      trialDateFromGmt: json['trialDateFromGmt'] == null
          ? 0
          : _readInt(json['trialDateFromGmt']),
      trialDateToGmt:
          json['trialDateToGmt'] == null ? 0 : _readInt(json['trialDateToGmt']),
      currency: json['currency'] as String?,
      gender: json['gender'] as String?,
      brief: json['brief'] as String?,
      location: json['location'] as String?,
      trialVenue: json['trialVenue'] as String?,
      ageFrom: json['ageFrom'] == null ? 0 : _readInt(json['ageFrom']),
      ageTo: json['ageTo'] == null ? 0 : _readInt(json['ageTo']),
      lat: json['lat'] == null ? 0 : _readDouble(json['lat']),
      lng: json['lng'] == null ? 0 : _readDouble(json['lng']),
      cost: json['cost'] == null ? 0 : _readInt(json['cost']),
      isDelete: json['isDelete'] as bool? ?? false,
      active: json['active'] as bool? ?? false,
      clubDetails: json['clubDetails'] == null
          ? null
          : ClubTrialOrgModel.fromJson(
              json['clubDetails'] as Map<String, dynamic>),
      academyDetails: json['academyDetails'] == null
          ? null
          : ClubTrialOrgModel.fromJson(
              json['academyDetails'] as Map<String, dynamic>),
      trialStatus: json['trialStatus'] == null
          ? null
          : ClubTrialStatusModel.fromJson(
              json['trialStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClubTrialModelImplToJson(
        _$ClubTrialModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'trialId': instance.trialId,
      'clubId': instance.clubId,
      'faId': instance.faId,
      'trialType': instance.trialType,
      'trialName': instance.trialName,
      'registerDateFrom': instance.registerDateFrom,
      'registerDateTo': instance.registerDateTo,
      'registerDateFromGmt': instance.registerDateFromGmt,
      'registerDateToGmt': instance.registerDateToGmt,
      'trialDateFrom': instance.trialDateFrom,
      'trialDateTo': instance.trialDateTo,
      'trialDateFromGmt': instance.trialDateFromGmt,
      'trialDateToGmt': instance.trialDateToGmt,
      'currency': instance.currency,
      'gender': instance.gender,
      'brief': instance.brief,
      'location': instance.location,
      'trialVenue': instance.trialVenue,
      'ageFrom': instance.ageFrom,
      'ageTo': instance.ageTo,
      'lat': instance.lat,
      'lng': instance.lng,
      'cost': instance.cost,
      'isDelete': instance.isDelete,
      'active': instance.active,
      'clubDetails': instance.clubDetails,
      'academyDetails': instance.academyDetails,
      'trialStatus': instance.trialStatus,
    };

_$ClubTrialOrgModelImpl _$$ClubTrialOrgModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubTrialOrgModelImpl(
      id: json['_id'] as String?,
      clubId: json['clubId'] as String?,
      academyId: json['academyId'] as String?,
      clubName: json['clubName'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$ClubTrialOrgModelImplToJson(
        _$ClubTrialOrgModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clubId': instance.clubId,
      'academyId': instance.academyId,
      'clubName': instance.clubName,
      'name': instance.name,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
    };

_$ClubTrialStatusModelImpl _$$ClubTrialStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubTrialStatusModelImpl(
      expire: json['expire'] as bool? ?? false,
      canRegister: json['canRegister'] as bool? ?? false,
      live: json['live'] as bool? ?? false,
      registered: json['registered'] as bool? ?? false,
    );

Map<String, dynamic> _$$ClubTrialStatusModelImplToJson(
        _$ClubTrialStatusModelImpl instance) =>
    <String, dynamic>{
      'expire': instance.expire,
      'canRegister': instance.canRegister,
      'live': instance.live,
      'registered': instance.registered,
    };
