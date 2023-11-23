import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/widgets/saved_weather_card.dart';

class SavedLocations extends StatefulWidget {
  const SavedLocations({super.key});

  @override
  State<SavedLocations> createState() => _SavedLocationsState();
}

class _SavedLocationsState extends State<SavedLocations> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 57, 26, 73),
              Color.fromARGB(255, 48, 29, 92),
              Color.fromARGB(255, 38, 33, 113),
              Color.fromARGB(255, 48, 29, 92),
              Color.fromARGB(255, 57, 26, 73),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),

              //Search Bar
              Row(
                children: [
                  Text(
                    'Saved Locations',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ],
              ),

              SizedBox(
                height: 15,
              ),

              //Cards
              WeatherCard(),
              WeatherCard(),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                height: 60,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(155, 170, 165, 165),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add new',
                      style: GoogleFonts.poppins(
                        height: 0.8,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
