import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  return repository.getUserProfile(user.id);
});
