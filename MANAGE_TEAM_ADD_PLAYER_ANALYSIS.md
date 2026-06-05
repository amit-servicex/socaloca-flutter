# Manage Team Add Player Migration Analysis

## Objective

Implement the "Add Player" feature inside the Flutter Manage Team screen, matching the Android app's `AddInvitePlayerFragment` flow: a 3-tab screen for Search & Invite, Invite by Phone, and Create Player — accessible from both the New Players and Jersey Assigned tabs.

---

## Android Source Files Inspected

| File | Purpose |
|------|---------|
| `fragment/ManageNewPlayersFragment.java` | New Players tab — contains `addPlayers` click listener |
| `fragment/ManageJerseyAssignFragment.java` | Jersey Assigned tab — same add button |
| `fragment/AddInvitePlayerFragment.java` | Container with 3-tab ViewPager |
| `fragment/SearchInviteFragment.java` | Tab 0 — Search & Invite |
| `fragment/InvitePlayersFragment.java` | Tab 1 — Invite by Phone |
| `fragment/AddPlayersFragment.java` | Tab 2 — Create Player |
| `libs/APINames.java` | All endpoint string constants |
| `libs/Params.java` | Flag constants (`IS_ADD_PLAYER_FROM_MANAGE_TEAM`) |
| `res/layout/fragment_manage_new_players.xml` | Layout for New Players tab |
| `res/layout/fragment_manage_jersey_assign.xml` | Layout for Jersey Assigned tab |
| `res/layout/fragment_search_invite.xml` | Layout for Search & Invite tab |
| `res/layout/fragment_invite_players.xml` | Layout for Invite by Phone tab |
| `res/layout/fragment_add_players.xml` | Layout for Create Player tab |

---

## Flutter Source Files Inspected

| File | Notes |
|------|-------|
| `lib/features/teams/screens/manage_team_screen.dart` | Existing 3-tab Manage Team screen; no Add button yet |
| `lib/features/teams/data/repositories/team_manage_repository.dart` | Existing repo — needs new methods |
| `lib/core/constants/api_constants.dart` | Missing `inviteTeamUser`, `addTeamPlayer` |
| `lib/core/router/app_routes.dart` | Needs new route: `/teams/:teamId/add-player` |
| `lib/core/router/app_router.dart` | Needs new GoRoute registration |

---

## Existing Flutter Manage Team Flow

- `ManageTeamScreen` is a `StatelessWidget` with 3 tabs via `DefaultTabController`:
  - Tab 0: NEW REQUESTS (`_JoinRequestsTab`)
  - Tab 1: NEW PLAYERS (`_NewPlayersTab`)
  - Tab 2: JERSEY ASSIGNED (`_JerseyAssignedTab`)
- Both `_NewPlayersTab` and `_JerseyAssignedTab` have player lists — **neither has an Add button yet**.

---

## Android Manage Team Tabs

- **New Players tab** (`ManageNewPlayersFragment`): Header row has `addPlayers` LinearLayout (right-aligned). Tap → `AddInvitePlayerFragment` with `setTeam(team)`.
- **Jersey Assigned tab** (`ManageJerseyAssignFragment`): Identical `addPlayers` button in header row.
- Both pass the full `Team` object to `AddInvitePlayerFragment`.

---

## Add Player Icon Logic

| Property | Value |
|---|---|
| Icon | `ic_person_add` (person with + symbol) |
| Text | "Add" |
| Position | Right side of tab header row, next to section title |
| Layout | Horizontal LinearLayout: icon (25dp) + Text |
| Click target | Both `_NewPlayersTab` and `_JerseyAssignedTab` |

---

## Add Player Navigation Flow

```
ManageNewPlayersTab  ─┐
                       ├──► AddInvitePlayerFragment (teamId passed)
ManageJerseyTab     ─┘
                         ├── Tab 0: SearchInviteFragment
                         ├── Tab 1: InvitePlayersFragment
                         └── Tab 2: AddPlayersFragment
```

Parameters passed from both tabs: full `Team` object (teamId, teamName, imageUrl).

---

## Add Player Screen Tabs

Exact tab names confirmed from `getString()` calls in Android:

| Index | Android String Resource | Display Text |
|-------|------------------------|-------------|
| 0 | `R.string.search_and_invite` | "Search & Invite" |
| 1 | `R.string.invite_by_phone` | "Invite by Phone" |
| 2 | `R.string.create_player` | "Create Player" |

---

## Search and Invite Tab

### Android UI
- `searchText` (EditText): single-line, auto-triggers search at ≥3 characters via `TextWatcher`
- `searchIcon` (ImageView): manual search trigger
- `RecyclerView`: player results list with INVITE button per row
- Pagination: `start` (0) + `limit` (10), auto-loads on scroll

### API Endpoint
```
POST {BASE_URL}/searchPlayerForTeam
```
Constant: `ApiConstants.searchPlayerForTeam` (already exists in Flutter)

### Request Payload
```json
{
  "teamId": "<teamId>",
  "userId": "<currentUserId>",
  "searchTerm": "<text>",
  "country": "<currentUser.country>",
  "start": 0,
  "limit": 10
}
```

### Invite API Endpoint
```
POST {BASE_URL}/inviteTeamPlayer
```
Constant: `ApiConstants.inviteTeamPlayer` (already exists in Flutter)

### Invite Request Payload
```json
{
  "teamId": "<teamId>",
  "userId": "<currentUserId>",
  "playerId": "<selectedPlayer.userId>",
  "teamName": "<teamName>",
  "teamImageUrl": "<teamImageUrl>",
  "myName": "<currentUser firstName + lastName>"
}
```

### Response Handling
- Search: returns `players` list in response
- Invite success: `status == 1 && success == true` → mark player as invited in UI (button disabled), toast "Invite sent"
- Invite failure: show error SnackBar

### Flutter Required Changes
- New `searchPlayersForTeam()` method in `TeamManageRepository`
- New `invitePlayer()` method in `TeamManageRepository`
- `_SearchAndInviteTab` widget in `add_player_screen.dart`

---

## Invite by Phone Tab

### Android UI
- `countryCode` (TextView): auto-filled from user profile (read-only display)
- `phoneNumber` (EditText): digits only, input type phone
- `addNumber` (ImageView, 45dp): adds number to pending list
- Dynamic `numberHolder` (LinearLayout): shows added numbers as removable chips
- Submit button: sends invite to all added numbers

### Validation Rules (must match Android exactly)
1. Phone empty → error
2. Phone length < 7 → "Please enter valid mobile number"
3. Phone matches own number → "Cannot invite your own number"
4. Phone already in list → "Already added"

### API Endpoint
```
POST {BASE_URL}/inviteTeamUser
```
Constant: `ApiConstants.inviteTeamUser` (**MISSING** — must add to Flutter)

### Request Payload
```json
{
  "userId": "<currentUserId>",
  "teamId": "<teamId>",
  "numbers": [
    { "countryCode": "<code>", "mobile": "<phoneNumber>" }
  ],
  "teamName": "<teamName>",
  "myName": "<currentUser firstName + lastName>",
  "teamImageUrl": "<teamImageUrl>"
}
```

### Response Handling
- Success: `status == 1 && result == 1` → toast "Invitation sent to all numbers", clear list
- Failure: show error SnackBar

### Flutter Required Changes
- New `inviteByPhone()` method in `TeamManageRepository`
- `_InviteByPhoneTab` widget in `add_player_screen.dart`
- Country code read from `StorageService.currentUser['countryCode']`

---

## Create Player Tab

### Android UI
Required fields (all validated before submit):
- `firstName` (EditText)
- `lastName` (EditText)
- `profileName` (EditText) — min 5 chars, real-time availability check
- `yearOfBirth` (Spinner) — years list
- `gender` (RadioGroup) — Male / Female, default Male
- `country` (EditText) — read-only, pre-filled from current user
- `playPosition` (Spinner) — Goalkeeper / Defender / Midfield / Attack
- `playPositionType` (Spinner) — dynamic based on position

### Position → Sub-position mapping
```
Goalkeeper  → [Goalkeeper (GK)]
Defender    → [Centre Back (CB), Right Back (RB), Left Back (LB)]
Midfield    → [Defensive Midfield (DM), Center Midfield (CM), Attacking Midfield (AM), Right Wing (RW), Left Wing (LW)]
Attack      → [Center Forward (CF), Striker (ST), Second Striker (SS), False 9 (F9)]
```

### Image URL (auto-generated, no upload)
```
age > 16 && male   → "avatar_male_adult.png"
age > 16 && female → "avatar_female_adult.png"
age ≤ 16 && male   → "avatar_male_young.png"
age ≤ 16 && female → "avatar_female_young.png"
```

### Profile Name Check API
```
POST {BASE_URL}/searchProfileName
```
Constant: `ApiConstants.searchProfileName` (already exists)
Payload: `{ "userId": "<userId>", "profileName": "<name>" }`
Response: `status == 1 && available == true`

### Create Player API Endpoint
```
POST {BASE_URL}/addTeamPlayer
```
Constant: `ApiConstants.addTeamPlayer` (**MISSING** — must add to Flutter)

### Request Payload
```json
{
  "userId": "<currentUserId>",
  "teamId": "<teamId>",
  "firstName": "<firstName>",
  "lastName": "<lastName>",
  "gender": "male" | "female",
  "profileName": "<profileName>",
  "yearOfBirth": <year>,
  "country": "<country>",
  "playPosition": "<position>",
  "playPositionType": "<subPosition>",
  "imageUrl": "<auto-generated avatar filename>"
}
```

### Response Handling
- Success: `status == 1 && playerDetails != null` → show confirmation dialog
  - "Assign Jersey" button → pop back to Manage Team (New Players tab)
  - "Add Another" button → reset form
- Failure: show error SnackBar

### Flutter Required Changes
- New `checkProfileName()` method in `TeamManageRepository`
- New `createPlayer()` method in `TeamManageRepository`
- `_CreatePlayerTab` widget in `add_player_screen.dart`

---

## API Mapping Table

| Feature | Android Endpoint | Flutter Constant | Status |
|---------|-----------------|-----------------|--------|
| Search players | `searchPlayerForTeam` | `ApiConstants.searchPlayerForTeam` | ✅ Exists |
| Invite player | `inviteTeamPlayer` | `ApiConstants.inviteTeamPlayer` | ✅ Exists |
| Invite by phone | `inviteTeamUser` | `ApiConstants.inviteTeamUser` | ❌ Missing |
| Create player | `addTeamPlayer` | `ApiConstants.addTeamPlayer` | ❌ Missing |
| Check profile name | `searchProfileName` | `ApiConstants.searchProfileName` | ✅ Exists |

---

## Phase-wise Implementation Plan

### Phase 1 — Constants + Repository
- Add `inviteTeamUser` and `addTeamPlayer` to `api_constants.dart`
- Add `searchPlayersForTeam()`, `invitePlayer()`, `inviteByPhone()`, `checkProfileName()`, `createPlayer()` to `TeamManageRepository`

### Phase 2 — Add Player Button in Manage Tabs
- Add "Add" icon+text button to `_NewPlayersTab` header row
- Add same button to `_JerseyAssignedTab` header row
- Both navigate to new `AddPlayerScreen`

### Phase 3 — AddPlayerScreen scaffold
- Create `add_player_screen.dart` with `DefaultTabController` (3 tabs)
- Accept `teamId` + `TeamDetailsModel` params
- Register route `/teams/:teamId/add-player` in router

### Phase 4 — Search & Invite Tab
- Search field with debounce (≥3 chars)
- Player results list with INVITE button
- Loading / empty / error states
- Pagination on scroll

### Phase 5 — Invite by Phone Tab
- Country code display + phone input
- Add-to-list UX (chips)
- Validation matching Android rules
- Submit to `inviteTeamUser`

### Phase 6 — Create Player Tab
- Full form: firstName, lastName, profileName (with availability check), yearOfBirth, gender, country (read-only), position + sub-position
- Auto avatar selection logic
- Submit to `addTeamPlayer`
- Success dialog: Assign Jersey / Add Another

---

## Testing Checklist

- [ ] Add button visible in New Players tab header
- [ ] Add button visible in Jersey Assigned tab header
- [ ] Tapping button opens AddPlayerScreen with correct team name in AppBar
- [ ] **Search & Invite**: typing ≥3 chars triggers search
- [ ] **Search & Invite**: results list shows players
- [ ] **Search & Invite**: INVITE button sends invite, button disabled after
- [ ] **Search & Invite**: pagination loads next page on scroll
- [ ] **Invite by Phone**: country code pre-filled
- [ ] **Invite by Phone**: validation — empty phone error
- [ ] **Invite by Phone**: validation — phone < 7 digits error
- [ ] **Invite by Phone**: validation — own phone number error
- [ ] **Invite by Phone**: validation — duplicate in list error
- [ ] **Invite by Phone**: add number creates chip, submit clears list
- [ ] **Create Player**: profileName availability indicator (green/red)
- [ ] **Create Player**: position → sub-position list updates dynamically
- [ ] **Create Player**: form validation blocks empty required fields
- [ ] **Create Player**: success dialog shows with correct buttons
- [ ] **Create Player**: "Assign Jersey" pops back and refreshes manage team
- [ ] **Create Player**: "Add Another" resets form
- [ ] No crash when navigating back from any tab
