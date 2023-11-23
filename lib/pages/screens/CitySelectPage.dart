import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/screens/HomePage.dart';
import 'package:weather_app/provider/get_city_provider.dart';

class CitySelection extends StatefulWidget {
  const CitySelection({super.key});

  @override
  State<CitySelection> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetCityProvider>(
        builder: (BuildContext context, GetCityProvider cityProvider,
                Widget? child) =>
            Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Spacer(),
              TextField(
                onChanged: (text) {
                  cityProvider.setEnteredText(text.trim());
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_city,
                    color: Color.fromARGB(112, 3, 20, 108),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(112, 3, 20, 108),
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Enter city name',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(112, 3, 20, 108),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 130, 157, 237),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(63, 0, 0, 0),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Get Weather',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
