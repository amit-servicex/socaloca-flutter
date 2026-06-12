# Google Sign-In Reauth Failed Analysis

## Problem

On `new_login_screen.dart`, after selecting a Gmail account from the Google account chooser, login fails with:

```text
Google SignIn exception: code=GoogleSignInExceptionCode.canceled, desc=[16] Account reauth failed.
```

The Google account chooser opens, but authentication does not complete. Because the exception is thrown from:

```dart
final googleUser = await GoogleSignIn.instance.authenticate();
```

the app never reaches `_socialLogin(...)`, and the SocaLoca backend `socialLogin` API is not called for this failure.

## Files Checked

| Area | File |
| --- | --- |
| Flutter login UI and Google function | `lib/features/auth/screens/new_login_screen.dart` |
| Flutter social login API payload | `lib/features/auth/repositories/auth_repository.dart` |
| Flutter Android app config | `android/app/build.gradle` |
| Flutter Firebase/Google config | `android/app/google-services.json` |
| Flutter app startup/Firebase init | `lib/main.dart` |
| Legacy Android login/signup Google flow | `Socaloca-legacy/app/src/main/java/com/football/socaloca/fragment/NewLoginFragment.java`, `NewSignUpFragment.java` |
| Legacy Android Google config | `Socaloca-legacy/app/google-services.json` |
| `google_sign_in` local plugin docs | `~/.pub-cache/hosted/pub.dev/google_sign_in_android-7.2.10/README.md` |

## Current Flutter Code Path

`_googleLogin()` in `new_login_screen.dart` does this:

```dart
final googleUser = await GoogleSignIn.instance.authenticate();
await _socialLogin(
  socialId: googleUser.id,
  email: googleUser.email,
  firstName: firstName,
  lastName: lastName,
  media: 'google',
);
```

If `authenticate()` fails, the backend call is skipped.

The backend payload in `auth_repository.dart` matches the legacy Android payload shape:

```json
{
  "firstName": "...",
  "lastName": "...",
  "media": "google",
  "socialId": "...",
  "email": "...",
  "deviceType": "android",
  "deviceId": "...",
  "deviceModel": "Unknown"
}
```

So this is not currently a SocaLoca API issue. It fails before the API request.

## Main Finding

This is most likely a Google/Firebase Android OAuth configuration issue, specifically a signing certificate SHA mismatch.

The local `google_sign_in_android` plugin README says that a `GoogleSignInExceptionCode.canceled` after selecting an account can actually be caused by configuration errors. It lists common causes:

- Missing or incorrect signing SHA for one or more build configurations.
- Incorrect Android package name on the server side.
- Missing or incorrect `serverClientId`.

That exactly matches this symptom: the user selects an account, then Google returns `canceled` with `[16] Account reauth failed`.

## Evidence

### Package Name

Flutter Android package:

```text
android/app/build.gradle
applicationId "com.football.socaloca"
namespace "com.football.socaloca"
```

Google config package:

```text
android/app/google-services.json
package_name: com.football.socaloca
```

The package name matches, so package name is not the issue.

### Web Client ID

Flutter initializes Google Sign-In with:

```dart
serverClientId:
  '247756601333-i4p8he1a8ttnjlp8i812u8rhp5copmgk.apps.googleusercontent.com'
```

`android/app/google-services.json` contains the same web OAuth client:

```text
client_type: 3
client_id: 247756601333-i4p8he1a8ttnjlp8i812u8rhp5copmgk.apps.googleusercontent.com
```

So the hardcoded `serverClientId` appears to match the current downloaded Google config.

### SHA-1 Mismatch

`android/app/google-services.json` contains only one Android OAuth client SHA-1:

```text
C8:57:C1:AC:70:3F:8D:47:3A:66:01:CB:BF:22:68:FB:E8:72:78:45
```

That SHA-1 belongs to the legacy Android keystore:

```text
Socaloca-legacy/app/socalocanew.jks
alias: alias
SHA1: C8:57:C1:AC:70:3F:8D:47:3A:66:01:CB:BF:22:68:FB:E8:72:78:45
```

But the Flutter app uses different signing certificates locally:

Debug keystore:

```text
~/.android/debug.keystore
alias: androiddebugkey
SHA1: 09:22:B7:9C:64:E4:3D:F9:02:C2:F9:BE:1B:D4:65:3E:0C:9D:5F:E9
SHA256: 17:50:42:A9:5D:4D:73:B3:3F:62:E1:35:55:55:F7:6C:ED:FA:31:2A:B4:C7:39:98:12:78:3E:2F:C8:12:0C:A0
```

Flutter release/upload keystore:

```text
android/app/upload-keystore.jks
alias: upload
SHA1: EB:7E:3F:22:D6:7F:10:56:EE:61:B7:BC:F9:B3:2B:06:CC:5B:25:FF
SHA256: 5B:9E:E6:71:35:EF:B9:FD:8C:B8:93:F0:05:EE:AC:61:07:52:2D:44:E2:74:CA:FC:54:85:81:E6:A6:4A:EC:1D
```

Neither Flutter SHA-1 is present in `google-services.json`.

This means the installed Flutter app is probably signed with a certificate that Google OAuth does not recognize for `com.football.socaloca`.

## Why Legacy May Work But Flutter Fails

The Flutter app has copied the same `google-services.json` as the legacy Android app. That config is registered for the legacy keystore SHA-1.

The Flutter app is not signed with that same legacy keystore:

- Debug builds use `~/.android/debug.keystore`.
- Flutter release builds use `android/app/upload-keystore.jks`.

Therefore Google Sign-In can open the account chooser, but fails during the credential/authentication step.

## Codebase Issues Found

### 1. Missing Flutter SHA fingerprints in Firebase/Google config

This is the primary issue.

Fix in Firebase Console or Google Cloud OAuth configuration:

1. Open the Firebase project for `socaloca-f5230`.
2. Open Android app `com.football.socaloca`.
3. Add the Flutter debug SHA-1 and SHA-256:

```text
SHA1: 09:22:B7:9C:64:E4:3D:F9:02:C2:F9:BE:1B:D4:65:3E:0C:9D:5F:E9
SHA256: 17:50:42:A9:5D:4D:73:B3:3F:62:E1:35:55:55:F7:6C:ED:FA:31:2A:B4:C7:39:98:12:78:3E:2F:C8:12:0C:A0
```

4. Add the Flutter release/upload SHA-1 and SHA-256:

```text
SHA1: EB:7E:3F:22:D6:7F:10:56:EE:61:B7:BC:F9:B3:2B:06:CC:5B:25:FF
SHA256: 5B:9E:E6:71:35:EF:B9:FD:8C:B8:93:F0:05:EE:AC:61:07:52:2D:44:E2:74:CA:FC:54:85:81:E6:A6:4A:EC:1D
```

5. Download the updated `google-services.json`.
6. Replace `socaloca-flutter/android/app/google-services.json`.
7. Run a clean rebuild:

```bash
flutter clean
flutter pub get
flutter run
```

### 2. `_googleLogin()` hides this config failure from the user

Current code suppresses the snackbar when the plugin code is `canceled`:

```dart
if (mounted && e.code != GoogleSignInExceptionCode.canceled) {
  AppSnackBar.showError(context, AppStrings.googleSignInFailedWithCode(e.code));
}
```

For real user cancellation this is fine. But for this Google SDK behavior, configuration errors can also be reported as `canceled`, so the app silently stops loading and gives no user-facing error.

Recommendation:

- Keep ignoring plain user cancellation if possible.
- During debug builds, show/log the full description when `e.description` contains `Account reauth failed` or `[16]`.
- This will make future configuration issues easier to identify.

Example diagnostic behavior:

```dart
if (e.code == GoogleSignInExceptionCode.canceled &&
    (e.description?.contains('reauth failed') ?? false)) {
  AppSnackBar.showError(context, AppStrings.googleSignInFailed);
}
```

### 3. Hardcoded `serverClientId`

The hardcoded `serverClientId` currently matches `google-services.json`, so it is not the main problem.

However, the Android plugin docs say that when using `google-services.json` with a web OAuth client entry, Android does not need Dart identifiers during initialization.

Current code:

```dart
await GoogleSignIn.instance.initialize(
  serverClientId:
    '247756601333-i4p8he1a8ttnjlp8i812u8rhp5copmgk.apps.googleusercontent.com',
);
```

Recommended after fixing Firebase config:

```dart
await GoogleSignIn.instance.initialize();
```

Or keep `serverClientId` only if the app intentionally wants to override the value from Google services config.

## Things That Are Probably Not The Issue

### SocaLoca backend social login API

Not reached. The failure happens before `_socialLogin(...)`.

### Flutter Firebase initialization

`main.dart` calls:

```dart
await Firebase.initializeApp();
```

So Firebase is initialized before the app UI starts.

### Android package name

`applicationId` matches `google-services.json`:

```text
com.football.socaloca
```

### Missing web OAuth client

`google-services.json` includes a web OAuth client with `client_type: 3`.

## Verification After Fix

After adding the Flutter SHA fingerprints and downloading the new config:

1. Confirm `android/app/google-services.json` contains Android OAuth clients for the Flutter debug/release SHA values.
2. Rebuild the app from clean state.
3. Tap Google login.
4. Select Gmail account.
5. Expected behavior:
   - `GoogleSignIn.instance.authenticate()` returns a `GoogleSignInAccount`.
   - `_socialLogin(...)` is called.
   - App either logs in, routes existing users, or opens the social profile creation flow for new users.

## Final Diagnosis

The error is not caused by the SocaLoca social login API and is not primarily a Dart payload issue.

The strongest repo-backed cause is that the Flutter app is signed with SHA fingerprints that are not registered in the Firebase/Google OAuth config. The checked-in `google-services.json` is registered only for the legacy Android keystore SHA-1, while the Flutter debug and Flutter release keystores have different SHA-1/SHA-256 fingerprints.

Fix the Firebase/Google OAuth SHA configuration, download the updated `google-services.json`, clean rebuild, and test Google login again.
