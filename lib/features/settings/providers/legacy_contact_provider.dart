import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (_) => SettingsRepository(),
);

class LegacyContactState {
  const LegacyContactState({
    this.isLoading = false,
    this.isSaving = false,
    this.hasContact = false,
    this.contactName = '',
    this.contactEmail = '',
    this.error,
    this.saveSuccess = false,
  });

  final bool isLoading;
  final bool isSaving;
  final bool hasContact;
  final String contactName;
  final String contactEmail;
  final String? error;
  final bool saveSuccess;

  LegacyContactState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? hasContact,
    String? contactName,
    String? contactEmail,
    String? error,
    bool? saveSuccess,
  }) =>
      LegacyContactState(
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
        hasContact: hasContact ?? this.hasContact,
        contactName: contactName ?? this.contactName,
        contactEmail: contactEmail ?? this.contactEmail,
        error: error,
        saveSuccess: saveSuccess ?? this.saveSuccess,
      );
}

class LegacyContactNotifier extends StateNotifier<LegacyContactState> {
  LegacyContactNotifier(this._repo) : super(const LegacyContactState());

  final SettingsRepository _repo;

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await _repo.getLegacyContact();
      if (data != null) {
        state = state.copyWith(
          isLoading: false,
          hasContact: data['hasContact'] as bool? ?? false,
          contactName: data['contactName'] as String? ?? '',
          contactEmail: data['contactEmail'] as String? ?? '',
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> save({
    required String contactName,
    required String contactEmail,
  }) async {
    state = state.copyWith(isSaving: true, saveSuccess: false);
    try {
      final success = await _repo.saveLegacyContact(
        contactName: contactName,
        contactEmail: contactEmail,
      );
      state = state.copyWith(
        isSaving: false,
        saveSuccess: success,
        hasContact: success ? true : state.hasContact,
        contactName: success ? contactName : state.contactName,
        contactEmail: success ? contactEmail : state.contactEmail,
      );
      return success;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      return false;
    }
  }
}

final legacyContactProvider = StateNotifierProvider.autoDispose<
    LegacyContactNotifier, LegacyContactState>(
  (ref) => LegacyContactNotifier(ref.read(settingsRepositoryProvider)),
);
