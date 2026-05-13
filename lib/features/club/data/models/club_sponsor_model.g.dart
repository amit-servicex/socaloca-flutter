// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_sponsor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubSponsorModelImpl _$$ClubSponsorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubSponsorModelImpl(
      sponsorId: json['sponsorId'] as String,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      seq: (json['seq'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ClubSponsorModelImplToJson(
        _$ClubSponsorModelImpl instance) =>
    <String, dynamic>{
      'sponsorId': instance.sponsorId,
      'name': instance.name,
      'logo': instance.logo,
      'seq': instance.seq,
    };
