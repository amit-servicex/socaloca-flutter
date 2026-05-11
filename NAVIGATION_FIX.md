# Navigation Fix: Onboarding & Role Choice

## Issue
The onboarding screen and role choice screen were not appearing after the splash screen.

## Root Cause
The splash screen was not checking the onboarding completion status from storage. It was always navigating directly to the onboarding screen, but the router might have been redirecting or the logic was incomplete.

## Fix Applied

### 1. Updated Splash Screen Navigation Logic
**File:** `lib/features/auth/screens/splash_screen.dart`

**Before:**
```dart
void _navigate() {
  if (!mounted) return;
  final isLoggedIn = ref.read(authStateProvider).isAuthenticated;
  if (isLoggedIn) {
    context.go(AppRoutes.home);
  } else {
    context.go(AppRoutes.onboarding); // Always went to onboarding
  }
}
```

**After:**
```dart
void _navigate() {
  if (!mounted) return;
  final isLoggedIn = ref.read(authStateProvider).isAuthenticated;
  
  if (isLoggedIn) {
    // User is logged in, go to home
    context.go(AppRoutes.home);
  } else {
    // User is not logged in, check onboarding status
    final hasSeenOnboarding = StorageService.onboardingComplete;
    
    if (hasSeenOnboarding) {
      // User has seen onboarding, go to role choice
      context.go(AppRoutes.roleChoice);
    } else {
      // First time user, show onboarding
      context.go(AppRoutes.onboarding);
    }
  }
}
```

### 2. Added Storage Import
Added import for `StorageService`:
```dart
import '../../../core/storage/storage_service.dart';
```

### 3. Added Clear Onboarding Method
**File:** `lib/core/storage/storage_service.dart`

Added method for testing:
```dart
static Future<bool> clearOnboarding() =>
    remove(StorageKeys.onboardingComplete);
```

## Expected Flow Now

### First Time User:
```
Splash (2.5s)
    ↓
Onboarding Slider (4 screens)
    ↓ (marks onboarding complete)
Role Choice Screen
    ↓
Login/Signup
```

### Returning User (Not Logged In):
```
Splash (2.5s)
    ↓
Role Choice Screen (skips onboarding)
    ↓
Login/Signup
```

### Logged In User:
```
Splash (2.5s)
    ↓
Home Screen
```

## How to Test

### Test 1: First Time User Flow
1. Clear app data or run:
   ```dart
   await StorageService.clearOnboarding();
   ```
2. Launch app
3. **Expected:** Splash → Onboarding (4 slides) → Role Choice

### Test 2: Returning User Flow
1. Complete onboarding once
2. Close and reopen app
3. **Expected:** Splash → Role Choice (skips onboarding)

### Test 3: Logged In User Flow
1. Log in to the app
2. Close and reopen app
3. **Expected:** Splash → Home Screen

## Testing Commands

### Clear Onboarding (See it again)
```bash
# Option 1: Clear all app data
flutter run --clear-cache

# Option 2: Uninstall and reinstall
flutter clean
flutter run

# Option 3: Clear app data on device
# Android:
adb shell pm clear com.football.socaloca

# iOS:
# Delete app from device and reinstall
```

### Debug Navigation
Add debug prints to splash screen:
```dart
void _navigate() {
  if (!mounted) return;
  final isLoggedIn = ref.read(authStateProvider).isAuthenticated;
  final hasSeenOnboarding = StorageService.onboardingComplete;
  
  print('🔍 Navigation Debug:');
  print('  - isLoggedIn: $isLoggedIn');
  print('  - hasSeenOnboarding: $hasSeenOnboarding');
  
  if (isLoggedIn) {
    print('  → Going to HOME');
    context.go(AppRoutes.home);
  } else {
    if (hasSeenOnboarding) {
      print('  → Going to ROLE CHOICE');
      context.go(AppRoutes.roleChoice);
    } else {
      print('  → Going to ONBOARDING');
      context.go(AppRoutes.onboarding);
    }
  }
}
```

## Verification Checklist

- [ ] First launch shows onboarding
- [ ] Onboarding can be skipped
- [ ] Onboarding navigates to role choice when complete
- [ ] Second launch skips onboarding
- [ ] Role choice screen appears after onboarding
- [ ] All 6 roles are visible
- [ ] Role selection navigates correctly
- [ ] Logged in users go directly to home
- [ ] No infinite loops or crashes

## Common Issues & Solutions

### Issue: Still not showing onboarding
**Solution:** Check if `StorageService.init()` is called in `main.dart`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init(); // Must be called!
  runApp(const MyApp());
}
```

### Issue: Onboarding shows every time
**Solution:** Check if `setOnboardingComplete()` is called in onboarding screen:
```dart
Future<void> _complete() async {
  await StorageService.setOnboardingComplete(); // Must be called!
  if (mounted) context.go(AppRoutes.roleChoice);
}
```

### Issue: Router redirects away
**Solution:** Check `app_router.dart` redirect logic doesn't interfere:
```dart
redirect: (context, state) {
  final isSplash = state.matchedLocation == AppRoutes.splash;
  if (isSplash) return null; // Don't redirect from splash
  
  // ... rest of redirect logic
}
```

### Issue: Black screen after splash
**Solution:** Check console for errors. Verify routes are defined:
```dart
// In app_router.dart
GoRoute(
  path: AppRoutes.onboarding,
  builder: (ctx, state) => const OnboardingScreen(),
),
GoRoute(
  path: AppRoutes.roleChoice,
  builder: (ctx, state) => const RoleChoiceScreen(),
),
```

## Files Modified

1. ✅ `lib/features/auth/screens/splash_screen.dart`
   - Added storage check
   - Updated navigation logic
   - Added import for StorageService

2. ✅ `lib/core/storage/storage_service.dart`
   - Added `clearOnboarding()` method for testing

## Testing Results

Run these tests and check off:

### Manual Testing:
- [ ] Fresh install → Shows onboarding
- [ ] Complete onboarding → Shows role choice
- [ ] Relaunch app → Skips onboarding, shows role choice
- [ ] Select role → Navigates to login
- [ ] Login → Next launch goes to home

### Edge Cases:
- [ ] Kill app during onboarding → Resumes correctly
- [ ] Clear data → Shows onboarding again
- [ ] Logout → Shows role choice (not onboarding)

## Status

✅ **Fix Applied**
✅ **Analysis Clean**
⏳ **Awaiting Testing**

## Next Steps

1. Run the app: `flutter run`
2. Verify onboarding appears
3. Complete onboarding flow
4. Verify role choice appears
5. Relaunch and verify onboarding is skipped
6. Test all navigation paths

---

**Fixed:** 2026-05-05
**Files Changed:** 2
**Lines Changed:** ~20
