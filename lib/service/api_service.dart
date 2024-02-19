import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio = Dio();
  String? _bearerToken;

  ApiService() {
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add 'Content-Type': 'application/json' header
          options.headers['Content-Type'] = 'application/json';

          // Add bearer token if available
          if (_bearerToken != null) {
            options.headers['Authorization'] = 'Bearer $_bearerToken';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("DioError: $e");

          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            debugPrint("Timeout Error");
          } else if (e.type == DioExceptionType.cancel) {
            debugPrint("Request Cancelled");
          } else {
            debugPrint("Other Error");
          }
          return handler.next(e);
        },
      ),
    );
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 150,
    ));
  }

  // Call this method after the user logs in to set the bearer token
  void setBearerToken(String token) {
    _bearerToken = token;
  }

  Future<Response> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      throw Exception("Failed to get data");
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: json.encode(data));
      return response;
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<Response> postMultipartData(
      String endpoint, Map<String, dynamic> data, Map<String, String> filesMap) async {
    try {
      FormData formData = FormData.fromMap(data);
      for (var entry in filesMap.entries) {
        String key = entry.key;
        String filePath = entry.value;
        formData.files.add(MapEntry(key, await MultipartFile.fromFile(filePath, filename: key)));
      }

      final response = await _dio.post(endpoint, data: formData);
      return response;
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}
