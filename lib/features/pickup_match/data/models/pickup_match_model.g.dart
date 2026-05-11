// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupMatchModelImpl _$$PickupMatchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PickupMatchModelImpl(
      id: json['_id'] as String?,
      matchId: json['matchId'] as String?,
      createdBy: json['createdBy'] as String?,
      createdByName: json['createdByName'] as String?,
      createdByImage: json['createdByImage'] as String?,
      gameType: json['gameType'] as String?,
      gender: json['gender'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      venueName: json['venueName'] as String?,
      locationName: json['locationName'] as String?,
      locationLat: (json['locationLat'] as num?)?.toDouble() ?? 0.0,
      locationLng: (json['locationLng'] as num?)?.toDouble() ?? 0.0,
      matchDate: json['matchDate'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      startTimeGmt: (json['startTimeGmt'] as num?)?.toInt() ?? 0,
      endTimeGmt: (json['endTimeGmt'] as num?)?.toInt() ?? 0,
      avgAge: json['avgAge'] as String?,
      maxPlayer: (json['maxPlayer'] as num?)?.toInt() ?? 0,
      matchNote: json['matchNote'] as String?,
      isDelete: json['isDelete'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
      createdOn: (json['createdOn'] as num?)?.toInt() ?? 0,
      requestCount: (json['requestCount'] as num?)?.toInt() ?? 0,
      acceptedCount: (json['acceptedCount'] as num?)?.toInt() ?? 0,
      isRequested: json['isRequested'] as bool? ?? false,
      isAccepted: json['isAccepted'] as bool? ?? false,
      isRejected: json['isRejected'] as bool? ?? false,
      isCancelled: json['isCancelled'] as bool? ?? false,
      requestStatus: json['requestStatus'] as String?,
    );

Map<String, dynamic> _$$PickupMatchModelImplToJson(
        _$PickupMatchModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchId': instance.matchId,
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'createdByImage': instance.createdByImage,
      'gameType': instance.gameType,
      'gender': instance.gender,
      'country': instance.country,
      'city': instance.city,
      'venueName': instance.venueName,
      'locationName': instance.locationName,
      'locationLat': instance.locationLat,
      'locationLng': instance.locationLng,
      'matchDate': instance.matchDate,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimeGmt': instance.startTimeGmt,
      'endTimeGmt': instance.endTimeGmt,
      'avgAge': instance.avgAge,
      'maxPlayer': instance.maxPlayer,
      'matchNote': instance.matchNote,
      'isDelete': instance.isDelete,
      'active': instance.active,
      'createdOn': instance.createdOn,
      'requestCount': instance.requestCount,
      'acceptedCount': instance.acceptedCount,
      'isRequested': instance.isRequested,
      'isAccepted': instance.isAccepted,
      'isRejected': instance.isRejected,
      'isCancelled': instance.isCancelled,
      'requestStatus': instance.requestStatus,
    };
