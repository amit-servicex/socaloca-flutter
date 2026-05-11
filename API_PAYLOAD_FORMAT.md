# Login API Payload Format - Corrected

## ✅ Issue Fixed

**Problem**: API payload was using wrong field names (`password`, `phone`) instead of the actual required fields (`passKey`, `mobile`, `signType`).

---

## Correct API Payload Format

### Mobile Login
```json
{
  "mobile": "9830157659",
  "countryCode": "+91",
  "signType": "mobile",
  "passKey": "123456",
  "deviceId": "jwijr4afbc9086kf67sv2yikzsdi724e"
}
```

### Email Login
```json
{
  "email": "user@example.com",
  "signType": "email",
  "passKey": "123456",
  "deviceId": "jwijr4afbc9086kf67sv2yikzsdi724e"
}
```

### SocaLoca ID Login
```json
{
  "sclId": "SCL123456",
  "signType": "sclId",
  "passKey": "123456",
  "deviceId": "jwijr4afbc9086kf67sv2yikzsdi724e"
}
```

---

## Field Mapping

| Field Name | Required | Description | Example |
|------------|----------|-------------|---------|
| `mobile` | Yes (for mobile) | Phone number without country code | `"9830157659"` |
| `email` | Yes (for email) | Email address | `"user@example.com"` |
| `sclId` | Yes (for ID) | SocaLoca ID | `"SCL123456"` |
| `countryCode` | Yes (for mobile) | Country calling code with + | `"+91"` |
| `signType` | Yes | Type of login | `"mobile"`, `"email"`, or `"sclId"` |
| `passKey` | Yes | User password | `"123456"` |
| `deviceId` | Yes | Unique device identifier | `"jwijr4afbc9086kf67sv2yikzsdi724e"` |
| `fcmToken` | Optional | Firebase Cloud Messaging token | `"fcm_token_here"` |

---

## Changes Made

### Before (Wrong)
```dart
final body = {
  'password': password,        // ❌ Wrong field name
  'phone': phoneNumber,        // ❌ Wrong field name
  'deviceId': deviceId,
};
```

### After (Correct)
```dart
final body = {
  'passKey': password,         // ✅ Correct field name
  'mobile': phoneNumber,       // ✅ Correct field name
  'signType': 'mobile',        // ✅ Added signType
  'countryCode': countryCode,  // ✅ Added countryCode
  'deviceId': deviceId,
};
```

---

## Implementation in Flutter

### auth_repository.dart

```dart
Future<AuthResult<LoginResponse>> login({
  required String identity,
  required String password,
  String? countryCode,
  String? fcmToken,
}) async {
  try {
    // Build request body
    final body = <String, dynamic>{
      'passKey': password,  // ✅ Changed from 'password'
      'deviceId': DeviceInfo.deviceId,
      if (fcmToken != null) 'fcmToken': fcmToken,
    };

    // Detect identity type and add appropriate fields
    if (_isSocaLocaId(identity)) {
      body['sclId'] = identity;
      body['signType'] = 'sclId';  // ✅ Added signType
    } else if (_isEmail(identity)) {
      body['email'] = identity;
      body['signType'] = 'email';  // ✅ Added signType
    } else {
      // Mobile number
      body['mobile'] = identity;  // ✅ Changed from 'phone'
      body['signType'] = 'mobile';  // ✅ Added signType
      if (countryCode != null) {
        body['countryCode'] = countryCode;
      }
    }

    final data = await ApiClient.instance.post(
      ApiConstants.modSignIn,
      body: body,
    );
    // ... handle response
  }
}
```

---

## signType Values

| Input Type | signType Value | Description |
|------------|---------------|-------------|
| Phone Number | `"mobile"` | User enters phone number (digits only) |
| Email Address | `"email"` | User enters email with @ |
| SocaLoca ID | `"sclId"` | User enters SCL + numbers |

---

## Example Requests & Responses

### Example 1: Mobile Login (India)

**Request**:
```json
POST /modSignIn
{
  "mobile": "9830157659",
  "countryCode": "+91",
  "signType": "mobile",
  "passKey": "123456",
  "deviceId": "jwijr4afbc9086kf67sv2yikzsdi724e"
}
```

**Response** (Success):
```json
{
  "status": 1,
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "userData": {
    "id": "user123",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+919830157659",
    "userType": "player",
    "policyAccepted": true
  }
}
```

**Response** (Wrong Password):
```json
{
  "status": 2,
  "message": "Wrong password"
}
```

**Response** (Not Registered):
```json
{
  "status": 0,
  "message": "Account not registered"
}
```

### Example 2: Email Login

**Request**:
```json
POST /modSignIn
{
  "email": "john@example.com",
  "signType": "email",
  "passKey": "123456",
  "deviceId": "jwijr4afbc9086kf67sv2yikzsdi724e"
}
```

### Example 3: SocaLoca ID Login

**Request**:
```json
POST /modSignIn
{
  "sclId": "SCL123456",
  "signType": "sclId",
  "passKey": "123456",
  "deviceId": "jwijr4afbc9086kf67sv2yikzsdi724e"
}
```

---

## Validation Rules

### Mobile Number
- Must be digits only (no spaces, dashes, or country code)
- Minimum 7 digits
- Example: `9830157659` ✅
- Not: `+91 9830157659` ❌
- Not: `98-3015-7659` ❌

### Country Code
- Must include `+` prefix
- Example: `+91` ✅
- Not: `91` ❌

### Password (passKey)
- Minimum 6 characters
- Can contain letters, numbers, special characters

### signType
- Must be exactly: `"mobile"`, `"email"`, or `"sclId"`
- Case-sensitive

---

## Testing

### Test Case 1: Mobile Login
```bash
# Input
Mobile: 9830157659
Country: India (+91)
Password: 123456

# Expected Payload
{
  "mobile": "9830157659",
  "countryCode": "+91",
  "signType": "mobile",
  "passKey": "123456",
  "deviceId": "..."
}
```

### Test Case 2: Email Login
```bash
# Input
Email: test@example.com
Password: 123456

# Expected Payload
{
  "email": "test@example.com",
  "signType": "email",
  "passKey": "123456",
  "deviceId": "..."
}
```

### Test Case 3: SocaLoca ID Login
```bash
# Input
SocaLoca ID: SCL123456
Password: 123456

# Expected Payload
{
  "sclId": "SCL123456",
  "signType": "sclId",
  "passKey": "123456",
  "deviceId": "..."
}
```

---

## Comparison: Before vs After

### Mobile Login Payload

**Before** ❌:
```json
{
  "phone": "9830157659",
  "password": "123456",
  "deviceId": "..."
}
```

**After** ✅:
```json
{
  "mobile": "9830157659",
  "countryCode": "+91",
  "signType": "mobile",
  "passKey": "123456",
  "deviceId": "..."
}
```

### Email Login Payload

**Before** ❌:
```json
{
  "email": "test@example.com",
  "password": "123456",
  "deviceId": "..."
}
```

**After** ✅:
```json
{
  "email": "test@example.com",
  "signType": "email",
  "passKey": "123456",
  "deviceId": "..."
}
```

---

## Files Modified

- `lib/features/auth/data/auth_repository.dart`
  - Changed `password` → `passKey`
  - Changed `phone` → `mobile`
  - Added `signType` field for all login types

---

## Status

✅ **Field Names Corrected**  
✅ **signType Added**  
✅ **Payload Format Matches API**  
🚀 **Ready for Testing**

---

**Date**: May 5, 2026  
**Issue**: Wrong field names in API payload  
**Solution**: Updated to match actual API requirements  
**Status**: Fixed ✅
