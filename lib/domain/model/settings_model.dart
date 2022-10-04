class Settings {
  final String homeName;

  Settings({
    required this.homeName,
  });

  // Convert a UserSettings object into a Map object.
  Map<String, dynamic> toMap() {
    return {
      'homeName': homeName,
    };
  }

  //fromJson
  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      homeName: json['homeName'],
    );
  }
}
