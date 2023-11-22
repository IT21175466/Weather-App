import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherRepo {
  Future<Weather> getData(String city) async {
    var uriCall = Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=ec7393d3fcbf49c494a124957231811&q=$city&days=5&aqi=no&alerts=no');
    var response = await http.get(uriCall);
    var body = jsonDecode(response.body);

    return Weather.fromJson(body);
  }
}
