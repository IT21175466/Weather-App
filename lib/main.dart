import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/SplashScreen.dart';
import 'package:weather_app/provider/city_image_provider.dart';
import 'package:weather_app/provider/get_city_provider.dart';
import 'package:weather_app/provider/saved_location_provider.dart';
import 'package:weather_app/provider/search_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/repositories/city_image_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetCityProvider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => SavedLocationProvider()),
        ChangeNotifierProvider(
            create: (context) => CityImageProvider(CityImageRepo())),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
