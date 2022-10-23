import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../extensions/capitalize.dart';

import '../../../../cubit/location/home_location_cubit.dart';

import '../../../../cubit/weather/weather_cubit.dart';
import 'weather_detail_tile.dart';
import 'weather_icon_and_temperature.dart';

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
    return BlocConsumer<WeatherCubit, WeatherState>(
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
                color:
                    Theme.of(context).colorScheme.secondary,
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
        return Center(
            child: InkWell(
          onTap: () {
            BlocProvider.of<HomeLocationCubit>(context)
                .currentLocation
                .then((value) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding:
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20)),
                      backgroundColor:
                          Theme.of(context).backgroundColor,
                      title: Text('Location',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color)),
                      content: SizedBox(
                        height: MediaQuery.of(context)
                                .size
                                .height *
                            0.1,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Set ${value.city} as the home location. You can change this location in settings.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Do you want to continue?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color))),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<
                                          HomeLocationCubit>(
                                      context)
                                  .saveHomeLocation(value);
                              Navigator.pop(context);
                            },
                            child: Text('Continue',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Theme.of(context)
                                        .focusColor))),
                      ],
                    );
                  });
            });
          },
          child: Text('Set your home location ',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w600)),
        ));
      }
    });
  }
}
