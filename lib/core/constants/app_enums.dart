/// User types — matches Params.java USER_TYPE_* constants
enum UserType {
  fan,
  player,
  coach,
  club,
  referee,
  academy,
  fa,
  confederation,
  sponsor,
  charity;

  bool get isOrganisation => [
        UserType.club,
        UserType.academy,
        UserType.fa,
        UserType.confederation,
        UserType.sponsor,
        UserType.charity,
      ].contains(this);

  bool get hasTeams =>
      this == UserType.player ||
      this == UserType.coach ||
      this == UserType.club;
}

/// Match status values from Params.java
enum MatchStatus {
  pending,
  accepted,
  rejected,
  played,
  live,
  upcoming,
  cancelled;
}

/// Tournament status values
enum TournamentStatus {
  upcoming,
  ongoing,
  closed,
}

/// Post type
enum PostType {
  text,
  image,
  video,
  news,
}

/// Notification type
enum NotificationType {
  match,
  team,
  tournament,
  social,
  system,
}

/// Age consent tier — from AgeSelectionFragment/ChildConsentFragment flow
enum AgeTier {
  adult, // 18+
  youth, // 13–17: requires parental consent
  child, // under 13: full parental lockdown
}

/// Pick-up match slot status
enum PickupSlotStatus {
  open,
  full,
  cancelled,
}
