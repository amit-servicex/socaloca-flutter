# Login Flow Diagram

## Complete Login Flow (Android → Flutter Migration)

```
┌─────────────────────────────────────────────────────────────────┐
│                      LOGIN LANDING SCREEN                        │
│                                                                  │
│                    [Login Button] [SignUp Button]               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ Tap Login
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                       NEW LOGIN SCREEN                           │
│                                                                  │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  Mobile number */Email */SocaLoca ID *                 │    │
│  │  [+1 ▼] [________________input_________________]       │    │
│  └────────────────────────────────────────────────────────┘    │
│         ▲                                                        │
│         │ Country code appears only for phone numbers           │
│         │                                                        │
│  ┌────────────────────────────────────────────────────────┐    │
│  │  Password                                    [👁]       │    │
│  │  [________________input_________________]              │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                  │
│  * mandatory fields              Forgotten Password?            │
│                                                                  │
│  💡 Find your new SocaLoca ID in the sliding hamburger menu    │
│                                                                  │
│                    ┌──────────────────┐                         │
│                    │     LOG IN       │                         │
│                    └──────────────────┘                         │
│                                                                  │
│                   or continue with                               │
│                                                                  │
│         [Facebook Button]    [Google Button]                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
   [Email Login]        [Mobile Login]      [SocaLoca ID Login]
        │                     │                     │
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │  Input Validation │
                    └──────────────────┘
                              │
                ┌─────────────┴─────────────┐
                │                           │
                ▼                           ▼
           [Valid]                     [Invalid]
                │                           │
                │                           ▼
                │                    Show Error Message
                │                           │
                │                           └──► Return to Input
                │
                ▼
        ┌──────────────────┐
        │  Detect Input Type│
        └──────────────────┘
                │
    ┌───────────┼───────────┐
    │           │           │
    ▼           ▼           ▼
 [Email]    [Mobile]   [SocaLoca ID]
    │           │           │
    │           │           │
    └───────────┼───────────┘
                │
                ▼
        ┌──────────────────┐
        │  Build API Request│
        │                  │
        │  {               │
        │    email/phone/  │
        │    sclId: value, │
        │    password: xxx,│
        │    deviceId: xxx,│
        │    countryCode?: │
        │  }               │
        └──────────────────┘
                │
                ▼
        ┌──────────────────┐
        │  POST /modSignIn │
        └──────────────────┘
                │
    ┌───────────┴───────────┐
    │                       │
    ▼                       ▼
[Success]              [Failure]
status=1               status=0/2
    │                       │
    │                       ├──► status=2 → "Wrong password"
    │                       │
    │                       └──► status=0 → "Account not registered"
    │
    ▼
┌──────────────────┐
│ Check Policy     │
│ Accepted?        │
└──────────────────┘
    │
    ├──► Yes → Skip policy call
    │
    └──► No ──┐
              │
              ▼
      ┌──────────────────┐
      │ POST             │
      │ /accUserPolicy   │
      │                  │
      │ { userId: xxx }  │
      └──────────────────┘
              │
              ▼
      ┌──────────────────┐
      │ Save User Session│
      │ - Token          │
      │ - User Data      │
      └──────────────────┘
              │
              ▼
      ┌──────────────────┐
      │ Navigate Based   │
      │ on Role          │
      └──────────────────┘
              │
    ┌─────────┼─────────┐
    │         │         │
    ▼         ▼         ▼
 [Fan]   [Referee]  [Other]
    │         │         │
    └─────────┼─────────┘
              │
              ▼
      ┌──────────────────┐
      │   HOME SCREEN    │
      └──────────────────┘
```

---

## Social Login Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                       NEW LOGIN SCREEN                           │
│                                                                  │
│         [Facebook Button]    [Google Button]                    │
└─────────────────────────────────────────────────────────────────┘
                │                           │
                │                           │
                ▼                           ▼
        ┌──────────────┐          ┌──────────────┐
        │   Facebook   │          │    Google    │
        │     SDK      │          │     SDK      │
        └──────────────┘          └──────────────┘
                │                           │
                │                           │
                └───────────┬───────────────┘
                            │
                            ▼
                    ┌──────────────────┐
                    │  Get User Data   │
                    │  - socialId      │
                    │  - email         │
                    │  - name          │
                    │  - profilePic    │
                    │  - loginType     │
                    └──────────────────┘
                            │
                            ▼
                    ┌──────────────────┐
                    │ POST             │
                    │ /socialLogin     │
                    └──────────────────┘
                            │
                ┌───────────┴───────────┐
                │                       │
                ▼                       ▼
         [New User]              [Existing User]
         isNewUser=true          isNewUser=false
                │                       │
                │                       │
                ▼                       ▼
    ┌──────────────────┐      ┌──────────────────┐
    │  Age Selection   │      │  Save Session    │
    │     Screen       │      │  Navigate Home   │
    └──────────────────┘      └──────────────────┘
```

---

## Input Type Detection Flow

```
User Types: "test@example.com"
                │
                ▼
        ┌──────────────────┐
        │  Regex Check:    │
        │  ^[^@]+@[^@]+\.  │
        └──────────────────┘
                │
                ▼
            [Email]
                │
                ▼
        Country Code: Hidden
        API Field: "email"


User Types: "1234567890"
                │
                ▼
        ┌──────────────────┐
        │  Regex Check:    │
        │  ^\d+$           │
        └──────────────────┘
                │
                ▼
            [Mobile]
                │
                ▼
        Country Code: Visible (+1 ▼)
        API Field: "phone" + "countryCode"


User Types: "SCL123456"
                │
                ▼
        ┌──────────────────┐
        │  Regex Check:    │
        │  ^[Ss][Cc][Ll]\d+│
        └──────────────────┘
                │
                ▼
         [SocaLoca ID]
                │
                ▼
        Country Code: Hidden
        API Field: "sclId"
```

---

## Validation Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                      VALIDATION CHECKS                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │  Identity Empty? │
                    └──────────────────┘
                              │
                    ┌─────────┴─────────┐
                    │                   │
                    ▼                   ▼
                  [Yes]               [No]
                    │                   │
                    │                   ▼
                    │         ┌──────────────────┐
                    │         │  Detect Type     │
                    │         └──────────────────┘
                    │                   │
                    │         ┌─────────┴─────────┐
                    │         │                   │
                    │         ▼                   ▼
                    │     [Mobile]            [Other]
                    │         │                   │
                    │         ▼                   │
                    │   ┌──────────────┐         │
                    │   │ Length < 7?  │         │
                    │   └──────────────┘         │
                    │         │                   │
                    │   ┌─────┴─────┐            │
                    │   │           │            │
                    │   ▼           ▼            │
                    │ [Yes]       [No]           │
                    │   │           │            │
                    │   │           └────────────┘
                    │   │                   │
                    ▼   ▼                   ▼
            ┌──────────────────┐   ┌──────────────────┐
            │  Show Error      │   │  Password Empty? │
            └──────────────────┘   └──────────────────┘
                    │                       │
                    │             ┌─────────┴─────────┐
                    │             │                   │
                    │             ▼                   ▼
                    │           [Yes]               [No]
                    │             │                   │
                    │             │                   ▼
                    │             │         ┌──────────────────┐
                    │             │         │  Length < 6?     │
                    │             │         └──────────────────┘
                    │             │                   │
                    │             │         ┌─────────┴─────────┐
                    │             │         │                   │
                    │             ▼         ▼                   ▼
                    │      ┌──────────────────┐          ┌──────────┐
                    │      │  Show Error      │          │ Valid ✅ │
                    │      └──────────────────┘          └──────────┘
                    │             │                           │
                    └─────────────┴───────────────────────────┘
                                  │
                                  ▼
                          Return to Input
```

---

## Error Handling Flow

```
API Response
    │
    ▼
┌──────────────────┐
│  Check Status    │
└──────────────────┘
    │
    ├──► status = 1 → Success → Continue
    │
    ├──► status = 2 → "Wrong password"
    │
    ├──► status = 0 → "Account not registered"
    │
    └──► Other → Display error message
```

---

## Key Differences: Android vs Flutter

### Android
- Separate activities for Fan/Referee/Common users
- Uses CountryCodePicker library
- Uses Volley for networking
- Stores user in SharedPreferences

### Flutter
- Unified home screen with role-based UI
- Custom country code picker (TODO: full implementation)
- Uses Dio for networking
- Uses Riverpod for state management

### Result
✅ **Functionality is identical, implementation details differ**
