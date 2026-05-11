import '../network/api_exception.dart';

/// Converts any exception into a user-friendly error message.
class ErrorHandler {
  ErrorHandler._();

  static String getMessage(Object error) {
    if (error is ApiException) return error.message;
    return error.toString().replaceAll('Exception: ', '');
  }
}
