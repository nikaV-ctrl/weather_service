import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_service_app/features/home/model/weather_response.dart';

Future<WeatherResponse> getWeatherFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  late WeatherResponse weatherResponse;
  
  if (prefs.getString('city') != null) {
    weatherResponse = WeatherResponse(
        name: prefs.getString('city'),
        weather: [
          Weather(
              main: prefs.getString('weather'),
              description: prefs.getString('description'))
        ],
        main: Main(
          feelsLike: prefs.getDouble('feelsLike'),
          temp: prefs.getDouble('temperature'),
          pressure: prefs.getInt('pressure'),
          humidity: prefs.getInt('humidity'),
        ),
        wind: Wind(gust: prefs.getDouble('windSpeed')),
        sys: Sys(
            sunrise: prefs.getInt('sunrise'), sunset: prefs.getInt('sunset')));
  } else {
    weatherResponse = WeatherResponse();
  }

  return weatherResponse;
}
