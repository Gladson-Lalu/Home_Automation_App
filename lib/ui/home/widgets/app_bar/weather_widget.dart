import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/location/home_location_cubit.dart';
import '../../../../domain/Service/location_service.dart';

import '../../../../cubit/weather/weather_cubit.dart';
import 'weather_detail_tile.dart';
import 'weather_icon_and_temperature.dart';

//capitalize extension to String
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() =>
      _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeLocationCubit>(context)
        .getHomeLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeLocationCubit,
            HomeLocationState>(
        listener: (context, state) {
          if (state is HomeLocationLoaded) {
            BlocProvider.of<WeatherCubit>(context)
                .getWeather(
                    latitude: state.homeLocation.latitude,
                    longitude:
                        state.homeLocation.longitude);
          } else {
            LocationService()
                .getCurrentLocation()
                .then((value) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Location'),
                      content: Column(
                        children: [
                          Text(
                              'Setting ${value.city} as home location'),
                          const SizedBox(height: 10),
                          const Text(
                              'You can change this in settings'),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<
                                          HomeLocationCubit>(
                                      context)
                                  .saveHomeLocation(value);
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'))
                      ],
                    );
                  });
            });
          }
        },
        child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
          if (state is WeatherLoading) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary,
                    strokeWidth: 2),
              ),
            );
          } else if (state is WeatherLoaded) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 850),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: Column(children: [
                        const SizedBox(height: 20),
                        WeatherIconAndTemperature(
                            weather: state.weather),
                        Text(
                          state.weather.description
                              .capitalize(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        //feels like
                        Wrap(
                          children: [
                            Text(
                              'Feels like ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w100),
                            ),
                            Text(
                              '${state.weather.feelsLike}°',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .color!
                              .withOpacity(0.5),
                          thickness: 1,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            WeatherDetailTile(
                              assetPath:
                                  'assets/icons/weather/wind.png',
                              title:
                                  '${state.weather.wind} km/h',
                            ),
                            const SizedBox(width: 30),
                            WeatherDetailTile(
                              assetPath:
                                  'assets/icons/weather/humidity.png',
                              title:
                                  '${state.weather.humidity} %',
                            ),
                            const SizedBox(width: 30),
                            WeatherDetailTile(
                              assetPath:
                                  'assets/icons/weather/cloudy.png',
                              title:
                                  '${state.weather.cloudiness} %',
                            ),
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Set your home location ');
          }
        }));
  }
}
