import 'package:freezed_annotation/freezed_annotation.dart';

part 'cup_models.freezed.dart';
part 'cup_models.g.dart';

/// Cup Tournament Model - extends base tournament with cup-specific fields
/// Mirrors Android TournamentCup.java
@freezed
class TournamentCupModel with _$TournamentCupModel {
  const factory TournamentCupModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'tournamentId') String? tournamentId,
    String? name,
    String? logo,
    String? location,
    String? venue,
    String? ageGroup,
    @JsonKey(name: 'ageCat') String? ageCat,
    String? gameType,
    String? gender,
    String? startDate,
    String? endDate,
    String? status, // 'init', 'fixture', 'live', 'end'
    @JsonKey(name: 'tmntType') String? tmntType, // Should be 'CUP'
    String? visibility, // 'local' or 'global'
    String? country,
    String? confed,
    String? parentId,
    String? createdBy,
    String? notes,
    String? description,
    String? prize,
    @JsonKey(name: 'regFee') String? regFee,
    String? orgDetails,
    @JsonKey(name: 'fsdDate') String? fsdDate,
    @JsonKey(name: 'fsdTime') String? fsdTime,
    @JsonKey(name: 'fsdGmtMs') @Default(0) int fsdGmtMs,
    @JsonKey(name: 'teamPlayerType') String? teamPlayerType,
    @JsonKey(name: 'teamPlayerLimit') @Default(0) int teamPlayerLimit,
    @Default(0) int followCount,
    @JsonKey(name: 'following') @Default(false) bool isFollowing,
    @Default(0) int teamCount,
    @Default(0) int matchCount,
    @Default(false) bool withdrawable,
    // Cup-specific fields
    @Default(0) int rounds, // Number of knockout rounds
    int? lastUpdated, // Timestamp
    int? startedOn, // Timestamp when cup started
    String? startedBy, // User ID who started it
    String? updatedBy, // User ID of last updater
    // Related data
    List<CupBannerModel>? banners,
    List<CupTeamModel>? teams,
    List<CupSponsorModel>? sponsors,
    List<CupRoundModel>? roundsList,
  }) = _TournamentCupModel;

  factory TournamentCupModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentCupModelFromJson(json);
}

extension TournamentCupModelX on TournamentCupModel {
  String get effectiveId => tournamentId ?? id ?? '';
}

/// Cup Round Model - represents a round in the cup (group stage or knockout)
/// Mirrors Android CupRound.java
@freezed
class CupRoundModel with _$CupRoundModel {
  const factory CupRoundModel({
    @JsonKey(name: '_id') String? id,
    String? roundId,
    String? tournamentId,
    String? roundName, // e.g., "Group Stage", "Quarter Final", "Semi Final"
    String? mode, // 'GROUP' or 'KNOCKOUT'
    String? tie, // Tie-breaking rule
    String? seq, // Sequence order
    String? count, // Number of teams/groups
    String? level, // Bracket depth level
    @Default(false) bool isExtraTime, // Extra time enabled
    @Default(false) bool isPenalty, // Penalty shootout enabled
    String? addedBy, // User ID who added round
    String? addedOn, // Timestamp added
    @Default(false) bool isDelete, // Soft-delete flag
    List<CupGroupModel>? groups, // Groups in this round (if GROUP mode)
  }) = _CupRoundModel;

  factory CupRoundModel.fromJson(Map<String, dynamic> json) =>
      _$CupRoundModelFromJson(json);
}

/// Cup Group Model - represents a group within a group stage round
/// Mirrors Android CupGroup.java
@freezed
class CupGroupModel with _$CupGroupModel {
  const factory CupGroupModel({
    @JsonKey(name: '_id') String? id,
    String? groupId,
    String? roundId,
    String? tournamentId,
    String? groupName, // e.g., "Group A", "Group B"
    String? mode, // Match mode
    String? status, // Group status
    String? level, // Level in bracket
    String? seq, // Sequence order
    String? fixture, // Fixture format
    @Default(false) bool isDelete, // Soft-delete flag
    @Default([]) List<CupLeagueModel> leg1, // First leg matches
    @Default([]) List<CupLeagueModel> leg2, // Second leg matches (if applicable)
  }) = _CupGroupModel;

  factory CupGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CupGroupModelFromJson(json);
}

/// Cup League Model - represents a match within a group stage
/// Mirrors Android CupLeague.java
@freezed
class CupLeagueModel with _$CupLeagueModel {
  const factory CupLeagueModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') String? matchId,
    String? tournamentId,
    String? roundId,
    String? groupId,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamLogo,
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamLogo,
    int? homeScore,
    int? awayScore,
    String? status, // 'upcoming', 'live', 'end'
    String? matchDate,
    @Default(0) int matchDateMs,
    String? venue,
    String? gameType,
    String? ageGroup,
    String? leg, // 'leg1' or 'leg2'
  }) = _CupLeagueModel;

  factory CupLeagueModel.fromJson(Map<String, dynamic> json) =>
      _$CupLeagueModelFromJson(json);
}

extension CupLeagueModelX on CupLeagueModel {
  String get effectiveId => matchId ?? id ?? '';
}

/// Cup Match Model - represents a knockout bracket match
/// Mirrors Android CupMatch.java
@freezed
class CupMatchModel with _$CupMatchModel {
  const factory CupMatchModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') String? matchId,
    String? tournamentId,
    String? roundId,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamLogo,
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamLogo,
    int? homeScore,
    int? awayScore,
    int? homeExtraTimeScore, // Extra time score
    int? awayExtraTimeScore,
    int? homePenaltyScore, // Penalty shootout score
    int? awayPenaltyScore,
    String? winnerId, // Team ID of winner
    String? winnerName,
    String? status, // 'upcoming', 'live', 'end'
    String? matchDate,
    @Default(0) int matchDateMs,
    String? venue,
    String? gameType,
    String? ageGroup,
    String? level, // Bracket level (e.g., "1" for final, "2" for semi)
    String? seq, // Sequence in level
  }) = _CupMatchModel;

  factory CupMatchModel.fromJson(Map<String, dynamic> json) =>
      _$CupMatchModelFromJson(json);
}

extension CupMatchModelX on CupMatchModel {
  String get effectiveId => matchId ?? id ?? '';
}

/// Cup Group Point Table Entry
/// Similar to PointsTableEntry but for cup groups
@freezed
class CupGroupPointTableEntry with _$CupGroupPointTableEntry {
  const factory CupGroupPointTableEntry({
    String? teamId,
    String? teamName,
    String? teamLogo,
    @Default(0) int seq, // Position
    @Default(0) int played,
    @JsonKey(name: 'win') @Default(0) int won,
    @JsonKey(name: 'draw') @Default(0) int drawn,
    @JsonKey(name: 'loss') @Default(0) int lost,
    @JsonKey(name: 'gf') @Default(0) int goalsFor,
    @JsonKey(name: 'ga') @Default(0) int goalsAgainst,
    @JsonKey(name: 'gd') @Default(0) int goalDifference,
    @JsonKey(name: 'pts') @Default(0) int points,
    String? groupId,
    String? roundId,
  }) = _CupGroupPointTableEntry;

  factory CupGroupPointTableEntry.fromJson(Map<String, dynamic> json) =>
      _$CupGroupPointTableEntryFromJson(json);
}

/// Cup Banner Model (same as BannerModel but separate for clarity)
@freezed
class CupBannerModel with _$CupBannerModel {
  const factory CupBannerModel({
    String? imageUrl,
    @Default(0) int seq,
    String? link,
  }) = _CupBannerModel;

  factory CupBannerModel.fromJson(Map<String, dynamic> json) =>
      _$CupBannerModelFromJson(json);
}

/// Cup Team Model (same as TeamModel but separate for clarity)
@freezed
class CupTeamModel with _$CupTeamModel {
  const factory CupTeamModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'teamId') String? teamId,
    String? teamName,
    String? logo,
    String? country,
  }) = _CupTeamModel;

  factory CupTeamModel.fromJson(Map<String, dynamic> json) =>
      _$CupTeamModelFromJson(json);
}

extension CupTeamModelX on CupTeamModel {
  String get effectiveId => teamId ?? id ?? '';
}

/// Cup Sponsor Model
@freezed
class CupSponsorModel with _$CupSponsorModel {
  const factory CupSponsorModel({
    @JsonKey(name: '_id') String? id,
    String? name,
    String? logo,
    String? website,
  }) = _CupSponsorModel;

  factory CupSponsorModel.fromJson(Map<String, dynamic> json) =>
      _$CupSponsorModelFromJson(json);
}

/// Cup Player Stat Entry (for group mode and match mode stats)
@freezed
class CupPlayerStatEntry with _$CupPlayerStatEntry {
  const factory CupPlayerStatEntry({
    String? userId,
    String? playerName,
    String? playerImage,
    String? teamId,
    String? teamName,
    @Default(0) int count, // Goals, assists, or MOM count
    @Default(0) int yellowCards,
    @Default(0) int redCards,
    String? roundId,
    String? groupId,
  }) = _CupPlayerStatEntry;

  factory CupPlayerStatEntry.fromJson(Map<String, dynamic> json) =>
      _$CupPlayerStatEntryFromJson(json);
}
