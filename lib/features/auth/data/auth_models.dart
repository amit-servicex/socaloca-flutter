import '../../../core/constants/api_constants.dart';
import '../../../shared/models/user_model.dart';

/// Response from modSignIn
class LoginResponse {
  const LoginResponse({
    required this.status,
    this.message,
    this.token,
    this.user,
  });

  final int status;
  final String? message;
  final String? token;
  final UserModel? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as Map<String, dynamic>?;
    final userData = response?['userDetails'] as Map<String, dynamic>?;
    return LoginResponse(
      status: (response?['status'] as num?)?.toInt() ?? 0,
      message: response?['message'] as String?,
      token: response?['token'] as String?,
      user: userData != null ? _mapUserDetails(userData) : null,
    );
  }

  static UserModel _mapUserDetails(Map<String, dynamic> json) {
    final firstName = json['firstName'] as String? ?? '';
    final lastName = json['lastName'] as String? ?? '';
    final fullName = '$firstName $lastName'.trim();
    final imageUrl = json['imageUrl'] as String?;

    return UserModel(
      id: (json['_id'] ?? json['userId']) as String? ?? '',
      name: fullName.isNotEmpty
          ? fullName
          : (json['profileName'] as String? ?? ''),
      email: json['email'] as String?,
      username: json['profileName'] as String?,
      profileImage: ApiConstants.getImageUrl(imageUrl),
      phone: json['mobile'] as String?,
      country: json['country'] as String?,
      dob: json['dob'] as String?,
      userType: json['type'] as String?,
      isVerified: (json['verified'] as bool?) ?? false,
      policyAccepted: (json['acceptPolicy'] as bool?) ?? false,
      profile: (json['profile'] as bool?) ?? false,
      isPlayer: (json['isPlayer'] as bool?) ?? false,
      isCoach: (json['isCoach'] as bool?) ?? false,
      isAdmin: (json['isAdmin'] as bool?) ?? false,
      isFan: (json['isFan'] as bool?) ?? false,
      isReferee: (json['isReferee'] as bool?) ?? false,
      token: null,
    );
  }
}

/// Response from clubLogin
class ClubLoginResponse {
  const ClubLoginResponse({
    required this.status,
    this.message,
    this.token,
    this.clubUser,
    this.success,
    this.isChild,
    this.childDetails,
  });

  final int status;
  final String? message;
  final String? token;
  final ClubUserModel? clubUser;
  final bool? success;
  final bool? isChild;
  final Map<String, dynamic>? childDetails;

  factory ClubLoginResponse.fromJson(Map<String, dynamic> json) {
    // PostApiRequest.java unwraps the "response" wrapper before onFetchComplete —
    // Flutter receives the raw HTTP body: { "response": { "status", "details" } }
    final resp = json['response'] as Map<String, dynamic>? ?? json;
    var details = resp['details'] as Map<String, dynamic>?;
    if (details != null) {
      // Normalize fields that differ from the Dart model:
      // stadium comes as [] array — model expects String?
      // comps comes as [] array  — model field is competitions
      details = Map<String, dynamic>.from(details);
      if (details['stadium'] is List) details['stadium'] = null;
      if (details['comps'] is List) {
        details['competitions'] =
            (details['comps'] as List).map((e) => e.toString()).join(', ');
      }
    }
    return ClubLoginResponse(
      status: (resp['status'] as num?)?.toInt() ?? 0,
      message: resp['message'] as String?,
      token: resp['token'] as String?,
      clubUser: details != null ? ClubUserModel.fromJson(details) : null,
      success: resp['success'] as bool?,
      isChild: resp['isChild'] as bool?,
      childDetails: resp['childDetails'] as Map<String, dynamic>?,
    );
  }
}

/// Response from socialLogin
class SocialLoginResponse {
  const SocialLoginResponse({
    required this.status,
    this.message,
    this.token,
    this.user,
    this.isNewUser = false,
  });

  final int status;
  final String? message;
  final String? token;
  final UserModel? user;
  final bool isNewUser;

  factory SocialLoginResponse.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as Map<String, dynamic>?;
    final userData = response?['userDetails'] as Map<String, dynamic>?;
    return SocialLoginResponse(
      status: (response?['status'] as num?)?.toInt() ?? 0,
      message: response?['message'] as String?,
      token: response?['token'] as String?,
      user: userData != null ? LoginResponse._mapUserDetails(userData) : null,
      isNewUser: (response?['isNewUser'] as bool?) ?? false,
    );
  }
}

/// Response from modSignUp
class SignUpResponse {
  const SignUpResponse({
    required this.status,
    this.message,
    this.token,
    this.user,
  });

  final int status;
  final String? message;
  final String? token;
  final UserModel? user;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as Map<String, dynamic>?;
    final userData = response?['userDetails'] as Map<String, dynamic>?;
    return SignUpResponse(
      status: (response?['status'] as num?)?.toInt() ?? 0,
      message: response?['message'] as String?,
      token: response?['token'] as String?,
      user: userData != null ? LoginResponse._mapUserDetails(userData) : null,
    );
  }
}

/// Response from verifyOtp
class OtpResponse {
  const OtpResponse({required this.status, this.message});
  final int status;
  final String? message;

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    final response = json['response'] as Map<String, dynamic>?;
    return OtpResponse(
      status: (response?['status'] as num?)?.toInt() ?? 0,
      message: response?['message'] as String?,
    );
  }
}

/// Response from preRegister (parental consent for youth/child)
class PreRegisterResponse {
  const PreRegisterResponse({
    required this.status,
    this.message,
    this.success,
    this.consentId,
    this.ageGroup,
  });

  final int status;
  final String? message;
  final bool? success;
  final String? consentId;
  final String? ageGroup;

  factory PreRegisterResponse.fromJson(Map<String, dynamic> json) {
    return PreRegisterResponse(
      status: (json['status'] as num?)?.toInt() ?? 0,
      message: json['message'] as String?,
      success: json['success'] as bool?,
      consentId: json['consentId'] as String?,
      ageGroup: json['ageGroup'] as String?,
    );
  }
}

/// Minimal success/failure wrapper — used instead of a full Either type
/// since the project does not depend on dartz/fpdart.
sealed class AuthResult<T> {
  const AuthResult();
}

final class AuthSuccess<T> extends AuthResult<T> {
  const AuthSuccess(this.data);
  final T data;
}

final class AuthFailure<T> extends AuthResult<T> {
  const AuthFailure(this.error);
  final String error;
}
