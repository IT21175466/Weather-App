import 'package:flutter/material.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  var _repo = WeatherRepo();
  var data;

  info(String city) async {
    try {
      data = await _repo.getData(city);

      notifyListeners();
      return data;
    } catch (e) {
      print(e);
    }
  }
}
