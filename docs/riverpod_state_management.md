# Riverpod State Management Documentation

This document explains how Riverpod is implemented in the SocaLoca Flutter app and how it manages application state.

Project path:

```text
socaloca-flutter
```

## 1. Riverpod Setup

Riverpod is initialized at the root of the app in:

```text
lib/main.dart
```

The app is wrapped with `ProviderScope`:

```dart
runApp(
  const ProviderScope(
    child: SocaLocaApp(),
  ),
);
```

`ProviderScope` creates the global Riverpod container. All providers in the app live inside this scope.

Before `ProviderScope` is created, the app initializes:

- Flutter bindings
- portrait orientation
- Firebase
- `StorageService`

This is important because many providers read user/session data from `StorageService`.

## 2. Riverpod Dependency

The project uses Riverpod through:

```yaml
flutter_riverpod: ^2.5.1
riverpod_annotation: ^2.3.5
riverpod_generator: ^2.4.0
riverpod_lint: ^2.3.10
```

Although generator packages are included, the current implementation mostly uses manual Riverpod providers instead of generated `@riverpod` providers.

## 3. Main Provider Types Used

The project mainly uses these Riverpod provider types:

### Provider

Used for repositories and derived read-only values.

Example:

```dart
final academiesRepositoryProvider = Provider<AcademiesRepository>((ref) {
  return AcademiesRepository();
});
```

### StateNotifierProvider

Used for mutable screen or feature state.

Example:

```dart
final academiesProvider =
    StateNotifierProvider<AcademiesNotifier, AcademiesState>((ref) {
  final repository = ref.watch(academiesRepositoryProvider);
  return AcademiesNotifier(repository);
});
```

### FutureProvider

Used for async one-time reads.

Example:

```dart
final appUpdateProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.checkAppUpdate();
});
```

### FutureProvider.family

Used when async data depends on a parameter such as an ID.

Example:

```dart
final academyBioProvider =
    FutureProvider.family<AcademyBioData?, String>((ref, academyId) async {
  final userId = StorageService.userId ?? '';
  return ref.read(academiesRepositoryProvider).getAcademyBio(
        userId: userId,
        academyId: academyId,
      );
});
```

### StateNotifierProvider.family

Used when mutable action state belongs to a specific entity.

Example:

```dart
final cupFollowProvider =
    StateNotifierProvider.family<CupFollowNotifier, AsyncValue<bool>, String>(
  (ref, tournamentId) => CupFollowNotifier(ref),
);
```

## 4. App-Level Riverpod Usage

The root app widget is:

```text
lib/app.dart
```

`SocaLocaApp` extends `ConsumerWidget`, which gives access to `WidgetRef`.

```dart
class SocaLocaApp extends ConsumerWidget {
  const SocaLocaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
```

The app watches `appRouterProvider`, so routing is also managed through Riverpod.

## 5. Auth State Management

Auth state is implemented in:

```text
lib/shared/providers/auth_provider.dart
```

### AuthState

`AuthState` stores the current session:

```dart
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
}
```

It tracks:

- normal logged-in user
- club user
- auth token

### AuthNotifier

`AuthNotifier` extends:

```dart
StateNotifier<AuthState>
```

It loads the saved session from `StorageService` when created:

```dart
AuthNotifier() : super(const AuthState()) {
  _loadFromStorage();
}
```

It exposes these main methods:

```dart
setUserSession()
setClubSession()
logout()
```

Each method updates storage and then assigns a new `state`.

Example:

```dart
state = AuthState(token: token, user: user);
```

When `state` changes, all widgets/providers watching `authStateProvider` are notified.

### Auth Providers

```dart
final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
```

Convenience providers are also available:

```dart
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authStateProvider).user;
});

final currentClubUserProvider = Provider<ClubUserModel?>((ref) {
  return ref.watch(authStateProvider).clubUser;
});
```

These allow features to read only the user they need without depending on the full auth state.

## 6. Router Integration

Routing is implemented in:

```text
lib/core/router/app_router.dart
```

The router is provided through:

```dart
final appRouterProvider = Provider<GoRouter>((ref) {
  ...
});
```

The router listens to auth state through a `ChangeNotifier` bridge:

```dart
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen<AuthState>(authStateProvider, (_, __) => notifyListeners());
  }
}
```

This allows GoRouter to re-check redirects when login/logout state changes.

The redirect function reads the current auth state:

```dart
final authState = ref.read(authStateProvider);
```

Then it decides whether the user can access the requested route.

Main routing rules:

- splash route is allowed to handle its own navigation
- unauthenticated users are redirected to login
- club users can access club/settings routes
- authenticated users are redirected away from most auth routes
- onboarding and signup-related routes are explicitly allowed

## 7. Repository Provider Pattern

Most features expose repositories through `Provider`.

Examples:

```dart
final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});
```

```dart
final notificationsRepositoryProvider = Provider<NotificationsRepository>((ref) {
  return NotificationsRepository();
});
```

```dart
final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  return TournamentRepository();
});
```

This keeps repository creation centralized and allows notifiers/screens to access repositories through `ref.read` or `ref.watch`.

## 8. Feature State Pattern

Most feature screens follow this pattern:

```text
Screen
  watches provider state
  calls notifier methods

State class
  stores data, loading flags, filters, errors

Notifier
  mutates state
  calls repository
  handles loading, success, error, pagination

Repository
  performs API calls
  maps response into models
```

## 9. Example: Academies List

Files:

```text
lib/features/academies/providers/academies_provider.dart
lib/features/academies/screens/academies_screen.dart
lib/features/academies/data/repositories/academies_repository.dart
```

### AcademiesState

`AcademiesState` contains:

```dart
final List<AcademyModel> academies;
final bool isLoading;
final bool isLoadingMore;
final String? error;
final String? selectedCountry;
final String? selectedConfederation;
final String? selectedCategory;
final int start;
final bool hasMore;
```

This state manages:

- academy list
- first-page loading
- pagination loading
- error message
- selected filters
- API pagination start value
- whether more results are available

### AcademiesNotifier

`AcademiesNotifier` owns the business logic:

```dart
class AcademiesNotifier extends StateNotifier<AcademiesState>
```

Important methods:

```dart
setCountry()
setCategory()
search()
loadMore()
reset()
```

### Search Flow

When `search()` is called:

1. old list is cleared
2. `isLoading` becomes `true`
3. pagination starts from `0`
4. `_loadAcademies()` is called
5. repository fetches data
6. state is updated with new academies

```dart
state = state.copyWith(
  isLoading: true,
  error: null,
  start: 0,
  hasMore: true,
  academies: [],
);
```

### Pagination Flow

When the screen reaches near the bottom, it calls:

```dart
ref.read(academiesProvider.notifier).loadMore();
```

The notifier prevents duplicate pagination calls:

```dart
if (state.isLoadingMore || !state.hasMore) return;
```

New results are appended:

```dart
final updatedAcademies = [...state.academies, ...newAcademies];
```

`hasMore` is calculated from the API result size:

```dart
final hasMore = newAcademies.length >= 10;
```

## 10. Example: Academy Bio

Files:

```text
lib/features/academies/providers/academy_bio_provider.dart
lib/features/academies/screens/academy_bio_screen.dart
```

Academy bio uses `FutureProvider.family`:

```dart
final academyBioProvider =
    FutureProvider.family<AcademyBioData?, String>((ref, academyId) async {
  final userId = StorageService.userId ?? '';
  return ref.read(academiesRepositoryProvider).getAcademyBio(
        userId: userId,
        academyId: academyId,
      );
});
```

The `academyId` parameter creates a separate provider instance for each academy.

The screen watches it like this:

```dart
final bioAsync = ref.watch(academyBioProvider(widget.academyId));
```

The UI handles async states with:

```dart
bioAsync.when(
  data: ...,
  loading: ...,
  error: ...,
)
```

This is the standard Riverpod pattern for async detail screens.

## 11. Example: Players List

Files:

```text
lib/features/players/providers/players_provider.dart
lib/features/players/screens/players_screen.dart
```

The players feature uses:

```dart
PlayersState
PlayersNotifier
playersProvider
playersRepositoryProvider
```

`PlayersState` stores:

- players
- loading flag
- pagination loading flag
- has more flag
- error
- play position filter
- age group filter
- gender filter

The screen calls:

```dart
ref.read(playersProvider.notifier).load();
ref.read(playersProvider.notifier).loadMore();
ref.read(playersProvider.notifier).setFilters(...);
```

The screen watches:

```dart
final state = ref.watch(playersProvider);
```

This means the UI rebuilds whenever the players state changes.

## 12. Example: Notifications

Files:

```text
lib/features/notifications/providers/notifications_provider.dart
lib/features/notifications/screens/notifications_screen.dart
```

Notifications use a `StateNotifierProvider` with a custom state class:

```dart
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier(
    repository: ref.read(notificationsRepositoryProvider),
  );
});
```

The notifier supports:

```dart
loadNotifications()
loadMoreNotifications()
refresh()
```

The screen renders:

- shimmer while loading
- error state if first load fails
- empty state if there are no notifications
- paginated list when data exists
- bottom loader when loading more

## 13. Example: Tournaments and Cups

Files:

```text
lib/features/tournaments/providers/tournament_providers.dart
lib/features/tournaments/providers/cup_providers.dart
```

Tournament and cup providers use more `FutureProvider.family` and `StateNotifierProvider.family` because most data depends on tournament IDs, round IDs, group IDs, or stat types.

Examples:

```dart
final cupDetailsProvider = FutureProvider.family<TournamentCupModel?, String>(
  (ref, tournamentId) async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;

    final repository = ref.watch(cupRepositoryProvider);
    return await repository.getCupDetails(
      userId: user.id,
      tournamentId: tournamentId,
    );
  },
);
```

For actions like follow:

```dart
class CupFollowNotifier extends StateNotifier<AsyncValue<bool>>
```

It changes state like this:

```dart
state = const AsyncValue.loading();
state = AsyncValue.data(result['isFollow'] as bool);
state = AsyncValue.error(e, stack);
```

After a successful follow action, the details provider is invalidated:

```dart
ref.invalidate(cupDetailsProvider(tournamentId));
```

This forces the details data to refresh.

## 14. ref.watch vs ref.read

The project uses `ref.watch` when UI or provider logic needs to react to changes.

Example:

```dart
final state = ref.watch(academiesProvider);
```

This rebuilds the widget when `academiesProvider` changes.

The project uses `ref.read` when calling an action or reading a value once.

Example:

```dart
ref.read(academiesProvider.notifier).search();
```

This does not subscribe the widget to changes. It simply calls the notifier method.

General rule used in the project:

```text
ref.watch = listen and rebuild/react
ref.read = one-time read or action call
```

## 15. StateNotifier State Updates

State is updated immutably.

State classes usually define `copyWith`.

Example:

```dart
state = state.copyWith(
  isLoading: false,
  academies: updatedAcademies,
  hasMore: hasMore,
);
```

The old state object is not modified directly. A new state object is assigned.

This is important because Riverpod notifies listeners when `state` is replaced.

## 16. Loading, Empty, Error, Success Handling

The app uses two patterns.

### Custom State Classes

Used by features like academies, players, search, notifications.

Typical fields:

```dart
bool isLoading;
bool isLoadingMore;
String? error;
bool hasMore;
List<T> items;
```

Common UI logic:

```text
if loading and list is empty -> show full loader
else if error and list is empty -> show error/retry
else if list is empty -> show empty state
else -> show list
if loading more -> show bottom loader
```

### AsyncValue

Used by `FutureProvider` and some action notifiers.

Typical UI logic:

```dart
asyncValue.when(
  data: (data) => ...,
  loading: () => ...,
  error: (error, stack) => ...,
)
```

## 17. Local Widget State vs Riverpod State

The app does not put every value into Riverpod.

Local UI-only values often stay inside widgets with `setState`.

Examples:

- dropdown selected label
- page controller index
- local joining/following flags
- scroll controllers
- text controllers

Riverpod is used for:

- API data
- auth/session data
- screen state that affects rendering
- pagination
- filters used by API calls
- async action state

This split keeps Riverpod focused on app and feature state while allowing simple UI state to remain local.

## 18. API and Storage Relationship

Many providers read session information from `StorageService`.

Examples:

```dart
final userId = StorageService.userId;
final user = StorageService.currentUser;
```

Repositories use the API layer, while providers/notifiers prepare request parameters from:

- provider state
- current user
- route ID
- selected filters
- pagination values

The API client automatically attaches the auth token from `StorageService`.

## 19. Common Feature Flow

Most features follow this lifecycle:

```text
1. Screen opens
2. initState schedules initial load
3. Screen calls ref.read(provider.notifier).load()
4. Notifier sets loading state
5. Notifier calls repository
6. Repository calls API
7. API returns response
8. Repository maps response to models
9. Notifier assigns new state
10. UI rebuilds because it uses ref.watch(provider)
```

## 20. Architecture Summary

The Riverpod architecture in this project can be summarized as:

```text
ProviderScope
  SocaLocaApp
    appRouterProvider
      authStateProvider

Feature Screen
  ref.watch(featureProvider)
  ref.read(featureProvider.notifier).action()

Feature Provider
  creates Notifier
  injects Repository

Notifier
  owns feature state
  handles loading/error/success
  calls repository

Repository
  calls API
  returns models
```

This gives the project a clear separation of responsibilities:

- widgets render UI
- notifiers manage state transitions
- providers connect dependencies
- repositories handle API calls
- models represent response data

## 21. Important Files

Core Riverpod setup:

```text
lib/main.dart
lib/app.dart
lib/core/router/app_router.dart
lib/shared/providers/auth_provider.dart
```

Auth providers:

```text
lib/features/auth/providers/auth_provider.dart
lib/shared/providers/auth_provider.dart
```

Academies providers:

```text
lib/features/academies/providers/academies_provider.dart
lib/features/academies/providers/academy_bio_provider.dart
```

Players provider:

```text
lib/features/players/providers/players_provider.dart
```

Search provider:

```text
lib/features/search/providers/search_provider.dart
```

Notifications provider:

```text
lib/features/notifications/providers/notifications_provider.dart
```

Home providers:

```text
lib/features/home/providers/home_providers.dart
lib/features/home/providers/home_feed_providers.dart
```

Tournament providers:

```text
lib/features/tournaments/providers/tournament_providers.dart
lib/features/tournaments/providers/cup_providers.dart
```

Team providers:

```text
lib/features/teams/providers/teams_provider.dart
lib/features/teams/providers/team_bio_provider.dart
lib/features/teams/providers/team_players_provider.dart
```

Referee providers:

```text
lib/features/referee/providers/referee_providers.dart
```

## 22. Notes for Future Development

When adding a new Riverpod feature, follow the existing project pattern:

1. Create a repository provider.
2. Create a state class if the screen has mutable UI/API state.
3. Create a `StateNotifier` for actions and state transitions.
4. Expose it through `StateNotifierProvider`.
5. Use `FutureProvider.family` for simple ID-based detail fetches.
6. Use `ref.watch` in UI for state.
7. Use `ref.read(...notifier)` for button taps, initial loads, refresh, and pagination.
8. Keep local visual-only state in the widget when it does not need to be shared.
9. Handle loading, empty, error, and success states explicitly.
10. Invalidate related providers after successful mutations when fresh data is needed.
