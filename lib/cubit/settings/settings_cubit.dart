import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/settings_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences _prefs;

  SettingsCubit(this._prefs)
      : super(const SettingsInitial());

  Future<void> getSettings() async {
    try {
      final String? settingsString =
          _prefs.getString('settings');
      if (settingsString != null) {
        final Settings settings =
            Settings.fromJson(jsonDecode(settingsString));
        emit(SettingsLoaded(settings));
      } else {
        emit(const SettingsInitial());
      }
    } catch (e) {
      emit(const SettingsInitial());
    }
  }

  Future<void> saveSettings(Settings settings) async {
    await _prefs.setString(
        'settings', jsonEncode(settings.toMap()));
    emit(SettingsLoaded(settings));
  }
}
