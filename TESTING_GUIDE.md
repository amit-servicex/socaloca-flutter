# Quick Testing Guide: Onboarding Flow

## 🚀 Quick Start

```bash
# Run the app
cd socaloca-flutter
flutter run
```

## ✅ What to Expect

### First Launch (Fresh Install)
```
Splash Screen (2.5s)
    ↓
Onboarding Slide 1 (auto-scroll after 3s)
    ↓
Onboarding Slide 2 (auto-scroll after 3s)
    ↓
Onboarding Slide 3 (auto-scroll after 3s)
    ↓
Onboarding Slide 4 (auto-navigate after 2.5s)
    ↓
Role Choice Screen
```

### Second Launch (Returning User)
```
Splash Screen (2.5s)
    ↓
Role Choice Screen (onboarding skipped!)
```

### After Login
```
Splash Screen (2.5s)
    ↓
Home Screen
```

## 🧪 Test Cases

### Test 1: First Time User ⭐
**Steps:**
1. Uninstall app or clear data
2. Run `flutter run`
3. Wait for splash (2.5s)

**Expected:**
- ✅ Onboarding appears
- ✅ 4 slides with images
- ✅ Auto-scroll every 3 seconds
- ✅ Skip button visible
- ✅ Page indicators at bottom
- ✅ After last slide → Role Choice

**Pass/Fail:** ___

---

### Test 2: Skip Onboarding ⏭️
**Steps:**
1. Fresh install
2. Tap "Skip" button on any slide

**Expected:**
- ✅ Immediately goes to Role Choice
- ✅ Onboarding marked as complete

**Pass/Fail:** ___

---

### Test 3: Complete Onboarding 📱
**Steps:**
1. Fresh install
2. Let all 4 slides auto-scroll
3. Wait on last slide

**Expected:**
- ✅ Auto-navigates to Role Choice after 2.5s
- ✅ Onboarding marked as complete

**Pass/Fail:** ___

---

### Test 4: Returning User 🔄
**Steps:**
1. Complete onboarding once
2. Close app completely
3. Reopen app

**Expected:**
- ✅ Splash appears
- ✅ Onboarding is SKIPPED
- ✅ Goes directly to Role Choice

**Pass/Fail:** ___

---

### Test 5: Role Selection 🎯
**Steps:**
1. Reach Role Choice screen
2. View all 6 roles
3. Tap any role

**Expected:**
- ✅ All 6 roles visible:
  - Player
  - Coach
  - Manager
  - Referee
  - Fan
  - Professional Club
- ✅ Selection highlights
- ✅ Navigates to login/signup

**Pass/Fail:** ___

---

### Test 6: Manual Swipe 👆
**Steps:**
1. Fresh install
2. Manually swipe between slides

**Expected:**
- ✅ Swipe works smoothly
- ✅ Auto-scroll timer resets
- ✅ Page indicators update

**Pass/Fail:** ___

---

### Test 7: After Login 🏠
**Steps:**
1. Complete login
2. Close app
3. Reopen app

**Expected:**
- ✅ Splash appears
- ✅ Goes directly to Home
- ✅ Skips onboarding and role choice

**Pass/Fail:** ___

## 🔧 Troubleshooting

### Problem: Onboarding doesn't appear
**Solution:**
```bash
# Clear app data
flutter clean
flutter run
```

### Problem: Onboarding appears every time
**Check:**
1. Is `StorageService.init()` called in main.dart?
2. Is `setOnboardingComplete()` called in onboarding screen?

**Debug:**
```dart
// Add to splash screen
print('Onboarding complete: ${StorageService.onboardingComplete}');
```

### Problem: Black screen after splash
**Check:**
1. Console for errors
2. Routes are defined in app_router.dart
3. Images exist in assets/images/

### Problem: Images not loading
**Check:**
1. Files exist:
   - assets/images/sp_one.jpg
   - assets/images/sp_two.jpg
   - assets/images/sp_three.jpg
   - assets/images/sp_four.jpg
2. pubspec.yaml includes assets
3. Run `flutter pub get`

## 🎯 Quick Commands

### See Onboarding Again
```bash
# Option 1: Clear app data
adb shell pm clear com.football.socaloca

# Option 2: Uninstall and reinstall
flutter clean
flutter run

# Option 3: In code (debug only)
await StorageService.clearOnboarding();
```

### Check Storage
```dart
// Add to splash screen for debugging
print('Storage Debug:');
print('  Onboarding: ${StorageService.onboardingComplete}');
print('  Auth Token: ${StorageService.authToken}');
```

### Force Navigation
```dart
// Skip to specific screen (debug only)
context.go(AppRoutes.onboarding);  // Force onboarding
context.go(AppRoutes.roleChoice);  // Force role choice
context.go(AppRoutes.home);        // Force home
```

## 📊 Test Results Template

```
Date: ___________
Tester: ___________
Device: ___________
OS Version: ___________

Test 1 (First Time):     [ ] Pass  [ ] Fail
Test 2 (Skip):           [ ] Pass  [ ] Fail
Test 3 (Complete):       [ ] Pass  [ ] Fail
Test 4 (Returning):      [ ] Pass  [ ] Fail
Test 5 (Role Select):    [ ] Pass  [ ] Fail
Test 6 (Manual Swipe):   [ ] Pass  [ ] Fail
Test 7 (After Login):    [ ] Pass  [ ] Fail

Issues Found:
_________________________________
_________________________________
_________________________________

Overall Status: [ ] Pass  [ ] Fail
```

## 🎨 Visual Checklist

### Onboarding Screen
- [ ] Images load correctly
- [ ] Text is readable
- [ ] Skip button visible (top-right)
- [ ] Page indicators visible (bottom)
- [ ] Active indicator is highlighted
- [ ] Smooth transitions
- [ ] Dark theme consistent

### Role Choice Screen
- [ ] Header "I am a..." visible
- [ ] All 6 role cards visible
- [ ] Icons display correctly
- [ ] Selection state works
- [ ] Radio buttons work
- [ ] Smooth animations
- [ ] Dark theme consistent

## 📱 Device Testing

Test on multiple devices:

| Device | OS | Test 1 | Test 4 | Test 5 | Status |
|--------|----|----|----|----|--------|
| Pixel 6 | Android 13 | [ ] | [ ] | [ ] | ___ |
| iPhone 14 | iOS 16 | [ ] | [ ] | [ ] | ___ |
| Samsung S21 | Android 12 | [ ] | [ ] | [ ] | ___ |
| iPad | iOS 16 | [ ] | [ ] | [ ] | ___ |

## 🐛 Known Issues

None currently reported.

If you find issues:
1. Note the device and OS version
2. Describe steps to reproduce
3. Check console for errors
4. Take screenshots if possible

## ✨ Success Criteria

All tests must pass:
- ✅ Onboarding appears on first launch
- ✅ Onboarding can be skipped
- ✅ Onboarding auto-scrolls
- ✅ Onboarding navigates to role choice
- ✅ Second launch skips onboarding
- ✅ Role choice shows all 6 roles
- ✅ Role selection navigates correctly
- ✅ No crashes or errors
- ✅ Smooth animations
- ✅ Images load correctly

## 📞 Support

If tests fail:
1. Check `FIX_SUMMARY.md` for details
2. Check `NAVIGATION_FIX.md` for troubleshooting
3. Review console logs
4. Verify all files are saved
5. Try `flutter clean` and rebuild

---

**Last Updated:** 2026-05-05
**Version:** 1.0.0
**Status:** Ready for Testing
