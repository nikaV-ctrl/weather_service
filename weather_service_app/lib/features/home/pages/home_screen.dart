// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_service_app/features/home/bloc/weather_bloc.dart';
import 'package:weather_service_app/features/home/pages/weather_screen.dart';
import 'package:weather_service_app/features/home/repository/weather_repository.dart';
import 'package:weather_service_app/resources/app_colors.dart';
import 'package:weather_service_app/resources/app_images.dart';
import 'package:weather_service_app/utils/get_weather_from_storage.dart';
import 'package:weather_service_app/utils/set_weather_to_storage.dart';
import 'package:weather_service_app/widgets/column_space.dart';
import 'package:weather_service_app/widgets/custom_text_field.dart';
import 'package:weather_service_app/widgets/filled_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();
  late WeatherBLoC weatherBLoC;

  @override
  void initState() {
    super.initState();
    weatherBLoC = WeatherBLoC(
      weatherRepository: WeatherRepository(),
    );
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: weatherBLoC,
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ColumnSpace(20),
                Image.asset(
                  AppImages.weather,
                  width: 300,
                  height: 300,
                ),
                const ColumnSpace(40),
                CustomTextField(
                  textController: cityController,
                  hintText: 'Выберите город',
                  height: 54,
                  keyboardType: TextInputType.text,
                  fillColor: AppColors.lightBlue,
                ),
                const ColumnSpace(20),
                FilledButtonWidget(
                  backgroundColor: AppColors.yellow,
                  height: 54,
                  width: double.infinity,
                  radius: 9,
                  onPressed: () {
                    weatherBLoC.add(WeatherEvent.getWeatherForCity(
                        city: cityController.text));
                  },
                  text: 'Показать прогноз',
                  textStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const ColumnSpace(20),
                BlocConsumer<WeatherBLoC, WeatherState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        success: (weatherResponse) {
                          setWeatherToStorage(weatherResponse);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => WeatherScreen(
                                      weatherResponse: weatherResponse))));
                        },
                        error: (message) async {
                          if (message == 'Нет подключения к Интернету') {
                            final response = await getWeatherFromStorage();
                            response.name != null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => WeatherScreen(
                                            weatherResponse: response))))
                                : null;
                          }
                        },
                      );
                    },
                    builder: (context, state) => state.maybeWhen(
                          orElse: () => const SizedBox.shrink(),
                          inProgress: () => const CircularProgressIndicator(
                            color: AppColors.yellow,
                          ),
                          error: (message) => Text(message),
                          success: (weatherResponse) {
                            return const SizedBox.shrink();
                          },
                        ))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
