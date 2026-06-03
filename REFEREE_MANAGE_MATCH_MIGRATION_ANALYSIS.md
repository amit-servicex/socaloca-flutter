# Referee Manage Match Migration Analysis

## Android Feature Analysis Report

### 1. Screens Found

- `RefereeManageMatchFragment`
  - Native Android source screen for the referee tournament match report/manage-match workflow.
  - Layout is a single `NestedScrollView` containing stacked sections rather than tabbed pages.
  - Sections include match header, score, goals, extra-time goals, penalty goals, player of the match, cards, clean sheet, squad, substitutes, coach/manager, club/team officials, photos, match highlights, match videos, and match incidents.

### 2. Android Files Used

- `Socaloca-legacy/app/src/main/java/com/football/socaloca/fragment/RefereeManageMatchFragment.java`
- `Socaloca-legacy/app/src/main/res/layout/fragment_referee_match_manage.xml`
- `Socaloca-legacy/app/src/main/java/com/football/socaloca/libs/APINames.java`
- Related Android adapters:
  - `RefereeGoalsAdapter`
  - `RefereeCardsAdapter`
  - `RefereeSquadAdapter`
  - `RefereeSubstituteAdapter`
  - `RefereeMatchHighlightAdapter`
  - `RefereeMatchVideoAdapter`
  - `MatchDifferentOfficialsAdapter`
- Related Android row/popup layouts:
  - `referee_goal_edit_cell.xml`
  - `referee_goal_view_cell.xml`
  - `referee_card_edit_cell.xml`
  - `referee_card_view_cell.xml`
  - `referee_squad_edit_cell.xml`
  - `referee_squad_view_cell.xml`
  - `referee_substitute_edit_cell.xml`
  - `referee_substitute_view_cell.xml`
  - `referee_match_highlight.xml`
  - `match_video_cell.xml`
  - `match_photo_cell.xml`
  - `item_match_club_offcialls.xml`
  - `add_substitute_popup.xml`

### 3. Flutter Files Inspected

- `socaloca-flutter/lib/features/referee/screens/referee_manage_match_screen.dart`
- `socaloca-flutter/lib/features/referee/data/referee_repository.dart`
- `socaloca-flutter/lib/core/constants/api_constants.dart`
- `socaloca-flutter/lib/core/constants/app_strings.dart`

Current Flutter status:

- Existing Flutter screen has only four tabs: `Score`, `Goals`, `Cards`, `MVP`.
- Existing MVP implementation saves text fields through `saveRefMatchMgmt`, which does not match Android.
- Existing repository has `getRefTmntMtchDtl`, `saveRefMatchScore`, and `saveRefMatchMgmt`.
- API constants for most Android endpoints already exist, but repository methods and UI/state are missing.
- Flutter score tab currently shows a loader at the bottom instead of the Android `SAVE SCORE` button behavior.

### 4. APIs Used

Load details:

- Endpoint: `getRefTmntMtchDtl`
- Android request body:
  - `userId`
  - `matchId`
  - `tournamentId`
- Android response data used:
  - `matchDetails`
  - `score`
  - `matchDetails.gallery`
  - team/player sets
  - team admins
  - officials
  - MVP, clean sheet, coach/manager, substitute, incident, media fields when present

Save endpoints:

| Feature | Endpoint | Android payload |
| --- | --- | --- |
| Score | `saveRefMatchScore` | `userId`, `tournamentId`, `matchId`, `myGoals`, `opponentGoals`, `matchType` |
| Extra-time score | `saveRefMtchExtScore` | `userId`, `tournamentId`, `matchId`, extra-time score fields |
| Penalty score | `saveRefMtchPenaltyScore` | `userId`, `tournamentId`, `matchId`, penalty score fields |
| Goals | `refSaveMatchGoals` | `userId`, `tournamentId`, `matchId`, `matchType`, team goal arrays |
| Extra-time goals | `saveRefMtchExtGoals` | `userId`, `tournamentId`, `matchId`, extra-time goal arrays |
| Penalty goals | `saveRefMtchPenaltyGoals` | `userId`, `tournamentId`, `matchId`, penalty goal arrays |
| Player of the Match | `saveRefMatchMvp` | `tournamentId`, `userId`, `matchId`, `matchType`, `mvpTeamId`, `mvpPlayerId`, `mvpPlayerName` |
| Cards | `saveRefMtchCards` | `userId`, `tournamentId`, `matchId`, card arrays |
| Clean Sheet | `refMatchCleanSheet` | `tournamentId`, `userId`, `matchId`, optional `myTeamCleanSheet`, optional `oppoTeamCleanSheet` |
| Squad | `saveRefMtchSquad` | `tournamentId`, `userId`, `matchId`, `myPlayers`, `opponentPlayers` |
| Substitutes | `saveRefMatchSubs` | `matchId`, `players` |
| Coach/Manager | `saveRefMatchMgmt` | `matchId`, optional `myCoach`, `myManager`, `oppoCoach`, `oppoManager` |
| Club/Team Officials | `saveMatchOfcl` | `userId`, `matchId`, `myOfficials`, `oppoOfficials` |
| Photos | `saveRefMtchPhotos` | `userId`, `matchId`, `parentId`, `photos` |
| Match highlights | `saveRefMtchVideos` | `userId`, `matchId`, `parentId`, `matchType`, `videos` |
| Match videos | `saveRefMtchBigVideo` | `userId`, `matchId`, `parentId`, `matchType`, `videos` |
| Publish match videos | `pubRefMtchBigVideo` | `userId`, `matchId`, mapped `matchType`, video payload |
| Match incidents | `saveRefMatchIncident` | `userId`, `matchId`, `desc`, optional `commIncident` |

Upload endpoints:

- Image upload:
  - Endpoint: `uploadImage`
  - Multipart field: `image`
  - Response field: `response.image`
- Highlight and goal video upload:
  - Endpoint: `uploadVdo`
  - Multipart field: `video`
  - Response fields: `response.status`, `response.videoId`, `response.videoUrl`, `response.thumbnail`
- Full match video upload:
  - URL: `https://largeupload.socaloca.football/uploadFile`
  - Android `OkHttp` body uses raw stream in the active upload path.
  - Legacy multipart fallback uses field `file`.
  - Response fields: `response.status`, `response.videoId`, `response.videoUrl`, `response.thumbnail`

### 5. Models/DTOs

Android dynamic objects used in the fragment:

- Match details and score:
  - `matchDetails`
  - `score`
  - `gallery`
- Player/team objects:
  - `playerId`
  - `userId`
  - `firstName`
  - `lastName`
  - `name`
  - `imageUrl`
  - `playerJersey`
  - `playPosition`
  - `playPositionType`
  - `teamId`
- Squad payload player:
  - `playerId`
  - `playerJersey`
  - `firstName`
  - `lastName`
  - `imageUrl`
  - `playPosition`
  - `playPositionType`
- Substitute payload:
  - `seq`
  - `teamId`
  - `playerId`
  - `playerName`
  - `playerOutId`
  - `playerOutName`
  - `time`
- Coach/manager payload:
  - `{ userId, name }`
- Official payload:
  - `{ name, role }`
- Photo payload:
  - `imageUrl`
  - `seq`
  - `addedBy`
- Video payload:
  - `seq`
  - `videoId`
  - `videoUrl`
  - `thumbnail`
  - `thumbSet`
  - `size`

Flutter needs typed local DTOs or map builders for these payloads. The existing `RefereeMatchModel` is not enough for the complete manage-match screen.

### 6. UI Flow

Android flow:

1. Referee opens a match from referee match lists.
2. `RefereeManageMatchFragment` loads `getRefTmntMtchDtl`.
3. The screen shows a match header with two teams, logo placeholders/images, date, time, stadium, field, and optional leg/round labels.
4. The user scrolls through stacked report sections.
5. Each section has its own save button and independent API call.
6. Most successful saves refresh match details with `getMatchDetails()`.
7. Club/team officials save shows a toast but does not refresh in the Android listener.

Flutter target flow:

1. Keep the existing route to `RefereeManageMatchScreen`.
2. Load `getRefTmntMtchDtl` on screen init, not only rely on the passed match card summary.
3. Replace or expand the tabbed partial implementation so every Android section is reachable.
4. Save each section through the matching endpoint.
5. Refresh detail data after successful saves where Android does.
6. Preserve Android toasts/snackbar semantics with existing Flutter snackbar patterns.

### 7. State Handling

Android:

- Fragment owns mutable section lists and selected player objects.
- Uses `RequestQueueService.showProgressDialog` for loading/saving/uploading.
- Uses RecyclerView adapters with edit/view variants.
- Save buttons validate local mutable state before sending JSON.
- On successful saves, details usually reload.

Flutter target:

- Existing screen is `ConsumerStatefulWidget`.
- Recommended first implementation should keep screen-local state for parity and lower blast radius.
- Repository should expose section-specific save methods.
- Loading states should be per section, plus initial detail loading and upload loading.
- Existing shared `AppLoader`, colors, text styles, repository provider, and `ApiClient` should be reused.

### 8. Validations

Player of the Match:

- Android requires a selected MVP player.
- User chooses one team via radio group.
- Selected player comes from that team's player dropdown.
- Error toast: `Please select player of the match`.

Clean Sheet:

- Android lets the referee select one optional player per team.
- No required validation found.
- No goalkeeper/defender filter found in Android validation. It uses available team player lists.

Squad:

- Android requires at least one selected player from both teams.
- Error toast: `Please select players from both teams`.
- No Android validation found for starting eleven, bench count, or player position eligibility.

Substitutes:

- Each substitute row must have:
  - `time > 0`
  - player in selected
  - player out selected
  - player out name present
- Error toast includes ordinal and team name: `Please enter {ordinal} substitute details for {teamName}`.

Coach/Manager:

- Android `isValidCoachManager()` returns true.
- All four selections are optional.

Club/Team Officials:

- Android saves selected officials for both teams.
- No required validation found.

Media:

- Photos: maximum `MAX_PHOTO = 5`.
- Full match videos: maximum `MAX_VIDEO = 2`.
- Highlight videos: extension must be `.mp4` or `.mov`, max `MAX_HIGHLIGHT_VIDEO_SIZE = 15MB`.
- Goal videos: extension must be `.mp4` or `.mov`, max `MAX_GOAL_VIDEO_SIZE = 50MB`.
- Image upload failure toast uses the existing string for image upload failure.
- Video upload failure toast uses the existing string for video upload failure.

Match Incidents:

- Android sends free text incident fields.
- Structured incident categories such as foul, injury, VAR, booking reason, minute, player, or team were not found in Android code.

### 9. Business Logic

- Role-based context:
  - This screen is specifically under the referee flow and sends `userId` as the logged-in referee for detail load and most saves.
  - Android does not show separate admin/coach branches in `RefereeManageMatchFragment`.
  - Some fields are team-specific: `my` team and `oppo` team are derived from the match details response.
- Different UI per detail section:
  - Score uses compact numeric boxes because it saves total goals.
  - Goals/cards use per-team RecyclerViews because each event belongs to a team/player/time/type.
  - MVP uses team radio buttons plus player dropdowns because only one player can be selected.
  - Clean sheet uses two independent dropdowns because each team can have a clean-sheet player.
  - Squad uses checkbox-style player lists because multiple players are selected per team.
  - Substitutes use row/popup editing because each substitution needs player in, player out, team, and minute.
  - Coach/manager uses four dropdowns because each team has separate coach and manager selections.
  - Officials use checkbox lists of role/name pairs because multiple officials can be selected.
  - Media uses picker/upload previews because files are uploaded before save.
  - Incidents use text areas because Android stores unstructured incident/report text.
- Publish match videos maps Android match types:
  - `tournament` -> `leagueMatch`
  - `cupLeague` -> `cupGroup`
  - `cupMatch` -> `cupKnock`

### 10. Edge Cases

- Missing or failed `getRefTmntMtchDtl` should show an error state and allow retry.
- Empty player lists should disable player-based saves or show an empty dropdown/list state.
- MVP save must not allow an empty selected player.
- Clean sheet can save with no selected players.
- Squad save must reject if either team has no selected players.
- Substitute rows must reject incomplete time/player-in/player-out data.
- Uploaded media should not be saved until upload response includes the server URL/id fields.
- Full match video can enter a processing/uploading state after upload.
- Android refreshes after most saves; Flutter should avoid stale state by reloading after successful saves.
- Club/team officials are the Android exception: it shows success without refresh.
- Incident structured event fields are not present in Android. Do not invent them for parity.

## Android-to-Flutter Mapping

| Android section | Current Flutter | Required Flutter work |
| --- | --- | --- |
| Match header | Partial card summary | Load full detail and match Android header fields |
| Score | Present, but bottom shows loader | Restore save button and use Android payload shape |
| Goals | Partial local-only UI | Persist via `refSaveMatchGoals`; use player dropdowns/lists |
| Cards | Partial local-only UI | Persist via `saveRefMtchCards`; use Android card payload |
| Player of the Match | Text fields, wrong endpoint | Use team selector + player dropdown + `saveRefMatchMvp` |
| Clean Sheet | Missing | Add two player dropdowns + `refMatchCleanSheet` |
| Squad Selection | Missing | Add team player selection lists + `saveRefMtchSquad` |
| Substitute | Missing | Add substitute row editor + `saveRefMatchSubs` |
| Coach/Manager | Missing | Add four optional dropdowns + `saveRefMatchMgmt` |
| Club/Team Officials | Missing | Add checkbox official lists + `saveMatchOfcl` |
| Photos | Missing | Add picker/upload/save; max 5 |
| Highlights | Missing | Add video picker/upload/save; mp4/mov, max 15MB |
| Match Videos | Missing | Add large upload/save/publish; max 2 |
| Match Incidents | Missing | Add incident/report text areas + `saveRefMatchIncident` |

## Phase-Wise Flutter Implementation Plan

### Phase 1: Non-media detail fields

Implement:

- Player of the Match
- Clean Sheet
- Coach/Manager
- Club and Team Officials

Repository methods:

- `savePlayerOfTheMatch`
- `saveCleanSheet`
- `saveCoachManager`
- `saveMatchOfficials`

UI/state:

- Add full manage-match detail load.
- Add player/member/official parsing helpers.
- Add Android-like section cards and save buttons.
- Keep changes scoped to referee manage-match screen/repository and strings if needed.

### Phase 2: Squad and Substitute

Implement:

- Squad selection for both teams.
- Substitute editor for both teams.

Status:

- Implemented in Flutter after Phase 1.
- Squad uses player checkbox lists for each team and saves to `saveRefMtchSquad`.
- Substitute flow uses per-team substitute counts, generated rows, player-in/player-out dropdowns, and minute fields, then saves to `saveRefMatchSubs`.

Repository methods:

- `saveMatchSquad`
- `saveSubstitutes`

Validation:

- Squad requires at least one player from both teams.
- Substitute rows require time, player in, and player out.

### Phase 3: Match Incidents

Implement:

- Incident description text area.
- Commissioner report text area.
- Save to `saveRefMatchIncident`.

Status:

- Implemented in Flutter after Phase 2.
- Pre-fills incident description from `matchDetails.refIncident.desc`.
- Shows and pre-fills commissioner report from `matchDetails.commIncident` only when the logged-in user is the match commissioner.
- Saves `userId`, `matchId`, `desc`, and optional `commIncident`.

Important:

- Structured incident event types were not found in Android code and should not be added as parity behavior.

### Phase 4: Media Uploads

Implement:

- Photos upload/save.
- Match highlights upload/save.
- Match videos large-upload/save/publish.

Status:

- Implemented in Flutter after Phase 3.
- Photos upload through `uploadImage`, then save to `saveRefMtchPhotos`.
- Match highlights upload through `uploadVdo`, then save to `saveRefMtchVideos`.
- Match videos upload through Android large-upload URL, then save to `saveRefMtchBigVideo`.
- Match video publish uses `pubRefMtchBigVideo` with Android match-type mapping.

Validation:

- Photos max 5.
- Match videos max 2.
- Highlight video max 15MB.
- Goal video max 50MB if goal video upload is migrated in the goals phase.
- `.mp4` and `.mov` video extension validation.

## Testing and Review Checklist

- Verify `getRefTmntMtchDtl` payload matches Android.
- Verify each save endpoint name and request body matches Android.
- Verify MVP uses `saveRefMatchMvp`, not `saveRefMatchMgmt`.
- Verify clean sheet can save optional empty selections.
- Verify coach/manager can save with no selected values.
- Verify officials save selected `{ name, role }` arrays.
- Verify Flutter loading, empty, and error states for initial detail load.
- Verify per-section saving states and success/failure messages.
- Run `dart format` on changed Dart files.
- Run `flutter analyze --no-pub` or targeted analyzer command.
- Run available Flutter tests if possible.
