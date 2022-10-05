part of 'theme_mode_cubit.dart';

@immutable
abstract class ThemeModeState {
  //theme mode
  final ThemeMode themeMode;
  const ThemeModeState(this.themeMode);
}

class ThemeModeInitial extends ThemeModeState {
  const ThemeModeInitial(ThemeMode light)
      : super(ThemeMode.light);
}

class ThemeModeChanged extends ThemeModeState {
  const ThemeModeChanged(ThemeMode themeMode)
      : super(themeMode);
  @override
  String toString() =>
      'ThemeModeChanged { themeMode: $themeMode }';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeModeChanged &&
        other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;
}
