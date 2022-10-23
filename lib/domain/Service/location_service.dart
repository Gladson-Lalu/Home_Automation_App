//singleton pattern
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

import '../model/home_location_model.dart';

class LocationService {
  LocationService._privateConstructor();

  static final LocationService _instance =
      LocationService._privateConstructor();

  factory LocationService() {
    return _instance;
  }

  Location location = Location();

  Future<HomeLocation> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error(
            'Location services are disabled.');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted =
          await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error(
            'Location permissions are denied');
      }
    }

    locationData = await location.getLocation();
    final String cityName = await getCityName(
        locationData.latitude!, locationData.longitude!);
    return HomeLocation(
        latitude: locationData.latitude.toString(),
        longitude: locationData.longitude.toString(),
        city: cityName);
  }

  //get the city name using geocoding
  Future<String> getCityName(
      double latitude, double longitude) async {
    List<geo.Placemark> placemarks = await geo
        .placemarkFromCoordinates(latitude, longitude);
    return placemarks[0].locality!;
  }
}
