import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/player_bio_model.dart';
import '../data/models/game_stats_model.dart';
import '../data/models/match_training_status_model.dart';
import '../data/models/player_team_model.dart';
import '../data/models/player_skill_model.dart';
import '../data/models/player_post_model.dart';
import '../data/models/endorsement_model.dart';
import '../data/models/academy_model.dart';
import '../data/models/tournament_model.dart';
import '../data/models/tagged_video_model.dart';
import '../data/repositories/player_bio_repository.dart';

/// State for player bio
class PlayerBioState {
  final PlayerBioModel? playerBio;
  final bool isLoading;
  final String? error;
  final bool isFollowing;
  final bool isLiked;
  final GameStatsModel? footballStats;
  final GameStatsModel? futsalStats;
  final bool isLoadingStats;
  final int selectedYear;
  final MatchTrainingStatusModel? footballMatches;
  final MatchTrainingStatusModel? futsalMatches;
  final MatchTrainingStatusModel? trainCurrMonth;
  final MatchTrainingStatusModel? trainPrevMonth;
  final String? lastYear;
  final bool isLoadingMatches;
  final List<PlayerTeamModel> teams;
  final bool isLoadingTeams;
  final List<PlayerSkillModel> skills;
  final double? overallRating;
  final bool isLoadingSkills;
  final List<PlayerPostModel> posts;
  final bool isLoadingPosts;
  final List<EndorsementModel> endorsements;
  final bool isLoadingEndorsements;
  final List<AcademyModel> academies;
  final bool isLoadingAcademies;
  final List<TournamentModel> tournaments;
  final bool isLoadingTournaments;
  final List<TaggedVideoModel> taggedVideos;
  final bool isLoadingTaggedVideos;

  PlayerBioState({
    this.playerBio,
    this.isLoading = false,
    this.error,
    this.isFollowing = false,
    this.isLiked = false,
    this.footballStats,
    this.futsalStats,
    this.isLoadingStats = false,
    int? selectedYear,
    this.footballMatches,
    this.futsalMatches,
    this.trainCurrMonth,
    this.trainPrevMonth,
    this.lastYear,
    this.isLoadingMatches = false,
    List<PlayerTeamModel>? teams,
    this.isLoadingTeams = false,
    List<PlayerSkillModel>? skills,
    this.overallRating,
    this.isLoadingSkills = false,
    List<PlayerPostModel>? posts,
    this.isLoadingPosts = false,
    List<EndorsementModel>? endorsements,
    this.isLoadingEndorsements = false,
    List<AcademyModel>? academies,
    this.isLoadingAcademies = false,
    List<TournamentModel>? tournaments,
    this.isLoadingTournaments = false,
    List<TaggedVideoModel>? taggedVideos,
    this.isLoadingTaggedVideos = false,
  })  : selectedYear = selectedYear ?? DateTime.now().year,
        teams = teams ?? [],
        skills = skills ?? [],
        posts = posts ?? [],
        endorsements = endorsements ?? [],
        academies = academies ?? [],
        tournaments = tournaments ?? [],
        taggedVideos = taggedVideos ?? [];

  PlayerBioState copyWith({
    PlayerBioModel? playerBio,
    bool? isLoading,
    String? error,
    bool? isFollowing,
    bool? isLiked,
    GameStatsModel? footballStats,
    GameStatsModel? futsalStats,
    bool? isLoadingStats,
    int? selectedYear,
    MatchTrainingStatusModel? footballMatches,
    MatchTrainingStatusModel? futsalMatches,
    MatchTrainingStatusModel? trainCurrMonth,
    MatchTrainingStatusModel? trainPrevMonth,
    String? lastYear,
    bool? isLoadingMatches,
    List<PlayerTeamModel>? teams,
    bool? isLoadingTeams,
    List<PlayerSkillModel>? skills,
    double? overallRating,
    bool? isLoadingSkills,
    List<PlayerPostModel>? posts,
    bool? isLoadingPosts,
    List<EndorsementModel>? endorsements,
    bool? isLoadingEndorsements,
    List<AcademyModel>? academies,
    bool? isLoadingAcademies,
    List<TournamentModel>? tournaments,
    bool? isLoadingTournaments,
    List<TaggedVideoModel>? taggedVideos,
    bool? isLoadingTaggedVideos,
  }) {
    return PlayerBioState(
      playerBio: playerBio ?? this.playerBio,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isFollowing: isFollowing ?? this.isFollowing,
      isLiked: isLiked ?? this.isLiked,
      footballStats: footballStats ?? this.footballStats,
      futsalStats: futsalStats ?? this.futsalStats,
      isLoadingStats: isLoadingStats ?? this.isLoadingStats,
      selectedYear: selectedYear ?? this.selectedYear,
      footballMatches: footballMatches ?? this.footballMatches,
      futsalMatches: futsalMatches ?? this.futsalMatches,
      trainCurrMonth: trainCurrMonth ?? this.trainCurrMonth,
      trainPrevMonth: trainPrevMonth ?? this.trainPrevMonth,
      lastYear: lastYear ?? this.lastYear,
      isLoadingMatches: isLoadingMatches ?? this.isLoadingMatches,
      teams: teams ?? this.teams,
      isLoadingTeams: isLoadingTeams ?? this.isLoadingTeams,
      skills: skills ?? this.skills,
      overallRating: overallRating ?? this.overallRating,
      isLoadingSkills: isLoadingSkills ?? this.isLoadingSkills,
      posts: posts ?? this.posts,
      isLoadingPosts: isLoadingPosts ?? this.isLoadingPosts,
      endorsements: endorsements ?? this.endorsements,
      isLoadingEndorsements:
          isLoadingEndorsements ?? this.isLoadingEndorsements,
      academies: academies ?? this.academies,
      isLoadingAcademies: isLoadingAcademies ?? this.isLoadingAcademies,
      tournaments: tournaments ?? this.tournaments,
      isLoadingTournaments: isLoadingTournaments ?? this.isLoadingTournaments,
      taggedVideos: taggedVideos ?? this.taggedVideos,
      isLoadingTaggedVideos:
          isLoadingTaggedVideos ?? this.isLoadingTaggedVideos,
    );
  }
}

/// Notifier for player bio
class PlayerBioNotifier extends StateNotifier<PlayerBioState> {
  final PlayerBioRepository _repository;
  final String playerId;
  final bool isCoachAdminProfile;

  PlayerBioNotifier(
    this._repository,
    this.playerId, {
    this.isCoachAdminProfile = false,
  }) : super(PlayerBioState());

  /// Load player bio
  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userId = StorageService.userId;
      if (userId == null || userId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not logged in',
        );
        return;
      }

      final playerBio = isCoachAdminProfile
          ? await _repository.getAdminBio(
              userId: userId,
              adminId: playerId,
            )
          : await _repository.getPlayerBio(
              userId: userId,
              playerId: playerId,
            );

      if (playerBio != null) {
        state = state.copyWith(
          playerBio: playerBio,
          isLoading: false,
          isFollowing: playerBio.followedByMe ?? false,
          isLiked: playerBio.likedByMe ?? false,
        );

        if (!isCoachAdminProfile) {
          // Load stats for current year
          await loadStats(state.selectedYear);

          // Load mini activity (matches & training)
          await loadMiniActivity();
        }

        // Load teams and posts
        await loadTeams();
        await loadPosts();

        if (!isCoachAdminProfile) {
          await loadSkills();
          await loadEndorsements();
        }

        // Load academies and tournaments
        await loadAcademies();
        await loadTournaments();

        if (!isCoachAdminProfile) {
          await loadTaggedVideos();
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Player not found',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load player stats for a specific year
  Future<void> loadStats(int year) async {
    state = state.copyWith(isLoadingStats: true, selectedYear: year);

    try {
      final stats = await _repository.getPlayerStats(
        playerId: playerId,
        year: year,
      );

      state = state.copyWith(
        footballStats: stats['football'],
        futsalStats: stats['futsal'],
        isLoadingStats: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingStats: false);
    }
  }

  /// Load mini activity (matches & training)
  Future<void> loadMiniActivity() async {
    state = state.copyWith(isLoadingMatches: true);

    try {
      final data = await _repository.getMiniActivity(playerId: playerId);

      state = state.copyWith(
        footballMatches: data['football'] as MatchTrainingStatusModel?,
        futsalMatches: data['futsal'] as MatchTrainingStatusModel?,
        trainCurrMonth: data['trainCurrMonth'] as MatchTrainingStatusModel?,
        trainPrevMonth: data['trainPrevMonth'] as MatchTrainingStatusModel?,
        lastYear: data['lastYear'] as String?,
        isLoadingMatches: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMatches: false);
    }
  }

  /// Toggle follow status
  Future<void> toggleFollow() async {
    if (state.playerBio == null) return;

    final userId = StorageService.userId;
    final currentUser = StorageService.currentUser;
    if (userId == null || currentUser == null) return;

    try {
      final response = await _repository.followUser(
        userId: userId,
        toUserId: playerId,
        myName:
            '${currentUser['firstName'] ?? ''} ${currentUser['lastName'] ?? ''}'
                .trim(),
        myImageUrl: currentUser['imageUrl'] ?? '',
        isPlayer: currentUser['isPlayer'] ?? false,
        isCoach: currentUser['isCoach'] ?? false,
        isAdmin: currentUser['isAdmin'] ?? false,
        isFan: currentUser['isFan'] ?? false,
      );

      if (response['status'] == 1 && response['isFollow'] != null) {
        final isFollowing = response['isFollow'] as bool;
        final updatedFollowCount = isFollowing
            ? (state.playerBio!.followCount ?? 0) + 1
            : (state.playerBio!.followCount ?? 0) - 1;

        state = state.copyWith(
          isFollowing: isFollowing,
          playerBio: state.playerBio!.copyWith(
            followCount: updatedFollowCount,
            followedByMe: isFollowing,
          ),
        );
      }
    } catch (e) {
      // Handle error silently or show toast
    }
  }

  /// Toggle like status
  Future<void> toggleLike() async {
    if (state.playerBio == null) return;

    final userId = StorageService.userId;
    final currentUser = StorageService.currentUser;
    if (userId == null || currentUser == null) return;

    try {
      final response = await _repository.likeUser(
        userId: userId,
        toUserId: playerId,
        myName:
            '${currentUser['firstName'] ?? ''} ${currentUser['lastName'] ?? ''}'
                .trim(),
        myImageUrl: currentUser['imageUrl'] ?? '',
        isPlayer: currentUser['isPlayer'] ?? false,
        isCoach: currentUser['isCoach'] ?? false,
        isAdmin: currentUser['isAdmin'] ?? false,
        isFan: currentUser['isFan'] ?? false,
      );

      if (response['status'] == 1 && response['isLike'] != null) {
        final isLiked = response['isLike'] as bool;
        final updatedLikeCount = isLiked
            ? (state.playerBio!.likeCount ?? 0) + 1
            : (state.playerBio!.likeCount ?? 0) - 1;

        state = state.copyWith(
          isLiked: isLiked,
          playerBio: state.playerBio!.copyWith(
            likeCount: updatedLikeCount,
            likedByMe: isLiked,
          ),
        );
      }
    } catch (e) {
      // Handle error silently or show toast
    }
  }

  /// Load player teams
  Future<void> loadTeams() async {
    state = state.copyWith(isLoadingTeams: true);

    try {
      final teams = await _repository.getPlayerTeams(
        playerId: playerId,
        start: 0,
        limit: 20,
      );

      state = state.copyWith(
        teams: teams,
        isLoadingTeams: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingTeams: false);
    }
  }

  /// Load player skills/ratings
  Future<void> loadSkills() async {
    final userId = StorageService.userId;
    if (userId == null) return;

    state = state.copyWith(isLoadingSkills: true);

    try {
      final data = await _repository.getPlayerSkills(
        userId: userId,
        playerId: playerId,
        start: 0,
        limit: 5,
      );

      state = state.copyWith(
        skills: data['skills'] as List<PlayerSkillModel>,
        overallRating: data['overall'] as double?,
        isLoadingSkills: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingSkills: false);
    }
  }

  /// Load player posts
  Future<void> loadPosts() async {
    final userId = StorageService.userId;
    if (userId == null) return;

    state = state.copyWith(isLoadingPosts: true);

    try {
      final posts = await _repository.getUserPosts(
        userId: playerId,
        myId: userId,
        start: 0,
        limit: 5,
      );

      state = state.copyWith(
        posts: posts,
        isLoadingPosts: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingPosts: false);
    }
  }

  /// Load endorsements
  Future<void> loadEndorsements() async {
    state = state.copyWith(isLoadingEndorsements: true);

    try {
      final endorsements = await _repository.getEndorses(
        userId: playerId,
        endType: 'accept',
        start: 0,
        limit: 1,
      );

      state = state.copyWith(
        endorsements: endorsements,
        isLoadingEndorsements: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingEndorsements: false);
    }
  }

  /// Load academies
  Future<void> loadAcademies() async {
    state = state.copyWith(isLoadingAcademies: true);

    try {
      final academies = await _repository.getUserAcademy(
        userId: playerId,
      );

      state = state.copyWith(
        academies: academies,
        isLoadingAcademies: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingAcademies: false);
    }
  }

  /// Load tournaments
  Future<void> loadTournaments() async {
    state = state.copyWith(isLoadingTournaments: true);

    try {
      final tournaments = isCoachAdminProfile
          ? await _repository.getCoachAdminTmnts(
              userId: playerId,
              start: 0,
              limit: 20,
            )
          : await _repository.getPlayerTmnts(
              playerId: playerId,
              start: 0,
              limit: 20,
            );

      state = state.copyWith(
        tournaments: tournaments,
        isLoadingTournaments: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingTournaments: false);
    }
  }

  /// Add a match activity and refresh mini activity
  Future<bool> addMatchActivity({
    required String gameType,
    required String matchDate,
    required int matchMonth,
    required int matchYear,
    required String matchMonthStr,
    required int goals,
    required int goalSaved,
    required int assists,
    required String playPosition,
    required String playPositionType,
    required int minutes,
    required String myTeamName,
    required String opponentTeamName,
    required int rating,
    required String notes,
    List<Map<String, dynamic>> tagged = const [],
  }) async {
    final userId = StorageService.userId;
    final currentUser = StorageService.currentUser;
    if (userId == null || currentUser == null) return false;

    try {
      final success = await _repository.addMatchActivity(
        userId: userId,
        gameType: gameType,
        matchDate: matchDate,
        matchMonth: matchMonth,
        matchYear: matchYear,
        matchMonthStr: matchMonthStr,
        goals: goals,
        goalSaved: goalSaved,
        assists: assists,
        playPosition: playPosition,
        playPositionType: playPositionType,
        minutes: minutes,
        myTeamName: myTeamName,
        opponentTeamName: opponentTeamName,
        rating: rating,
        notes: notes,
        tagged: tagged,
        isPlayer: currentUser['isPlayer'] ?? false,
        isCoach: currentUser['isCoach'] ?? false,
        isAdmin: currentUser['isAdmin'] ?? false,
        isFan: currentUser['isFan'] ?? false,
        firstName: currentUser['firstName'] ?? '',
        lastName: currentUser['lastName'] ?? '',
        myImageUrl: currentUser['imageUrl'] ?? '',
      );
      if (success) await loadMiniActivity();
      return success;
    } catch (e) {
      return false;
    }
  }

  /// Add a training session and refresh mini activity
  Future<bool> addTrainingActivity({
    required String trainType,
    required String trainDate,
    required int trainMonth,
    required int trainYear,
    required String trainMonthStr,
    required int minutes,
    required String notes,
    List<Map<String, dynamic>> tagged = const [],
  }) async {
    final userId = StorageService.userId;
    final currentUser = StorageService.currentUser;
    if (userId == null || currentUser == null) return false;

    try {
      final success = await _repository.addTrainingActivity(
        userId: userId,
        trainType: trainType,
        trainDate: trainDate,
        trainMonth: trainMonth,
        trainYear: trainYear,
        trainMonthStr: trainMonthStr,
        minutes: minutes,
        notes: notes,
        tagged: tagged,
        isPlayer: currentUser['isPlayer'] ?? false,
        isCoach: currentUser['isCoach'] ?? false,
        isAdmin: currentUser['isAdmin'] ?? false,
        isFan: currentUser['isFan'] ?? false,
        firstName: currentUser['firstName'] ?? '',
        lastName: currentUser['lastName'] ?? '',
        myImageUrl: currentUser['imageUrl'] ?? '',
      );
      if (success) await loadMiniActivity();
      return success;
    } catch (e) {
      return false;
    }
  }

  /// Load tagged videos
  Future<void> loadTaggedVideos() async {
    final userId = StorageService.userId;
    if (userId == null) return;

    state = state.copyWith(isLoadingTaggedVideos: true);

    try {
      final taggedVideos = await _repository.getPlayerAcaVdos(
        userId: userId,
        playerId: playerId,
      );

      state = state.copyWith(
        taggedVideos: taggedVideos,
        isLoadingTaggedVideos: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingTaggedVideos: false);
    }
  }
}

/// Provider for player bio repository
final playerBioRepositoryProvider = Provider<PlayerBioRepository>((ref) {
  return PlayerBioRepository();
});

/// Provider for player bio
final playerBioProvider =
    StateNotifierProvider.family<PlayerBioNotifier, PlayerBioState, String>(
  (ref, playerId) {
    final repository = ref.watch(playerBioRepositoryProvider);
    return PlayerBioNotifier(repository, playerId);
  },
);

/// Provider for coach/admin/manager bio.
final coachAdminBioProvider =
    StateNotifierProvider.family<PlayerBioNotifier, PlayerBioState, String>(
  (ref, memberId) {
    final repository = ref.watch(playerBioRepositoryProvider);
    return PlayerBioNotifier(
      repository,
      memberId,
      isCoachAdminProfile: true,
    );
  },
);
