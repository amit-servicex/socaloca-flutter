import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/team_bio_model.dart';
import '../data/repositories/team_players_repository.dart';

final teamPlayersRepositoryProvider = Provider<TeamPlayersRepository>((ref) {
  return TeamPlayersRepository();
});

final teamPlayersProvider =
    StateNotifierProvider.family<TeamPlayersNotifier, TeamPlayersState, String>(
        (ref, teamId) {
  final repository = ref.watch(teamPlayersRepositoryProvider);
  return TeamPlayersNotifier(repository, teamId);
});

class TeamPlayersState {
  final List<TeamPlayerModel> allPlayers;
  final List<TeamPlayerModel> goalkeepers;
  final List<TeamPlayerModel> defenders;
  final List<TeamPlayerModel> midfielders;
  final List<TeamPlayerModel> attackers;
  final List<TeamPlayerModel> coaches;
  final bool isLoading;
  final String? error;

  const TeamPlayersState({
    this.allPlayers = const [],
    this.goalkeepers = const [],
    this.defenders = const [],
    this.midfielders = const [],
    this.attackers = const [],
    this.coaches = const [],
    this.isLoading = false,
    this.error,
  });

  TeamPlayersState copyWith({
    List<TeamPlayerModel>? allPlayers,
    List<TeamPlayerModel>? goalkeepers,
    List<TeamPlayerModel>? defenders,
    List<TeamPlayerModel>? midfielders,
    List<TeamPlayerModel>? attackers,
    List<TeamPlayerModel>? coaches,
    bool? isLoading,
    String? error,
  }) {
    return TeamPlayersState(
      allPlayers: allPlayers ?? this.allPlayers,
      goalkeepers: goalkeepers ?? this.goalkeepers,
      defenders: defenders ?? this.defenders,
      midfielders: midfielders ?? this.midfielders,
      attackers: attackers ?? this.attackers,
      coaches: coaches ?? this.coaches,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TeamPlayersNotifier extends StateNotifier<TeamPlayersState> {
  final TeamPlayersRepository _repository;
  final String _teamId;

  TeamPlayersNotifier(this._repository, this._teamId)
      : super(const TeamPlayersState()) {
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final players = await _repository.getTeamPlayers(teamId: _teamId);

      // Categorize players by position
      final goalkeepers = <TeamPlayerModel>[];
      final defenders = <TeamPlayerModel>[];
      final midfielders = <TeamPlayerModel>[];
      final attackers = <TeamPlayerModel>[];
      final coaches = <TeamPlayerModel>[];

      for (final player in players) {
        final position = player.playPosition?.toLowerCase();

        // Check if player is coach/manager (no position or special jersey)
        final jerseyNo = player.jerseyNumber?.toLowerCase() ?? '';
        final isCoachManager = jerseyNo.contains('coach') ||
            jerseyNo.contains('manager') ||
            position == null ||
            position.isEmpty;

        if (isCoachManager) {
          coaches.add(player);
        } else {
          switch (position) {
            case 'goalkeeper':
              goalkeepers.add(player);
              break;
            case 'defender':
              defenders.add(player);
              break;
            case 'midfield':
              midfielders.add(player);
              break;
            case 'attack':
              attackers.add(player);
              break;
            default:
              // If position doesn't match known types, add to coaches
              coaches.add(player);
          }
        }
      }

      // Sort by jersey number
      goalkeepers.sort(_compareByJerseyNumber);
      defenders.sort(_compareByJerseyNumber);
      midfielders.sort(_compareByJerseyNumber);
      attackers.sort(_compareByJerseyNumber);
      coaches.sort(_compareByJerseyNumber);

      state = state.copyWith(
        allPlayers: players,
        goalkeepers: goalkeepers,
        defenders: defenders,
        midfielders: midfielders,
        attackers: attackers,
        coaches: coaches,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  int _compareByJerseyNumber(TeamPlayerModel a, TeamPlayerModel b) {
    final jerseyA = a.jerseyNumber;
    final jerseyB = b.jerseyNumber;

    if (jerseyA == null || jerseyA.isEmpty) return 1;
    if (jerseyB == null || jerseyB.isEmpty) return -1;

    // Try to parse as numbers
    final numA = int.tryParse(jerseyA);
    final numB = int.tryParse(jerseyB);

    if (numA != null && numB != null) {
      return numA.compareTo(numB);
    }

    // If not numbers, compare as strings
    return jerseyA.compareTo(jerseyB);
  }

  Future<void> refresh() async {
    await _loadPlayers();
  }
}
