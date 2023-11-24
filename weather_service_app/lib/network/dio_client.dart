import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_service_app/network/dio_endpoints.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = DioEndpoints.baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: DioEndpoints.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: DioEndpoints.receiveTimeout)
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Не удается обработать данные');
    } catch (e) {
      rethrow;
    }
  }
}
