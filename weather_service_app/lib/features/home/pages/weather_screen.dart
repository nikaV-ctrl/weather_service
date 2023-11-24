import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_service_app/features/home/model/weather_response.dart';
import 'package:weather_service_app/features/home/pages/home_screen.dart';
import 'package:weather_service_app/features/home/widgets/weather_values_cards.dart';
import 'package:weather_service_app/resources/app_colors.dart';
import 'package:weather_service_app/resources/app_svg_images.dart';
import 'package:weather_service_app/utils/determine_weather.dart';
import 'package:weather_service_app/utils/format_timestamp_date.dart';
import 'package:weather_service_app/utils/timestamp_to_time.dart';
import 'package:weather_service_app/widgets/column_space.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherResponse weatherResponse;
  const WeatherScreen({super.key, required this.weatherResponse});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          title: Text(formatTimestampDate()),
          actions: [
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const HomeScreen())));
              },
              child: SvgPicture.asset(
                AppSvgImages.location,
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Chip(
                      label: Text('${weatherResponse.name ?? 0}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.brown)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                const ColumnSpace(10),
                SvgPicture.asset(
                  determineWeather(weatherResponse.weather?.first.main ?? ''),
                  width: 150,
                  height: 150,
                ),
                const ColumnSpace(20),
                Text('${weatherResponse.main?.temp ?? 0} °C',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: AppColors.brown)),
                Text('${weatherResponse.weather?.first.description ?? 0}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white)),
                const ColumnSpace(20),
                WeatherValues(weatherResponse: weatherResponse),
                SunRiseAndSet(weatherResponse: weatherResponse),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherValues extends StatelessWidget {
  final WeatherResponse weatherResponse;
  const WeatherValues({super.key, required this.weatherResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherValuesCards(
          img: AppSvgImages.temperature,
          title: 'Ощущается как',
          value: '${weatherResponse.main?.feelsLike ?? 0} °C',
        ),
        const ColumnSpace(10),
        WeatherValuesCards(
          img: AppSvgImages.wind,
          title: 'Скорость ветра',
          value: '${weatherResponse.wind?.gust ?? 0} м/c',
        ),
        const ColumnSpace(10),
        WeatherValuesCards(
          img: AppSvgImages.humidity,
          title: 'Влажность',
          value: '${weatherResponse.main?.humidity ?? 0}%',
        ),
        const ColumnSpace(10),
        WeatherValuesCards(
          img: AppSvgImages.pressure,
          title: 'Атмосферное \nдавление',
          value: '${weatherResponse.main?.pressure ?? 0} мм рт.ст.',
        ),
        const ColumnSpace(20),
      ],
    );
  }
}

class SunRiseAndSet extends StatelessWidget {
  final WeatherResponse weatherResponse;
  const SunRiseAndSet({super.key, required this.weatherResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Восход',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(formatTimestampToTime(weatherResponse.sys?.sunrise ?? 0),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const ColumnSpace(10),
                  SvgPicture.asset(
                    AppSvgImages.sunrise,
                    width: 90,
                    height: 90,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Заход',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(formatTimestampToTime(weatherResponse.sys?.sunset ?? 0),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  const ColumnSpace(10),
                  SvgPicture.asset(
                    AppSvgImages.sunset,
                    width: 90,
                    height: 90,
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ),
            ],
          ),
        ),
        const ColumnSpace(30),
      ],
    );
  }
}
