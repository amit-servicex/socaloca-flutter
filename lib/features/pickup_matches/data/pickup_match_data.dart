/// Pickup match data model mapped directly from API response fields.
/// Mirrors PickUpMatch.java + PickUpRequest.java from the legacy Android app.
class PickupMatchData {
  final String matchId;
  final String createdBy;
  final String ageGroup;
  final String gender;
  final String matchDate;
  final String startTime;
  final String endTime;
  final String venue;
  final String country;
  final String locationName;
  final double locationLat;
  final double locationLng;
  final int maxPlayers;
  final String? matchNote;
  final int startTimeGmt;
  final int endTimeGmt;
  final PickupCreatorData? creatorDetails;
  final PickupRequestData? myRequest;

  const PickupMatchData({
    required this.matchId,
    required this.createdBy,
    required this.ageGroup,
    required this.gender,
    required this.matchDate,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.country,
    required this.locationName,
    required this.locationLat,
    required this.locationLng,
    required this.maxPlayers,
    this.matchNote,
    required this.startTimeGmt,
    required this.endTimeGmt,
    this.creatorDetails,
    this.myRequest,
  });

  factory PickupMatchData.fromJson(Map<String, dynamic> json) {
    final creator = json['creatorDetails'] as Map<String, dynamic>?;
    final request = json['myRequest'] as Map<String, dynamic>?;

    return PickupMatchData(
      matchId: json['matchId'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      ageGroup: json['ageGroup'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      matchDate: json['matchDate'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      venue: json['venue'] as String? ?? '',
      country: json['country'] as String? ?? '',
      locationName: json['locationName'] as String? ?? '',
      locationLat: (json['locationLat'] as num?)?.toDouble() ?? 0.0,
      locationLng: (json['locationLng'] as num?)?.toDouble() ?? 0.0,
      maxPlayers: (json['maxPlayers'] as num?)?.toInt() ?? 0,
      matchNote: json['matchNote'] as String?,
      startTimeGmt: (json['startTimeGmt'] as num?)?.toInt() ?? 0,
      endTimeGmt: (json['endTimeGmt'] as num?)?.toInt() ?? 0,
      creatorDetails:
          creator != null ? PickupCreatorData.fromJson(creator) : null,
      myRequest: request != null ? PickupRequestData.fromJson(request) : null,
    );
  }
}

class PickupCreatorData {
  final String userId;
  final String name;
  final String? imageUrl;
  final bool isPlayer;
  final bool isCoach;
  final bool isAdmin;
  final bool isFan;

  const PickupCreatorData({
    required this.userId,
    required this.name,
    this.imageUrl,
    required this.isPlayer,
    required this.isCoach,
    required this.isAdmin,
    required this.isFan,
  });

  factory PickupCreatorData.fromJson(Map<String, dynamic> json) {
    return PickupCreatorData(
      userId: json['userId'] as String? ?? json['_id'] as String? ?? '',
      name: json['name'] as String? ?? json['fullName'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      isPlayer: json['isPlayer'] as bool? ?? false,
      isCoach: json['isCoach'] as bool? ?? false,
      isAdmin: json['isAdmin'] as bool? ?? false,
      isFan: json['isFan'] as bool? ?? false,
    );
  }
}

class PickupRequestData {
  final String requestId;
  final String userId;
  final String matchId;
  final String status; // REQUEST_WAITING, REQUEST_ACCEPTED, REQUEST_DECLINED

  const PickupRequestData({
    required this.requestId,
    required this.userId,
    required this.matchId,
    required this.status,
  });

  factory PickupRequestData.fromJson(Map<String, dynamic> json) {
    return PickupRequestData(
      requestId: json['requestId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      matchId: json['matchId'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }

  bool get isAccepted => status == 'REQUEST_ACCEPTED';
  bool get isDeclined => status == 'REQUEST_DECLINED';
  bool get isWaiting => status == 'REQUEST_WAITING';
}
