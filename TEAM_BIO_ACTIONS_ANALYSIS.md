# Team Bio Actions Analysis

## Objective

Analyze the legacy Android SocaLoca app's Team Bio screen for Edit, Manage, and Delete action
button behavior, and implement matching behavior in the Flutter app's `team_bio_screen.dart`.

---

## Android Source Files Inspected

| File | Purpose |
|------|---------|
| `Socaloca-legacy/.../fragment/TeamBioFragment.java` | Main team bio screen; contains all three action button handlers |
| `Socaloca-legacy/.../res/layout/fragment_team_bio.xml` | Layout — `editManageBox` LinearLayout holds EDIT, MANAGE, delete-trash buttons |
| `Socaloca-legacy/.../res/layout/team_delete_archive_popup.xml` | First dialog — offers DELETE or ARCHIVE choice |
| `Socaloca-legacy/.../res/layout/team_delete_popup.xml` | Second dialog — "Are you sure to delete this team?" confirmation |
| `Socaloca-legacy/.../libs/APINames.java` | Endpoint constant: `DELETE_TEAM = "deleteTeam"` |
| `Socaloca-legacy/.../libs/Params.java` | Failure reason constants: `NO_TEAM`, `NO_RIGHT`, `HAS_PLAYER`, `HAS_MATCH`, `HAS_TOURNAMENT` |
| `Socaloca-legacy/.../model/Team.java` | Team model — `teamId`, `createdBy`, `isAdmin` fields |
| `Socaloca-legacy/.../APIRequest/PostApiRequest.java` | Volley POST wrapper — appends endpoint name to base URL |

---

## Flutter Source Files Inspected

| File | Purpose |
|------|---------|
| `lib/features/teams/screens/team_bio_screen.dart` | Team bio UI — `ConsumerWidget`, no AppBar, no admin actions |
| `lib/features/teams/providers/team_bio_provider.dart` | `TeamBioState` + `TeamBioNotifier` — already holds `isAdmin`, `createdBy`, `isArchive` |
| `lib/features/teams/data/repositories/team_bio_repository.dart` | API calls — follow, request-to-join, fetch bio; no delete method yet |
| `lib/core/constants/api_constants.dart` | Already has `deleteTeam`, `editTeam`, `archiveTeam` constants defined |
| `lib/core/router/app_routes.dart` | No edit-team or manage-team routes exist |

---

## Existing Flutter Team Bio Summary

- `TeamBioScreen` is a `ConsumerWidget` with **no Scaffold AppBar**.
- The screen already receives `state.isAdmin` and `state.createdBy` from the provider.
- `TeamBioState` has all required fields: `isAdmin`, `createdBy`, `isArchive`.
- `ApiConstants.deleteTeam` constant exists but no repository method calls it.
- No `editTeam` or `manageTeam` Flutter screens exist.

---

## Android UI Behavior

Buttons are placed inside a horizontal `LinearLayout` (`editManageBox`) in the team header,
next to the team logo and info rows — **not** in the AppBar menu.

| Button | Widget type | Text/Icon |
|--------|------------|-----------|
| EDIT   | White outlined button, 80dp | Text "EDIT" |
| MANAGE | Black filled button, 80dp | Text "MANAGE", yellow text |
| DELETE | ImageView, 35×35dp | `ic_trash_new` icon, visibility GONE by default |

---

## Edit Action

### Visibility Logic

```
visible when: state.isAdmin == true
```

Shown inside `editManageBox` which becomes `View.VISIBLE` when `isAdmin` is true.
The edit button itself has no additional condition beyond `isAdmin`.

### Click Behavior

Launches `EditTeamFragment`, passing the full `Team` object via `setTeam(team)`.

### Navigation Target

`EditTeamFragment` — Android-only. **No equivalent Flutter screen exists.**

### Parameters Passed

The full `Team` object (all team details including `teamId`, name, logo, etc.).

### API Usage

No API call before navigation. The edit screen itself calls `editTeam` on save.

---

## Manage Action

### Visibility Logic

```
visible when: state.isAdmin == true
```

Same `editManageBox` container as Edit — both shown/hidden together.

### Click Behavior

Launches `ManageTeamLandingFragment` with the full `Team` object.

### Navigation Target

`ManageTeamLandingFragment` — a tabbed screen with three tabs:
- **Tab 0 — NEW_REQUEST**: Player join requests (accept/reject)
- **Tab 1 — NEW_PLAYERS**: Invite players to team
- **Tab 2 — JERSEY_ASSIGNED**: Assign jersey numbers

**No equivalent Flutter screen exists.**

### Parameters Passed

The full `Team` object.

### API Usage

No API call before navigation. Each tab makes its own API calls.

---

## Delete Action

### Visibility Logic

```
visible when: state.isAdmin == true
           AND StorageService.userId == state.createdBy
```

Only the team **creator** can delete. Being an admin alone is not sufficient.

### Confirmation Dialog

Android shows a **two-step** dialog flow:

**Step 1 — `deleteArchiveTeamPopup()`:**
- Presents two choices: "DELETE" or "ARCHIVE"

**Step 2 — `deleteTeamPopup()` (when DELETE selected):**
- Message: `"Are you sure to\ndelete this team?"`
- Positive button: **"YES"** (white background, black text, outlined)
- Negative button: **"NO"** (black background, yellow text, filled)

Flutter implementation uses a **single confirmation dialog** (Archive is out of scope).

### API Endpoint

```
POST {BASE_URL}/deleteTeam
```

Constant: `ApiConstants.deleteTeam`

### Request Payload

```json
{
  "teamId": "<team ID>",
  "userId": "<current user ID>"
}
```

### Success Handling

- API returns `{ status: 1, success: true }`
- Toast: **"Team Deleted Successfully."**
- Navigate **back** (equivalent to Android's `onBackPressed()`)

### Failure Handling

API returns `{ status: 1, success: false, reason: "<code>" }`:

| Reason code | User-facing message |
|-------------|-------------------|
| `noTeam` | "This team does not exist." |
| `noRight` | "You don't have permissions to delete." |
| `hasPlayer` | "This team has players assigned and cannot be deleted. Please remove all players before you delete." |
| `hasMatch` | "This team has participated in Matches, and cannot be deleted." |
| `hasTournament` | "This team is participating in a Tournament, and cannot be deleted." |
| (other/network) | Show generic error message in a SnackBar |

---

## Flutter Required Changes

| File | Change |
|------|--------|
| `team_bio_repository.dart` | Add `deleteTeam()` method |
| `team_bio_provider.dart` | Add `isDeleteLoading` to state; add `deleteTeam()` to notifier |
| `team_bio_screen.dart` | Convert to `ConsumerStatefulWidget`; add AppBar with back + actions; add Edit/Manage/Delete buttons in team info header row |

---

## API Mapping

| Android endpoint constant | Flutter constant |
|--------------------------|-----------------|
| `APINames.DELETE_TEAM` = `"deleteTeam"` | `ApiConstants.deleteTeam` = `'deleteTeam'` |

---

## Navigation Mapping

| Android screen | Flutter equivalent | Status |
|---------------|-------------------|--------|
| `EditTeamFragment` | None | **Missing** — TODO added, no crash |
| `ManageTeamLandingFragment` | None | **Missing** — TODO added, no crash |

---

## Phase-wise Implementation Plan

### Phase 1 — Repository
- Add `deleteTeam(teamId)` to `TeamBioRepository`.
- POST to `ApiConstants.deleteTeam` with `teamId` + `userId`.
- Parse `status`, `success`, `reason` from response.
- Throw typed exception with the correct user-facing message on failure.

### Phase 2 — Provider / State
- Add `isDeleteLoading` bool to `TeamBioState` and `copyWith`.
- Add `deleteTeam()` async method to `TeamBioNotifier`.

### Phase 3 — Screen
- Convert `TeamBioScreen` from `ConsumerWidget` → `ConsumerStatefulWidget`.
- Wrap body in `Scaffold` with an AppBar (back button + actions).
- Compute visibility flags:
  - `canEditManage = state.isAdmin`
  - `canDelete = state.isAdmin && StorageService.userId == state.createdBy`
- Add EDIT and MANAGE buttons in the team-info header row (below team name, matching Android layout position).
- Add trash `IconButton` in the AppBar actions (visible when `canDelete`).
- Implement `_showDeleteConfirmation(context)` dialog matching Android text.
- On YES: call `notifier.deleteTeam()`, show SnackBar, pop navigation.

---

## Testing Checklist

- [ ] As team creator + admin: EDIT visible, MANAGE visible, DELETE icon visible
- [ ] As team admin (not creator): EDIT visible, MANAGE visible, DELETE icon **hidden**
- [ ] As regular member / non-member: EDIT hidden, MANAGE hidden, DELETE hidden
- [ ] Delete confirmation — tap NO: dialog closes, no API call
- [ ] Delete confirmation — tap YES: loading indicator shows, API called
- [ ] Delete success: SnackBar "Team Deleted Successfully." shown, screen pops
- [ ] Delete failure `hasPlayer`: correct error message shown in SnackBar
- [ ] Delete failure `hasMatch`: correct error message shown in SnackBar
- [ ] Delete failure `hasTournament`: correct error message shown in SnackBar
- [ ] Delete failure `noRight`: correct error message shown in SnackBar
- [ ] Edit tap (no screen yet): shows "Coming soon" SnackBar, no crash
- [ ] Manage tap (no screen yet): shows "Coming soon" SnackBar, no crash
- [ ] Archived team: Edit/Manage/Delete still follow same visibility rules
