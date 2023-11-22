import 'package:weather_app/model/forecast_model.dart';

class Weather {
  var name;
  var icon;
  var condition;
  var temp;
  var wind;
  var humidity;
  var feelsLike;
  var last_update;
  final List<Forecast> forecast;

  Weather({
    required this.name,
    required this.icon,
    required this.condition,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.feelsLike,
    required this.last_update,
    required this.forecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final forecastData = json['forecast']['forecastday'] as List<dynamic>?;

    return Weather(
      name: json['location']['name'],
      icon: json['current']['condition']['icon'],
      condition: json['current']['condition']['text'],
      temp: json['current']['temp_c'].toInt(),
      wind: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      feelsLike: json['current']['feelslike_c'],
      last_update: DateTime.parse(json['current']['last_updated']),
      forecast: forecastData != null
          ? forecastData
              .map((reviewData) =>
                  Forecast.fromJson(reviewData as Map<String, dynamic>))
              .toList()
          : <Forecast>[],
    );
  }
}
