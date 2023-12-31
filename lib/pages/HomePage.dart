import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/CitySelectPage.dart';
import 'package:weather_app/pages/SavedLocations.dart';
import 'package:weather_app/provider/city_image_provider.dart';
import 'package:weather_app/provider/get_city_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final cityProvider = Provider.of<GetCityProvider>(context, listen: false);
    final cityImageProvider =
        Provider.of<CityImageProvider>(context, listen: false);
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    provider.isLoaded = false;
    cityImageProvider.isImageLoaded = false;

    provider.info(cityProvider.enteredText);
    cityImageProvider.getCityImage(cityProvider.enteredText);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Get Screen Width and Height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String getFormattedDate() {
      DateTime today = DateTime.now();
      String formattedDate = DateFormat('MMMM d').format(today);
      return formattedDate;
    }

    return Scaffold(
      body: Consumer<CityImageProvider>(
        builder: (BuildContext context, CityImageProvider cityImageProvider,
                Widget? child) =>
            Consumer<WeatherProvider>(
          builder: (context, weather, child) => cityImageProvider.isImageLoaded
              ? Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: cityImageProvider.cityImage != null
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                cityImageProvider.cityImage!.imageUrl),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.33),
                                BlendMode.darken),
                          ),
                        )
                      : BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height,
                      ),

                      //Location and Menu Row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CitySelection()));
                              },
                              child: Text(
                                weather.data != null
                                    ? '${weather.data.name}'
                                    : '-',
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SavedLocations()));
                              },
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      //Date
                      Text(
                        getFormattedDate(),
                        style: GoogleFonts.roboto(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),

                      //Updated Date and Time
                      Text(
                        weather.data != null
                            ? 'Updated ${DateFormat('MM/dd/yyyy hh:mma').format(weather.data.last_update ?? DateTime.now())}'
                            : '-',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      //Icon
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: weather.data != null && weather.data.icon != null
                            ? Image.network('https:${weather.data.icon}')
                            : const Placeholder(),
                      ),

                      //Condition
                      Text(
                        weather.data != null
                            ? '${weather.data.condition}'
                            : '_',
                        style: GoogleFonts.roboto(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      //Temperature
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.data != null ? '${weather.data.temp}' : '_',
                            style: GoogleFonts.roboto(
                              height: 0.8,
                              fontSize: 86,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
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
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      //Humidity Wind FeelsLike
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                      'lib/assets/images/humidity.png'),
                                ),
                                Text(
                                  'HUMIDITY',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.humidity}%'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child:
                                      Image.asset('lib/assets/images/wind.png'),
                                ),
                                Text(
                                  'WIND',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.wind}km/h'
                                      : '_',
                                  //'4.63km/h',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                      'lib/assets/images/feellike.png'),
                                ),
                                Text(
                                  'FEELS LIKE',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.feelsLike}°'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //History
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(15),
                        height: 155,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 83, 83, 83)
                              .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weather.data != null
                                      ? DateFormat('E d').format(
                                          weather.data.forecast[1]?.f_date ??
                                              DateTime.now())
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: weather.data != null &&
                                          weather.data.forecast[1].f_icon !=
                                              null
                                      ? Image.network(
                                          'https:${weather.data.forecast[2].f_icon}')
                                      : const Placeholder(),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[1].f_temp}º'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[1].f_wind}'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'km/h',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weather.data != null
                                      ? DateFormat('E d').format(
                                          weather.data.forecast[2]?.f_date ??
                                              DateTime.now())
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: weather.data != null &&
                                          weather.data.forecast[2].f_icon !=
                                              null
                                      ? Image.network(
                                          'https:${weather.data.forecast[2].f_icon}')
                                      : const Placeholder(),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[2].f_temp}º'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[2].f_wind}'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'km/h',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weather.data != null
                                      ? DateFormat('E d').format(
                                          weather.data.forecast[3]?.f_date ??
                                              DateTime.now())
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: weather.data != null &&
                                          weather.data.forecast[3].f_icon !=
                                              null
                                      ? Image.network(
                                          'https:${weather.data.forecast[3].f_icon}')
                                      : const Placeholder(),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[3].f_temp}º'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[3].f_wind}'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'km/h',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weather.data != null
                                      ? DateFormat('E d').format(
                                          weather.data.forecast[4]?.f_date ??
                                              DateTime.now())
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: weather.data != null &&
                                          weather.data.forecast[4].f_icon !=
                                              null
                                      ? Image.network(
                                          'https:${weather.data.forecast[4].f_icon}')
                                      : const Placeholder(),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[4].f_temp}º'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  weather.data != null
                                      ? '${weather.data.forecast[4].f_wind}'
                                      : '_',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'km/h',
                                  style: GoogleFonts.roboto(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Center(
                    child: Column(
                      children: [
                        const Spacer(),
                        Lottie.asset('lib/assets/animations/loading.json'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Getting Weather....',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
