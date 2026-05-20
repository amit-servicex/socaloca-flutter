import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:socaloca/shared/models/team_model.dart';

part 'tournament_models.freezed.dart';
part 'tournament_models.g.dart';

/// Tournament model — mirrors Android Tournament.java exactly
@freezed
class TournamentModel with _$TournamentModel {
  const factory TournamentModel({
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
    @JsonKey(name: 'rule') String? rule, // tournament type: 'league'/'cup'
    @JsonKey(name: 'tmntType') String? tmntType,
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
    List<BannerModel>? banners,
    List<TeamModel>? teams,
    List<SponsorModel>? sponsors,
    ItineraryModel? itinerary,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);
}

/// Helper to get the tournament's effective ID
extension TournamentModelX on TournamentModel {
  String get effectiveId => tournamentId ?? id ?? '';
}

/// Banner model for tournament slider
@freezed
class BannerModel with _$BannerModel {
  const factory BannerModel({
    String? imageUrl,
    @Default(0) int seq,
    String? link,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}

// /// Team model (used in tournament teams list)
// @freezed
// class TeamModel with _$TeamModel {
//   const factory TeamModel({
//     @JsonKey(name: '_id') String? id,
//     @JsonKey(name: 'teamId') String? teamId,
//     String? teamName,
//     String? imageUrl,
//     String? country,
//   }) = _TeamModel;

//   factory TeamModel.fromJson(Map<String, dynamic> json) =>
//       _$TeamModelFromJson(json);
// }

// extension TeamModelX on TeamModel {
//   String get effectiveId => teamId ?? id ?? '';
// }

/// Sponsor model
@freezed
class SponsorModel with _$SponsorModel {
  const factory SponsorModel({
    @JsonKey(name: '_id') String? id,
    String? name,
    String? logo,
    String? website,
  }) = _SponsorModel;

  factory SponsorModel.fromJson(Map<String, dynamic> json) =>
      _$SponsorModelFromJson(json);
}

/// Itinerary model
@freezed
class ItineraryModel with _$ItineraryModel {
  const factory ItineraryModel({
    String? doc,
    @Default(false) bool canView,
  }) = _ItineraryModel;

  factory ItineraryModel.fromJson(Map<String, dynamic> json) =>
      _$ItineraryModelFromJson(json);
}

/// Tournament match model — mirrors Android SocaLocaMatch
@freezed
class TournamentMatchModel with _$TournamentMatchModel {
  const factory TournamentMatchModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'matchId') String? matchId,
    String? homeTeamId,
    String? homeTeamName,
    String? homeTeamLogo,
    String? awayTeamId,
    String? awayTeamName,
    String? awayTeamLogo,
    int? homeScore,
    int? awayScore,
    String? status,
    String? matchDate,
    @Default(0) int matchDateMs,
    String? venue,
    String? gameType,
    String? ageGroup,
  }) = _TournamentMatchModel;

  factory TournamentMatchModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentMatchModelFromJson(json);
}

extension TournamentMatchModelX on TournamentMatchModel {
  String get effectiveId => matchId ?? id ?? '';
}

/// Points table entry — mirrors Android Point model
@freezed
class PointsTableEntry with _$PointsTableEntry {
  const factory PointsTableEntry({
    String? teamId,
    String? teamName,
    String? teamLogo,
    @Default(0) int seq,
    @Default(0) int played,
    @JsonKey(name: 'win') @Default(0) int won,
    @JsonKey(name: 'draw') @Default(0) int drawn,
    @JsonKey(name: 'loss') @Default(0) int lost,
    @JsonKey(name: 'gf') @Default(0) int goalsFor,
    @JsonKey(name: 'ga') @Default(0) int goalsAgainst,
    @JsonKey(name: 'gd') @Default(0) int goalDifference,
    @JsonKey(name: 'pts') @Default(0) int points,
  }) = _PointsTableEntry;

  factory PointsTableEntry.fromJson(Map<String, dynamic> json) =>
      _$PointsTableEntryFromJson(json);
}

/// Player stat entry (goals, assists, cards, MOM)
@freezed
class PlayerStatEntry with _$PlayerStatEntry {
  const factory PlayerStatEntry({
    String? userId,
    String? playerName,
    String? playerImage,
    String? teamId,
    String? teamName,
    @Default(0) int count,
    @Default(0) int yellowCards,
    @Default(0) int redCards,
  }) = _PlayerStatEntry;

  factory PlayerStatEntry.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatEntryFromJson(json);
}

/// Tournament filters state
class TournamentFilters {
  final String? gameType;
  final String? ageGroup;
  final String? gender;
  final String? country;
  final String? confed;
  final String? location;
  final String visibility; // 'local' or 'global'

  const TournamentFilters({
    this.gameType,
    this.ageGroup,
    this.gender,
    this.country,
    this.confed,
    this.location,
    this.visibility = 'local',
  });

  TournamentFilters copyWith({
    String? gameType,
    String? ageGroup,
    String? gender,
    String? country,
    String? confed,
    String? location,
    String? visibility,
  }) {
    return TournamentFilters(
      gameType: gameType ?? this.gameType,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      confed: confed ?? this.confed,
      location: location ?? this.location,
      visibility: visibility ?? this.visibility,
    );
  }

  TournamentFilters clearFilters() {
    return TournamentFilters(visibility: visibility);
  }
}
