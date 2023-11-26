import 'package:flutter/material.dart';
import 'package:weather_app/model/city_image_model.dart';
import 'package:weather_app/repositories/city_image_repository.dart';

class CityImageProvider extends ChangeNotifier {
  CityImage? cityImage;
  bool isImageLoaded = false;
  final CityImageRepo cityImageRepo;

  CityImageProvider(this.cityImageRepo);

  Future<void> getCityImage(String cityName) async {
    try {
      final imageUrl = await cityImageRepo.getCityImage(cityName);
      cityImage = CityImage(name: cityName, imageUrl: imageUrl);

      print(cityImage?.imageUrl);
      isImageLoaded = true;

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load city data');
    }
  }
}
