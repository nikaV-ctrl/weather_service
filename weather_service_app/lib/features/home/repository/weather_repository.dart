// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:weather_service_app/features/home/api/weather_api.dart';
import 'package:weather_service_app/features/home/model/weather_response.dart';
import 'package:weather_service_app/network/api_result.dart';
import 'package:weather_service_app/network/network_exceptions.dart';

class WeatherRepository {
  late WeatherApi weatherApi;

  WeatherRepository() {
    weatherApi = WeatherApi();
  }

  Future<Result<WeatherResponse>> getWeatherForCity({
    required String city,
  }) async {
    try {
      final response = await weatherApi.getWeatherApi(city);
      final responseData = WeatherResponse.fromJson(response);
      return Result.success(responseData);
    } on DioError catch (e) {
      return Result.failure(NetworkExceptions.getDioException(e));
    }
  }
}
