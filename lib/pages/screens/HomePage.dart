import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<WeatherProvider>(context, listen: false);

    provider.info('London');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Get Screen Width and Height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<WeatherProvider>(
        builder: (context, weather, child) => Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('lib/assets/images/eiffel_tower.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.33), BlendMode.darken),
            ),
          ),
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
                    Text(
                      weather.data != null ? '${weather.data.name}' : '-',
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
                    const Spacer(),
                    const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              //Date
              Text(
                weather.data != null ? '${weather.data.name}' : '-',
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              //Updated Date and Time
              Text(
                weather.data != null
                    ? 'Updated ${weather.data.last_update}'
                    : '-',
                //'Updated 6/7/2023 4:55 PM',
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
                    : Placeholder(), // You can replace Placeholder with any other widget or image to display when the icon is null
              ),

              //Condition
              Text(
                weather.data != null ? '${weather.data.condition}' : '_',
                //'Cloud',
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
              ),

              //Temperature
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.data != null ? '${weather.data.temp}' : '_',
                    //'24',
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
                          child: Image.asset('lib/assets/images/humidity.png'),
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
                          // '56%',
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
                          child: Image.asset('lib/assets/images/wind.png'),
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
                          child: Image.asset('lib/assets/images/feellike.png'),
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
                          //'22°',
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
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 83, 83, 83).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          weather.data != null
                              ? '${weather.data.forecast[0].f_date}'
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
                          width: 35,
                          height: 35,
                          child:
                              Image.asset('lib/assets/images/cloudy_sun.png'),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          '22º',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '1-5',
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
                    // const Spacer(),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       weather.data != null ? '${weather.data.f_date}' : '_',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     SizedBox(
                    //       width: 35,
                    //       height: 35,
                    //       child:
                    //           Image.asset('lib/assets/images/cloudy_moon.png'),
                    //     ),
                    //     const SizedBox(
                    //       height: 2,
                    //     ),
                    //     Text(
                    //       '25º',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Text(
                    //       '1-5',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Text(
                    //       'km/h',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const Spacer(),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Fri 18',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     SizedBox(
                    //       width: 35,
                    //       height: 35,
                    //       child:
                    //           Image.asset('lib/assets/images/cloudy_moon.png'),
                    //     ),
                    //     const SizedBox(
                    //       height: 2,
                    //     ),
                    //     Text(
                    //       '23º',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Text(
                    //       '5-10',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Text(
                    //       'km/h',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const Spacer(),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Fri 18',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     SizedBox(
                    //       width: 35,
                    //       height: 35,
                    //       child:
                    //           Image.asset('lib/assets/images/cloudy_rain.png'),
                    //     ),
                    //     const SizedBox(
                    //       height: 2,
                    //     ),
                    //     Text(
                    //       '25º',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Text(
                    //       '1-5',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Text(
                    //       'km/h',
                    //       style: GoogleFonts.roboto(
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             color: Colors.black.withOpacity(0.25),
                    //             offset: const Offset(0, 4),
                    //             blurRadius: 4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
