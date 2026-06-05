import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';

// ── Models ────────────────────────────────────────────────────────────────────

class TeamJoinRequestModel {
  final String? playerId;
  final String? name;
  final String? imageUrl;
  final String? country;
  final String? gender;
  final bool isPlayer;
  final bool isCoach;
  final bool isAdmin;

  const TeamJoinRequestModel({
    this.playerId,
    this.name,
    this.imageUrl,
    this.country,
    this.gender,
    this.isPlayer = false,
    this.isCoach = false,
    this.isAdmin = false,
  });

  factory TeamJoinRequestModel.fromJson(Map<String, dynamic> json) {
    return TeamJoinRequestModel(
      playerId: json['playerId'] as String? ?? json['userId'] as String?,
      name: json['myName'] as String? ??
          json['name'] as String? ??
          '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      imageUrl: json['myImageUrl'] as String? ?? json['imageUrl'] as String?,
      country: json['country'] as String?,
      gender: json['gender'] as String?,
      isPlayer: _readBool(json['isPlayer']),
      isCoach: _readBool(json['isCoach']),
      isAdmin: _readBool(json['isAdmin']),
    );
  }

  static bool _readBool(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    return false;
  }
}

class TeamMemberModel {
  final String? userId;
  final String? playerId;
  final String? name;
  final String? imageUrl;
  final String? jerseyNo;
  final String? type;
  final bool isPlayer;
  final bool isAdmin;
  final bool isCoach;
  final bool isManager;
  final bool isUserCoach;
  final bool isUserManager;
  final String? playPositionType;
  final String? yearOfBirth;
  final String? dob;

  const TeamMemberModel({
    this.userId,
    this.playerId,
    this.name,
    this.imageUrl,
    this.jerseyNo,
    this.type,
    this.isPlayer = false,
    this.isAdmin = false,
    this.isCoach = false,
    this.isManager = false,
    this.isUserCoach = false,
    this.isUserManager = false,
    this.playPositionType,
    this.yearOfBirth,
    this.dob,
  });

  String get effectiveId => playerId ?? userId ?? '';

  String get roleLabel {
    if (isCoach) return 'Coach';
    if (isManager) return 'Manager';
    if (isAdmin) return 'Admin';
    return '';
  }

  String get ageString {
    int birthYear = 0;
    try {
      if (dob == null || dob!.isEmpty) {
        if (yearOfBirth != null && yearOfBirth!.isNotEmpty) {
          birthYear = int.parse(yearOfBirth!);
        }
      } else {
        final split = dob!.split('-');
        if (split.length == 3) {
          birthYear = int.parse(split[2]);
        }
      }
    } catch (_) {}

    if (birthYear > 1900) {
      final currentYear = DateTime.now().year;
      final age = currentYear - birthYear;
      return '$age years';
    }
    return '';
  }

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName'] as String? ?? '';
    final lastName = json['lastName'] as String? ?? '';
    final fullName = json['myName'] as String? ??
        json['name'] as String? ??
        '$firstName $lastName'.trim();
    return TeamMemberModel(
      userId: json['userId'] as String? ?? json['playerId'] as String?,
      playerId: json['playerId'] as String? ?? json['userId'] as String?,
      name: fullName.isNotEmpty ? fullName : null,
      imageUrl: json['myImageUrl'] as String? ?? json['imageUrl'] as String?,
      jerseyNo: json['teamJerseyNo'] as String?,
      type: json['type'] as String?,
      isPlayer: _readBool(json['isPlayer']),
      isAdmin: _readBool(json['isAdmin']),
      isCoach: _readBool(json['teamCoach']) ||
          _readBool(json['isTeamCoach']) ||
          json['teamJerseyNo'] == 'coach',
      isManager: _readBool(json['teamManager']) ||
          _readBool(json['isTeamManager']) ||
          json['teamJerseyNo'] == 'manager',
      isUserCoach: _readBool(json['isCoach']),
      isUserManager: _readBool(json['isManager']),
      playPositionType: json['playPositionType'] as String?,
      yearOfBirth: json['yearOfBirth']?.toString(),
      dob: json['dob'] as String?,
    );
  }

  static bool _readBool(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    return false;
  }
}

// ── Add-player models ─────────────────────────────────────────────────────────

class PlayerSearchResult {
  final String? userId;
  final String? name;
  final String? imageUrl;
  final String? country;
  final bool invited; // already invited to this team

  const PlayerSearchResult({
    this.userId,
    this.name,
    this.imageUrl,
    this.country,
    this.invited = false,
  });

  PlayerSearchResult copyWith({bool? invited}) => PlayerSearchResult(
        userId: userId,
        name: name,
        imageUrl: imageUrl,
        country: country,
        invited: invited ?? this.invited,
      );

  factory PlayerSearchResult.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName'] as String? ?? '';
    final lastName = json['lastName'] as String? ?? '';
    return PlayerSearchResult(
      userId: json['userId'] as String? ?? json['_id'] as String?,
      name: json['profileName'] as String? ?? '$firstName $lastName'.trim(),
      imageUrl: json['imageUrl'] as String?,
      country: json['country'] as String?,
      invited: _readBool(json['inviteStatus']) || _readBool(json['isInvited']),
    );
  }

  static bool _readBool(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    return false;
  }
}

// ── Repository ────────────────────────────────────────────────────────────────

class TeamManageRepository {
  final String teamId;
  const TeamManageRepository({required this.teamId});

  String get _userId => StorageService.userId ?? '';

  Map<String, dynamic> _unwrap(Map<String, dynamic> response) {
    final r = response['response'];
    return r is Map ? Map<String, dynamic>.from(r) : response;
  }

  // ── Edit Team ──────────────────────────────────────────────────────────────

  Future<void> editTeam({
    required String teamName,
    required String teamShortName,
    required String city,
    required String ageGroup,
    required String ageCat,
    required String gameType,
    required String imageUrl,
    File? imageFile,
  }) async {
    final currentUser = StorageService.currentUser ?? {};
    final firstName = currentUser['firstName'] as String? ?? '';
    final lastName = currentUser['lastName'] as String? ?? '';
    final myName = '$firstName $lastName'.trim();

    String finalImageUrl = imageUrl;
    if (imageFile != null) {
      final formData = FormData.fromMap({
        'metadata': '',
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: DioMediaType('application', 'octet-stream'),
        ),
      });
      final uploadResp = await ApiClient.instance.uploadFile(
        ApiConstants.uploadImage,
        formData: formData,
      );
      final uploadedUrl = uploadResp['response']?['image'] as String? ?? '';
      if (uploadedUrl.isNotEmpty) {
        finalImageUrl = uploadedUrl;
        log('✅ Team image uploaded: $finalImageUrl');
      } else {
        log('⚠️ Image upload returned no URL — keeping existing image');
      }
    }

    final response = await ApiClient.instance.post(
      ApiConstants.editTeam,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'myName': myName,
        'teamName': teamName,
        'teamShortName': teamShortName,
        'imageUrl': finalImageUrl,
        'city': city,
        'ageGroup': ageGroup,
        'ageCat': ageCat,
        'gameType': gameType,
      },
    );

    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception('Failed to update team info');
  }

  // ── Join Requests ──────────────────────────────────────────────────────────

  Future<List<TeamJoinRequestModel>> getJoinRequests() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getTeamJoinRequests,
      body: {'userId': _userId, 'teamId': teamId},
    );
    final data = _unwrap(response);
    if (data['status'] != 1) return [];
    final raw = data['requests'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((m) => TeamJoinRequestModel.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> respondJoinRequest({
    required String playerId,
    required bool accept,
    required String teamName,
    required String teamImageUrl,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.respondTeamJoinRequest,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'playerId': playerId,
        'accept': accept,
        'teamName': teamName,
        'teamImageUrl': teamImageUrl,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception(
        accept ? 'Failed to accept request' : 'Failed to reject request');
  }

  // ── New Players (unassigned jerseys) ───────────────────────────────────────

  Future<List<TeamMemberModel>> getNewPlayers() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getNewTeamPlayers,
      body: {'userId': _userId, 'teamId': teamId},
    );
    final data = _unwrap(response);
    if (data['status'] != 1) return [];
    final raw = data['players'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((m) => TeamMemberModel.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> assignJerseys(List<Map<String, String>> playerJerseys) async {
    final response = await ApiClient.instance.post(
      ApiConstants.assignTeamPlayers,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'players': playerJerseys,
      },
    );
    final data = _unwrap(response);
    if ((data['result'] as num?)?.toInt() == 1) return;
    if (_readBool(data['success'])) return;
    throw Exception('Failed to assign jerseys');
  }

  // ── Assigned Players (jersey management) ───────────────────────────────────

  Future<List<TeamMemberModel>> getAssignedPlayers() async {
    final response = await ApiClient.instance.post(
      ApiConstants.getAssignTeamPlayers,
      body: {'userId': _userId, 'teamId': teamId},
    );
    final data = _unwrap(response);
    if (data['status'] != 1) return [];
    final raw = data['players'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((m) => TeamMemberModel.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> editJersey({
    required String playerId,
    required String newJerseyNo,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.editTeamPlayerJersey,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'playerId': playerId,
        'newJerseyNo': newJerseyNo,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception('Failed to update jersey number');
  }

  Future<void> removePlayer({required String playerId}) async {
    final response = await ApiClient.instance.post(
      ApiConstants.removeTeamPlayer,
      body: {'userId': _userId, 'teamId': teamId, 'playerId': playerId},
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception('Failed to remove player');
  }

  Future<void> toggleAdmin({
    required String playerId,
    required bool makeAdmin,
  }) async {
    final endpoint =
        makeAdmin ? ApiConstants.assignTeamAdmin : ApiConstants.removeTeamAdmin;
    final response = await ApiClient.instance.post(
      endpoint,
      body: {'userId': _userId, 'teamId': teamId, 'playerId': playerId},
    );
    final data = _unwrap(response);
    if (data['status'] == 1) return;
    throw Exception(
        makeAdmin ? 'Failed to assign admin' : 'Failed to remove admin');
  }

  Future<void> assignCoachManager({
    required String playerId,
    required bool isCoach,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.promCoachManager,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'toUserId': playerId,
        'isCoach': isCoach,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception(
      isCoach ? 'Failed to assign team coach' : 'Failed to assign team manager',
    );
  }

  Future<bool> requestPlayerTransfer({
    required String playerId,
    required String mobile,
    required String countryCode,
    required String countryIso,
    required String country,
    required String password,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.reqPlayerTransfer,
      body: {
        'adminId': _userId,
        'playerId': playerId,
        'mobile': mobile,
        'countryCode': countryCode,
        'countryIso': countryIso,
        'country': country,
        'pwd': password,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && data.containsKey('duplicate')) {
      return _readBool(data['duplicate']);
    }
    throw Exception('Failed to request account transfer');
  }

  Future<void> verifyPlayerTransfer({
    required String playerId,
    required int otp,
  }) async {
    final response = await ApiClient.instance.post(
      ApiConstants.verifyPlayerTransfer,
      body: {
        'adminId': _userId,
        'playerId': playerId,
        'otp': otp,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception('Invalid OTP');
  }

  // ── Add Player ───────────────────────────────────────────────────────────────

  Future<List<PlayerSearchResult>> searchPlayersForTeam({
    required String searchTerm,
    int start = 0,
    int limit = 10,
  }) async {
    final currentUser = StorageService.currentUser ?? {};
    final response = await ApiClient.instance.post(
      ApiConstants.searchPlayerForTeam,
      body: {
        'teamId': teamId,
        'userId': _userId,
        'searchTerm': searchTerm,
        'country': currentUser['country']?.toString() ?? '',
        'start': start,
        'limit': limit,
      },
    );
    final data = _unwrap(response);
    if (data['status'] != 1) return [];
    final raw = data['players'];
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((m) => PlayerSearchResult.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> invitePlayer({
    required String playerId,
    required String teamName,
    required String teamImageUrl,
  }) async {
    final currentUser = StorageService.currentUser ?? {};
    final firstName = currentUser['firstName'] as String? ?? '';
    final lastName = currentUser['lastName'] as String? ?? '';
    final myName = '$firstName $lastName'.trim();
    final response = await ApiClient.instance.post(
      ApiConstants.inviteTeamPlayer,
      body: {
        'teamId': teamId,
        'userId': _userId,
        'playerId': playerId,
        'teamName': teamName,
        'teamImageUrl': teamImageUrl,
        'myName': myName,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && _readBool(data['success'])) return;
    throw Exception('Failed to send invite');
  }

  Future<void> inviteByPhone({
    required List<Map<String, String>> numbers,
    required String teamName,
    required String teamImageUrl,
  }) async {
    final currentUser = StorageService.currentUser ?? {};
    final firstName = currentUser['firstName'] as String? ?? '';
    final lastName = currentUser['lastName'] as String? ?? '';
    final myName = '$firstName $lastName'.trim();
    final response = await ApiClient.instance.post(
      ApiConstants.inviteTeamUser,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'numbers': numbers,
        'teamName': teamName,
        'myName': myName,
        'teamImageUrl': teamImageUrl,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 &&
        (data['result'] == 1 || _readBool(data['success']))) {
      return;
    }
    throw Exception('Failed to send phone invitation');
  }

  Future<bool> checkProfileName(String profileName) async {
    final response = await ApiClient.instance.post(
      ApiConstants.searchProfileName,
      body: {'userId': _userId, 'profileName': profileName},
    );
    final data = _unwrap(response);
    return data['status'] == 1 && _readBool(data['available']);
  }

  Future<Map<String, dynamic>> createPlayer({
    required String firstName,
    required String lastName,
    required String profileName,
    required int yearOfBirth,
    required String gender,
    required String country,
    required String playPosition,
    required String playPositionType,
  }) async {
    final age = DateTime.now().year - yearOfBirth;
    final isAdult = age > 16;
    final isMale = gender.toLowerCase() == 'male';
    final imageUrl = isAdult
        ? (isMale ? 'avatar_male_adult.png' : 'avatar_female_adult.png')
        : (isMale ? 'avatar_male_young.png' : 'avatar_female_young.png');

    final response = await ApiClient.instance.post(
      ApiConstants.addTeamPlayer,
      body: {
        'userId': _userId,
        'teamId': teamId,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender.toLowerCase(),
        'profileName': profileName,
        'yearOfBirth': yearOfBirth,
        'country': country,
        'playPosition': playPosition,
        'playPositionType': playPositionType,
        'imageUrl': imageUrl,
      },
    );
    final data = _unwrap(response);
    if (data['status'] == 1 && data['playerDetails'] != null) {
      return data['playerDetails'] is Map
          ? Map<String, dynamic>.from(data['playerDetails'] as Map)
          : {};
    }
    throw Exception(data['reason']?.toString() ?? 'Failed to create player');
  }

  static bool _readBool(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    return false;
  }
}
