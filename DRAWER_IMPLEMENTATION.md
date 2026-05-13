# Drawer Feature — Flutter Migration

## Overview

The right-side drawer (`HomeDrawer`) slides in from the right (hamburger icon in AppBar).
Width: 300 dp. Used by both the main shell (`MainShellScreen`) and `RefereeHomeScreen`.

---

## Header Section

| Element | Android source | Flutter |
|---|---|---|
| Profile image | 100 dp circular, `@drawable/avatar1` default | `CircleAvatar` radius 50, initials fallback |
| Full name | Yellow, Lato Bold 20sp | Yellow, Lato Bold 20sp |
| SocaLoca ID label | White 14sp | White 14sp |
| SocaLoca ID value | Yellow 14sp | Yellow 14sp |
| Copy icon | 27 dp next to ID | `Icons.copy` 27sp, copies to clipboard |
| Background | Black | `AppColors.socaBlack` |

---

## Menu Items (in order)

| # | Item | Android ID | Action |
|---|---|---|---|
| 1 | Trials | — | Push `/trials` |
| 2 | My Gallery | — | Push `/gallery` |
| 3 | Update Profile | `updateProfile` | Push `/my-bio/edit-profile` with `PlayerBioModel` |
| 4 | Change Password | `changePassword` | Push `/settings/change-password` |
| 5 | Change Language | `changeLanguageBtn` | Show `LanguageSelectionBottomSheet` |
| 6 | Help Desk | `helpDesk` | Open URL: `https://organise.socaloca.football/support.php` |
| 7 | Privacy Settings | `privacySettingsBtn` | Push `/settings/privacy` |
| 8 | Help Us To Improve | `feedbackBtn` | Opens `SurveyActivity` (Android) → stub/coming soon |
| — | Data Policy | `dataPolicyBtn` | Open URL: `https://socaloca.football/privacy-policy/` |
| — | Terms & Conditions | `termConditionsBtn` | Open URL: `https://socaloca.football/terms-of-service/` |
| — | Sign Out | `signOutBtn` | Clear session → navigate to `/auth/role-choice` |

---

## Phase 1 — Wire existing stubs

**Changes only in `home_drawer.dart`** — no new screens needed.

- Help Desk → `launchUrl(Uri.parse('https://organise.socaloca.football/support.php'))`
- Data Policy → `launchUrl(Uri.parse('https://socaloca.football/privacy-policy/'))`
- Terms & Conditions → `launchUrl(Uri.parse('https://socaloca.football/terms-of-service/'))`
- Change Language → `showModalBottomSheet` with `LanguageSelectionBottomSheet`
- Help Us To Improve → `AppSnackBar.showSuccess(context, 'Coming soon')`

**Status:** ✅ Complete

---

## Phase 2 — Change Password Screen

**File:** `lib/features/settings/screens/change_password_screen.dart`
**Route:** `AppRoutes.changePassword = '/settings/change-password'`

### UI
- AppBar: "Change Password", back button
- SocaLoca ID display row (white text)
- Three password fields (Current Password, New Password, Confirm New Password)
  - All masked with eye-toggle
- SUBMIT button (black fill, yellow text)

### Validation (matches Android `FanChangePasswordFragment`)
- All three fields required
- New password ≥ 6 characters
- New password ≠ current password
- Confirm password must match new password

### API
- Endpoint: `ApiConstants.changePassword` → `'changePassword'`
- Method: POST
- Payload: `{ userId, currentPassword, newPassword }`
- Success response: `response.status == 1`

**Status:** ✅ Complete

---

## Phase 3 — Privacy Settings Screen

**File:** `lib/features/settings/screens/privacy_settings_screen.dart`
**Route:** `AppRoutes.privacySettings = '/settings/privacy'`

### Content (matches `CommonPrivacySettingsFragment`)

| Section | Type | Action |
|---|---|---|
| Header image | 170 dp banner | — |
| About SocaLoca | Expandable text | Expands/collapses description |
| Manage Account | Expandable | Contains sub-items below |
| → Deactivate/Delete Account | Sub-item | Stub — coming soon |
| Data Privacy | Tap row | Open `https://socaloca.football/privacy-policy/` |
| Terms & Conditions | Tap row | Open `https://socaloca.football/terms-of-service/` |
| Sign Out | Button | Same as drawer sign-out |

**Status:** ✅ Complete

---

## Key URLs

| Purpose | URL |
|---|---|
| Help Desk | `https://organise.socaloca.football/support.php` |
| Data Privacy | `https://socaloca.football/privacy-policy/` |
| Terms & Conditions | `https://socaloca.football/terms-of-service/` |

## Key Files

| File | Role |
|---|---|
| `lib/features/home/widgets/home_drawer.dart` | Main drawer widget (shared by all shells) |
| `lib/features/home/widgets/language_selection_bottom_sheet.dart` | Language picker |
| `lib/features/settings/screens/change_password_screen.dart` | Phase 2 screen |
| `lib/features/settings/screens/privacy_settings_screen.dart` | Phase 3 screen |
| `lib/core/router/app_routes.dart` | Route constants |
| `lib/core/router/app_router.dart` | Route registrations |
