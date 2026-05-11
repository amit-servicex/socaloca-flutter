# Quick Start Guide: Onboarding & Role Selection

## Overview
This guide helps you understand and test the newly implemented onboarding and role selection screens.

## What Was Added

### 1. Image Slider Onboarding (4 Screens)
- **File:** `lib/features/auth/screens/onboarding_screen.dart`
- **Purpose:** First-time user introduction to the app
- **Features:**
  - Auto-scrolling image slides (3-second intervals)
  - Manual swipe support
  - Skip button
  - Page indicators
  - Auto-navigation on completion

### 2. Role Selection Screen
- **File:** `lib/features/auth/screens/role_choice_screen.dart`
- **Purpose:** User selects their role in the app
- **Options:**
  - Player
  - Coach
  - Manager
  - Referee
  - Fan
  - Professional Club

## User Flow

```
App Launch
    ↓
Splash Screen (2.5s)
    ↓
Onboarding Slider (First time only)
    ↓
Role Choice Screen
    ↓
Login/Signup
```

## How to Test

### Run the App
```bash
cd socaloca-flutter
flutter run
```

### Test Onboarding
1. **First Launch:**
   - App shows splash → onboarding → role choice
   
2. **Skip Button:**
   - Tap "Skip" on any slide
   - Should navigate to role choice immediately
   
3. **Auto-Scroll:**
   - Wait on any slide
   - Should auto-advance after 3 seconds
   
4. **Manual Swipe:**
   - Swipe left/right
   - Auto-scroll timer should reset
   
5. **Last Slide:**
   - Reach the 4th slide
   - Should auto-navigate after 2.5 seconds

### Test Role Selection
1. **View All Roles:**
   - Scroll through all 6 role cards
   
2. **Select a Role:**
   - Tap any role card
   - Card should highlight
   - Should navigate to appropriate screen
   
3. **Role Navigation:**
   - Player/Coach/Manager/Referee/Fan → Login Landing
   - Professional Club → Club Login

### Reset Onboarding
To see onboarding again (for testing):
```dart
// In your code or debug console:
await StorageService.clearOnboarding();
```

Or clear app data:
```bash
# Android
adb shell pm clear com.football.socaloca

# iOS
flutter clean
```

## Code Structure

### Onboarding Screen
```dart
OnboardingScreen (StatefulWidget)
  ├── PageController (manages slides)
  ├── Timer (auto-scroll)
  └── PageView
      ├── Slide 1 (sp_one.jpg)
      ├── Slide 2 (sp_two.jpg)
      ├── Slide 3 (sp_three.jpg)
      └── Slide 4 (sp_four.jpg)
```

### Role Choice Screen
```dart
RoleChoiceScreen (StatefulWidget)
  └── Column
      ├── Header ("I am a...")
      └── ScrollView
          ├── Player Card
          ├── Coach Card
          ├── Manager Card
          ├── Referee Card
          ├── Fan Card
          └── Club Card
```

## Customization

### Change Onboarding Images
Edit `onboarding_screen.dart`:
```dart
static const _pages = [
  _OnboardingPage(
    imagePath: 'assets/images/your_image.jpg',
    title: 'Your Title',
    subtitle: 'Your Subtitle',
  ),
  // ... more pages
];
```

### Change Auto-Scroll Timing
Edit `onboarding_screen.dart`:
```dart
// Change from 3 seconds to your desired duration
Timer.periodic(const Duration(seconds: 3), (_) { ... });
```

### Add/Remove Roles
Edit `role_choice_screen.dart`:
```dart
_RoleCard(
  role: 'your_role',
  title: 'Your Role',
  icon: Icons.your_icon,
  isSelected: _selectedRole == 'your_role',
  onTap: () => _onRoleSelected('your_role'),
),
```

### Change Colors
Edit theme colors in `lib/core/theme/app_colors.dart`:
```dart
static const primary = Color(0xFFYourColor);
```

## Troubleshooting

### Onboarding Shows Every Time
**Problem:** Onboarding appears on every app launch

**Solution:** Check storage implementation
```dart
// Verify this is called:
await StorageService.setOnboardingComplete();
```

### Images Not Loading
**Problem:** Onboarding shows gradient instead of images

**Solution:** 
1. Check images exist in `assets/images/`
2. Verify `pubspec.yaml` includes assets:
```yaml
flutter:
  assets:
    - assets/images/
```
3. Run `flutter pub get`

### Auto-Scroll Not Working
**Problem:** Slides don't advance automatically

**Solution:** Check timer initialization in `initState()`

### Role Selection Not Navigating
**Problem:** Tapping role doesn't navigate

**Solution:** Check router configuration in `app_router.dart`

## Performance Tips

1. **Image Optimization:**
   - Compress images before adding to assets
   - Use appropriate image sizes for mobile

2. **Memory Management:**
   - Timer is disposed in `dispose()`
   - PageController is disposed properly

3. **Smooth Animations:**
   - Use `Curves.easeInOut` for natural motion
   - Keep animation duration reasonable (300-500ms)

## Accessibility

### Screen Reader Support
Add semantic labels:
```dart
Semantics(
  label: 'Skip onboarding',
  child: TextButton(...),
)
```

### High Contrast Mode
Test with system high contrast enabled

### Font Scaling
Test with different text size settings

## Analytics (TODO)

Track user behavior:
```dart
// Track onboarding completion
analytics.logEvent('onboarding_completed');

// Track role selection
analytics.logEvent('role_selected', parameters: {
  'role': selectedRole,
});
```

## Localization (TODO)

Add multi-language support:
```dart
// Instead of hardcoded strings:
Text('Welcome to SocaLoca')

// Use:
Text(AppLocalizations.of(context).welcomeTitle)
```

## Related Files

- `lib/features/auth/screens/splash_screen.dart` - Entry point
- `lib/features/auth/screens/onboarding_screen.dart` - Image slider
- `lib/features/auth/screens/role_choice_screen.dart` - Role selection
- `lib/core/router/app_router.dart` - Navigation configuration
- `lib/core/router/app_routes.dart` - Route constants
- `lib/core/storage/storage_service.dart` - Persistent storage
- `assets/images/sp_*.jpg` - Onboarding images

## Support

For issues or questions:
1. Check `ONBOARDING_IMPLEMENTATION.md` for detailed docs
2. Check `IMPLEMENTATION_SUMMARY.md` for overview
3. Review Android source in `Socaloca-legacy/` for reference

## Next Steps

After testing:
1. ✅ Verify all flows work correctly
2. ✅ Test on different devices/screen sizes
3. ✅ Check performance and memory usage
4. 📝 Add analytics tracking
5. 📝 Add localization
6. 📝 Implement scout info screen
7. 📝 Add automated tests

## Checklist

- [ ] Splash screen displays correctly
- [ ] Onboarding shows on first launch only
- [ ] All 4 slides are visible
- [ ] Auto-scroll works (3s interval)
- [ ] Manual swipe works
- [ ] Skip button works
- [ ] Page indicators update correctly
- [ ] Last slide auto-navigates
- [ ] All 6 roles are visible
- [ ] Role selection highlights correctly
- [ ] Navigation works for each role
- [ ] Images load properly
- [ ] Text is readable
- [ ] Animations are smooth
- [ ] No memory leaks
- [ ] Works on different screen sizes

---

**Status:** ✅ Implementation Complete
**Last Updated:** 2026-05-05
**Version:** 1.0.0
