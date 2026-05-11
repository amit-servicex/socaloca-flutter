# Home Screen Implementation Guide

Comparison of Android `CommonHomeActivity` vs Flutter `HomeScreen`.  
All colours and dimensions are taken directly from the Android source.

---

## 1. Layout Hierarchy

### Android (`activity_common_home.xml`)

```
DrawerLayout (match_parent, right-side drawer)
└── RelativeLayout (bg: #f6f6f6)
    └── LinearLayout (vertical)
        ├── CoordinatorLayout
        │   └── AppBarLayout (elevation: 0)
        ├── RelativeLayout (main content)
        │   ├── [HeaderBox] — 56dp app bar
        │   ├── [mainContent] — feed area fills remaining space
        │   ├── [feedbackBox] — 50dp banner, visibility: gone (conditional)
        │   ├── [LiveMatchBox] — 50dp banner, always visible
        │   └── [footerBox] — 56dp bottom navigation (6 tabs)
        └── [common_menu] — 300dp right drawer (included layout)
```

### Flutter (current state)

```
Scaffold
├── endDrawer: HomeDrawer
└── body: Column
    └── Expanded → SocialFeedScreen
    // TODO: feedbackBox missing
    // TODO: LiveMatchBox missing
    // HomeAppBar is not wired into Scaffold.appBar
```

**Problems:**
- `HomeAppBar` is not connected to `Scaffold.appBar` — the app bar never shows.
- `LiveMatchBanner` widget is missing entirely.
- `FeedbackBanner` widget is missing entirely.
- Bottom navigation is handled by `MainShellScreen` (separate from home) — this is correct for Flutter architecture.

---

## 2. App Bar (`HomeAppBar`)

### Android spec (from `activity_common_home.xml` header section)

| Property | Value |
|----------|-------|
| Height | 56 dp |
| Background | `#f6f6f6` (new_white) |
| Elevation | 0 dp |
| Logo | `ic_new_app_top_logo`, 40 dp wide, centered |
| Back button | 40 dp wide × match_parent, `ic_back` icon, left side |
| Search icon | `ic_search`, 25 dp × 25 dp, right side |
| Notification icon | `ic_notification`, 25 dp × 22 dp, rightmost |
| Notification badge | 7 dp green dot, positioned top-right of bell icon |

### Flutter current (`home_app_bar.dart`)

| Property | Android Match | Issue |
|----------|--------------|-------|
| Height | ✅ 56 | — |
| Background | ❌ `Colors.white` | Should be `AppColors.socaPageBg` (#f6f6f6) |
| Logo | ❌ `Image.asset('assets/images/logo.png')` | Should be `SvgPicture.asset('assets/icons/socaloca_logo.svg')` |
| Logo size | ✅ 40 wide | — |
| Search icon | ✅ 25 dp | — |
| Notification icon | ✅ 25 dp | — |
| Notification badge | ✅ green dot | Badge size should be 7 dp (currently 8 dp) |
| `withOpacity` | ❌ deprecated | Replace with `.withValues(alpha: 0.05)` |
| Wired to Scaffold | ❌ not connected | `HomeScreen` must pass it to `appBar:` |

### Required changes to `home_app_bar.dart`

```dart
// 1. Background: #f6f6f6 not white
color: AppColors.socaPageBg,

// 2. Logo: use SVG not PNG
SvgPicture.asset('assets/icons/socaloca_logo.svg', width: 40),

// 3. Badge: 7dp not 8dp
width: 7, height: 7,

// 4. Fix deprecated withOpacity
color: Colors.black.withValues(alpha: 0.05),
```

### Required change to `home_screen.dart`

```dart
// Add appBar to Scaffold
return Scaffold(
  key: _scaffoldKey,
  backgroundColor: AppColors.socaPageBg,
  appBar: const HomeAppBar(),   // ← add this
  endDrawer: const HomeDrawer(),
  body: ...
```

---

## 3. Live Match Banner

### Android spec (from `activity_common_home.xml` — `@id/LiveMatchBox`)

```
LinearLayout (LiveMatchBox)
  visibility: visible (always shown)
  layout: above footerBox, margin: 5dp top, 3dp bottom
  background: @drawable/shadow_background (drop shadow)

  └── LinearLayout (horizontal)
        background: #eaeae8 (new_grey)
        paddingTop/Bottom: 5dp

        ├── ImageView (liveGif)
        │     width: 64dp, height: 32dp
        │     marginStart: 15dp
        │     src: @drawable/sl_live  (animated GIF → use Lottie/GIF in Flutter)

        ├── TextView "Live Match Update"
        │     font: poppins_bold, 12sp
        │     color: #1c1c1c (new_black)
        │     gravity: center_vertical

        ├── View (weight:1 spacer)

        └── TextView (LiveMatchBTN) "VIEW"
              background: rounded black (#1c1c1c, 5dp radius)
              font: poppins_bold, 10sp
              color: #eeff41 (new_yellow)
              textAllCaps: true
              paddingH: 12dp, paddingV: 5dp
              marginRight: 15dp
              onClick: navigate to live matches screen
```

### Flutter widget to create

Create `lib/features/home/widgets/live_match_banner.dart`:

```dart
class LiveMatchBanner extends StatelessWidget {
  const LiveMatchBanner({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 3),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,         // #eaeae8
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 4, offset: const Offset(0, 2),
        )],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            const SizedBox(width: 15),
            // Replace with Lottie animation or gif_view for animated GIF
            Image.asset('assets/animations/sl_live.gif',
                width: 64, height: 32),
            const SizedBox(width: 8),
            const Text(
              'Live Match Update',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.socaBlack,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'VIEW',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: AppColors.socaYellow,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Wire into `home_screen.dart`:**

```dart
body: Column(
  children: [
    Expanded(child: SocialFeedScreen()),
    if (_showFeedbackBanner) FeedbackBanner(onTap: _openFeedbackForm),
    LiveMatchBanner(onTap: () => context.push(AppRoutes.matches)),
  ],
),
```

**Visibility:** Always visible in Android. Show it unconditionally in Flutter for now. Later add a provider that checks if there are live matches and hide when none.

**Live GIF asset:** The Android app uses `@drawable/sl_live` (an animated GIF). Add an equivalent asset:
- Option A: Add the GIF to `assets/animations/sl_live.gif` and use the `gif_view` package.
- Option B: Replace with a Lottie animation (`lottie` package — already in pubspec).
- Option C: Use a simple red pulsing dot `Container` (simplest fallback).

---

## 4. Feedback Banner

### Android spec (from `activity_common_home.xml` — `@id/feedbackBox`)

Same visual structure as Live Match Banner but:
- `visibility: gone` — **hidden by default**
- Icon: `@drawable/ic_survey` (20 dp × 20 dp survey/clipboard icon)
- Text: "Help us to improve" (10sp, poppins_bold)
- Button text: "FEEDBACK" (10sp, poppins_bold, yellow on black, 5dp radius)
- Visibility controlled in Java: shown when user hasn't given feedback recently

### Flutter widget to create

Create `lib/features/home/widgets/feedback_banner.dart`:

```dart
class FeedbackBanner extends StatelessWidget {
  const FeedbackBanner({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 3),
      decoration: BoxDecoration(
        color: AppColors.socaGrey,
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 4, offset: const Offset(0, 2),
        )],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.assignment_outlined,
                size: 20, color: AppColors.socaBlack),
            const SizedBox(width: 10),
            const Text(
              'Help us to improve',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: AppColors.socaBlack,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.socaBlack,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'FEEDBACK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: AppColors.socaYellow,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Visibility logic in `home_screen.dart`:**

```dart
bool _showFeedbackBanner = false;

@override
void initState() {
  super.initState();
  _checkFeedbackVisibility();
}

Future<void> _checkFeedbackVisibility() async {
  // Show if user hasn't given feedback (use SharedPreferences)
  final lastFeedback = StorageService.lastFeedbackDate; // add this key
  final daysSince = DateTime.now()
      .difference(lastFeedback ?? DateTime(2000))
      .inDays;
  if (daysSince > 30 && mounted) {
    setState(() => _showFeedbackBanner = true);
  }
}
```

---

## 5. Navigation Drawer (`HomeDrawer`)

### Android spec (from `common_menu.xml`)

**Overall structure:**
- Width: 300 dp
- Opens from **right** side (`layout_gravity="right"`)
- Background: `#FFFFFF` (white)

**Top profile section (220 dp height):**
- Background: `#1c1c1c` (new_black) — **currently Flutter uses white**
- User image: 100 dp × 100 dp, centered, circular
- Full name: `#eeff41` (new_yellow), 20sp, lato_bold — **currently Flutter uses black**
- Label "SocaLoca ID": white, 14sp
- SocaLoca ID value: `#eeff41` (new_yellow), 14sp, lato_bold — **currently Flutter uses black**
- Copy icon: 27 dp × 27 dp
- Sign Out link: in top section (white text, 14sp), `visibility: gone` — **not in Flutter top section**

**Menu items order (Android):**
1. Trials (`ic_trials`) — missing in Flutter
2. My Gallery (`ic_gallery_new`)
3. Update Profile (`ic_update_profile`)
4. Change Password (`ic_lock_new`)
5. Change Language (`ic_change_language`)
6. Help Desk (`ic_helpdesk`)
7. Privacy Settings (`ic_settings`)
8. Help Us To Improve (`help_us_to_improve`)
9. Legacy Contact (visibility: gone)
10. Download Activities (visibility: gone)
11. Deactivate/Delete Account (visibility: gone)

Each menu item:
- Icon: 22 dp × 22 dp, marginStart: 20 dp
- Text: lato_bold, 15sp, color: `#1c1c1c`
- Padding: 12-15 dp vertical
- Divider: 0.5 dp black line between items

**Bottom legal links:**
- "Data Policy" | "Terms & Conditions" (separated by "|")
- 14sp, lato_bold, color: `#1c1c1c`
- These are inline in one Row, **not** two separate ListTiles

### Required changes to `home_drawer.dart`

| Section | Current Flutter | Should Be |
|---------|----------------|-----------|
| Profile bg | white | `#1c1c1c` (AppColors.socaBlack) |
| Name colour | `AppColors.socaBlack` | `AppColors.socaYellow` |
| ID label | none | white "SocaLoca ID:" label + yellow ID value |
| ID copy icon | 16 dp | 27 dp |
| Sign Out | bottom button | move into profile section (hidden until needed) |
| Menu item 1 | My Gallery | **Trials** → insert before My Gallery |
| Menu order | wrong | match Android order above |
| Item icon size | default ListTile | 22 dp, marginStart 20 dp |
| Item font | Poppins 14sp | Poppins/Lato 15sp |
| Legal links | 2 ListTiles | 1 Row: "Data Policy | Terms & Conditions" |
| Dividers | single at bottom | 0.5 dp after each item |

---

## 6. Social Feed Header (missing in Flutter)

### Android spec (from `fragment_common_home_feed.xml`)

The `CommonHomeFeedFragment` has a **collapsible CollapsingToolbarLayout header** above the RecyclerView:

```
CollapsingToolbarLayout
└── LinearLayout (profile header)
    ├── RelativeLayout (padding: 10dp)
    │   ├── LinearLayout (left: greeting)
    │   │   ├── TextView "Hello," — 13sp, poppins_regular, #1c1c1c
    │   │   └── TextView {lastName} — 18sp, poppins_bold, #1c1c1c
    │   │
    │   ├── LinearLayout (center: countBox, visibility: gone by default)
    │   │   └── [Posts | Cheers | Followers | Following counts]
    │   │
    │   └── ImageView (userImage)
    │         Size: 60dp × 60dp (circle crop)
    │         Position: alignParentRight
    │         Default: @drawable/avatar1
    │
    ├── View (divider 0.5dp)
    │
    └── LinearLayout (horizontal action buttons)
          ├── myBioBtn  (icon + "My Bio" label)
          ├── myPostsBtn (icon + "My Posts" label)
          ├── myRatingsBtn (visibility: gone)
          └── galleryBtn (icon + "Gallery" label)
```

**Action buttons** — each button:
- Icon: 20-25 dp, `#1c1c1c`
- Label text: 12sp, poppins_bold
- Tap: navigate to the respective screen

### Flutter implementation

This header belongs inside `SocialFeedScreen` (or a new `FeedHeaderWidget`). It collapses as the user scrolls:

```dart
// In SocialFeedScreen, wrap ListView in CustomScrollView:
CustomScrollView(
  slivers: [
    SliverToBoxAdapter(child: FeedHeaderWidget()),
    SliverList(...), // existing posts
  ],
)
```

Create `lib/features/social_feed/widgets/feed_header.dart`:

```dart
class FeedHeaderWidget extends ConsumerWidget {
  const FeedHeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Greeting
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hello,',
                    style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 13,
                      color: AppColors.socaBlack)),
                  Text(user.lastName ?? user.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w700,
                      fontSize: 18, color: AppColors.socaBlack)),
                ],
              ),
              const Spacer(),
              // Profile photo
              CircleAvatar(
                radius: 30,   // 60dp diameter
                backgroundImage: user.profileImage != null
                    ? NetworkImage(user.profileImage!) : null,
                child: user.profileImage == null
                    ? Text(user.name[0],
                        style: const TextStyle(fontSize: 24))
                    : null,
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 0.5,
            color: AppColors.socaBlack),
        // Action buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ActionButton(
              icon: Icons.person, label: 'My Bio',
              onTap: () => context.push(AppRoutes.profile)),
            _ActionButton(
              icon: Icons.article, label: 'My Posts',
              onTap: () { /* navigate */ }),
            _ActionButton(
              icon: Icons.photo_library, label: 'Gallery',
              onTap: () { /* navigate */ }),
          ],
        ),
      ],
    );
  }
}
```

---

## 7. Implementation Checklist

### Phase 1 — App Bar fixes (quick, `home_app_bar.dart`)
- [ ] Change background from `Colors.white` to `AppColors.socaPageBg`
- [ ] Replace `Image.asset('assets/images/logo.png')` with `SvgPicture.asset('assets/icons/socaloca_logo.svg', width: 40)`
- [ ] Change notification badge from 8 dp to 7 dp
- [ ] Replace `.withOpacity(0.05)` with `.withValues(alpha: 0.05)`

### Phase 2 — Wire app bar into screen (`home_screen.dart`)
- [ ] Add `appBar: const HomeAppBar()` to the `Scaffold`
- [ ] Remove duplicate `SafeArea` wrappers inside `HomeAppBar` if appBar is used

### Phase 3 — Live Match Banner (new widget)
- [ ] Create `lib/features/home/widgets/live_match_banner.dart`
- [ ] Add live animation asset or fallback pulsing dot
- [ ] Add to `home_screen.dart` body Column, above bottom nav
- [ ] Wire `onTap` → `context.push(AppRoutes.matches)`

### Phase 4 — Feedback Banner (new widget)
- [ ] Create `lib/features/home/widgets/feedback_banner.dart`
- [ ] Add `_showFeedbackBanner` state + 30-day logic in `home_screen.dart`
- [ ] Wire `onTap` → show feedback dialog or navigate to feedback screen

### Phase 5 — Drawer profile section (`home_drawer.dart`)
- [ ] Set profile box background to `AppColors.socaBlack` (#1c1c1c)
- [ ] Set user name text colour to `AppColors.socaYellow` (#eeff41)
- [ ] Add "SocaLoca ID:" white label above the ID value
- [ ] Set SocaLoca ID text colour to `AppColors.socaYellow`
- [ ] Resize copy icon to 27 dp

### Phase 6 — Drawer menu order (`home_drawer.dart`)
- [ ] Add **Trials** as the first menu item (currently missing)
- [ ] Reorder to match Android: Trials → My Gallery → Update Profile → Change Password → Change Language → Help Desk → Privacy Settings → Help Us To Improve
- [ ] Keep Legacy Contact, Download Activities, Deactivate/Delete hidden (`Visibility` / `if (false)`)
- [ ] Replace 2 legal ListTiles with 1 Row: `"Data Policy  |  Terms & Conditions"`
- [ ] Add 0.5 dp divider after each menu item
- [ ] Update each `_DrawerMenuItem` icon size to 22 dp with 20 dp left margin

### Phase 7 — Social feed header (new widget in `social_feed_screen.dart`)
- [ ] Create `lib/features/social_feed/widgets/feed_header.dart`
- [ ] Replace `ListView.builder` with `CustomScrollView` + `SliverList`
- [ ] Add `FeedHeaderWidget` as first sliver
- [ ] Implement: greeting (Hello, {lastName}), 60 dp avatar (right), action buttons row

---

## 8. File Structure After Implementation

```
lib/features/home/
├── screens/
│   └── home_screen.dart          ← add appBar:, add banners to body
├── widgets/
│   ├── home_app_bar.dart         ← fix bg, logo, badge size
│   ├── home_drawer.dart          ← fix profile section, menu order
│   ├── live_match_banner.dart    ← NEW
│   ├── feedback_banner.dart      ← NEW
│   └── language_selection_bottom_sheet.dart
└── providers/
    └── home_providers.dart

lib/features/social_feed/
├── screens/
│   └── social_feed_screen.dart   ← switch to CustomScrollView
└── widgets/
    └── feed_header.dart          ← NEW
```

---

## 9. Key Colour / Dimension Reference

| Token | Hex | Usage |
|-------|-----|-------|
| `AppColors.socaBlack` | `#1c1c1c` | Profile section bg, icon colours, button bg |
| `AppColors.socaYellow` | `#eeff41` | Name/ID in drawer, button labels |
| `AppColors.socaPageBg` | `#f6f6f6` | App bar bg, screen bg |
| `AppColors.socaGrey` | `#eaeae8` | Banner bg, input bg |
| Green dot | `Colors.green` | Notification badge |

| Element | dp |
|---------|-----|
| App bar height | 56 |
| Drawer width | 300 |
| Drawer profile section height | 220 |
| User avatar (feed header) | 60 (radius 30) |
| User avatar (drawer) | 100 (radius 50) |
| Copy icon | 27 |
| Menu icon | 22 |
| Logo width | 40 |
| Search icon | 25 |
| Notification icon | 25 × 22 |
| Notification badge | 7 |
| Banner height (approx) | ~50 |
| Banner live icon | 64 × 32 |
| Survey icon | 20 |
| Bottom nav height | 56 |
