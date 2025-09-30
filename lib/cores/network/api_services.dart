import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;

  ApiServices(this.dio);

  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    return await dio.get(
      endpoint,
      queryParameters: query,
      cancelToken: cancelToken,
    );
  }

  Future<Response> postRequest(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await dio.post(endpoint, data: data, cancelToken: cancelToken);
  }

  Future<Response> putRequest(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await dio.put(endpoint, data: data, cancelToken: cancelToken);
  }

  Future<Response> deleteRequest(
    String endpoint, {
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    return await dio.delete(endpoint, data: data, cancelToken: cancelToken);
  }
}
