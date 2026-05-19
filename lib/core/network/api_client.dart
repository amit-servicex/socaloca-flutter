import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_constants.dart';
import '../storage/storage_service.dart';
import 'api_exception.dart';

/// Dio-based API client. All SocaLoca calls are POST with JSON body.
class ApiClient {
  ApiClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

    // Add auth interceptor first
    _dio.interceptors.add(_authInterceptor());

    // Add logger in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: false,
          maxWidth: 90,
        ),
      );
    }
  }

  static final ApiClient instance = ApiClient._();
  late final Dio _dio;

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = StorageService.authToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // Token expired — trigger logout
          StorageService.clearUserSession();
        }
        handler.next(error);
      },
    );
  }

  /// Main POST method — wraps all API calls.
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      // Log request in debug mode
      if (kDebugMode) {
        developer.log(
          '🌐 API Request: $endpoint',
          name: 'ApiClient',
        );
        developer.log(
          '📤 Request Body: ${body ?? {}}',
          name: 'ApiClient',
        );
      }

      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: body ?? {},
      );

      final data = response.data;

      // Log response in debug mode
      if (kDebugMode) {
        developer.log(
          '✅ API Response: $endpoint',
          name: 'ApiClient',
        );
        developer.log(
          '📥 Response Data: ${jsonEncode(data)}',
          name: 'ApiClient',
        );
      }

      if (data == null) {
        throw ApiException(message: 'Empty response from $endpoint');
      }

      return data;
    } on DioException catch (e) {
      // Log error in debug mode
      if (kDebugMode) {
        developer.log(
          '❌ API Error: $endpoint',
          name: 'ApiClient',
          error: e.message,
        );
      }
      throw ApiException.fromDioException(e);
    }
  }

  /// GET request — no body, no params (matches Android GetApiRequest).
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      if (kDebugMode) {
        developer.log('🌐 GET: $endpoint', name: 'ApiClient');
      }
      final response = await _dio.get<Map<String, dynamic>>(endpoint);
      final data = response.data;
      if (data == null) {
        throw ApiException(message: 'Empty response from $endpoint');
      }
      return data;
    } on DioException catch (e) {
      if (kDebugMode) {
        developer.log('❌ GET Error: $endpoint',
            name: 'ApiClient', error: e.message);
      }
      throw ApiException.fromDioException(e);
    }
  }

  /// Multipart file upload (images, videos).
  /// Matches Android: no Authorization header, no explicit Content-Type override
  /// (Dio sets multipart/form-data; boundary=... automatically for FormData).
  Future<Map<String, dynamic>> uploadFile(
    String endpoint, {
    required FormData formData,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: formData,
        options: Options(
          headers: {'Authorization': null},
          receiveTimeout: const Duration(minutes: 2),
          sendTimeout: const Duration(minutes: 5),
        ),
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
