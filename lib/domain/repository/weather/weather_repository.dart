import '../../model/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(
      {required String latitude,
      required String longitude});
}
