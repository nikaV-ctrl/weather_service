// ignore_for_file: avoid_dynamic_calls, avoid-ignoring-return-values
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_service_app/features/home/model/weather_response.dart';
import 'package:weather_service_app/features/home/repository/weather_repository.dart';
import 'package:weather_service_app/network/network_exceptions.dart';

part 'weather_bloc.freezed.dart';

@freezed
abstract class WeatherEvent with _$WeatherEvent {
  const WeatherEvent._();

  /// Событие отправки формы для получения погоды по определенному городу
  const factory WeatherEvent.getWeatherForCity({required String city}) =
      _GetWeatherForCity;
}

@freezed
abstract class WeatherState with _$WeatherState {
  const WeatherState._();

  /// Первичное состояние
  const factory WeatherState.initial() = _Initial;

  /// Успешно
  const factory WeatherState.success({
    required WeatherResponse weatherResponse,
  }) = _Success;

  /// Ошибка
  const factory WeatherState.error({@Default('Ошибка') String message}) =
      _Error;

  /// В обработке
  const factory WeatherState.inProgress() = _InProgress;

  bool get inProgress => maybeMap(
        orElse: () => false,
        inProgress: (_) => true,
      );

  bool get isSuccess => maybeMap(
        orElse: () => false,
        success: (_) => true,
      );

  String get error => maybeMap(
        orElse: () => '',
      );
}

class WeatherBLoC extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBLoC({
    required final WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherState.initial()) {
    on<WeatherEvent>(
      (WeatherEvent event, Emitter<WeatherState> emit) => event.map(
        getWeatherForCity: (event) => _getWeatherForCity(event, emit),
      ),
    );
  }

  Future<void> _getWeatherForCity(
      _GetWeatherForCity event, Emitter<WeatherState> emit) async {
    try {
      emit(const WeatherState.inProgress());

      final result = await _weatherRepository.getWeatherForCity(
        city: event.city,
      );

      result.when(
        success: (response) {
          emit(
            WeatherState.success(
              weatherResponse: response,
            ),
          );
        },
        failure: (e) {
          emit(
            WeatherState.error(
              message: NetworkExceptions.getErrorMessage(e),
            ),
          );
        },
      );
    } on Object catch (e) {
      emit(
        WeatherState.error(
          message: e.toString(),
        ),
      );
      rethrow;
    }
  }
}
