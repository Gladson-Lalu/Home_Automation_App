//import http package
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenWeatherAPIClient {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5';
  static final String _apiKey =
      dotenv.env['OPENWEATHERMAP_API_KEY']!;

  Future<http.Response> getWeather(
      {required String latitude,
      required String longitude}) {
    return http.get(Uri.parse(
        '$_baseUrl/weather?lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric'));
  }
}
