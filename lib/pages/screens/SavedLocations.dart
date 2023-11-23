import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/screens/AddNewLocation.dart';
import 'package:weather_app/provider/saved_location_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class SavedLocations extends StatefulWidget {
  const SavedLocations({super.key});

  @override
  State<SavedLocations> createState() => _SavedLocationsState();
}

class _SavedLocationsState extends State<SavedLocations> {
  @override
  void initState() {
    super.initState();
  }

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
          child: Consumer<SavedLocationProvider>(
            builder: (BuildContext context,
                    SavedLocationProvider savedLocationProvider,
                    Widget? child) =>
                Column(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: savedLocationProvider.cities.length,
                    itemBuilder: (context, index) {
                      final provider =
                          Provider.of<WeatherProvider>(context, listen: false);

                      provider
                          .info(savedLocationProvider.cities[index].city_name);

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        height: 160,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(155, 170, 165, 165),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  savedLocationProvider.cities[index].city_name,
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  provider.data != null
                                      ? '${provider.data.condition}'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Humidity',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      provider.data != null
                                          ? '${provider.data.humidity}'
                                          : '_',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Wind',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      provider.data != null
                                          ? '${provider.data.wind}km/h'
                                          : '_',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Spacer(),
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: provider.data != null &&
                                          provider.data.icon != null
                                      ? Image.network(
                                          'https:${provider.data.icon}')
                                      : const Placeholder(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '24',
                                      style: GoogleFonts.roboto(
                                        height: 0.8,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'ºC',
                                      style: GoogleFonts.roboto(
                                        height: 1,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddNewLocation()));
                  },
                  child: Container(
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
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
