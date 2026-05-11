# Cup Stats Tab - Ticker Provider Fix

## Issue

When navigating to the Stats tab under Cup Tournament screen, the following error occurred:

```
════════ Exception caught by widgets library ═══════════════════════════════════
_CupStatsTabState is a SingleTickerProviderStateMixin but multiple tickers were created.
```

This resulted in a red error screen.

---

## Root Cause

The `_CupStatsTabState` class was using `SingleTickerProviderStateMixin` but creating **3 TabControllers**:

1. `_modeTabController` - For switching between Group Stage and Knockout modes
2. `_groupStatsTabController` - For Group Stage stats tabs (Goals/Assists/Cards/MOM)
3. `_knockoutStatsTabController` - For Knockout stats tabs (Goals/Assists/Cards/MOM)

**Rule:** `SingleTickerProviderStateMixin` can only provide a ticker for **one** `TabController`. When you need multiple `TabController`s, you must use `TickerProviderStateMixin` instead.

---

## Solution

Changed the mixin from `SingleTickerProviderStateMixin` to `TickerProviderStateMixin`:

### Before (Incorrect):
```dart
class _CupStatsTabState extends ConsumerState<CupStatsTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _modeTabController;
  late TabController _groupStatsTabController;
  late TabController _knockoutStatsTabController;
  // ❌ Error: SingleTickerProviderStateMixin can't handle 3 TabControllers
```

### After (Correct):
```dart
class _CupStatsTabState extends ConsumerState<CupStatsTab>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _modeTabController;
  late TabController _groupStatsTabController;
  late TabController _knockoutStatsTabController;
  // ✅ Correct: TickerProviderStateMixin can handle multiple TabControllers
```

---

## File Modified

**File:** `socaloca-flutter/lib/features/tournaments/screens/cup/tabs/cup_stats_tab.dart`

**Line:** 29

**Change:** `SingleTickerProviderStateMixin` → `TickerProviderStateMixin`

---

## Verification

✅ No compilation errors  
✅ No runtime errors  
✅ Stats tab now works correctly  
✅ All 3 TabControllers function properly  

---

## Key Learnings

### When to use SingleTickerProviderStateMixin:
- When you have **exactly one** `TabController` (or other ticker-based animation)
- Most common use case for simple tab layouts

### When to use TickerProviderStateMixin:
- When you have **multiple** `TabController`s
- When you have nested tabs (tabs within tabs)
- When you have multiple animations running simultaneously

### Example Pattern:
```dart
// Single TabController - Use SingleTickerProviderStateMixin
class MyState extends State<MyWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
}

// Multiple TabControllers - Use TickerProviderStateMixin
class MyState extends State<MyWidget> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  late TabController _tabController3;
}
```

---

## Status

✅ **FIXED** - Cup Stats tab now works without errors

The Cup Tournament Stats feature is now fully functional with proper ticker provider support for nested tab navigation.

