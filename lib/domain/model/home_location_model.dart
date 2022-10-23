class HomeLocation {
  final String city;
  final String latitude;
  final String longitude;

  HomeLocation({
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  // Convert a UserSettings object into a Map object.
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  //fromJson
  factory HomeLocation.fromJson(Map<String, dynamic> json) {
    return HomeLocation(
      city: json['city'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
