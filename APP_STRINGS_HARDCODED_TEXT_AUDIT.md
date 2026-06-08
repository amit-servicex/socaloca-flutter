# AppStrings Hardcoded Text Audit

## Objective

Identify every hardcoded user-facing static string in the Flutter app and replace it with the `AppStrings` localization system, so that language changes (triggered from `language_selection_bottom_sheet.dart`) reflect across the entire app.

---

## Localization System Summary

| Item | Detail |
|------|--------|
| System | Custom static class (`AppStrings`) — no `BuildContext` required |
| File | `lib/core/constants/app_strings.dart` |
| Languages | `en`, `es`, `pt`, `fr` |
| Access pattern | `AppStrings.cancel` (named getter) |
| Migration helper | `'Cancel'.tr` (String extension via `AppStrings.literal()`) |
| Language switch | `AppStrings.setLanguage(code)` called by `LocaleNotifier` |
| Persistence | Language code saved in `StorageService` |

The `.tr` extension resolves an English literal against `_englishLiteralKeys` / `_englishLowerLiteralKeys` maps, and preserves the ALL_CAPS casing of the original value (e.g. `'CANCEL'.tr` → translated and uppercased).

---

## Files Scanned

All `.dart` files under `lib/` excluding:
- `*.g.dart`, `*.freezed.dart` (code-generated)
- `._*.dart` (macOS resource forks)
- Data models, repositories, providers (non-UI logic)

Total files scanned: **346** source dart files

---

## Hardcoded Strings Found

| File | Screen/Widget | Hardcoded Text | Convert? | Reason | AppStrings Key |
|------|--------------|----------------|----------|--------|----------------|
| `features/referee/screens/referee_live_match_update_screen.dart:785` | Confirm End Match dialog | `'Warning'` | ✅ | Static dialog title | `warning` (new) |
| `features/referee/screens/referee_live_match_update_screen.dart:786` | Confirm End Match dialog | `'Are you sure you want to end this match?'` | ✅ | Static dialog body | `confirmEndMatch` (new) |
| `features/social_feed/widgets/feed_post_card.dart:427` | Block user dialog | `'No'` | ✅ | Static button | `AppStrings.no` (existing) |
| `features/social_feed/widgets/feed_post_card.dart:450` | Block user dialog | `'Yes'` | ✅ | Static button | `AppStrings.yes` (existing) |
| `features/teams/screens/manage_team_screen.dart:373` | Jersey assignment snackbar | `'Jerseys assigned'` | ✅ | Static message | `jerseysAssigned` (new) |
| `features/teams/screens/manage_team_screen.dart:653` | Edit jersey dialog | `'CANCEL'` | ✅ | Static button | `AppStrings.cancel` (existing) |
| `features/teams/screens/manage_team_screen.dart:663` | Edit jersey dialog | `'SAVE'` | ✅ | Static button | `AppStrings.save` (existing) |
| `features/teams/screens/manage_team_screen.dart:706` | Remove player dialog | `'YES'` | ✅ | Static button | `AppStrings.yes` (existing) |
| `features/teams/screens/manage_team_screen.dart:717` | Remove player dialog | `'NO'` | ✅ | Static button | `AppStrings.no` (existing) |
| `features/teams/screens/manage_team_screen.dart:1550` | Error state | `'Retry'` | ✅ | Static button | `AppStrings.retry` (existing) |
| `features/teams/screens/add_player_screen.dart:274` | Invite player snackbar | `'Invite sent'` | ✅ | Static message | `inviteSent` (new) |
| `features/teams/screens/add_player_screen.dart:334` | Search empty state | `'Enter at least 3 characters to search'` | ✅ | Static hint | `enterAtLeast3Chars` (new) |
| `features/teams/screens/add_player_screen.dart:342` | Search no results | `'No players found'` | ✅ | Static empty state | `noPlayersFound` (new) |
| `features/teams/screens/add_player_screen.dart:602` | Bulk invite snackbar | `'Invitation sent to all numbers'` | ✅ | Static message | `invitationSentAll` (new) |
| `features/teams/screens/add_player_screen.dart:896` | Profile check snackbar | `'Profile name is not available'` | ✅ | Static message | `profileNameNotAvailable` (new) |
| `features/teams/screens/add_player_screen.dart:1090` | Year dropdown hint | `'Select year'` | ✅ | Static hint | `selectYear` (new) |
| `features/teams/screens/edit_team_screen.dart:133` | Image source sheet | `'Camera'` | ✅ | Static label | `camera` (new) |
| `features/teams/screens/edit_team_screen.dart:143` | Image source sheet | `'Gallery'` | ✅ | Static label | `AppStrings.gallery` (existing) |
| `features/teams/screens/edit_team_screen.dart:176` | Save success snackbar | `'Team info updated'` | ✅ | Static message | `teamInfoUpdated` (new) |
| `features/tournaments/screens/league/tabs/league_stats_tab.dart:213` | Stats header | `'PLAYERS'` | ✅ | Static header | `AppStrings.players.toUpperCase()` |
| `features/tournaments/screens/league/tabs/league_stats_tab.dart:217` | Stats header | `'GOALS'` | ✅ | Static header | `AppStrings.goals.toUpperCase()` |
| `features/tournaments/screens/league/tabs/league_stats_tab.dart:231` | Stats header | `'PLAYERS'` | ✅ | Static header | `AppStrings.players.toUpperCase()` |

---

## Strings Not Converted

| File | Text / Value | Reason Not Converted |
|------|-------------|----------------------|
| `core/router/app_router.dart:382` | `'trials - Coming Soon'` | Development placeholder, not production UI |
| `core/router/app_router.dart:772` | `'Confederation Bio — Coming Soon'` | Development placeholder |
| `core/router/app_router.dart:914` | `'Referee Activities — Phase 9'` | Development placeholder |
| `core/router/app_router.dart:988` | `'Page not found: ${state.error}'` | Dynamic — contains runtime error value |
| All files | `Text('Error: $e')` / `Text('Error loading ...: $error')` | Dynamic — contains runtime exception/error value |
| `cup_group_point_table_dialog.dart` | `'#'`, `'P'`, `'W'`, `'D'`, `'L'`, `'GF'`, `'GA'`, `'GD'`, `'Pts'` | Universal football statistical abbreviations, language-neutral |
| `league_stats_tab.dart` | `'${team.played}'`, `'${team.won}'`, etc. | Dynamic API data values |
| All files | `DataCell(Text('${index + 1}'))` | Computed numeric value |
| `social_feed/widgets/feed_post_card.dart:597` | `'🌍'.tr` | Emoji decoration, already uses `.tr` |
| `create_post_screen.dart:1054,1059` | `'0MB'`, `'1024MB'` | Scale markers, technical notation |
| `club_trials_bio_screen.dart:619` | `':'` | Punctuation separator |
| `live_match_details_screen.dart:368,400` | `'—'` | Typographic dash, language-neutral |
| `notifications/utils/notification_navigation_handler.dart:655` | `'$feature not yet available'` | Dynamic — feature name comes from code variable |
| `survey/screens/survey_screen.dart:577` | `'😊'` | Emoji, language-neutral |

---

## AppStrings Keys To Add

| Key | English Value | Used In Files |
|-----|--------------|---------------|
| `warning` | `'Warning'` | `referee_live_match_update_screen.dart` |
| `confirmEndMatch` | `'Are you sure you want to end this match?'` | `referee_live_match_update_screen.dart` |
| `jerseysAssigned` | `'Jerseys assigned'` | `manage_team_screen.dart` |
| `inviteSent` | `'Invite sent'` | `add_player_screen.dart` |
| `enterAtLeast3Chars` | `'Enter at least 3 characters to search'` | `add_player_screen.dart` |
| `noPlayersFound` | `'No players found'` | `add_player_screen.dart` |
| `invitationSentAll` | `'Invitation sent to all numbers'` | `add_player_screen.dart` |
| `profileNameNotAvailable` | `'Profile name is not available'` | `add_player_screen.dart` |
| `selectYear` | `'Select year'` | `add_player_screen.dart` |
| `camera` | `'Camera'` | `edit_team_screen.dart` |
| `teamInfoUpdated` | `'Team info updated'` | `edit_team_screen.dart` |

---

## Implementation Plan

### Phase 1 — Common/shared widgets
No changes needed; `shared/widgets/` already uses AppStrings throughout.

### Phase 2 — Auth/Profile screens
All auth screens already use `.tr` extension or `AppStrings.*` getters extensively. No additional changes required.

### Phase 3 — Home screens
Home screens fully localized. No changes required.

### Phase 4 — Teams screens
- `manage_team_screen.dart` — 5 strings (CANCEL, SAVE, YES, NO, Retry + Jerseys assigned)
- `add_player_screen.dart` — 6 strings (Invite sent, search hints, snackbars)
- `edit_team_screen.dart` — 3 strings (Camera, Gallery, Team info updated)

### Phase 5 — Matches/Referee screens
- `referee_live_match_update_screen.dart` — 2 strings (Warning dialog)

### Phase 6 — Dialogs/Snackbars/Tournament screens
- `league_stats_tab.dart` — 3 header strings (PLAYERS × 2, GOALS × 1)

---

## Implementation Status

| Phase | Status |
|-------|--------|
| Phase 1 — Shared widgets | ✅ Already localized |
| Phase 2 — Auth/Profile | ✅ Already localized (`.tr` used throughout) |
| Phase 3 — Home | ✅ Already localized |
| Phase 4 — Teams | ✅ Implemented |
| Phase 5 — Matches/Referee | ✅ Implemented |
| Phase 6 — Tournaments | ✅ Implemented |

---

## Testing Checklist

- [ ] Change language to Spanish → all static labels update
- [ ] Change language to Portuguese → all static labels update
- [ ] Change language to French → all static labels update
- [ ] Block user dialog shows localized Yes/No
- [ ] Jersey assignment shows localized snackbar
- [ ] Player invite shows localized snackbar
- [ ] End match dialog shows localized Warning title and message
- [ ] Team info updated snackbar localizes
- [ ] League stats PLAYERS / GOALS headers localize
- [ ] API response content (team names, player names, scores) unchanged
- [ ] No UI layout breaks from longer translated strings
