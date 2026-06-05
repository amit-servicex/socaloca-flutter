# Manage Team Member Actions Analysis

## Objective

Migrate the missing Manage Team member menu actions from the legacy Android app into Flutter:

- Assign Team Coach
- Assign Team Manager
- Account Transfer

Existing Flutter actions must remain:

- Edit Jersey
- Make Admin / Remove Admin
- Remove from Team

## Android Source Files Inspected

- `Socaloca-legacy/app/src/main/java/com/football/socaloca/fragment/ManageJerseyAssignFragment.java`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/adapter/ManageJerseyAssignPlayersAdapter.java`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/fragment/AccountTransferFragment.java`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/model/TeamPlayer.java`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/model/Team.java`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/libs/APINames.java`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/libs/Params.java`
- `Socaloca-legacy/app/src/main/res/layout/jersey_assign_popup.xml`
- `Socaloca-legacy/app/src/main/res/layout/fragment_account_transfer.xml`
- `Socaloca-legacy/app/src/main/res/values/strings.xml`

## Flutter Source Files Inspected

- `lib/features/teams/screens/manage_team_screen.dart`
- `lib/features/teams/data/repositories/team_manage_repository.dart`
- `lib/features/teams/data/models/team_bio_model.dart`
- `lib/core/constants/api_constants.dart`
- `lib/core/network/api_client.dart`
- `lib/core/storage/storage_service.dart`

## Current Flutter Menu Actions

The Flutter member row currently has:

- `Edit Jersey`
- `Make Admin` / `Remove Admin`
- `Remove from Team`

These are implemented in `manage_team_screen.dart` with `_MemberAction.editJersey`, `_MemberAction.toggleAdmin`, and `_MemberAction.remove`.

## Android Menu Actions

Android uses a custom dialog layout, `jersey_assign_popup.xml`, opened from `ManageJerseyAssignPlayersAdapter`.

Actions in the Android dialog:

- `Assign Team Coach`
- `Assign Team Manager`
- `Remove Team Coach`
- `Remove Team Manager`
- `Edit jersey number`
- `Account Transfer`
- `Remove from Team`

This migration only adds the missing actions requested by the task:

- `Assign Team Coach`
- `Assign Team Manager`
- `Account Transfer`

## Missing Flutter Actions

Flutter is missing:

- `_MemberAction.assignTeamCoach`
- `_MemberAction.assignTeamManager`
- `_MemberAction.accountTransfer`

## Assign Team Coach

### Android UI Behavior

Label: `Assign Team Coach`

Android shows this row in `jersey_assign_popup.xml` as `makeTeamCoachBox`. On tap, the adapter calls:

```java
mContext.makeCoachManager(teamPlayer, true);
```

No confirmation dialog is shown.

### Visibility Logic

Android visibility is role based:

- If current user is a team admin and target is not another admin, it is shown when target is not already `teamCoach`.
- If current user is a team coach/manager and target is a normal player or normal non-player, it is shown.
- It is hidden for target admins.
- It is hidden for target team coach/manager users in cases where Android hides the action menu or only allows jersey/account actions.

Android role constants:

- `TEAM_ADMIN_USER_PLAYER = 1`
- `TEAM_ADMIN_USER_NOT_PLAYER = 2`
- `TEAM_COACH_MANAGER_USER_PLAYER = 3`
- `TEAM_COACH_MANAGER_USER_NOT_PLAYER = 4`
- `USER_PLAYER = 5`
- `USER_NOT_PLAYER = 6`
- `NO_ROLE = -1`

Android also uses `teamCoach` and `teamManager`, which are team-specific role flags separate from generic `isCoach` / `isManager`.

### API Endpoint

Endpoint: `promCoachManager`

Android constant:

```java
PROM_COACH_MANAGER = "promCoachManager"
```

Method: POST through `PostApiRequest`.

### Request Payload

```json
{
  "userId": "<currentUserId>",
  "teamId": "<teamId>",
  "toUserId": "<target playerId>",
  "isCoach": true
}
```

### Response Handling

Android checks:

- `status == 1`
- `success == true`

On success it calls `getTeamPlayers()` to reload the assigned member list.

No explicit success toast was found for this action in Android.

### Flutter Required Change

- Add menu item `Assign Team Coach`.
- Add repository method using `ApiConstants.promCoachManager`.
- Use payload `userId`, `teamId`, `toUserId`, `isCoach: true`.
- Refresh assigned players after success.
- Prevent duplicate calls through the existing `_acting` set.

## Assign Team Manager

### Android UI Behavior

Label: `Assign Team Manager`

Android shows this row in `jersey_assign_popup.xml` as `makeTeamManagerBox`. On tap, the adapter calls:

```java
mContext.makeCoachManager(teamPlayer, false);
```

No confirmation dialog is shown.

### Visibility Logic

Same role conditions as Assign Team Coach, except Android toggles against target `teamManager`.

### API Endpoint

Endpoint: `promCoachManager`

Method: POST.

### Request Payload

```json
{
  "userId": "<currentUserId>",
  "teamId": "<teamId>",
  "toUserId": "<target playerId>",
  "isCoach": false
}
```

### Response Handling

Android checks:

- `status == 1`
- `success == true`

On success it calls `getTeamPlayers()`.

No explicit success toast was found for this action in Android.

### Flutter Required Change

- Add menu item `Assign Team Manager`.
- Add repository method using `ApiConstants.promCoachManager`.
- Use payload `userId`, `teamId`, `toUserId`, `isCoach: false`.
- Refresh assigned players after success.
- Prevent duplicate calls through the existing `_acting` set.

## Account Transfer

### Android UI Behavior

Label: `Account Transfer`

Android opens a full screen:

```java
AccountTransferFragment accountTransferFragment = new AccountTransferFragment();
accountTransferFragment.setPlayerId(teamPlayer.getPlayerId());
pushFragments(accountTransferFragment, false, true, null);
```

The screen:

1. Loads target player profile using `getPlayerBio`.
2. Shows mobile number, country code, and password inputs.
3. Calls `reqPlayerTransfer` to request OTP.
4. Shows OTP input.
5. Calls `verifyPlayerTransfer`.
6. On success, shows `Account transfer successful` and navigates back.

### Visibility Logic

Android shows Account Transfer when:

- Target player `type == "addedPlayer"`.
- For coach/manager current users, it additionally checks `currentUserId != playerId`.
- It is hidden for target admins and most non-player management roles.

Android constant:

```java
ADDED_PLAYER = "addedPlayer"
```

### API Endpoint

Request OTP endpoint:

```java
REQ_PLAYER_TRANSFER = "reqPlayerTransfer"
```

Verify OTP endpoint:

```java
VERIFY_PLAYER_TRANSFER = "verifyPlayerTransfer"
```

Method: POST.

### Request Payload

Request OTP:

```json
{
  "adminId": "<currentUserId>",
  "playerId": "<target playerId>",
  "mobile": "<mobile>",
  "countryCode": "<countryCode>",
  "countryIso": "<countryIso>",
  "country": "<country>",
  "pwd": "<password>"
}
```

Verify OTP:

```json
{
  "adminId": "<currentUserId>",
  "playerId": "<target playerId>",
  "otp": 123456
}
```

### Response Handling

Request OTP:

- Android checks `status == 1` and `duplicate`.
- If `duplicate == false`, it shows the OTP input.
- If `duplicate == true`, it shows `Account with this mobile number already exists`.

Verify OTP:

- Android checks `status == 1` and `success`.
- If `success == true`, it shows `Account transfer successful` and navigates back.
- If `success == false`, it shows `Invalid OTP`.

Whether current user loses owner/admin rights after transfer: not handled locally in the Android fragment. The client only shows success and goes back; server-side permission changes are not inspected in this code.

### Flutter Required Change

Flutter has endpoint constants for both transfer APIs but no existing Account Transfer route/screen. Required implementation:

- Add menu item `Account Transfer`.
- Add repository methods for `reqPlayerTransfer` and `verifyPlayerTransfer`.
- Use exact Android payloads.
- Open a Flutter dialog from `manage_team_screen.dart` to collect mobile/password, then OTP.
- Refresh assigned players after successful verification.
- Do not fake success if either API fails.

## API Mapping Table

| Action | Android Endpoint | Method | Payload | Flutter Existing Method | Flutter Required Method | Status |
|---|---|---|---|---|---|---|
| Edit Jersey | `editTeamPlayerJersey` | POST | `userId`, `teamId`, `playerId`, `newJerseyNo` | `editJersey` | None | Existing |
| Make Admin | `assignTeamAdmin` | POST | `userId`, `teamId`, `adminId` in Android | `toggleAdmin` | None | Existing, payload name differs in Flutter |
| Remove Admin | `removeTeamAdmin` | POST | `userId`, `teamId`, `adminId` in Android | `toggleAdmin` | None | Existing, payload name differs in Flutter |
| Remove Player | `removeTeamPlayer` | POST | `userId`, `teamId`, `playerId` | `removePlayer` | None | Existing |
| Assign Coach | `promCoachManager` | POST | `userId`, `teamId`, `toUserId`, `isCoach: true` | Not present | `assignCoachManager(isCoach: true)` | Missing |
| Assign Manager | `promCoachManager` | POST | `userId`, `teamId`, `toUserId`, `isCoach: false` | Not present | `assignCoachManager(isCoach: false)` | Missing |
| Account Transfer - request | `reqPlayerTransfer` | POST | `adminId`, `playerId`, `mobile`, `countryCode`, `countryIso`, `country`, `pwd` | Not present | `requestPlayerTransfer` | Missing |
| Account Transfer - verify | `verifyPlayerTransfer` | POST | `adminId`, `playerId`, `otp` | Not present | `verifyPlayerTransfer` | Missing |

## Permission / Visibility Matrix

| Current User Role | Target Player Role | Edit Jersey | Make Admin | Remove Admin | Remove Player | Assign Coach | Assign Manager | Account Transfer |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| Team Admin | Team Admin + Player | Yes | Existing Flutter behavior | Existing Flutter behavior | No in Android | No | No | No |
| Team Admin | Team Admin + Not Player | No | Existing Flutter behavior | Existing Flutter behavior | No | No | No | No |
| Team Admin | Normal / Coach / Manager target | If target is player | Existing Flutter behavior | Existing Flutter behavior | Yes | If not team coach | If not team manager | If `type == addedPlayer` |
| Team Coach/Manager | Team Admin + Player | Yes | Existing Flutter behavior | Existing Flutter behavior | No | No | No | No |
| Team Coach/Manager | Team Admin + Not Player | No | Existing Flutter behavior | Existing Flutter behavior | No | No | No | No |
| Team Coach/Manager | Team Coach/Manager + Player | Yes | Existing Flutter behavior | Existing Flutter behavior | No | No | No | If not self and `type == addedPlayer` |
| Team Coach/Manager | Normal Player | Yes | Existing Flutter behavior | Existing Flutter behavior | Yes | Yes | Yes | If not self and `type == addedPlayer` |
| Team Coach/Manager | Normal Non-player | Yes in Android popup | Existing Flutter behavior | Existing Flutter behavior | Yes | Yes | Yes | No |

## Implementation Plan

### Phase 1

Add enum values and menu items:

- `assignTeamCoach`
- `assignTeamManager`
- `accountTransfer`

### Phase 2

Implement Assign Team Coach API call using `promCoachManager`.

### Phase 3

Implement Assign Team Manager API call using `promCoachManager`.

### Phase 4

Implement Account Transfer dialog/API flow using `reqPlayerTransfer` and `verifyPlayerTransfer`.

### Phase 5

Refresh assigned members after success and validate existing actions still work.

## Testing Checklist

- Page load: assigned players still load from `getAssignTeamPlayers`.
- Existing `Edit Jersey` still opens the edit dialog and updates.
- Existing `Make Admin` / `Remove Admin` still calls the existing method.
- Existing `Remove from Team` still confirms and removes.
- `Assign Team Coach` calls `promCoachManager` with `isCoach: true`.
- `Assign Team Manager` calls `promCoachManager` with `isCoach: false`.
- Account Transfer request validates mobile/password.
- Account Transfer request calls `reqPlayerTransfer`.
- Duplicate mobile response shows an error.
- OTP verification calls `verifyPlayerTransfer`.
- Invalid OTP shows an error.
- Successful OTP verification shows success and refreshes members.
- Duplicate action calls are blocked by `_acting`.
