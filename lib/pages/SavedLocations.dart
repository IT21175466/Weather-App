import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/AddNewLocation.dart';
import 'package:weather_app/provider/saved_location_provider.dart';
import 'package:weather_app/provider/search_provider.dart';

class SavedLocations extends StatefulWidget {
  const SavedLocations({super.key});

  @override
  State<SavedLocations> createState() => _SavedLocationsState();
}

class _SavedLocationsState extends State<SavedLocations> {
  TextEditingController searchController = TextEditingController();

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<SearchProvider>(
            builder: (BuildContext context, SearchProvider searchProvider,
                    Widget? child) =>
                Consumer<SavedLocationProvider>(
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
                      Visibility(
                        visible: searchProvider.isSearching == false,
                        child: Text(
                          'Saved Locations',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          searchProvider.toggleSearch();
                        },
                        child: searchProvider.isSearching
                            ? const Icon(
                                Icons.close,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: searchProvider.isSearching ? screenWidth / 2 : 0,
                        child: Visibility(
                          visible: searchProvider.isSearching,
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //Cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: savedLocationProvider.savedLocations.length,
                      itemBuilder: (context, index) {
                        if (searchController.text.toString().isEmpty) {
                          return Slidable(
                            endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      savedLocationProvider.deleteLocation(
                                          savedLocationProvider
                                              .savedLocations[index]);
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: "Delete",
                                  )
                                ]),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              height: 160,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(155, 170, 165, 165),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        savedLocationProvider
                                            .savedLocations[index].city_name,
                                        style: GoogleFonts.roboto(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 4),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        savedLocationProvider
                                            .savedLocations[index].condition,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Humidity',
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${savedLocationProvider.savedLocations[index].humidity}%',
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
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${savedLocationProvider.savedLocations[index].wind}km/h',
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
                                  const Spacer(),
                                  Column(
                                    children: [
                                      const Spacer(),
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.network(
                                            'https:${savedLocationProvider.savedLocations[index].icon}'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            savedLocationProvider
                                                .savedLocations[index].temp
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                              height: 0.8,
                                              fontSize: 48,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
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
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (searchController.text.toString().contains(
                            savedLocationProvider
                                .savedLocations[index].city_name)) {
                          return Slidable(
                            endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      savedLocationProvider.deleteLocation(
                                          savedLocationProvider
                                              .savedLocations[index]);
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: "Delete",
                                  )
                                ]),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              height: 160,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(155, 170, 165, 165),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        savedLocationProvider
                                            .savedLocations[index].city_name,
                                        style: GoogleFonts.roboto(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 4),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        savedLocationProvider
                                            .savedLocations[index].condition,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Humidity',
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${savedLocationProvider.savedLocations[index].humidity}%',
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
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${savedLocationProvider.savedLocations[index].wind}km/h',
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
                                  const Spacer(),
                                  Column(
                                    children: [
                                      const Spacer(),
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.network(
                                            'https:${savedLocationProvider.savedLocations[index].icon}'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            savedLocationProvider
                                                .savedLocations[index].temp
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                              height: 0.8,
                                              fontSize: 48,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
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
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AddNewLocation()));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
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
                          const SizedBox(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
