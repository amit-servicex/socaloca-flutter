/// Model for search filters
class SearchFilterModel {
  final String type;
  final String value;

  SearchFilterModel({
    required this.type,
    required this.value,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchFilterModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          value == other.value;

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}

/// Filter types
class SearchFilterType {
  static const String country = 'BY_COUNTRY';
  static const String type = 'BY_TYPE';
  static const String choice = 'BY_CHOICE';
}

/// Filter values for type
class UserTypeFilter {
  static const String player = 'Player';
  static const String coach = 'Coach';
  static const String manager = 'Manager';
  static const String referee = 'Referee';
}

/// Filter values for choice (sorting)
class SortingFilter {
  static const String mostPosts = 'Most Posts';
  static const String mostAppearances = 'Most Appearances';
  static const String mostGoals = 'Most Goals';
}
