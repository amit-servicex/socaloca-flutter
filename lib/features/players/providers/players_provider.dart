import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/storage_service.dart';
import '../data/models/player_model.dart';
import '../data/repositories/players_repository.dart';

/// State for players list with filters and pagination
class PlayersState {
  final List<PlayerModel> players;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final String playPosition;
  final String ageGroup;
  final String gender;

  const PlayersState({
    this.players = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.playPosition = '',
    this.ageGroup = '',
    this.gender = '',
  });

  PlayersState copyWith({
    List<PlayerModel>? players,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    String? playPosition,
    String? ageGroup,
    String? gender,
  }) {
    return PlayersState(
      players: players ?? this.players,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      playPosition: playPosition ?? this.playPosition,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
    );
  }
}

/// Notifier for players list with pagination and filters
class PlayersNotifier extends StateNotifier<PlayersState> {
  PlayersNotifier(this._ref) : super(const PlayersState());

  final Ref _ref;
  static const int _pageSize = 10;

  /// Load initial players list
  Future<void> load() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final userId = StorageService.userId ?? '';
      final user = StorageService.currentUser;
      final country = user?['country'] ?? '';

      if (userId.isEmpty || country.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not logged in or country not set',
        );
        return;
      }

      final players = await _ref.read(playersRepositoryProvider).getPlayers(
            userId: userId,
            country: country,
            playPosition: state.playPosition,
            gender: state.gender,
            ageGroup: state.ageGroup,
            start: 0,
            limit: _pageSize,
          );

      state = state.copyWith(
        players: players,
        isLoading: false,
        hasMore: players.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load more players (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final userId = StorageService.userId ?? '';
      final user = StorageService.currentUser;
      final country = user?['country'] ?? '';

      final newPlayers = await _ref.read(playersRepositoryProvider).getPlayers(
            userId: userId,
            country: country,
            playPosition: state.playPosition,
            gender: state.gender,
            ageGroup: state.ageGroup,
            start: state.players.length,
            limit: _pageSize,
          );

      state = state.copyWith(
        players: [...state.players, ...newPlayers],
        isLoadingMore: false,
        hasMore: newPlayers.length >= _pageSize,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// Set filters and reload
  void setFilters({
    String? playPosition,
    String? ageGroup,
    String? gender,
  }) {
    state = state.copyWith(
      playPosition: playPosition ?? state.playPosition,
      ageGroup: ageGroup ?? state.ageGroup,
      gender: gender ?? state.gender,
      players: [],
      hasMore: true,
    );
    load();
  }

  /// Refresh players list
  Future<void> refresh() async {
    state = state.copyWith(players: [], hasMore: true);
    await load();
  }
}

/// Provider for players repository
final playersRepositoryProvider = Provider<PlayersRepository>((ref) {
  return PlayersRepository();
});

/// Provider for players list
final playersProvider =
    StateNotifierProvider<PlayersNotifier, PlayersState>((ref) {
  return PlayersNotifier(ref);
});
