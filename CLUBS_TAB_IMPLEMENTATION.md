# Clubs & Partners Tab — Implementation Guide

Analysis of Android `CommonClubsPartnersLandingFragment` + `CommonClubsFragment` + `ClubBioUserFragment`  
compared against the current (empty) Flutter `lib/features/club/` directory.

All colours, dimensions, fonts, and API fields are taken directly from the Android source.

---

## 1. Feature Overview

The **Clubs & Partners** tab is the 4th item in the bottom navigation bar.  
It has two sub-tabs managed by a `TabLayout + ViewPager`:

| Tab | Android Fragment | Flutter Screen |
|-----|-----------------|---------------|
| Clubs | `CommonClubsFragment` | `ClubsScreen` |
| Partners | `CommonPartnersFragment` | `PartnersScreen` |

This document covers the **Clubs tab** only. Partners follows the same pattern.

**Bottom nav entry**:
- Icon: `ic_clubs_partners_new` (30 dp × 30 dp)
- Label: "CLUBS & PARTNERS" (Lato Bold 8sp, new_black, uppercase)
- Active state: yellow oval background behind icon

---

## 2. Screen Hierarchy

```
ClubsPartnersLandingScreen
├── TabBar (Clubs | Partners)
└── TabBarView
    ├── ClubsScreen                  ← This document
    │   ├── Filter row
    │   │   ├── Country dropdown
    │   │   ├── Partnership dropdown
    │   │   └── GO button
    │   └── Club list (infinite scroll)
    │       └── ClubCard × N
    └── PartnersScreen               ← separate doc
```

**Club bio (detail) screen** — pushed on card tap:
```
ClubBioScreen
├── Top bar: Club name + Gallery + Website icons
├── Club image + Follow button + Follow count
├── FIFA ID row (conditional)
├── Info fields: Nickname, Formed, Country, City, Stadium, Manager
├── League (conditional)
├── Competitions (conditional)
├── Partnership badge (Platinum / Gold / Silver)
├── News & Announcements list
├── Recent Matches grid
├── Featured Players grid
├── Club Teams carousel
├── Sponsors carousel
├── Kit images: Home / Away / Third
└── Trial registration box (conditional)
```

---

## 3. File Structure to Create

```
lib/features/club/
├── data/
│   ├── models/
│   │   ├── club_model.dart          ← ClubInfo POJO
│   │   ├── club_model.freezed.dart  (generated)
│   │   ├── club_model.g.dart        (generated)
│   │   ├── club_news_model.dart
│   │   ├── club_news_model.freezed.dart
│   │   ├── club_news_model.g.dart
│   │   ├── club_bio_model.dart      ← full bio response
│   │   ├── club_bio_model.freezed.dart
│   │   └── club_bio_model.g.dart
│   └── repositories/
│       └── club_repository.dart
├── providers/
│   ├── clubs_provider.dart          ← club list + filters
│   └── club_bio_provider.dart       ← bio detail
├── screens/
│   ├── clubs_partners_landing_screen.dart
│   ├── clubs_screen.dart
│   └── club_bio_screen.dart
└── widgets/
    ├── club_card.dart
    ├── club_filter_row.dart
    ├── club_bio_info_row.dart
    ├── club_bio_section_header.dart
    ├── club_news_card.dart
    ├── club_players_grid.dart
    ├── club_teams_carousel.dart
    ├── club_sponsors_carousel.dart
    └── partnership_badge.dart
```

---

## 4. Data Models

### 4.1 `ClubModel` (list item)

Fields from Android `ClubInfo.java`:

```dart
@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    required String clubId,
    @JsonKey(name: '_id') String? id,
    required String clubName,
    String? partnerType,      // "platinum" | "gold" | "silver" | "nopartner"
    String? country,
    String? city,
    String? nickName,
    String? formedYear,
    String? manager,
    String? confed,
    String? league,
    String? website,
    String? imageUrl,
    String? homeKit,
    String? awayKit,
    String? thirdKit,
    String? orgFifaId,
    @Default(false) bool following,
    @Default(false) bool trialBadge,
    @Default(false) bool isPartner,
    @Default(0) int followCount,
    @Default(0) int likeCount,
    @Default(0) int plan,
    @Default([]) List<StadiumModel> stadiums,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);
}

@freezed
class StadiumModel with _$StadiumModel {
  const factory StadiumModel({
    required String name,
    @Default(0) int seq,
  }) = _StadiumModel;

  factory StadiumModel.fromJson(Map<String, dynamic> json) =>
      _$StadiumModelFromJson(json);
}
```

**Helper** — format partner type label (matches Android adapter logic):

```dart
extension ClubModelX on ClubModel {
  String get partnerLabel {
    if (partnerType == null || partnerType == 'nopartner') return 'Non-Partner';
    final type = partnerType!;
    return '${type[0].toUpperCase()}${type.substring(1)} Partner';
  }

  String get stadiumsAsStr =>
      stadiums.map((s) => s.name).join(', ');
}
```

### 4.2 `ClubNewsModel`

```dart
@freezed
class ClubNewsModel with _$ClubNewsModel {
  const factory ClubNewsModel({
    required String newsId,
    String? title,
    String? description,
    String? imageUrl,
    String? videoUrl,
    String? videoThumb,
    String? videoId,
    String? link,
    String? newsDate,
    @Default(0) int newsDateGmt,
    String? newsCat,        // "image" | "video"
  }) = _ClubNewsModel;

  factory ClubNewsModel.fromJson(Map<String, dynamic> json) =>
      _$ClubNewsModelFromJson(json);
}
```

### 4.3 `ClubPlayerModel`

```dart
@freezed
class ClubPlayerModel with _$ClubPlayerModel {
  const factory ClubPlayerModel({
    required String userId,
    String? firstName,
    String? lastName,
    String? position,
    String? imageUrl,
    @Default(0) int jersey,
    @Default(0) int seq,
  }) = _ClubPlayerModel;

  factory ClubPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$ClubPlayerModelFromJson(json);
}
```

### 4.4 `ClubTeamModel`

```dart
@freezed
class ClubTeamModel with _$ClubTeamModel {
  const factory ClubTeamModel({
    required String teamId,
    String? teamName,
    String? imageUrl,
    @Default(0) int seq,
  }) = _ClubTeamModel;

  factory ClubTeamModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTeamModelFromJson(json);
}
```

### 4.5 `ClubSponsorModel`

```dart
@freezed
class ClubSponsorModel with _$ClubSponsorModel {
  const factory ClubSponsorModel({
    required String sponsorId,
    String? name,
    String? imageUrl,
    @Default(0) int seq,
  }) = _ClubSponsorModel;

  factory ClubSponsorModel.fromJson(Map<String, dynamic> json) =>
      _$ClubSponsorModelFromJson(json);
}
```

### 4.6 `ClubBioModel` (full detail response)

```dart
@freezed
class ClubBioModel with _$ClubBioModel {
  const factory ClubBioModel({
    required ClubModel clubDetails,
    ClubTrialStatusModel? trialDetails,
    @Default([]) List<ClubNewsModel> newsList,
    @Default([]) List<ClubMatchModel> matchList,
    @Default([]) List<ClubPlayerModel> playerList,
    @Default([]) List<ClubTeamModel> teamList,
    @Default([]) List<ClubSponsorModel> sponsorList,
  }) = _ClubBioModel;

  factory ClubBioModel.fromJson(Map<String, dynamic> json) =>
      _$ClubBioModelFromJson(json);
}

@freezed
class ClubTrialStatusModel with _$ClubTrialStatusModel {
  const factory ClubTrialStatusModel({
    @Default(false) bool trialBadge,
    @Default(false) bool isRegisterBtn,
    @Default(false) bool isRegistered,
    @Default(false) bool isRegistrationClosed,
  }) = _ClubTrialStatusModel;

  factory ClubTrialStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ClubTrialStatusModelFromJson(json);
}
```

---

## 5. API Endpoints

### 5.1 `getClubs` — Club List

| Property | Value |
|----------|-------|
| Endpoint | `ApiConstants.getClubs` (`getClubs`) |
| Method | POST |
| Timeout | 30 s |

**Request body**:
```dart
{
  'userId': currentUserId,
  'country': selectedCountry,  // "" for All
  'confed': '',
  'partnerShip': selectedPartnership,  // "" | "platinum" | "gold" | "silver" | "nopartner"
  'trial': '',
  'start': pageOffset,         // 0, 100, 200 …
  'limit': 100,
}
```

**Response** — parse `response.clubs` array into `List<ClubModel>`:
```json
{
  "response": {
    "clubs": [ { ...ClubModel fields... } ]
  }
}
```

**Pagination**: `start` increments by `limit` (100). Stop loading when returned list < 100.

---

### 5.2 `getClubBio` — Club Detail

| Property | Value |
|----------|-------|
| Endpoint | `ApiConstants.getClubBio` (`getClubBio`) |
| Method | POST |

**Request body**:
```dart
{
  'clubId': clubId,
  'userId': currentUserId,
  'isUser': true,
}
```

**Response** — parse `response.details` into `ClubBioModel`:
```json
{
  "response": {
    "status": 1,
    "details": {
      "clubDetails": { ...ClubModel fields... },
      "trialDetails": {
        "trialBadge": true,
        "isRegisterBtn": true,
        "isRegistered": false,
        "isRegistrationClosed": false
      },
      "newsList":    [ ...ClubNewsModel... ],
      "matchList":   [ ...ClubMatchModel... ],
      "playerList":  [ ...ClubPlayerModel... ],
      "teamList":    [ ...ClubTeamModel... ],
      "sponsorList": [ ...ClubSponsorModel... ]
    }
  }
}
```

**Sort order** (match Android):
- `newsList`: by `newsDateGmt` descending
- `matchList`: by `matchDateGmt` descending
- `playerList`: by `seq` asc, then `firstName` asc
- `teamList`: by `seq` asc, then `teamName` asc
- `sponsorList`: by `seq` asc, then `name` asc
- `stadiums`: by `seq` asc, then `name` asc

---

### 5.3 `followClub`

| Property | Value |
|----------|-------|
| Endpoint | `ApiConstants.followClub` (`followClub`) |
| Method | POST |

```dart
{ 'clubId': clubId, 'userId': currentUserId }
```

---

### 5.4 `trialRegister`

| Property | Value |
|----------|-------|
| Endpoint | `ApiConstants.trialRegister` (`trialRegister`) |
| Method | POST |

```dart
{ 'clubId': clubId, 'userId': currentUserId, 'email': userEmail }
```

---

## 6. Riverpod Providers

### 6.1 `clubsProvider` — paginated club list with filters

```dart
// State
class ClubsState {
  final List<ClubModel> clubs;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final String country;
  final String partnership;  // "" | "platinum" | "gold" | "silver" | "nopartner"

  ClubsState({...});
}

// Notifier
class ClubsNotifier extends StateNotifier<ClubsState> {
  Future<void> load();           // initial / refresh
  Future<void> loadMore();       // pagination
  void setCountry(String c);     // update filter + reload
  void setPartnership(String p); // update filter + reload
}

final clubsProvider =
    StateNotifierProvider<ClubsNotifier, ClubsState>((ref) => ClubsNotifier(ref));
```

### 6.2 `clubBioProvider` — single club detail

```dart
final clubBioProvider = FutureProvider.family<ClubBioModel, String>(
  (ref, clubId) async => ref.read(clubRepositoryProvider).getClubBio(clubId),
);
```

### 6.3 `followClubProvider`

```dart
final followClubProvider = FutureProvider.family<void, String>(
  (ref, clubId) async {
    await ref.read(clubRepositoryProvider).followClub(clubId);
    ref.invalidate(clubBioProvider(clubId));
  },
);
```

---

## 7. UI Specification

### 7.1 Landing Screen (`clubs_partners_landing_screen.dart`)

| Property | Value |
|----------|-------|
| Background | `AppColors.socaPageBg` (#f6f6f6) |
| Tab indicator colour | `AppColors.socaBlack` (#1c1c1c) |
| Tab indicator height | 3 dp |
| Tab font | Poppins (via `CustomTextAppearanceTab`) |
| Tab mode | fixed, gravity fill |
| Tabs | "Clubs" and "Partners" |

```dart
DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        indicatorColor: AppColors.socaBlack,
        indicatorWeight: 3,
        labelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        tabs: const [Tab(text: 'Clubs'), Tab(text: 'Partners')],
      ),
    ),
    body: const TabBarView(
      children: [ClubsScreen(), PartnersScreen()],
    ),
  ),
)
```

---

### 7.2 Clubs Screen (`clubs_screen.dart`)

#### Filter Row

| Element | Spec |
|---------|------|
| Country dropdown | SearchableSpinner equivalent — use a DropdownButton or showModalBottomSheet with search |
| Dropdown height | 42 dp |
| Dropdown background | `AppColors.socaGrey` (#eaeae8), radius 5 dp |
| Dropdown font | Poppins Regular 12sp |
| Arrow icon | 12 dp × 12 dp |
| Partnership dropdown | Same styling, options below |
| GO button | 42 dp height, black bg, yellow text, Poppins Bold 14sp, radius 5 dp |

**Partnership dropdown options**:
```dart
const partnerships = [
  ('', 'Partnership (all)'),
  ('platinum', 'Platinum'),
  ('gold', 'Gold'),
  ('silver', 'Silver'),
  ('nopartner', 'Non-Partner'),
];
```

**Header text** (above filters):
- Font: Poppins Regular 12sp, `AppColors.socaBlack`
- Margin: 20dp left/right, 10dp top, 5dp bottom
- Text: `"clubs_and_partners"` (localised in Android — use "Clubs & Partners" in Flutter)

**Infinite scroll trigger**: Load more when `ScrollController.position.pixels >= maxScrollExtent - 200`

---

#### Club Card (`club_card.dart`)

From Android `common_clubs_cell.xml`:

| Element | Spec |
|---------|------|
| Card background | white |
| Card corner radius | 10 dp |
| Card elevation | 4 dp |
| Card margin | 5dp start/end, 10dp top, 5dp bottom |
| Club image | 80 dp × 80 dp, circle crop, `oval_new_grey` bg, 3dp padding |
| Image placeholder | `AppColors.socaGrey` circle |
| Trial badge | Visible if `club.trialBadge == true` |
| Trial badge text | "LIVE TRIAL" |
| Trial badge bg | white with 1dp black stroke, radius 5dp |
| Trial badge font | Poppins Bold 12sp, `AppColors.socaBlack` |
| Trial badge padding | 5dp horizontal, 2dp vertical |
| Club name font | Poppins Bold 16sp, `AppColors.socaBlack` |
| Partner type font | Poppins Regular 13sp, `AppColors.socaBlack` |
| Country font | Poppins Regular 12sp, `AppColors.socaBlack` |
| VIEW button width | 80 dp |
| VIEW button bg | `AppColors.socaBlack`, radius 5dp |
| VIEW button text | "VIEW", Poppins Bold 12sp, `AppColors.socaYellow` |
| VIEW button padding | 8dp top/bottom |

**Partner type label logic**:
```dart
// "platinum" → "Platinum Partner"
// "gold"     → "Gold Partner"
// "silver"   → "Silver Partner"
// "nopartner"→ "Non-Partner"
```

**Image URL**: `ApiConstants.getImageUrl(club.imageUrl)`

---

### 7.3 Club Bio Screen (`club_bio_screen.dart`)

#### Top Bar

| Element | Spec |
|---------|------|
| Background | white |
| Club name font | Lato Bold 18sp, `AppColors.socaBlack`, left margin 15dp |
| Gallery icon | ImageView 25 dp × 25 dp, right side |
| Website icon | ImageView 25 dp × 25 dp, right of gallery |

#### Club Image + Follow

| Element | Spec |
|---------|------|
| Club image | 80 dp × 80 dp, circle crop |
| Follow button width | 85 dp |
| Follow button bg | `AppColors.socaBlack`, radius 5dp |
| Follow button font | Poppins Bold 12sp, `AppColors.socaYellow` |
| Follow button text | "FOLLOW" / "FOLLOWING" (toggle) |
| Follow count font | Poppins Regular 12sp, `AppColors.socaBlack` |

**Follow state**: Initial value from `bio.clubDetails.following`. Toggle locally on tap and call `followClub` API.

#### FIFA ID Row

| Element | Spec |
|---------|------|
| Visible when | `club.orgFifaId != null && orgFifaId.isNotEmpty` |
| Label | "FIFA ID:" (Poppins Regular 12sp) |
| Value | actual ID (Poppins Bold 12sp) |
| Verify icon | 22 dp × 22 dp |

#### Info Fields

Each row — label + value, Poppins Bold 12sp, `AppColors.socaBlack`:

| Label | Field |
|-------|-------|
| Nickname | `club.nickName` |
| Formed | `club.formedYear` |
| Country | `club.country` |
| City | `club.city` |
| Stadium | `club.stadiumsAsStr` (comma-joined, sorted by seq) |
| Manager | `club.manager` |

Show/hide each row individually if the field is null or empty.

#### Conditional Sections

| Section | Show when |
|---------|-----------|
| League | `club.league != null && league.isNotEmpty` |
| Competitions | `bio.clubDetails.comps != null && comps.isNotEmpty` |
| Partnership badge | always (Platinum/Gold/Silver show badge image; Non-Partner shows nothing) |

**Partnership badge assets** (add to `assets/icons/`):
- `ic_platinum_badge.png`
- `ic_gold_badge.png`
- `ic_silver_badge.png`

#### News & Announcements List

| Element | Spec |
|---------|------|
| Layout | `ListView` (LinearLayoutManager, vertical) |
| Hidden when | `bio.newsList.isEmpty` |
| Section header | "News & Announcements", Poppins Bold 14sp |

Each `ClubNewsCard`:
- News image (if `newsCat == "image"`) — fill width, max height 200dp
- Video thumbnail + play icon (if `newsCat == "video"`) — tappable, opens video
- Date: formatted from `newsDate` (parse `dd-MM-yyyy`, display `MMMM d`)
- Title: Poppins Bold 12sp
- Description: Poppins Regular 11sp, max 3 lines
- On tap: open `link` in browser (if `link != null`)

#### Recent Matches Grid

| Element | Spec |
|---------|------|
| Layout | `GridView`, 2 columns |
| Hidden when | `bio.matchList.isEmpty` |
| Section header | "Recent Matches" |

#### Featured Players Grid

| Element | Spec |
|---------|------|
| Layout | `GridView`, 2 columns |
| Hidden when | `bio.playerList.isEmpty` |
| Section header | "Featured Players" |
| "View All" button | links to full player list |

Each player card: circle avatar (60dp), name, position, jersey number.

#### Club Teams Carousel

| Element | Spec |
|---------|------|
| Layout | Horizontal `ListView` |
| Left/Right arrows | Visible for scroll hint |
| Hidden when | `bio.teamList.isEmpty` |

#### Sponsors Carousel

Same structure as Club Teams Carousel.

#### Kit Images

| Element | Spec |
|---------|------|
| Labels | "Home", "Away", "Third" |
| Each kit | displayed in a row, square image |
| Hidden when | kit URL is null or empty |

#### Trial Registration Box

| Element | Spec |
|---------|------|
| Visible when | `trialDetails.trialBadge == true` |
| Register button | `AppColors.socaBlack` bg, `AppColors.socaYellow` text |
| "Registered" label | shown when `isRegistered == true` (hide button) |
| "Registration Closed" label | shown when `isRegistrationClosed == true` (hide button) |

**Register tap**: Call `trialRegister` API with `clubId`, `userId`, `userEmail`. On success, update state to `isRegistered = true`.

---

## 8. Colour / Dimension Reference

| Token | Hex | Usage |
|-------|-----|-------|
| `AppColors.socaBlack` | `#1c1c1c` | Text, button bg, card borders |
| `AppColors.socaYellow` | `#eeff41` | Button text |
| `AppColors.socaPageBg` | `#f6f6f6` | Screen background |
| `AppColors.socaGrey` | `#eaeae8` | Dropdown bg, image placeholder |

| Element | dp |
|---------|----|
| Club card image | 80 × 80 |
| Card corner radius | 10 |
| Card elevation | 4 |
| Card margin (h/v) | 5 / 10 |
| Dropdown height | 42 |
| Dropdown arrow icon | 12 × 12 |
| GO button height | 42 |
| VIEW button width | 80 |
| VIEW button padding (v) | 8 |
| Follow button width | 85 |
| Club bio image | 80 × 80 |
| FIFA verify icon | 22 × 22 |
| Gallery / website icons | 25 × 25 |
| Partnership badge (Platinum) | from asset |
| Copy icon (drawer ref) | 27 |

---

## 9. Router Integration

Add to `app_routes.dart` (already has `clubsPartners`):
```dart
static const String clubBio = '/clubs/:clubId';   // already defined
```

Add to `app_router.dart`:
```dart
GoRoute(
  path: AppRoutes.clubsPartners,
  name: 'clubsPartners',
  builder: (ctx, state) => const ClubsPartnersLandingScreen(),
),
GoRoute(
  path: AppRoutes.clubBio,
  name: 'clubBio',
  builder: (ctx, state) {
    final clubId = state.pathParameters['clubId']!;
    return ClubBioScreen(clubId: clubId);
  },
),
```

**Navigation from card**:
```dart
context.push('/clubs/${club.clubId}');
```

---

## 10. Implementation Checklist

### Phase 1 — Models
- [ ] Create `ClubModel` with `@freezed` + run `build_runner`
- [ ] Create `ClubNewsModel`
- [ ] Create `ClubPlayerModel`, `ClubTeamModel`, `ClubSponsorModel`
- [ ] Create `ClubBioModel` (aggregate response model)
- [ ] Create `ClubTrialStatusModel`
- [ ] Add `stadiumsAsStr` and `partnerLabel` extension methods

### Phase 2 — Repository
- [ ] Create `ClubRepository` with `getClubs(params)`, `getClubBio(clubId)`, `followClub(clubId)`, `trialRegister(clubId)`
- [ ] Add API constants for `getClubs`, `getClubBio`, `followClub`, `trialRegister` (already in `ApiConstants`)
- [ ] Parse `response.clubs` list from `getClubs` response
- [ ] Parse `response.details` from `getClubBio` response
- [ ] Apply sort order to all lists in bio response

### Phase 3 — Providers
- [ ] Create `ClubsNotifier` with paginated state (`clubs`, `isLoading`, `hasMore`, `country`, `partnership`)
- [ ] Implement `load()`, `loadMore()`, `setCountry()`, `setPartnership()`
- [ ] Create `clubBioProvider` family
- [ ] Create `followClubProvider` family
- [ ] Create `trialRegisterProvider` family

### Phase 4 — Clubs List Screen
- [ ] Create `ClubsPartnersLandingScreen` with `TabBar` + `TabBarView`
- [ ] Create `ClubsScreen` with filter row + `ListView.builder`
- [ ] Create `ClubFilterRow` widget (Country dropdown + Partnership dropdown + GO button)
- [ ] Create `ClubCard` widget matching `common_clubs_cell.xml` spec
- [ ] Implement infinite scroll (ScrollController listener)
- [ ] Wire `ClubCard` "VIEW" button → `context.push('/clubs/${club.clubId}')`

### Phase 5 — Club Bio Screen
- [ ] Create `ClubBioScreen(clubId)` using `clubBioProvider`
- [ ] Top bar: club name + gallery/website icon buttons
- [ ] Club image + follow button (toggle + API call)
- [ ] FIFA ID row (conditional)
- [ ] Info fields grid (Nickname, Formed, Country, City, Stadium, Manager)
- [ ] League row (conditional)
- [ ] Competitions row (conditional)
- [ ] Partnership badge (conditional)
- [ ] News & Announcements list (`ClubNewsCard`)
- [ ] Recent Matches grid
- [ ] Featured Players grid + "View All" button
- [ ] Club Teams horizontal carousel
- [ ] Sponsors horizontal carousel
- [ ] Kit images row (Home / Away / Third)
- [ ] Trial registration box (conditional, 3 states)

### Phase 6 — Router Wiring
- [ ] Add `ClubsPartnersLandingScreen` route to `app_router.dart`
- [ ] Add `ClubBioScreen` route to `app_router.dart`
- [ ] Confirm bottom nav `clubsPartners` tab navigates to landing screen

---

## 11. Key Behaviours

**Filter application**: Any filter change resets `start = 0`, clears the list, and reloads.  
The GO button is optional (Android hides it by default) — apply filter on dropdown change directly.

**Image loading**: Use `cached_network_image` with `ApiConstants.getImageUrl(imageUrl)`. Circle crop for avatars and club logos.

**Infinite scroll**: Attach `ScrollController` to list; trigger `loadMore()` when within 200 px of the bottom.

**Follow toggle**: Update local state optimistically on tap; call `followClub` API; revert on error.

**Trial states** (mutually exclusive):
1. `isRegisterBtn == true` → show "REGISTER" button
2. `isRegistered == true` → show "REGISTERED" label (no button)
3. `isRegistrationClosed == true` → show "REGISTRATION CLOSED" label (no button)

**Video news**: On tap, use `url_launcher` to open `videoUrl` in external player (or `video_player` in-screen).

**Partners tab**: Follows the same patterns as Clubs tab — different endpoint (`getSponList`, `getCharityList`, etc.) and model fields. Document separately when implementing.
