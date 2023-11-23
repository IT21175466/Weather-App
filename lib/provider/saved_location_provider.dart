import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/city_model.dart';

class SavedLocationProvider with ChangeNotifier {
  List<City> cities = [];

  void initialState() {
    syncDataWithProvider();
  }

  void saveCityName(String cityName) {
    City city = City(city_name: cityName);
    cities.add(city);
    updateSharedprefrences();
    notifyListeners();
  }

  void updateSharedprefrences() async {
    List<String> savedCities =
        cities.map((e) => json.encode(e.toJson())).toList();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setStringList('cities', savedCities);
  }

  int getCitiesLength() {
    return cities.length;
  }

  Future syncDataWithProvider() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var results = preferences.getStringList('cities');

    if (results != null) {
      cities = results.map((e) => City.fromJson(json.decode(e))).toList();
    }
    notifyListeners();
  }
}
