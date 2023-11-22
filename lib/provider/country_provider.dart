import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<String> countries = ["Paris", "Dubai", "Bangkok", "Barcelona", "Rome"];

  var selectedCountry = 'Paris';

  setCountry(value) {
    selectedCountry = value;
    notifyListeners();
  }
}
