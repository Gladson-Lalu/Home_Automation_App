import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'cubit/electronic_devices/devices/devices_electronic_devices_cubit.dart';
import 'cubit/electronic_devices/home/home_electronic_devices_cubit.dart';
import 'domain/Service/db_service.dart';
import 'domain/Service/dialogflow_service.dart';
import 'domain/repository/database/local_db_repository.dart';
import 'config/theme.dart';
import 'cubit/location/home_location_cubit.dart';
import 'cubit/settings/settings_cubit.dart';
import 'cubit/theme_mode/theme_mode_cubit.dart';
import 'cubit/voice/voice_cubit.dart';
import 'domain/repository/database/local_db_repository_impl.dart';
import 'domain/repository/speech/speech_repository_impl.dart';
import 'domain/repository/weather/weather_repository_impl.dart';
import 'ui/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/weather/weather_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: '.env');
  final SharedPreferences prefs =
      await SharedPreferences.getInstance();

  runApp(MyApp(
    preferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({Key? key, required this.preferences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalDbRepository localDbRepository =
        LocalDbRepositoryImpl(LocalDBService());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                WeatherCubit(WeatherRepositoryImpl())),
        BlocProvider(
            create: (context) => HomeLocationCubit(
                BlocProvider.of<WeatherCubit>(context),
                preferences)),
        BlocProvider(
            create: (context) =>
                SettingsCubit(preferences)),
        BlocProvider(
            create: (context) =>
                ThemeModeCubit(preferences)),
        BlocProvider(
            create: (context) => VoiceCubit(
                SpeechRepositoryImpl(),
                DialogflowService())),
        BlocProvider(
            create: (context) => HomeElectronicDevicesCubit(
                localDbRepository)),
        BlocProvider(
          create: (context) =>
              DevicesElectronicDevicesCubit(
                  localDbRepository),
        ),
      ],
      child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Home Automation',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
