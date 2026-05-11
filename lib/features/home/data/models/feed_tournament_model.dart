import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_tournament_model.freezed.dart';
part 'feed_tournament_model.g.dart';

/// Model for live tournaments in home feed (from getFeedLiveTmnts API)
@freezed
class FeedTournamentModel with _$FeedTournamentModel {
  const factory FeedTournamentModel({
    @JsonKey(name: 'feedId') String? feedId,
    @JsonKey(name: 'feedType') String? feedType,
    @JsonKey(name: 'tournamentId') String? tournamentId,
    @JsonKey(name: 'name') String? tmntName,
    @JsonKey(name: 'logo') String? imageUrl,
    @JsonKey(name: 'startDate') String? startDate,
    @JsonKey(name: 'endDate') String? endDate,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'teamCount') @Default(0) int teamsCount,
    @JsonKey(name: 'tmntType') String? tmntType,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'location') String? city,
    @JsonKey(name: 'ageGroup') String? ageGroup,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'gameType') String? gameType,
    @JsonKey(name: 'visibility') String? visibility,
    @JsonKey(name: 'venue') String? venue,
    @JsonKey(name: 'ageCat') String? ageCat,
    @JsonKey(name: 'teamPlayerType') String? teamPlayerType,
    @JsonKey(name: 'teamPlayerLimit') int? teamPlayerLimit,
    @JsonKey(name: 'createdOn') int? createdOn,
    @JsonKey(name: 'following') @Default(false) bool following,
    @JsonKey(name: 'comments') @Default([]) List<dynamic> comments,
  }) = _FeedTournamentModel;

  factory FeedTournamentModel.fromJson(Map<String, dynamic> json) =>
      _$FeedTournamentModelFromJson(json);
}
