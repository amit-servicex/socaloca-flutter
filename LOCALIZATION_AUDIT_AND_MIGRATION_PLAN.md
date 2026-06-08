# Localization Audit and Migration Plan

## Problem Summary

Changing language from `lib/features/home/widgets/language_selection_bottom_sheet.dart` updates the selected locale, but many screens still display English because user-facing strings are hardcoded or use a literal `.tr` bridge without matching entries in `AppStrings`.

## Current Localization Architecture

The app currently has two localization systems:

1. Generated Flutter localization files under `lib/l10n/`:
   - `app_en.arb`
   - `app_es.arb`
   - `app_fr.arb`
   - `app_pt.arb`
   - generated `AppLocalizations` classes

2. Custom app string registry:
   - `lib/core/constants/app_strings.dart`
   - `AppStrings.xxx` getters
   - `String.get tr => AppStrings.literal(this)`

Most recently migrated screens use `AppStrings`. Many older screens use English literal strings plus `.tr`. The `.tr` bridge only translates literals whose English value already exists in the `AppStrings` English map; otherwise it returns the original English text.

## Language Selection Flow

`LanguageSelectionBottomSheet` calls:

- `ref.read(localeProvider.notifier).setLocale(code, name)`
- `LocaleNotifier.setLocale()` updates `AppStrings.setLanguage(languageCode)`
- selected language is persisted through `StorageService.setLanguageCode`, `setLanguageName`, and `setLanguageSelected`
- `localeProvider` emits `Locale(languageCode)`
- `SocaLocaApp` watches `localeProvider` and passes the locale into `MaterialApp.router`
- `MaterialApp.router` uses `AppLocalizations.localizationsDelegates` and `AppLocalizations.supportedLocales`
- the app tree is wrapped in a `KeyedSubtree` keyed by locale language code

## Locale State Management

Locale state is managed by Riverpod:

- `lib/core/providers/locale_provider.dart`
- provider type: `NotifierProvider<LocaleNotifier, Locale?>`
- persisted storage: `StorageService.languageCode`
- cold-start restore: `LocaleNotifier.build()`

Runtime language switching is supported by the root app. The issue is primarily incomplete string migration and mixed localization patterns, not a missing root rebuild.

## Root Cause

| Cause | Status | Notes |
| --- | --- | --- |
| Locale state not rebuilding root app | Not primary | `SocaLocaApp` watches `localeProvider`; `MaterialApp.router` receives `locale`; subtree key changes. |
| Selected language not persisted | Not primary | `StorageService` persists language code/name/selected flag. |
| Bottom sheet selected item stale | Found | Sheet defaulted to English visually. Fixed to initialize from `AppStrings.currentLanguage`. |
| Hardcoded user-facing strings | Primary | Many `Text('...')`, `SnackBar`, `AlertDialog`, `Tab`, validation, empty states remain hardcoded or use incomplete `.tr`. |
| Missing translation keys | Primary | Many `.tr` literals are not present in `AppStrings`, so they fall back to English. |
| Mixed localization systems | Primary | Generated `AppLocalizations` exists, but screens mostly use `AppStrings`/`.tr`. |

## Hardcoded String Audit

The audit command scanned `Text`, `TextSpan`, `Tab`, `SnackBar`, `AlertDialog`, `InputDecoration`, validators, empty/error states, and buttons. The table below lists representative high-priority findings; the migration should continue screen by screen using the same search patterns.

| File | Screen/Widget | Hardcoded Text | Current Usage | Required Localization Key | Priority |
| --- | --- | --- | --- | --- | --- |
| `lib/shared/widgets/searchable_dropdown.dart` | Search dropdown | `Search...`, `No results found` | `.tr` literal | `searchEllipsis`, `noResultsFound` | High |
| `lib/shared/services/location_service.dart` | Location permission dialogs | `Location Permission`, `Learn more`, `OK` | `.tr` literal | `locationPermission`, `learnMore`, `ok` | High |
| `lib/core/router/app_router.dart` | Placeholder pages/errors | `trials - Coming Soon`, `Page not found: ...` | `.tr` / hardcoded | `comingSoon`, `pageNotFound` | Medium |
| `lib/features/auth/screens/create_profile_screen.dart` | Create profile form | `Select role *`, `About Me`, `minimum 5 characters`, image picker errors | `.tr` literal/snackbar | existing profile keys plus missing validation keys | High |
| `lib/features/auth/screens/signup_screen.dart` | Sign up | `mobile number or email *`, `or continue with`, `Unexpected response. Please try again.` | `.tr` literal/snackbar | `mobileNumberOrEmailRequired`, `orContinueWith`, `unexpectedResponseTryAgain` | High |
| `lib/features/auth/screens/forgot_password_screen.dart` | Forgot password | `Select Country`, `SEND OTP`, dialog labels | `.tr` literal | `selectCountry`, `sendOtpUpper` | High |
| `lib/features/my_bio/screens/edit_profile_screen.dart` | Edit profile | `Nationality *`, `Playing Position`, `Preferred Jersey Number`, `TAKE A PHOTO` | `.tr` literal | existing profile keys plus missing jersey/level keys | High |
| `lib/features/my_bio/screens/create_post_screen.dart` | Create/edit post | `Please write something`, `Post published successfully!`, `Video larger than available space` | `.tr` literal/snackbar | `pleaseWriteSomething`, `postPublishedSuccessfully`, `videoLargerThanAvailableSpace` | High |
| `lib/features/player_bio/screens/player_bio_screen.dart` | Player bio | `User blocked.`, `Report submitted. Thank you.`, dialog buttons | `.tr` literal/snackbar/dialog | `userBlocked`, `reportSubmittedThankYou` | High |
| `lib/features/player_bio/screens/player_pending_teams_screen.dart` | Pending teams | `Pending Requests`, `No pending requests.`, `Request cancelled.` | `.tr` literal/snackbar | `pendingRequests`, `noPendingRequests`, `requestCancelled` | Medium |
| `lib/features/teams/screens/team_bio_screen.dart` | Team bio | `Coach`, `No team data available`, `Failed to load team bio` | `.tr`/hardcoded | `coach`, `noTeamDataAvailable`, `failedToLoadTeamBio` | High |
| `lib/features/teams/widgets/team_filter_section.dart` | Team filters | `Location`, `GO`, typo `All temas` | `.tr` literal | `location`, `go`, `allTeams` | High |
| `lib/features/club/screens/clubs_partners_landing_screen.dart` | Clubs/Partners tabs | `Clubs`, `Partners` | hardcoded Tab text | existing `clubs`, `partners` | High |
| `lib/features/club/screens/partners_screen.dart` | Partners | `FAs`, `Confederations`, `Sponsors`, `Charities & NGOs`, empty states | hardcoded Tab/text | existing/partner keys | High |
| `lib/features/club/screens/club_trials_screen.dart` | Trial filters/dialogs | `SEARCH`, `RESET`, `Age Range`, `Enter a valid email` | `.tr` literal | `search`, `reset`, `ageRange`, `enterValidEmail` | Medium |
| `lib/features/tournaments/screens/tournament_featured_screen.dart` | Tournament details | `Matches fd`, `Points Table`, `Stats`, `Tournament not found` | hardcoded | `matches`, `pointsTable`, `stats`, `tournamentNotFound` | High |
| `lib/features/tournaments/screens/tabs/tournament_stats_tab.dart` | Tournament stats | `Goals`, `Assists`, `Cards`, `POM`, `No data available` | hardcoded | existing `goals`, `assists`, `cards`, `pom`, `noDataAvailable` | High |
| `lib/features/tournaments/screens/league/tabs/league_points_table_tab.dart` | Points table | `Team`, `P`, `W`, `D`, `L`, `GF`, `GA`, `GD`, `Pts` | `.tr` literal | stats table keys | Medium |
| `lib/features/tournaments/screens/match_management/*` | Match management | `SCORE`, `GOALS`, `CARDS`, `MVP`, `Add Goal`, `Delete Goal`, dialog errors | hardcoded/`.tr` | match management keys | High |
| `lib/features/referee/screens/referee_manage_match_screen.dart` | Referee manage match | `SCORE`, `RESET`, `SAVE SCORE`, `PLAYER OF THE MATCH`, `SAVE INCIDENTS`, modal labels | `.tr` literal | referee manage keys | High |
| `lib/features/referee/screens/referee_live_match_update_screen.dart` | Live update | dialog `Warning`, validation toasts, status labels | mixed AppStrings/hardcoded | live match message keys | High |
| `lib/features/referee/screens/referee_my_requests_screen.dart` | Referee requests | `Decline Reason`, `Enter reason...`, `Action failed. Please try again.` | `.tr` literal/snackbar/dialog | request keys | High |
| `lib/features/live_match/screens/live_match_details_screen.dart` | Live details | `Retry`, event labels, fallback punctuation | `.tr`/hardcoded | live detail keys | Medium |
| `lib/features/social_feed/widgets/feed_post_card.dart` | Feed post | `No`, `Yes`, `Double Tap to Cheer`, `SHARE` | hardcoded/`.tr` | existing common keys plus feed keys | Medium |
| `lib/features/settings/screens/settings_screen.dart` | Settings placeholder | `Settings`, `TODO: Implement Settings` | `.tr` literal | `settings`, `todoImplementSettings` | Low |
| `lib/features/cups/screens/cups_screen.dart` | Cups placeholder | `Cups`, `TODO: Implement Cups` | `.tr` literal | `cups`, `todoImplementCups` | Low |
| `lib/features/matches/screens/matches_screen.dart` | Matches placeholder | `Matches`, `TODO: Implement Matches` | `.tr` literal | existing `matches`, `todoImplementMatches` | Low |

## Missing Translation Keys

| Key | English Text | Existing? | Required Languages | File To Update |
| --- | --- | --- | --- | --- |
| `ok` | OK | Missing in `AppStrings` | en, es, pt, fr | `app_strings.dart` |
| `learnMore` | Learn more | Missing in `AppStrings` | en, es, pt, fr | `app_strings.dart` |
| `locationPermission` | Location Permission | Missing in `AppStrings` | en, es, pt, fr | `app_strings.dart` |
| `searchEllipsis` | Search... | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `noResultsFound` | No results found | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `retry` | Retry | Exists as getter in some usage | en, es, pt, fr | verify `app_strings.dart` |
| `warning` | Warning | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `pageNotFound` | Page not found | Missing | en, es, pt, fr | `app_strings.dart` |
| `reset` | RESET / Reset | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `go` | GO | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `settings` | Settings | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `pointsTable` | Points Table | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `stats` | Stats | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `noDataAvailable` | No data available | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `coach` | Coach | Missing/inconsistent | en, es, pt, fr | `app_strings.dart` |
| `allTeams` | All teams | Missing | en, es, pt, fr | `app_strings.dart` |
| `pleaseWriteSomething` | Please write something | Missing | en, es, pt, fr | `app_strings.dart` |
| `postPublishedSuccessfully` | Post published successfully! | Missing | en, es, pt, fr | `app_strings.dart` |
| `userBlocked` | User blocked. | Missing | en, es, pt, fr | `app_strings.dart` |
| `reportSubmittedThankYou` | Report submitted. Thank you. | Missing | en, es, pt, fr | `app_strings.dart` |

Translation note: if exact Spanish/Portuguese/French wording is not available during a migration phase, use English fallback temporarily and mark it in this document until product-approved translations arrive.

## Runtime Language Change Issues

- Root rebuild is wired correctly through `localeProvider`.
- `AppStrings` is updated before provider state changes.
- `MaterialApp.router.locale` receives the current locale.
- `KeyedSubtree` forces a full widget subtree replacement on language change.
- Fixed issue: `LanguageSelectionBottomSheet` now initializes selected language from `AppStrings.currentLanguage` instead of always showing English selected.
- Remaining issue: screens that do not use `AppStrings` keys or known `.tr` literals still show English after rebuild.

## Required Code Changes

1. Standardize new migrations on `AppStrings` named getters.
2. Keep `.tr` only as an interim bridge for legacy literals.
3. Add missing keys to `AppStrings` in all four languages.
4. Convert shared widgets first so many screens improve at once.
5. Replace `SnackBar`, dialog, validation, empty, loading, and error literals with `AppStrings` keys.
6. Avoid translating non-user-facing values such as API names, route names, payload fields, asset names, debug logs, enum values, IDs, and formatting-only punctuation.

## Phase-wise Implementation Plan

### Phase 1

Fix global language state/rebuild issues if needed.

- Verified `MaterialApp.router.locale` and localization delegates are configured.
- Fixed language sheet selected-index restore.
- Verify selected language persists after app restart.

### Phase 2

Convert common/shared widgets.

- `searchable_dropdown.dart`
- `app_snackbar.dart`
- `app_toast.dart`
- `confirm_dialog.dart`
- `match_card.dart`
- location permission dialogs

### Phase 3

Convert auth/profile/home/team/match/referee screens.

- Auth: login/signup/forgot password/OTP/create profile/edit profile.
- Home: shell, drawer, feed sections, language selection.
- Teams: team list, team bio, filters, players.
- Tournaments/matches: tournament details, stats, match management.
- Referee: live matches, manage match, requests, live update.

### Phase 4

Convert dialogs/snackbars/validations/empty states.

- Replace all `SnackBar(content: Text('...'))`.
- Replace all `AlertDialog(title/content/actions)` hardcoded text.
- Replace validators that return hardcoded strings.
- Replace empty/error/loading state text.

### Phase 5

Testing and cleanup.

- Re-run hardcoded string scans.
- Remove duplicate keys.
- Prefer reusable common keys.
- Run `flutter analyze`.
- Run `flutter test` if available.

## Testing Checklist

1. Launch app in English.
2. Open language bottom sheet and switch to Spanish.
3. Confirm current screen updates immediately.
4. Navigate to home, auth, team, tournament, referee, profile, dialogs, snackbars/toasts, and validation states.
5. Restart app and verify selected language persists.
6. Repeat for Portuguese and French.
7. Run hardcoded string audit command again.
8. Run `flutter analyze --no-pub`.
9. Run `flutter test` if test suite/dependencies are available.
