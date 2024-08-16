import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._singleton();

  static final APIService instance = APIService._singleton();

  String get baseUrl {
    if (kDebugMode) {
      return 'https://api.escuelajs.co';
    }
    return 'https://api.escuelajs.co';
  }

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    dynamic data, // Accept either param or formData
    Map<String, String>? headers,
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: contentType ?? Headers.formUrlEncodedContentType,
          headers: {
            if (headers != null) ...headers,
          },
        ),
      );

      switch (method) {
        case DioMethod.post:
          return dio.post(
            endpoint,
            data: data ?? param,
          );
        case DioMethod.get:
          return dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          return dio.put(
            endpoint,
            data: data ?? param,
          );
        case DioMethod.delete:
          return dio.delete(
            endpoint,
            data: data ?? param,
          );
        default:
          return dio.post(
            endpoint,
            data: data ?? param,
          );
      }
    } catch (e) {
      throw Exception('Network error');
    }
  }
}
