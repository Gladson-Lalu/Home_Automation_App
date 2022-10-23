import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_automation/domain/service/location_service.dart';

import '../../domain/model/home_location_model.dart';
import '../weather/weather_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_location_state.dart';

class HomeLocationCubit extends Cubit<HomeLocationState> {
  final SharedPreferences _prefs;
  final WeatherCubit _weatherCubit;
  HomeLocationCubit(this._weatherCubit, this._prefs)
      : super(const HomeLocationInitial());

  //get location
  Future<void> getHomeLocation() async {
    final String? homeLocationString =
        _prefs.getString('homeLocation');
    if (homeLocationString != null) {
      final HomeLocation homeLocation =
          HomeLocation.fromJson(
              jsonDecode(homeLocationString));
      emit(HomeLocationLoaded(homeLocation));
      _weatherCubit.getWeather(
          latitude: homeLocation.latitude,
          longitude: homeLocation.longitude);
    } else {
      emit(const HomeLocationInitial());
    }
  }

  //save location
  Future<void> saveHomeLocation(
      HomeLocation homeLocation) async {
    await _prefs.setString(
        'homeLocation', jsonEncode(homeLocation.toMap()));
    emit(HomeLocationLoaded(homeLocation));
    _weatherCubit.getWeather(
        latitude: homeLocation.latitude,
        longitude: homeLocation.longitude);
  }

  Future<HomeLocation> get currentLocation =>
      LocationService().getCurrentLocation();
}
