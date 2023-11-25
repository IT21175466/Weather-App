import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/saved_location_model.dart';

class SavedLocationProvider with ChangeNotifier {
  List<SavedLocation> savedLocations = [];

  void initialState() {
    syncDataWithProvider();
  }

  void saveLocation(var cityName, var condition, var icon, var humidity,
      double wind, var temp) {
    SavedLocation location = SavedLocation(
        city_name: cityName,
        condition: condition,
        icon: icon,
        humidity: humidity,
        wind: wind,
        temp: temp);
    savedLocations.add(location);
    updateSharedprefrences();
    notifyListeners();
  }

  void updateSharedprefrences() async {
    List<String> savedCities =
        savedLocations.map((e) => json.encode(e.toJson())).toList();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setStringList('savedLocations', savedCities);
  }

  int getCitiesLength() {
    return savedLocations.length;
  }

  Future syncDataWithProvider() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var results = preferences.getStringList('savedLocations');

    if (results != null) {
      savedLocations =
          results.map((e) => SavedLocation.fromJson(json.decode(e))).toList();
    }
    notifyListeners();
  }
}
