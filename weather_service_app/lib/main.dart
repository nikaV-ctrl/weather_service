import 'package:flutter/material.dart';
import 'package:weather_service_app/features/home/pages/home_screen.dart';
import 'package:weather_service_app/resources/app_colors.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}