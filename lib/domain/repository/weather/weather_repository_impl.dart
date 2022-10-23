import 'dart:convert';

import '../../service/weather_api.dart';
import '../../model/weather_model.dart';
import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final OpenWeatherAPIClient _openWeatherAPIClient;

  const WeatherRepositoryImpl(this._openWeatherAPIClient);

  @override
  Future<Weather> getWeather(
      {required String latitude,
      required String longitude}) async {
    final response = await _openWeatherAPIClient.getWeather(
        latitude: latitude, longitude: longitude);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
