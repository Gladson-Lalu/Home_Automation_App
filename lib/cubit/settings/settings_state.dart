part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoaded extends SettingsState {
  final Settings settings;
  const SettingsLoaded(this.settings);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsLoaded &&
        other.settings == settings;
  }

  @override
  int get hashCode => settings.hashCode;
}
