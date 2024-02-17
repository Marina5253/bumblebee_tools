import 'package:bumblebee_tools/bloc/weather_bloc.dart';
import 'package:bumblebee_tools/widgets/main/drawer.dart';
import 'package:bumblebee_tools/widgets/main/rootAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/weather/thunder.webp');
      case >= 300 && < 400:
        return Image.asset('assets/weather/rain.webp');
      case >= 500 && < 600:
        return Image.asset('assets/weather/heavy_rain.webp');
      case >= 600 && < 700:
        return Image.asset('assets/weather/snow.webp');
      case >= 700 && < 800:
        return Image.asset('assets/weather/mist.webp');
      case == 800:
        return Image.asset('assets/weather/sunny.webp');
      case > 800 && <= 804:
        return Image.asset('assets/weather/kinda_cloudy.webp');
      default:
        return Image.asset('assets/weather/kinda_cloudy.webp');
    }
  }

  Widget getGreeting() {
    int time = DateTime.now().hour;
    String greeting = "Good ";

    switch (time) {
      case >= 0 && <= 5 || == 23:
        greeting += "night";
      case >= 6 && <= 17:
        greeting += "morning";
      case >= 18 && <= 22:
        greeting += "evening";
    }

    return Text(
      greeting,
      style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontWeight: FontWeight.bold,
          fontSize: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RootAppBar(label: "Weather"),
      drawer: const RootDrawer(
        selectedIndex: 1,
      ),
      body: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider<WeatherBloc>(
              create: (context) =>
                  WeatherBloc()..add(FetchWeather(snap.data as Position)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 40, 30),
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccess) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.weather.areaName}",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.w300),
                              ),
                              getGreeting(),
                              getWeatherIcon(
                                  state.weather.weatherConditionCode!),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Center(
                                  child: Text(
                                    '${state.weather.temperature!.celsius!.round()}°C',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Center(
                                  child: Text(
                                    state.weather.weatherMain!.toUpperCase(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.zero,
                                child: Center(
                                  child: Text(
                                    DateFormat('EEEE dd •')
                                        .add_jm()
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/weather/sun.webp',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sunrise',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunrise!),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/weather/moon.webp',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sunset',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunset!),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/weather/heat.webp',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Temp Max',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${state.weather.tempMax!.celsius!.round()}°C',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/weather/cold.webp',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Temp Min',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '${state.weather.tempMin!.celsius!.round()}°C',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              ),
            );
          } else if (snap.hasError) {
            return Center(
              child: Text(snap.error.toString()),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
