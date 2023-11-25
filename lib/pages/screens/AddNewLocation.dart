import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/screens/SavedLocations.dart';
import 'package:weather_app/provider/saved_location_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class AddNewLocation extends StatefulWidget {
  const AddNewLocation({super.key});

  @override
  State<AddNewLocation> createState() => _AddNewLocationState();
}

class _AddNewLocationState extends State<AddNewLocation> {
  TextEditingController cityController = TextEditingController();

  void validationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 150,
              width: 260,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "Please Enter City Name",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final savedLocationProvider =
        Provider.of<SavedLocationProvider>(context, listen: false);

    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    void addLocation() {
      savedLocationProvider.saveLocation(
          cityController.text,
          weatherProvider.data.condition,
          weatherProvider.data.icon,
          weatherProvider.data.humidity,
          weatherProvider.data.wind,
          weatherProvider.data.temp);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            const Spacer(),
            TextField(
              controller: cityController,
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
                labelStyle: const TextStyle(
                  color: Color.fromARGB(112, 3, 20, 108),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (cityController.text.isEmpty) {
                  validationDialog();
                } else {
                  weatherProvider
                      .info(cityController.text)
                      .then((dynamic result) {
                    addLocation();
                  }).catchError((error) {
                    print(error);
                  });
                }

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SavedLocations()));
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 130, 157, 237),
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
                    'Save Location',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
