import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/screens/SavedLocations.dart';
import 'package:weather_app/provider/saved_location_provider.dart';

class AddNewLocation extends StatefulWidget {
  const AddNewLocation({super.key});

  @override
  State<AddNewLocation> createState() => _AddNewLocationState();
}

class _AddNewLocationState extends State<AddNewLocation> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final savedLocationProvider =
        Provider.of<SavedLocationProvider>(context, listen: false);

    void addCity() {
      savedLocationProvider.saveCityName(cityController.text);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
            ),
            Spacer(),
            TextField(
              controller: cityController,
              // onChanged: (value) {
              //
              // },
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
                addCity();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SavedLocations()));
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
            Spacer(),
          ],
        ),
      ),
    );
  }
}
