// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupMatchModelImpl _$$PickupMatchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PickupMatchModelImpl(
      id: json['id'] as String,
      hostId: json['hostId'] as String,
      hostName: json['hostName'] as String,
      hostImage: json['hostImage'] as String?,
      title: json['title'] as String,
      venue: json['venue'] as String?,
      matchDate: json['matchDate'] as String?,
      matchTime: json['matchTime'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      totalSlots: (json['totalSlots'] as num?)?.toInt() ?? 0,
      filledSlots: (json['filledSlots'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'open',
      hasRequested: json['hasRequested'] as bool? ?? false,
      isAccepted: json['isAccepted'] as bool? ?? false,
      description: json['description'] as String?,
      ageGroup: json['ageGroup'] as String?,
      skillLevel: json['skillLevel'] as String?,
    );

Map<String, dynamic> _$$PickupMatchModelImplToJson(
        _$PickupMatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostId': instance.hostId,
      'hostName': instance.hostName,
      'hostImage': instance.hostImage,
      'title': instance.title,
      'venue': instance.venue,
      'matchDate': instance.matchDate,
      'matchTime': instance.matchTime,
      'country': instance.country,
      'city': instance.city,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'totalSlots': instance.totalSlots,
      'filledSlots': instance.filledSlots,
      'status': instance.status,
      'hasRequested': instance.hasRequested,
      'isAccepted': instance.isAccepted,
      'description': instance.description,
      'ageGroup': instance.ageGroup,
      'skillLevel': instance.skillLevel,
    };
