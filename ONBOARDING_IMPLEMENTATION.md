# Onboarding & Role Selection Implementation

## Overview
This document describes the implementation of the onboarding flow and role selection screens in the Flutter app, migrated from the Android legacy app.

## Flow Diagram
```
Splash Screen (2.5s)
    ↓
Onboarding Slider (4 screens with auto-scroll)
    ↓
Role Choice Screen
    ↓
Login/Signup Flow (based on role)
```

## Implementation Details

### 1. Splash Screen (`splash_screen.dart`)
**Android Equivalent:** `SplashActivity.java`

**Features:**
- Displays splash image for 2.5 seconds
- Black status bar (matching Android `new_black` color: `#1C1C1C`)
- Checks authentication state
- Routes to:
  - Home screen if user is logged in
  - Onboarding screen if first-time user
  - Login screen if returning user

**Key Changes:**
- Modified navigation to go to onboarding instead of directly to login

### 2. Onboarding Screen (`onboarding_screen.dart`)
**Android Equivalent:** `BoardingActivity.java` + `OnboardingOneFragment.java` through `OnboardingFourFragment.java`

**Features:**
- 4 full-screen image slides with text overlay
- Auto-scroll every 3 seconds (matching Android interval)
- Manual swipe support with reset of auto-scroll timer
- Skip button (top-right corner)
- Page indicators (dots at bottom)
- On last slide, auto-navigates after 2.5 seconds
- Marks onboarding as complete in storage

**Images Used:**
- `assets/images/sp_one.jpg` - Welcome screen
- `assets/images/sp_two.jpg` - Connect with players
- `assets/images/sp_three.jpg` - Organize matches
- `assets/images/sp_four.jpg` - Join tournaments

**Styling:**
- Dark background (`#1C1C1C`)
- White text with gradient overlay for readability
- Poppins font family
- Smooth page transitions

### 3. Role Choice Screen (`role_choice_screen.dart`)
**Android Equivalent:** `RoleChoiceFragment.java`

**Features:**
- 6 role options presented as cards:
  1. **Player** - For individual players
  2. **Coach** - For team coaches
  3. **Manager** - For team managers
  4. **Referee** - For match referees
  5. **Fan** - For football fans
  6. **Professional Club** - For club administrators

**UI Components:**
- Each role card contains:
  - Icon representing the role
  - Role title
  - Radio button indicator
  - Hover/selection state with primary color highlight
- Dark theme matching onboarding
- Smooth animations on selection

**Navigation Logic:**
```dart
- Player/Coach/Manager/Referee/Fan → LoginLandingScreen
- Professional Club → ClubLoginScreen
- Scout → ScoutInfoScreen (TODO)
```

## Android to Flutter Mapping

| Android Component | Flutter Component | Status |
|------------------|-------------------|--------|
| `SplashActivity.java` | `splash_screen.dart` | ✅ Complete |
| `BoardingActivity.java` | `onboarding_screen.dart` | ✅ Complete |
| `OnboardingOneFragment.java` | Slide 1 in PageView | ✅ Complete |
| `OnboardingTwoFragment.java` | Slide 2 in PageView | ✅ Complete |
| `OnboardingThreeFragment.java` | Slide 3 in PageView | ✅ Complete |
| `OnboardingFourFragment.java` | Slide 4 in PageView | ✅ Complete |
| `RoleChoiceFragment.java` | `role_choice_screen.dart` | ✅ Complete |
| `AutoScrollViewPager` | PageController with Timer | ✅ Complete |

## Key Differences from Android

### Improvements:
1. **Smoother Animations**: Flutter's animation framework provides better transitions
2. **Responsive Design**: Automatically adapts to different screen sizes
3. **Better State Management**: Uses Riverpod for clean state handling
4. **Type Safety**: Dart's type system prevents many runtime errors

### Maintained Features:
1. **Auto-scroll timing**: Same 3-second interval
2. **Visual design**: Matching colors and layout
3. **Navigation flow**: Identical user journey
4. **Role options**: All 6 roles preserved

## Storage

The app uses `StorageService` to track onboarding completion:
```dart
await StorageService.setOnboardingComplete();
```

This ensures users only see onboarding once.

## Routes Configuration

Routes are defined in `app_router.dart`:
```dart
AppRoutes.splash → '/'
AppRoutes.onboarding → '/onboarding'
AppRoutes.roleChoice → '/auth/role-choice'
AppRoutes.loginLanding → '/auth'
AppRoutes.clubLogin → '/auth/club-login'
```

## Testing Checklist

- [ ] Splash screen displays for 2.5 seconds
- [ ] Onboarding auto-scrolls every 3 seconds
- [ ] Manual swipe resets auto-scroll timer
- [ ] Skip button navigates to role choice
- [ ] Last slide auto-navigates after 2.5 seconds
- [ ] Onboarding only shows once (check storage)
- [ ] All 6 role cards are visible and selectable
- [ ] Role selection navigates to correct screen
- [ ] Back button on role choice exits app
- [ ] Status bar is black throughout flow
- [ ] Images load correctly
- [ ] Text is readable on all slides
- [ ] Animations are smooth

## Future Enhancements

1. **Localization**: Add multi-language support for onboarding text
2. **Analytics**: Track which roles users select most
3. **A/B Testing**: Test different onboarding content
4. **Video Backgrounds**: Replace static images with video
5. **Interactive Elements**: Add tap-to-explore features
6. **Accessibility**: Add screen reader support and high contrast mode

## Files Modified

1. `lib/features/auth/screens/splash_screen.dart` - Updated navigation
2. `lib/features/auth/screens/onboarding_screen.dart` - Complete rewrite
3. `lib/features/auth/screens/role_choice_screen.dart` - Complete implementation
4. `lib/core/router/app_router.dart` - Already configured (no changes needed)

## Dependencies

No new dependencies were added. The implementation uses:
- `flutter/material.dart` - UI components
- `go_router` - Navigation
- `flutter_riverpod` - State management
- Built-in `PageController` and `Timer` for auto-scroll

## Notes

- The Android app used `AutoScrollViewPager` library, but Flutter's built-in `PageController` with `Timer` provides the same functionality
- Images are already present in the assets folder from the Android migration
- The role selection logic matches the Android implementation exactly
- Scout role navigation is marked as TODO pending implementation of scout info screen
