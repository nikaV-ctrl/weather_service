import 'package:dio/dio.dart';
import 'package:weather_service_app/network/dio_client.dart';
import 'package:weather_service_app/network/dio_endpoints.dart';

class WeatherApi {
  DioClient dioClient = DioClient(Dio());

  Future<Map<String, dynamic>> getWeatherApi(String city) async {
    try {
      final response =
          await dioClient.get('data/2.5/weather?', queryParameters: {
        'q': city,
        'lang': DioEndpoints.lang,
        'appid': DioEndpoints.apiKey,
        'units': DioEndpoints.units,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
