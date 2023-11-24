import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_service_app/features/home/model/weather_response.dart';

Future<void> setWeatherToStorage(WeatherResponse weatherResponse) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('city', weatherResponse.name ?? '');
  await prefs.setString('weather', weatherResponse.weather?.first.main ?? '');
  await prefs.setDouble('temperature', weatherResponse.main?.temp ?? 0);
  await prefs.setString(
      'description', weatherResponse.weather?.first.description ?? '');
  await prefs.setDouble('feelsLike', weatherResponse.main?.feelsLike ?? 0);
  await prefs.setDouble('windSpeed', weatherResponse.wind?.gust ?? 0);
  await prefs.setInt('humidity', weatherResponse.main?.humidity ?? 0);
  await prefs.setInt('pressure', weatherResponse.main?.pressure ?? 0);
  await prefs.setInt('sunrise', weatherResponse.sys?.sunrise ?? 0);
  await prefs.setInt('sunset', weatherResponse.sys?.sunset ?? 0);
}
