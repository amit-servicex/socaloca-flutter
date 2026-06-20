import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/api_constants.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

/// Club model matching Android ClubInfo.java
@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    required String clubId,
    @JsonKey(name: '_id') String? id,
    required String clubName,
    String? partnerType, // "platinum" | "gold" | "silver" | "nopartner"
    String? country,
    String? city,
    String? nickName,
    String? formedYear,
    String? manager,
    String? confed,
    String? league,
    String? website,
    String? imageUrl,
    String? homeKit,
    String? awayKit,
    String? thirdKit,
    String? orgFifaId,
    @Default(false) bool following,
    @Default(false) bool trialBadge,
    @Default(false) bool isPartner,
    @Default(0) int followCount,
    @Default(0) int likeCount,
    @Default(0) int plan,
    @Default([]) List<StadiumModel> stadiums,
    @Default([]) List<String> comps,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  /// Custom factory to handle API response with image URL conversion
  factory ClubModel.fromApiJson(Map<String, dynamic> json) {
    try {
      // Parse stadiums if present - handle both array and null cases
      final stadiumsList = <StadiumModel>[];
      final stadiumData = json['stadium'] ?? json['stadiums'];
      if (stadiumData != null &&
          stadiumData is List &&
          stadiumData.isNotEmpty) {
        try {
          for (var s in stadiumData) {
            if (s is Map<String, dynamic>) {
              // Ensure seq is an integer
              final stadiumJson = Map<String, dynamic>.from(s);
              if (stadiumJson['seq'] != null && stadiumJson['seq'] is! int) {
                stadiumJson['seq'] =
                    int.tryParse(stadiumJson['seq'].toString()) ?? 0;
              }
              stadiumsList.add(StadiumModel.fromJson(stadiumJson));
            } else if (s is String) {
              // Handle case where stadium is just a string name
              stadiumsList.add(StadiumModel(name: s, seq: 0));
            }
          }
        } catch (e) {
          print('⚠️ Error parsing stadiums: $e');
        }
      }

      // Sort stadiums by seq
      stadiumsList.sort((a, b) {
        final seqCompare = a.seq.compareTo(b.seq);
        if (seqCompare != 0) return seqCompare;
        return (a.name ?? '').compareTo(b.name ?? '');
      });

      // Helper to safely parse int values
      int safeParseInt(dynamic value, {int defaultValue = 0}) {
        if (value == null) return defaultValue;
        if (value is int) return value;
        return int.tryParse(value.toString()) ?? defaultValue;
      }

      final mappedJson = {
        'clubId': json['clubId'] ?? json['_id'] ?? '',
        '_id': json['_id'],
        'clubName': json['clubName'] ?? '',
        'partnerType': json['partnerType'],
        'country': json['country'],
        'city': json['city'],
        'nickName': json['nickName'],
        'formedYear': json['formedYear']?.toString(),
        'manager': json['manager'],
        'confed': json['confed'],
        'league': json['league'],
        'website': json['website'],
        'imageUrl': json['imageUrl'],
        'homeKit': json['homeKit'],
        'awayKit': json['awayKit'],
        'thirdKit': json['thirdKit'],
        'orgFifaId': json['orgFifaId'],
        'following': json['following'] ?? false,
        'trialBadge': json['trialBadge'] ?? false,
        'isPartner': json['isPartner'] ?? false,
        'followCount': safeParseInt(json['followCount']),
        'likeCount': safeParseInt(json['likeCount']),
        'plan': safeParseInt(json['plan']),
        'stadiums': stadiumsList.map((s) => s.toJson()).toList(),
        'comps':
            (json['comps'] as List<dynamic>?)?.cast<String>() ?? <String>[],
      };

      return ClubModel.fromJson(mappedJson);
    } catch (e, stackTrace) {
      print('❌ Error in ClubModel.fromApiJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }
}

@freezed
class StadiumModel with _$StadiumModel {
  const factory StadiumModel({
    String? name,
    @Default(0) int seq,
  }) = _StadiumModel;

  factory StadiumModel.fromJson(Map<String, dynamic> json) =>
      _$StadiumModelFromJson(json);
}

/// Extension methods for ClubModel
extension ClubModelX on ClubModel {
  /// Format partner type label (matches Android adapter logic)
  String get partnerLabel {
    final type = partnerType;
    if (type == null || type.isEmpty || type.toLowerCase() == 'nopartner') {
      return 'Non-Partner';
    }
    return '${type[0].toUpperCase()}${type.substring(1)} Partner';
  }

  /// Get stadiums as comma-separated string
  String get stadiumsAsStr =>
      stadiums.where((s) => s.name != null).map((s) => s.name!).join(', ');

  /// Get competitions as comma-separated string
  String get competitionsStr => comps.join(', ');

  /// Get full image URL
  String get fullImageUrl => ApiConstants.getImageUrl(imageUrl);
}
