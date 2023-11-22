import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherRepo {
  Future<Weather> getData(String city) async {
    var uriCall = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=ec7393d3fcbf49c494a124957231811&q=$city&aqi=no');
    var response = await http.get(uriCall);
    var body = jsonDecode(response.body);
    print(body);

    return Weather.fromJson(body);
  }
}
