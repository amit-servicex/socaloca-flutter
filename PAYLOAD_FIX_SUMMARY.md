# API Payload Fix - Quick Summary

## ✅ Issues Fixed

### Issue 1: Wrong Field Names
- ❌ Was using: `password`, `phone`
- ✅ Now using: `passKey`, `mobile`

### Issue 2: Missing signType
- ❌ Was missing: `signType` field
- ✅ Now includes: `signType` with correct value

---

## Changes Made

### Mobile Login Payload

**Before** ❌:
```json
{
  "phone": "9830157659",
  "countryCode": "+1",
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
  "email": "user@example.com",
  "password": "123456",
  "deviceId": "..."
}
```

**After** ✅:
```json
{
  "email": "user@example.com",
  "signType": "email",
  "passKey": "123456",
  "deviceId": "..."
}
```

### SocaLoca ID Login Payload

**Before** ❌:
```json
{
  "sclId": "SCL123456",
  "password": "123456",
  "deviceId": "..."
}
```

**After** ✅:
```json
{
  "sclId": "SCL123456",
  "signType": "sclId",
  "passKey": "123456",
  "deviceId": "..."
}
```

---

## Code Changes

### File: `lib/features/auth/data/auth_repository.dart`

```dart
// ✅ Changed field names
final body = <String, dynamic>{
  'passKey': password,  // Changed from 'password'
  'deviceId': DeviceInfo.deviceId,
};

// ✅ Added signType for each login type
if (_isSocaLocaId(identity)) {
  body['sclId'] = identity;
  body['signType'] = 'sclId';  // Added
} else if (_isEmail(identity)) {
  body['email'] = identity;
  body['signType'] = 'email';  // Added
} else {
  body['mobile'] = identity;  // Changed from 'phone'
  body['signType'] = 'mobile';  // Added
  if (countryCode != null) {
    body['countryCode'] = countryCode;
  }
}
```

---

## Field Reference

| Old Field | New Field | Required For |
|-----------|-----------|--------------|
| `password` | `passKey` | All logins |
| `phone` | `mobile` | Mobile login |
| N/A | `signType` | All logins |

---

## signType Values

| Login Type | signType Value |
|------------|---------------|
| Mobile | `"mobile"` |
| Email | `"email"` |
| SocaLoca ID | `"sclId"` |

---

## Testing Checklist

- [ ] Mobile login sends `mobile`, `countryCode`, `signType: "mobile"`, `passKey`
- [ ] Email login sends `email`, `signType: "email"`, `passKey`
- [ ] SocaLoca ID login sends `sclId`, `signType: "sclId"`, `passKey`
- [ ] Country code is dynamic (not hardcoded to +1)
- [ ] All payloads include `deviceId`

---

## Status

✅ **All Field Names Corrected**  
✅ **signType Added for All Login Types**  
✅ **Country Code Dynamic**  
✅ **Payload Matches API Requirements**  
🚀 **Ready for Testing**

---

**Date**: May 5, 2026  
**Priority**: Critical (Login broken without correct fields)  
**Status**: Fixed ✅
