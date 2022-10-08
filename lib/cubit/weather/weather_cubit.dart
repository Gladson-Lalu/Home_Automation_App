import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/weather/weather_repository.dart';

import '../../domain/model/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository)
      : super(const WeatherInitial());

  Future<void> getWeather(
      {required String latitude,
      required String longitude}) async {
    try {
      emit(const WeatherLoading());
      final Weather weather =
          await _weatherRepository.getWeather(
              latitude: latitude, longitude: longitude);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
