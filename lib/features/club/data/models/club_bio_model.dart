import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/models/match_model.dart';
import 'club_model.dart';
import 'club_news_model.dart';
import 'club_player_model.dart';
import 'club_sponsor_model.dart';
import 'club_team_model.dart';

part 'club_bio_model.freezed.dart';
part 'club_bio_model.g.dart';

/// Full club bio response model
@freezed
class ClubBioModel with _$ClubBioModel {
  const factory ClubBioModel({
    required ClubModel clubDetails,
    ClubTrialStatusModel? trialDetails,
    @Default([]) List<ClubNewsModel> newsList,
    @Default([]) List<MatchModel> matchList,
    @Default([]) List<ClubPlayerModel> playerList,
    @Default([]) List<ClubTeamModel> teamList,
    @Default([]) List<ClubSponsorModel> sponsorList,
  }) = _ClubBioModel;

  factory ClubBioModel.fromJson(Map<String, dynamic> json) =>
      _$ClubBioModelFromJson(json);

  /// Custom factory to handle API response with proper sorting
  factory ClubBioModel.fromApiJson(Map<String, dynamic> json) {
    // Parse club details
    final clubDetails = ClubModel.fromApiJson(
      json['clubDetails'] as Map<String, dynamic>,
    );

    // Parse trial details
    ClubTrialStatusModel? trialDetails;
    if (json['trialDetails'] != null) {
      trialDetails = ClubTrialStatusModel.fromJson(
        json['trialDetails'] as Map<String, dynamic>,
      );
    }

    // Parse and sort news list (by newsDateGmt descending)
    final newsList = <ClubNewsModel>[];
    if (json['newsList'] != null) {
      final newsJson = json['newsList'] as List;
      newsList.addAll(
        newsJson
            .map((n) => ClubNewsModel.fromApiJson(n as Map<String, dynamic>))
            .toList(),
      );
      newsList.sort((a, b) => b.newsDateGmt.compareTo(a.newsDateGmt));
    }

    // Parse and sort match list (by matchDateGmt descending)
    final matchList = <MatchModel>[];
    if (json['matchList'] != null) {
      final matchJson = json['matchList'] as List;
      matchList.addAll(
        matchJson
            .map((m) => MatchModel.fromJson(m as Map<String, dynamic>))
            .toList(),
      );
      // Note: MatchModel doesn't have matchDateGmt in the current definition
      // If needed, add sorting logic here
    }

    // Parse and sort player list (by seq asc, then firstName asc)
    final playerList = <ClubPlayerModel>[];
    if (json['playerList'] != null) {
      final playerJson = json['playerList'] as List;
      playerList.addAll(
        playerJson
            .map((p) => ClubPlayerModel.fromApiJson(p as Map<String, dynamic>))
            .toList(),
      );
      playerList.sort((a, b) {
        final seqCompare = a.seq.compareTo(b.seq);
        if (seqCompare != 0) return seqCompare;
        return (a.firstName ?? '').compareTo(b.firstName ?? '');
      });
    }

    // Parse and sort team list (by seq asc, then teamName asc)
    final teamList = <ClubTeamModel>[];
    if (json['teamList'] != null) {
      final teamJson = json['teamList'] as List;
      teamList.addAll(
        teamJson
            .map((t) => ClubTeamModel.fromApiJson(t as Map<String, dynamic>))
            .toList(),
      );
      teamList.sort((a, b) {
        final seqCompare = a.seq.compareTo(b.seq);
        if (seqCompare != 0) return seqCompare;
        return (a.teamName ?? '').compareTo(b.teamName ?? '');
      });
    }

    // Parse and sort sponsor list (by seq asc, then name asc)
    final sponsorList = <ClubSponsorModel>[];
    if (json['sponsorList'] != null) {
      final sponsorJson = json['sponsorList'] as List;
      sponsorList.addAll(
        sponsorJson
            .map((s) => ClubSponsorModel.fromApiJson(s as Map<String, dynamic>))
            .toList(),
      );
      sponsorList.sort((a, b) {
        final seqCompare = a.seq.compareTo(b.seq);
        if (seqCompare != 0) return seqCompare;
        return (a.name ?? '').compareTo(b.name ?? '');
      });
    }

    final mappedJson = {
      'clubDetails': clubDetails.toJson(),
      'trialDetails': trialDetails?.toJson(),
      'newsList': newsList.map((n) => n.toJson()).toList(),
      'matchList': matchList.map((m) => m.toJson()).toList(),
      'playerList': playerList.map((p) => p.toJson()).toList(),
      'teamList': teamList.map((t) => t.toJson()).toList(),
      'sponsorList': sponsorList.map((s) => s.toJson()).toList(),
    };

    return ClubBioModel.fromJson(mappedJson);
  }
}

@freezed
class ClubTrialStatusModel with _$ClubTrialStatusModel {
  const factory ClubTrialStatusModel({
    @Default(false) bool trialBadge,
    @Default(false) bool isRegisterBtn,
    @Default(false) bool isRegistered,
    @Default(false) bool isRegistrationClosed,
  }) = _ClubTrialStatusModel;

  factory ClubTrialStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTrialStatusModelFromJson(json);
}
