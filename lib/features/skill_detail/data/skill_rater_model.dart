/// A user who has rated/endorsed a specific skill.
/// Returned by getEndorsesSummary and getEndorseRoleUsers.
class SkillRaterModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String country;
  final String? playPosition;
  final String? imageUrl;
  final int rating;
  final int lastOnline;

  const SkillRaterModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.country,
    this.playPosition,
    this.imageUrl,
    required this.rating,
    required this.lastOnline,
  });

  factory SkillRaterModel.fromJson(Map<String, dynamic> json) =>
      SkillRaterModel(
        userId: json['userId'] as String? ?? '',
        firstName: json['firstName'] as String? ?? '',
        lastName: json['lastName'] as String? ?? '',
        country: json['country'] as String? ?? '',
        playPosition: json['playPosition'] as String?,
        imageUrl: json['imageUrl'] as String?,
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        lastOnline: (json['lastOnline'] as num?)?.toInt() ?? 0,
      );

  bool get isOnline {
    if (lastOnline == 0) return false;
    final diff =
        DateTime.now().millisecondsSinceEpoch - lastOnline;
    return diff < 300000; // 5 minutes
  }
}
