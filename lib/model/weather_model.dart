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
  late List<Forecast> forecast;

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

  Weather.fromJson(Map<String, dynamic> json) {
    name = json['location']['name'];
    icon = json['current']['condition']['icon'];
    condition = json['current']['condition']['text'];
    temp = json['current']['temp_c'].toInt();
    wind = json['current']['wind_kph'];
    humidity = json['current']['humidity'];
    feelsLike = json['current']['feelslike_c'];
    last_update = json['current']['last_updated'];
    if (json['forecast']['forecastday'] != null) {
      forecast = <Forecast>[];
      (json['forecast']['forecastday'] as List).forEach((element) {
        forecast.add(Forecast.fromJson(element));
        print(element);
      });
    }
    //forecast = List<Forecast>.from(json['forecast']['forecastday']);
  }
}
