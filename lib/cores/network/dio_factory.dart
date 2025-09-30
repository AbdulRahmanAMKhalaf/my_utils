import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:my_utils/cores/constants/index.dart';

class CustomDio {
  final SecureStorage customSecureStorage;
  final String baseUrl;
  final Connectivity? connectivity; // Optional: for offline handling

  // ✅ Better: Inject config instead of hardcoding
  CustomDio({
    required this.customSecureStorage,
    this.connectivity,
    String? baseUrl,
  }) : baseUrl = baseUrl ?? ApiEndpoints.baseUrl;

  Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      if (connectivity != null)
        buildConnectivityInterceptor(connectivity: connectivity),
      buildAuthInterceptor(),
      if (kDebugMode) buildLoggingInterceptor(),
      buildErrorInterceptor(),
    ]);

    log('✅ Dio initialized successfully with base URL: $baseUrl');
    return dio;
  }
}
