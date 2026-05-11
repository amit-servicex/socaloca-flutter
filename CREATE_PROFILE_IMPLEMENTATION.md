# Create Profile Screen — Flutter Implementation Guide

Analysed from: `Socaloca-legacy` Android app  
Target: `socaloca-flutter` Flutter app  
Date: 2026-05-07

---

## 1. Overview of the Android Flow

The Android app gates profile creation behind an **age-group selection** step. Every path through signup eventually lands on `CreateProfileFragment`, but what that screen shows is controlled entirely by the stored `ageGroup` value.

```
AgeSelectionFragment
  ├── Adult (≥16)  → NewSignUpFragment (phone/email + password)
  │                       └── CreateProfileFragment  [photo upload mode]
  │
  ├── Youth (13-15) → ChildConsentFragment (parent name, email, phone)
  │                       └── PinSetUpRegisterFragment
  │                               └── CreateProfileFragment  [avatar-only mode]
  │
  └── Child (7-12)  → ChildConsentFragment (minor name, parent name, email)
                          └── PinSetUpRegisterFragment
                                  └── CreateProfileFragment  [avatar-only mode]
```

The Flutter routes and screens for this flow already exist. What is **missing** is:
1. Age group state being saved when the user taps a button on `AgeSelectionScreen`.
2. `CreateProfileScreen` reading that state and switching between **photo-upload mode** (adult) and **avatar-only mode** (youth/child).

---

## 2. Age-Group Constants

Android source: `Params.java`

| Constant     | Value    | Min age |
|--------------|----------|---------|
| `AGE_ADULT`  | `">=16"` | 16      |
| `AGE_YOUTH`  | `"13-15"`| 12      |
| `AGE_CHILD`  | `"7-12"` | 6       |

Flutter equivalent (already in `auth_provider.dart`):

```dart
// signupTempProvider holds ageGroup as a String
// Use these string values throughout the Flutter app
const ageAdult  = 'adult';   // maps to >=16
const ageYouth  = 'youth';   // maps to 13-15
const ageChild  = 'child';   // maps to 7-12
```

---

## 3. File-by-File Changes Required

### 3.1 `age_selection_screen.dart`

**Current problem:** The three `InkWell` buttons navigate to the next screen but never save the age group into `signupTempProvider`.

**Required change:** Call `ref.read(signupTempProvider.notifier).setAgeGroup(...)` before each `context.push(...)`.

```dart
// Adult button onTap
onTap: () {
  ref.read(signupTempProvider.notifier).setAgeGroup('adult');
  context.push(AppRoutes.signup);
},

// Youth button onTap
onTap: () {
  ref.read(signupTempProvider.notifier).setAgeGroup('youth');
  context.push(AppRoutes.youthConsent);
},

// Child button onTap
onTap: () {
  ref.read(signupTempProvider.notifier).setAgeGroup('child');
  context.push(AppRoutes.childConsent);
},
```

The widget also needs to be converted from `StatelessWidget` to `ConsumerWidget` to gain `ref` access.

---

### 3.2 `create_profile_screen.dart` — Core Change

**Current problem:** The screen always shows both the avatar grid AND the camera/gallery buttons regardless of age group. The Android app shows **only one** of these sections depending on age group.

#### Android logic (from `CreateProfileFragment.java`, line 2893–2914):

```java
private void setAgeGroup() {
    String ageGroup = GlobalDataService.getInstance().getAgeGroup();
    switch (ageGroup) {
        case AGE_CHILD:
        case AGE_YOUTH:
            imageBox.setVisibility(View.GONE);       // hide photo upload
            avatarSection.setVisibility(View.VISIBLE); // show avatar grid
            orSection.setVisibility(View.GONE);
            break;
        case AGE_ADULT:
            imageBox.setVisibility(View.VISIBLE);    // show photo upload
            avatarSection.setVisibility(View.GONE);  // hide avatar grid
            orSection.setVisibility(View.GONE);
            break;
    }
}
```

#### Flutter equivalent to implement:

In `_CreateProfileScreenState`, read the stored age group and expose a computed property:

```dart
// Inside _CreateProfileScreenState
bool get _isAdult {
  final ageGroup = ref.read(signupTempProvider).ageGroup;
  return ageGroup == 'adult' || ageGroup.isEmpty; // default to adult
}
```

Then in `_buildAvatarSection()` replace the current combined widget with a conditional:

```dart
Widget _buildAvatarSection() {
  if (_isAdult) {
    // Adult: show photo upload only, no avatar grid
    return _buildPhotoUploadSection();
  } else {
    // Youth/Child: show avatar grid only, no photo upload
    return _buildAvatarGridSection();
  }
}

Widget _buildPhotoUploadSection() {
  return Column(
    children: [
      const SizedBox(height: 15),
      // Large preview circle (keep existing)
      Center(child: _buildProfileImagePreview()),
      const SizedBox(height: 20),
      // Camera + Gallery buttons only
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            const Text(
              'Upload your profile photo',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CAMERA button
                InkWell(
                  onTap: _pickImageFromCamera,
                  child: _buildUploadButton(
                    icon: Icons.camera_alt,
                    label: 'CAMERA',
                    isLight: true,
                  ),
                ),
                const SizedBox(width: 10),
                // GALLERY button
                InkWell(
                  onTap: _pickImageFromGallery,
                  child: _buildUploadButton(
                    icon: Icons.photo_library,
                    label: 'GALLERY',
                    isLight: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildAvatarGridSection() {
  return Column(
    children: [
      const SizedBox(height: 15),
      // Large preview circle showing selected avatar
      Center(child: _buildProfileImagePreview()),
      const SizedBox(height: 20),
      // Avatar selection grid only — no camera/gallery buttons
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            const Text(
              'Choose your avatar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.socaBlack,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _avatars.length,
              itemBuilder: (context, index) {
                final avatar = _avatars[index];
                final isSelected =
                    _selectedAvatar == avatar && _profileImage == null;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedAvatar = avatar;
                    _profileImage = null;
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.socaYellow
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/$avatar',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}
```

Extract the shared large preview circle into its own method:

```dart
Widget _buildProfileImagePreview() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.socaYellow,
            width: (_profileImage != null || _selectedAvatar != null) ? 3 : 0,
          ),
        ),
        child: ClipOval(
          child: _profileImage != null
              ? Image.file(_profileImage!, fit: BoxFit.cover)
              : _selectedAvatar != null
                  ? Image.asset('assets/images/$_selectedAvatar', fit: BoxFit.cover)
                  : CircleAvatar(
                      backgroundColor:
                          AppColors.socaYellow.withValues(alpha: 0.15),
                      child: const Icon(Icons.person, size: 80,
                          color: AppColors.socaBlack),
                    ),
        ),
      ),
      if (_profileImage != null || _selectedAvatar != null)
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: _showImageSourceDialog,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.socaBlack,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: AppColors.socaYellow, size: 18),
            ),
          ),
        ),
    ],
  );
}
```

The `OR` section (the text widget between avatar grid and upload section) must be **removed completely** — it is hidden (`orSection.setVisibility(View.GONE)`) in all Android paths.

---

### 3.3 `youth_consent_screen.dart`

**Current problem (to verify):** The Youth consent screen should collect `parentName`, `parentEmail`, and `parentPhone`. Confirm these three fields are present.

Android source (`fragment_youth_consent.xml`):
- `parentNameEt` — Parent/guardian's name
- `parentEmailEt` — Parent/guardian's email
- `parentPhoneEt` — Parent/guardian's phone (digits only, max 10)
- `consentCheck` — Checkbox
- `proceedBtn` — PROCEED button (black bg, yellow text)

The Child consent screen (`fragment_child_consent.xml`) differs in that it collects the **minor's own name** (`minorsEt`) instead of a phone number.

---

## 4. Screen-by-Screen UI Specification

### 4.1 Age Selection Screen

| Element | Android spec | Flutter equivalent |
|---|---|---|
| Background | `@color/new_white` = `#FFFFFF` | `AppColors.socaPageBg` |
| Logo | `150dp × 150dp`, centered, `marginTop=50dp` | 200px wide SVG, `SizedBox(height:50)` |
| Button height | `100dp` | `height: 100` |
| Button bg | `@drawable/rounded_new_black_5dp` | `AppColors.socaBlack`, `borderRadius: 5` |
| Button margin | `marginLeft/Right=10dp` | `horizontal: 10` |
| Button gap | `30dp` | `SizedBox(height: 30)` |
| Primary text size | `20sp` semibold | `fontSize: 20, FontWeight.w600` |
| Age text size | `24sp` bold | `fontSize: 24, FontWeight.w700` |
| Text color | `@color/new_yellow` | `AppColors.socaYellow` |

---

### 4.2 Child Consent Screen (7–12)

**Heading text (from `@string/child_consent_str1`):**
> "Accounts of children between the ages of 7 and 12 can only created and managed by a parent or guardian."

**Sub-text:**
> "Please fill out the fields below and tick the checkbox."

**Legal text (from `@string/child_consent_str2`):**
> "This is confirm that you are the legal guardian and will take full control and accountability of this account upon registering on behalf of a minor."

**Fields (in order):**
1. **Child's Name** — `textPersonName`, bold label
2. **Parent/Guardian's Name** — `textPersonName`, bold label
3. **Parent/Guardian's Email** — `textEmailAddress`, bold label

**Consent text (from `@string/child_consent_term`):**
> "I consent that I am registering on behalf of a minor and will take full control of this SocaLoca account."

**Button:** `PROCEED` — black bg, yellow text, 16sp bold, all caps

**API call:** `PRE_REGISTER` with `ageGroup: 'child'`  
**On success:** Navigate to `AppRoutes.pinSetup?consentId=<id>`

---

### 4.3 Youth Consent Screen (13–15)

**Heading text (from `@string/youth_consent_str1`):**
> Displayed as descriptive paragraph about youth registration requirements.

**Fields (in order, side-by-side label+input layout in Android, stacked in Flutter):**
1. **Parent/Guardian's Name** — `textPersonName`
2. **Parent/Guardian's Email** — `textEmailAddress`
3. **Parent/Guardian's Phone** — `phone`, digits only, max 10

**Consent checkbox**

**Button:** `PROCEED` — same style as child consent

**API call:** `PRE_REGISTER` with `ageGroup: 'youth'`  
**On success:** Navigate to `AppRoutes.pinSetup?consentId=<id>`

---

### 4.4 Create Profile Screen — Full Field Reference

All fields exist in the Android layout. The table below maps each to its visibility rule.

#### Always visible (all age groups)

| Field | Notes |
|---|---|
| First name | `hint="first name *"` |
| Last name | `hint="last name *"` |
| Profile name | Min 5 chars; show tick icon when valid |
| About Me | Multi-line, max 300 chars |
| Select Role chips | Player, Coach, Manager, Fan, Referee |
| Date of Birth | Calendar picker, mandatory |
| Country | Auto-detected from locale, display only |
| Gender | Radio: Male / Female |

#### Profile image section — age-group conditional

| Age group | Show | Hide |
|---|---|---|
| Adult (≥16) | Photo upload (camera + gallery buttons) | Avatar grid |
| Youth (13–15) | Avatar grid | Photo upload buttons |
| Child (7–12) | Avatar grid | Photo upload buttons |

The "OR" text between them is **never shown** — remove it.

#### Role-conditional fields

| Field | Visible when |
|---|---|
| Playing position (dropdown) | `isPlayer && !isFan && !isReferee` |
| Position type (dropdown) | Same as above |
| Playing level | Same as above |
| Preferred foot (radio) | Same as above |
| Height (cm) | Same as above |
| Nationality picker | Same as above |
| Jersey number | `(isPlayer \|\| isCoach \|\| isManager) && !isReferee` |
| Shirt/Jersey size | Same as above |
| Shoe size | Same as above |
| Location from map | `(isPlayer \|\| isCoach \|\| isManager) && !isReferee` |
| Fan location | `isFan` |
| Brands you like | `(isPlayer \|\| isCoach \|\| isManager \|\| isFan) && !isReferee` |
| Major leagues you follow | `isFan` |
| Teams you follow | `isFan` |

#### Role mutual-exclusivity rules (from Android)

- Selecting **Fan** deselects: Player, Coach, Manager, Referee
- Selecting **Referee** deselects: Player, Coach, Manager, Fan
- Selecting **Player**, **Coach**, or **Manager** deselects: Fan, Referee
- Player + Coach + Manager can coexist

---

## 5. State Management

### Where age group is stored

```
signupTempProvider (StateNotifierProvider<SignupTempNotifier, SignupTempState>)
  └── ageGroup: String  ('adult' | 'youth' | 'child')
```

### Reading age group in CreateProfileScreen

```dart
class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  // ...
  bool get _isAdult {
    final ag = ref.read(signupTempProvider).ageGroup;
    return ag == 'adult' || ag.isEmpty;
  }
}
```

`ref.read` (not `ref.watch`) is sufficient here since the age group does not change while the screen is open.

---

## 6. Routing — No Changes Needed

The route constants already exist in `app_routes.dart`:

```dart
static const String ageSelection   = '/auth/age-selection';
static const String youthConsent   = '/auth/youth-consent';
static const String childConsent   = '/auth/child-consent';
static const String pinSetup       = '/auth/pin-setup';
static const String createProfile  = '/auth/create-profile';
```

The router wiring just needs to confirm `createProfile` is accessible from `pinSetup` (for youth/child paths) and from the signup success handler (for adult path).

---

## 7. Implementation Checklist

### Step 1 — Fix `AgeSelectionScreen`
- [ ] Convert to `ConsumerWidget`
- [ ] Adult button: call `setAgeGroup('adult')` before `context.push(AppRoutes.signup)`
- [ ] Youth button: call `setAgeGroup('youth')` before `context.push(AppRoutes.youthConsent)`
- [ ] Child button: call `setAgeGroup('child')` before `context.push(AppRoutes.childConsent)`

### Step 2 — Update `CreateProfileScreen`
- [ ] Add `bool get _isAdult` computed getter
- [ ] Split `_buildAvatarSection()` into `_buildPhotoUploadSection()` and `_buildAvatarGridSection()`
- [ ] Route to the correct section based on `_isAdult`
- [ ] Extract `_buildProfileImagePreview()` shared widget
- [ ] Remove the "OR" `Text` widget between the two sections

### Step 3 — Verify `YouthConsentScreen`
- [ ] Confirm it collects: `parentName`, `parentEmail`, `parentPhone`
- [ ] Confirm it calls `PRE_REGISTER` with `ageGroup: 'youth'`
- [ ] Confirm it navigates to `AppRoutes.pinSetup?consentId=<id>` on success

### Step 4 — Verify `ChildConsentScreen`
- [ ] Confirm it collects: `minorName`, `parentName`, `parentEmail`
- [ ] Confirm it calls `PRE_REGISTER` with `ageGroup: 'child'`
- [ ] Confirm it navigates to `AppRoutes.pinSetup?consentId=<id>` on success

---

## 8. Android Source References

| What | Android file | Key lines |
|---|---|---|
| Age group constants | `libs/Params.java` | `AGE_ADULT`, `AGE_YOUTH`, `AGE_CHILD` |
| Age selection UI | `fragment/AgeSelectionFragment.java` | `adultBtnListener`, `youthBtnListener`, `childBtnListener` |
| Age selection layout | `res/layout/fragment_age_selection.xml` | `adultBtn`, `youthBtn`, `childBtn` |
| Child consent form | `fragment/ChildConsentFragment.java` | `minorsEt`, `parentNameEt`, `parentEmailEt` |
| Child consent layout | `res/layout/fragment_child_consent.xml` | Full form structure |
| Youth consent form | `res/layout/fragment_youth_consent.xml` | `parentNameEt`, `parentEmailEt`, `parentPhoneEt` |
| Create profile — age switch | `fragment/CreateProfileFragment.java` | Lines 2893–2914 (`setAgeGroup()`) |
| Create profile layout | `res/layout/fragment_create_profile.xml` | `imageBox`, `avatarSection`, `orSection` IDs |
| Global state service | `service/GlobalDataService.java` | `setAgeGroup()`, `getAgeGroup()` |
