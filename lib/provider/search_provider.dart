import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool _isSearching = false;
  String searchText = '';

  bool get isSearching => _isSearching;

  void toggleSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
}
