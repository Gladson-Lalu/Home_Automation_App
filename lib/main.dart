import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/theme.dart';
import 'cubit/location/home_location_cubit.dart';
import 'cubit/settings/settings_cubit.dart';
import 'domain/repository/weather_repository_impl.dart';
import 'ui/splash/splash_screen.dart';

import 'cubit/weather/weather_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                WeatherCubit(WeatherRepositoryImpl())),
        BlocProvider(
            create: (context) => HomeLocationCubit(
                BlocProvider.of<WeatherCubit>(context))),
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
      ),
    );
  }
}
