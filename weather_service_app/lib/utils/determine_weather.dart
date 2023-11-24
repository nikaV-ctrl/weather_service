import 'package:weather_service_app/resources/app_svg_images.dart';

String determineWeather(String weather) {
  late String weatherIcon;

  switch (weather){
    case 'Snow':
     weatherIcon = AppSvgImages.snow;
     break;
    case 'Clouds':
     weatherIcon = AppSvgImages.clouds;
     break;
    case 'Haze':
     weatherIcon = AppSvgImages.haze;
     break;
    case 'Clear':
     weatherIcon = AppSvgImages.clear;
     break;
    case 'Smoke':
     weatherIcon = AppSvgImages.smoke;
     break;
    case 'Rain':
     weatherIcon = AppSvgImages.rain;
     break;
  }
  
  return weatherIcon;
}