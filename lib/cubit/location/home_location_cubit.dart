import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../weather/weather_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/home_location.dart';

part 'home_location_state.dart';

class HomeLocationCubit extends Cubit<HomeLocationState> {
  SharedPreferences? _prefs;
  final WeatherCubit _weatherCubit;
  HomeLocationCubit(this._weatherCubit)
      : super(const HomeLocationInitial());

  //get location
  Future<void> getHomeLocation() async {
    _prefs ??= await SharedPreferences.getInstance();
    final String? homeLocationString =
        _prefs!.getString('homeLocation');
    if (homeLocationString != null) {
      final HomeLocation homeLocation =
          HomeLocation.fromJson(
              jsonDecode(homeLocationString));
      emit(HomeLocationLoaded(homeLocation));
    } else {
      emit(const HomeLocationInitial());
    }
  }

  //save location
  Future<void> saveHomeLocation(
      HomeLocation homeLocation) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(
        'homeLocation', jsonEncode(homeLocation.toMap()));
    emit(HomeLocationLoaded(homeLocation));
    _weatherCubit.getWeather(
        latitude: homeLocation.latitude,
        longitude: homeLocation.longitude);
  }
}
