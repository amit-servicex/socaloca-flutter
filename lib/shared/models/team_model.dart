import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    String? logo,
    String? coverImage,
    String? country,
    String? city,
    String? adminId,
    String? adminName,
    String? bio,
    @Default(0) int playersCount,
    @Default(0) int matchesCount,
    @Default(false) bool isFollowing,
    String? formationDefault,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}

@freezed
class TeamPlayer with _$TeamPlayer {
  const factory TeamPlayer({
    required String userId,
    required String name,
    String? profileImage,
    String? position,
    int? jerseyNumber,
    String? role, // 'player', 'admin', 'coach_manager'
    @Default(false) bool isAdmin,
  }) = _TeamPlayer;

  factory TeamPlayer.fromJson(Map<String, dynamic> json) =>
      _$TeamPlayerFromJson(json);
}
