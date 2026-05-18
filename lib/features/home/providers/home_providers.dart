import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user_model.dart';
import '../../../shared/providers/auth_provider.dart';
import '../data/home_repository.dart';
import '../data/models/match_update_model.dart';

// ─── Repository Provider ──────────────────────────────────────────────────────

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return const HomeRepository();
});

// ─── Blocked Users Provider ───────────────────────────────────────────────────

final blockedUsersProvider = FutureProvider<List<String>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final repository = ref.watch(homeRepositoryProvider);
  return repository.getBlockedUsers(user.id);
});

// ─── Notification Count Provider ──────────────────────────────────────────────

class NotificationCountNotifier extends StateNotifier<int> {
  NotificationCountNotifier(this.ref) : super(0) {
    _startPolling();
  }

  final Ref ref;
  Timer? _timer;

  void _startPolling() {
    // Poll every 5 seconds like Android
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      // _fetchCount();
    });
    // Fetch immediately
    // _fetchCount();
  }

  Future<void> _fetchCount() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    final repository = ref.read(homeRepositoryProvider);
    final count = await repository.getNotificationCount(user.id);
    state = count;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final notificationCountProvider =
    StateNotifierProvider<NotificationCountNotifier, int>((ref) {
  return NotificationCountNotifier(ref);
});

// ─── App Update Provider ──────────────────────────────────────────────────────

final appUpdateProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.checkAppUpdate();
});

// ─── Match Updates Provider ───────────────────────────────────────────────────
/// Provides match updates for Player/Coach/Manager/Admin roles
/// Matches Android UPDATEMATCH API
final matchUpdatesProvider =
    FutureProvider<List<MatchUpdateModel>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  // Only fetch for non-fan roles
  if (user.isFan) return [];

  final repository = ref.watch(homeRepositoryProvider);
  return repository.getMatchUpdates(user.id);
});

// ─── User Profile Provider ────────────────────────────────────────────────────
/// Provides complete user profile
/// Should be called before feed loads
final userProfileDetailsProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repository = ref.watch(homeRepositoryProvider);
  final profile = await repository.getUserProfile(user.id);
  if (profile != null) {
    final updatedUser = user.copyWith(
      firstName: profile['firstName']?.toString() ?? user.firstName,
      lastName: profile['lastName']?.toString() ?? user.lastName,
      name: _profileName(profile) ?? user.name,
      username: profile['profileName']?.toString() ?? user.username,
      email: profile['email']?.toString() ?? user.email,
      profileImage: profile['imageUrl']?.toString() ?? user.profileImage,
      phone: profile['mobile']?.toString() ?? user.phone,
      country: profile['country']?.toString() ?? user.country,
      sclId: readSclId(profile) ?? user.sclId,
      postCount: _readInt(profile['postCount']) ?? user.postCount,
      likeCount: _readInt(profile['likeCount']) ?? user.likeCount,
      followersCount: _readInt(profile['followCount']) ?? user.followersCount,
      followingCount:
          _readInt(profile['followingCount']) ?? user.followingCount,
    );

    if (updatedUser != user) {
      await ref.read(authStateProvider.notifier).updateUser(updatedUser);
    }
  }
  return profile;
});

String? _profileName(Map<String, dynamic> profile) {
  final firstName = profile['firstName']?.toString() ?? '';
  final lastName = profile['lastName']?.toString() ?? '';
  final fullName = '$firstName $lastName'.trim();
  if (fullName.isNotEmpty) return fullName;
  return profile['profileName']?.toString();
}

int? _readInt(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}
