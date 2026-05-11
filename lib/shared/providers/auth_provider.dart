import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/storage_service.dart';
import '../models/user_model.dart';

/// Auth state held in memory — mirrors GlobalDataService from Android
class AuthState {
  const AuthState({
    this.user,
    this.clubUser,
    this.token,
  });

  final UserModel? user;
  final ClubUserModel? clubUser;
  final String? token;

  bool get isAuthenticated => token != null;
  bool get isClub => clubUser != null;

  AuthState copyWith({
    UserModel? user,
    ClubUserModel? clubUser,
    String? token,
  }) {
    return AuthState(
      user: user ?? this.user,
      clubUser: clubUser ?? this.clubUser,
      token: token ?? this.token,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final token = StorageService.authToken;
    if (token == null) return;

    final rawUser = StorageService.currentUser;
    final rawClub = StorageService.clubUser;

    state = AuthState(
      token: token,
      user: rawUser != null ? UserModel.fromJson(rawUser) : null,
      clubUser: rawClub != null ? ClubUserModel.fromJson(rawClub) : null,
    );
  }

  Future<void> setUserSession({
    required String token,
    required UserModel user,
  }) async {
    await StorageService.setAuthToken(token);
    await StorageService.setCurrentUser(user.toJson());
    state = AuthState(token: token, user: user);
  }

  Future<void> setClubSession({
    required String token,
    required ClubUserModel clubUser,
  }) async {
    await StorageService.setAuthToken(token);
    await StorageService.setClubUser(clubUser.toJson());
    state = AuthState(token: token, clubUser: clubUser);
  }

  Future<void> logout() async {
    await StorageService.clearUserSession();
    state = const AuthState();
  }
}

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());

/// Convenience provider — current user (non-club)
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authStateProvider).user;
});

/// Convenience provider — current club user
final currentClubUserProvider = Provider<ClubUserModel?>((ref) {
  return ref.watch(authStateProvider).clubUser;
});
