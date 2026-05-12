import 'dart:developer';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/utils/device_info.dart';
import '../data/auth_models.dart';

/// All authentication API calls.
/// Every method returns AuthResult<T> — callers pattern-match on
/// AuthSuccess / AuthFailure rather than catching exceptions.
class AuthRepository {
  const AuthRepository();

  // ─── modSignIn ────────────────────────────────────────────────────────────

  Future<AuthResult<LoginResponse>> login({
    required String identity,
    required String password,
    String? countryCode,
    String? fcmToken,
  }) async {
    try {
      // Build request body based on identity type
      final body = <String, dynamic>{
        'passKey': password, // Changed from 'password' to 'passKey'
        'deviceId': DeviceInfo.deviceId,
        if (fcmToken != null) 'fcmToken': fcmToken,
      };

      // Detect identity type and add appropriate field + signType
      if (_isSocaLocaId(identity)) {
        body['sclId'] = identity;
        body['signType'] = 'sclId';
      } else if (_isEmail(identity)) {
        body['email'] = identity;
        body['signType'] = 'email';
      } else {
        // Mobile number
        body['mobile'] = identity; // Changed from 'phone' to 'mobile'
        body['signType'] = 'mobile';
        if (countryCode != null) {
          body['countryCode'] = countryCode;
        }
      }

      final data = await ApiClient.instance.post(
        ApiConstants.modSignIn,
        body: body,
      );
      final response = LoginResponse.fromJson(data);
      log("Login response: ${response.status} - ${response.message}");
      if (response.status.toString() != "1") {
        return AuthFailure(response.message ?? 'Login failed');
      }
      return AuthSuccess(response);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── accUserPolicy ────────────────────────────────────────────────────────

  Future<AuthResult<bool>> acceptUserPolicy({
    required String userId,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.accUserPolicy,
        body: {'userId': userId},
      );
      final status = (data['status'] as num?)?.toInt() ?? 0;
      if (status != 1) {
        return AuthFailure(
          (data['message'] as String?) ?? 'Failed to accept policy',
        );
      }
      return const AuthSuccess(true);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── Helper methods ───────────────────────────────────────────────────────

  bool _isEmail(String input) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(input);
  }

  bool _isSocaLocaId(String input) {
    // SocaLoca ID format: starts with 'SCL' or 'scl' followed by numbers
    return RegExp(r'^[Ss][Cc][Ll]\d+$').hasMatch(input);
  }

  // ─── clubLogin ────────────────────────────────────────────────────────────

  Future<AuthResult<ClubLoginResponse>> clubLogin({
    required String email,
    required String password,
    String? fcmToken,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.clubLogin,
        body: {
          'email': email,
          'password': password,
          'deviceId': DeviceInfo.deviceId,
          if (fcmToken != null) 'fcmToken': fcmToken,
        },
      );
      final response = ClubLoginResponse.fromJson(data);
      if (response.status != 1) {
        return AuthFailure(response.message ?? 'Club login failed');
      }
      return AuthSuccess(response);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── socialLogin ─────────────────────────────────────────────────────────

  Future<AuthResult<SocialLoginResponse>> socialLogin({
    required String socialId,
    required String email,
    required String name,
    required String profilePic,
    required String loginType, // 'google' | 'facebook'
    String? fcmToken,
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.socialLogin,
        body: {
          'socialId': socialId,
          'email': email,
          'name': name,
          'profilePic': profilePic,
          'loginType': loginType,
          'deviceId': DeviceInfo.deviceId,
          if (fcmToken != null) 'fcmToken': fcmToken,
        },
      );
      final response = SocialLoginResponse.fromJson(data);
      if (response.status != 1) {
        return AuthFailure(response.message ?? 'Social login failed');
      }
      return AuthSuccess(response);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── modSignUp ────────────────────────────────────────────────────────────
  // Matches Android NewSignUpFragment API format exactly

  Future<AuthResult<SignUpResponse>> signUp({
    required String emailOrMobile,
    required String password,
    required String signType, // 'mobile' or 'email'
    String? countryCode, // Required if signType='mobile'
    String? countryIso, // Required if signType='mobile'
    String? ageGroup, // 'adult', 'youth', 'child'
    String? consentId,
    String? deviceModel,
  }) async {
    try {
      final body = <String, dynamic>{
        'deviceType': 'android',
        'deviceId': DeviceInfo.deviceId,
        'deviceModel': deviceModel ?? 'Unknown',
        'signType': signType,
        'passKey': password, // Android uses 'passKey' not 'password'
        if (ageGroup != null) 'ageGroup': ageGroup,
        if (consentId != null) 'consentId': consentId,
      };

      // Add mobile or email based on signType
      if (signType == 'mobile') {
        body['mobile'] = emailOrMobile;
        body['countryCode'] = countryCode ?? '+44';
        if (countryIso != null) body['countryIso'] = countryIso;
      } else {
        body['email'] = emailOrMobile;
      }

      final data = await ApiClient.instance.post(
        ApiConstants.modSignUp,
        body: body,
      );

      final response = SignUpResponse.fromJson(data);
      log("   SignUp response: ${response.status} - ${response.message}");
      if (response.status != 1) {
        return AuthFailure(response.message ?? 'Registration failed');
      }
      return AuthSuccess(response);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── verifyOtp ────────────────────────────────────────────────────────────

  Future<AuthResult<OtpResponse>> verifyOtp({
    required String otp,
    required String userId,
    required String type, // 'phone' | 'email'
  }) async {
    try {
      final data = await ApiClient.instance.post(
        ApiConstants.verifyOtp,
        body: {'otp': otp, 'userId': userId, 'type': type},
      );
      final response = OtpResponse.fromJson(data);
      if (response.status != 1) {
        return AuthFailure(response.message ?? 'OTP verification failed');
      }
      return AuthSuccess(response);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── Forgot password — dual path ─────────────────────────────────────────

  /// [isClubPath] = false → forgetAllPass (user path)
  /// [isClubPath] = true  → forgetPass (club path)
  Future<AuthResult<bool>> forgotPassword({
    required String email,
    required bool isClubPath,
  }) async {
    try {
      final endpoint =
          isClubPath ? ApiConstants.forgetPass : ApiConstants.forgetAllPass;
      final data = await ApiClient.instance.post(
        endpoint,
        body: {'email': email},
      );
      final status = (data['status'] as num?)?.toInt() ?? 0;
      if (status != 1) {
        return AuthFailure(
          (data['message'] as String?) ?? 'Failed to send reset link',
        );
      }
      return const AuthSuccess(true);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── Reset password — dual path ───────────────────────────────────────────

  /// [isClubPath] = false → resetAllPass (user path)
  /// [isClubPath] = true  → resetPass (club path)
  Future<AuthResult<bool>> resetPassword({
    required String token,
    required String password,
    required bool isClubPath,
  }) async {
    try {
      final endpoint =
          isClubPath ? ApiConstants.resetPass : ApiConstants.resetAllPass;
      final data = await ApiClient.instance.post(
        endpoint,
        body: {'token': token, 'password': password},
      );
      final status = (data['status'] as num?)?.toInt() ?? 0;
      if (status != 1) {
        return AuthFailure(
          (data['message'] as String?) ?? 'Password reset failed',
        );
      }
      return const AuthSuccess(true);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── preRegister ──────────────────────────────────────────────────────────
  // Collects parental consent for youth (13-15) and child (7-12) age groups

  Future<AuthResult<PreRegisterResponse>> preRegister({
    String? minorName, // Required for child age group
    required String parentName,
    required String parentEmail,
    String? parentPhone, // Required for youth age group
    required String ageGroup, // 'youth' or 'child'
  }) async {
    try {
      final body = <String, dynamic>{
        'parentName': parentName,
        'parentMail': parentEmail,
        'ageGroup': ageGroup,
      };

      if (minorName != null) {
        body['minorName'] = minorName;
      }

      if (parentPhone != null) {
        body['parentPhone'] = parentPhone;
      }

      final data = await ApiClient.instance.post(
        ApiConstants.preRegister,
        body: body,
      );

      final response = PreRegisterResponse.fromJson(
          data['response'] as Map<String, dynamic>);
      log("this is the reposen of the pre-register ${response.status} and the message is ${response.status}");
      if (response.status != 1 || response.success != true) {
        return AuthFailure(response.message ?? 'Pre-registration failed');
      }
      return AuthSuccess(response);
    } on ApiException catch (e) {
      return AuthFailure(e.message);
    }
  }

  // ─── editCommonProfile ────────────────────────────────────────────────────
  // Edit existing user profile — mirrors Android CommonProfileEditNewFragment

  Future<bool> editCommonProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String profileName,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
    required String dob,
    required String country,
    required String gender,
    String aboutMe = '',
    String imageUrl = '',
    String playPosition = '',
    String playPositionType = '',
    String playLevel = '',
    String preferredFoot = 'right',
    String preferredJersey = '',
    int height = 0,
    String jerseySize = '',
    String shoeSize = '',
    String shoeSizeUnit = '',
    String nationality = '',
    String nationalityIso = '',
    String leagueFollow = '',
    String teamFollow = '',
    List<String> brands = const [],
    String userLoc = '',
    double userLat = 0.0,
    double userLng = 0.0,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'profileName': profileName,
        'isPlayer': isPlayer,
        'isCoach': isCoach,
        'isAdmin': isAdmin,
        'isFan': isFan,
        'dob': dob,
        'country': country,
        'gender': gender,
        'aboutMe': aboutMe,
        'imageUrl': imageUrl,
        'leagueFollow': leagueFollow,
        'teamFollow': teamFollow,
        'brands': brands,
        'userLoc': userLoc,
        'userLat': userLat,
        'userLng': userLng,
        'lastUpdateDeviceType': 'flutter',
      };

      if (isPlayer) {
        body['playPosition'] = playPosition;
        body['playPositionType'] = playPositionType;
        body['playLevel'] = playLevel;
        body['preferredFoot'] = preferredFoot;
        body['preferredJersey'] = preferredJersey;
        body['height'] = height;
        body['jerseySize'] = jerseySize;
        body['shoeSize'] = shoeSize;
        body['shoeSizeUnit'] = shoeSizeUnit;
        body['nationality'] = nationality;
        body['nationalityIso'] = nationalityIso;
      }

      if (isCoach || isAdmin) {
        body['jerseySize'] = jerseySize;
        body['shoeSize'] = shoeSize;
        body['shoeSizeUnit'] = shoeSizeUnit;
        body['preferredJersey'] = preferredJersey;
        body['nationality'] = nationality;
        body['nationalityIso'] = nationalityIso;
      }

      final data = await ApiClient.instance.post(
        ApiConstants.editCommonProfile,
        body: body,
      );

      final status = (data['response']['status'] as num?)?.toInt() ?? 0;
      return status == 1;
    } on ApiException catch (e) {
      log('❌ Edit profile error: ${e.message}');
      return false;
    }
  }

  // ─── createUserProfile ────────────────────────────────────────────────────
  // Complete user profile creation after signup
  // Matches Android CreateProfileFragment.saveProfile() exactly

  Future<bool> createUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String profileName,
    required bool isPlayer,
    required bool isCoach,
    required bool isAdmin,
    required bool isFan,
    required bool isReferee,
    required String dob,
    required String country,
    required String gender,
    String aboutMe = '',
    String imageUrl = '',
    String playPosition = '',
    String playPositionType = '',
    String playLevel = '',
    String preferredFoot = 'right',
    String preferredJersey = '',
    int height = 0,
    String jerseySize = '',
    String shoeSize = '',
    String shoeSizeUnit = '',
    String nationality = '',
    String nationalityIso = '',
    String leagueFollow = '',
    String teamFollow = '',
    List<String> brands = const [],
    String userLoc = '',
    double userLat = 0.0,
    double userLng = 0.0,
    String? referCode,
    String? consentId,
    bool isParentalConsent = false,
    String? parentPin,
    int parentComment = 0,
    int parentLikeFollow = 0,
    int parentPhotoVideo = 0,
    String? referByUserId,
    String? fa,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'profileName': profileName,
        'isPlayer': isPlayer,
        'isCoach': isCoach,
        'isAdmin': isAdmin,
        'isFan': isFan,
        'isReferee': isReferee,
        'dob': dob,
        'country': country,
        'gender': gender,
        'aboutMe': aboutMe,
        'imageUrl': imageUrl,
        'leagueFollow': leagueFollow,
        'teamFollow': teamFollow,
        'brands': brands,
        'userLoc': userLoc,
        'userLat': userLat,
        'userLng': userLng,
      };

      // Add player/referee specific fields
      if (isPlayer || isReferee) {
        body['playPosition'] = playPosition;
        body['playPositionType'] = playPositionType;
        body['playLevel'] = playLevel;
        body['preferredFoot'] = preferredFoot;
        body['preferredJersey'] = preferredJersey;
        body['height'] = height;
        body['jerseySize'] = jerseySize;
        body['shoeSize'] = shoeSize;
        body['shoeSizeUnit'] = shoeSizeUnit;
        body['nationality'] = nationality;
        body['nationalityIso'] = nationalityIso;
      }

      // Add coach/manager/referee specific fields
      if (isCoach || isAdmin || isReferee) {
        body['jerseySize'] = jerseySize;
        body['shoeSize'] = shoeSize;
        body['shoeSizeUnit'] = shoeSizeUnit;
        body['preferredJersey'] = preferredJersey;
        body['nationality'] = nationality;
        body['nationalityIso'] = nationalityIso;
      }

      // Add optional fields
      if (referCode != null) {
        body['referCode'] = referCode;
      } else {
        body['referCode'] = null;
      }

      if (consentId != null) {
        body['consentId'] = consentId;
      }

      body['isParentalConsent'] = isParentalConsent;

      if (parentPin != null) {
        body['parentPin'] = parentPin;
      }

      body['parentComment'] = parentComment;
      body['parentLikeFollow'] = parentLikeFollow;
      body['parentPhotoVideo'] = parentPhotoVideo;

      if (referByUserId != null) {
        body['referByUserId'] = referByUserId;
      }

      if (fa != null) {
        body['fa'] = fa;
      }

      final data = await ApiClient.instance.post(
        ApiConstants.createUserProfile,
        body: body,
      );

      final status = (data['response']['status'] as num?)?.toInt() ?? 0;
      log("this is thhe statis of the create profie ${status}");
      if (status == 1) {
        log('✅ Profile created successfully');
        return true;
      } else {
        log('❌ Profile creation failed: ${data['message']}');
        return false;
      }
    } on ApiException catch (e) {
      log('❌ Profile creation error: ${e.message}');
      return false;
    }
  }
}
