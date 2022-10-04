class Weather {
  final String icon;
  final String temperature;
  final String description;
  final String wind;
  final String humidity;
  final String cloudiness;
  final String feelsLike;

  const Weather({
    required this.icon,
    required this.temperature,
    required this.description,
    required this.wind,
    required this.cloudiness,
    required this.humidity,
    required this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'].toString(),
      description: json['weather'][0]['description'],
      wind: json['wind']['speed'].toString(),
      cloudiness: json['clouds']['all'].toString(),
      humidity: json['main']['humidity'].toString(),
      feelsLike: json['main']['feels_like'].toString(),
    );
  }
}
