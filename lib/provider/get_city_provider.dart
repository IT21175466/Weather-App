import 'package:flutter/material.dart';

class GetCityProvider extends ChangeNotifier {
  String _enteredCity = '';

  String get enteredText => _enteredCity;

  void setEnteredText(String text) {
    _enteredCity = text;
    notifyListeners();
  }
}
