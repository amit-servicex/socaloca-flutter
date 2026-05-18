class TeamFilterModel {
  final String location;
  final String gameType;
  final String gender;
  final String ageRange;
  final String ageCategory;

  const TeamFilterModel({
    this.location = '',
    this.gameType = '',
    this.gender = '',
    this.ageRange = '',
    this.ageCategory = '',
  });

  TeamFilterModel copyWith({
    String? location,
    String? gameType,
    String? gender,
    String? ageRange,
    String? ageCategory,
  }) {
    return TeamFilterModel(
      location: location ?? this.location,
      gameType: gameType ?? this.gameType,
      gender: gender ?? this.gender,
      ageRange: ageRange ?? this.ageRange,
      ageCategory: ageCategory ?? this.ageCategory,
    );
  }

  bool get hasAnyFilter =>
      location.isNotEmpty ||
      gameType.isNotEmpty ||
      gender.isNotEmpty ||
      ageRange.isNotEmpty ||
      ageCategory.isNotEmpty;
}
