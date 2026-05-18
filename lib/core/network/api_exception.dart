import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.errorCode,
  });

  final String message;
  final int? statusCode;
  final String? errorCode;

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timed out. Please check your internet.',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final data = e.response?.data;
        String msg = 'Server error ($statusCode)';
        if (data is Map) {
          msg = (data['message'] as String?) ?? (data['msg'] as String?) ?? msg;
        }
        return ApiException(message: msg, statusCode: statusCode);
      case DioExceptionType.cancel:
        return const ApiException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'No internet connection. Please try again.',
        );
      default:
        return ApiException(
          message: e.message ?? 'An unexpected error occurred',
        );
    }
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
