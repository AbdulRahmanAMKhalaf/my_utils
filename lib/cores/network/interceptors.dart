import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core_utils/cores/constants/index.dart';

Interceptor buildConnectivityInterceptor({Connectivity? connectivity}) {
  return InterceptorsWrapper(
    onRequest: (options, handler) async {
      final status = await connectivity!.checkConnectivity();
      if (status == ConnectivityResult.none) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            message: 'No internet connection',
          ),
        );
      }
      return handler.next(options);
    },
  );
}

// 🔐 2. Inject token
Interceptor buildAuthInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) async {
      // final token = await customSecureStorage.read('token');
      // if (token?.isNotEmpty == true) {
      //   options.headers['Authorization'] = 'Bearer $token';
      // }
      return handler.next(options);
    },
  );
}

// 📝 3. Structured logging
Interceptor buildLoggingInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (kDebugMode) {
        log('➡️ [${options.method.toUpperCase()}] ${options.path}');
        if (options.data != null) log('📦 BODY: ${options.data}');
        if (options.queryParameters.isNotEmpty) {
          log('🔍 QUERY: ${options.queryParameters}');
        }
      }
      return handler.next(options);
    },
    onResponse: (response, handler) {
      if (kDebugMode) {
        log('✅ [${response.statusCode}] ${response.requestOptions.path}');
        log('📦 DATA: ${_truncate(response.data)}');
      }
      return handler.next(response);
    },
    onError: (error, handler) {
      if (kDebugMode) {
        log(
          '❌ [${error.response?.statusCode ?? '??'}] ${error.requestOptions.path}',
        );
        log('💬 ${error.message}');
        if (error.response?.data != null) {
          log('📦 ERROR DATA: ${_truncate(error.response?.data)}');
        }
      }
      return handler.next(error);
    },
  );
}

// ❌ 4. Error mapping — DO NOT THROW, use handler.reject()
Interceptor buildErrorInterceptor() {
  return InterceptorsWrapper(
    onError: (DioException e, handler) {
      Failure failure;
      switch (e.response?.statusCode) {
        case 400:
          failure = APIFailure(
            e.response?.data?['message'] ?? e.message ?? 'Bad Request',
          );
          break;
        case 401:
          failure = UnauthorizedFailure(
            e.response?.data?['message'] ?? e.message ?? 'Unauthorized',
          );
          break;
        case 403:
          failure = APIFailure(
            e.response?.data?['message'] ?? e.message ?? 'Forbidden',
          );
          break;
        case 404:
          failure = APIFailure(
            e.response?.data?['message'] ?? e.message ?? 'Not Found',
          );
          break;
        case 500:
          failure = ServerFailure(
            e.response?.data?['message'] ??
                e.message ??
                'Internal Server Error',
          );
          break;
        default:
          failure = ServerFailure(
            e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
          );
      }

      // ✅ Use reject() — preserves error flow and allows retry logic later
      return handler.reject(
        DioException(
          requestOptions: e.requestOptions,
          response: e.response,
          type: e.type, // or use appropriate type
          message: failure.message, // optional: include message
        ),
      );
    },
  );
}

// 🧩 Helper: Avoid huge logs
String _truncate(dynamic data, [int max = 300]) {
  final str = data.toString();
  return str.length > max ? '${str.substring(0, max)}... (truncated)' : str;
}

// 🎯 Optional: Expose for screen-level cancellation
CancelToken newCancelToken() => CancelToken();
