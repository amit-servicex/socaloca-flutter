import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/auth_repository.dart';

/// Feature-level repository provider — screens use this to call auth APIs.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return const AuthRepository();
});

/// Temp state accumulated across the multi-step signup flow:
///   RoleChoiceScreen → AgeSelectionScreen → SignupScreen
class SignupTempState {
  const SignupTempState({
    this.userType = '',
    this.ageGroup = '',
  });

  final String userType; // e.g. 'player', 'coach', 'fan', ...
  final String ageGroup; // e.g. 'adult', 'youth', 'child'

  SignupTempState copyWith({String? userType, String? ageGroup}) {
    return SignupTempState(
      userType: userType ?? this.userType,
      ageGroup: ageGroup ?? this.ageGroup,
    );
  }
}

final signupTempProvider =
    StateNotifierProvider<SignupTempNotifier, SignupTempState>((ref) {
  return SignupTempNotifier();
});

class SignupTempNotifier extends StateNotifier<SignupTempState> {
  SignupTempNotifier() : super(const SignupTempState());

  void setUserType(String userType) =>
      state = state.copyWith(userType: userType);

  void setAgeGroup(String ageGroup) =>
      state = state.copyWith(ageGroup: ageGroup);

  void reset() => state = const SignupTempState();
}
