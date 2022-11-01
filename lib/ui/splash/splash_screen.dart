import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/bluetooth/bluetooth_cubit.dart';

import '../home/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BluetoothCubit>(context).isOn();
    Future.delayed(const Duration(milliseconds: 3200), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              foregroundImage:
                  AssetImage('assets/images/logo.gif'),
              radius: 55,
            ),
            const SizedBox(height: 30),
            AnimatedTextKit(animatedTexts: [
              TyperAnimatedText(
                'Home Automation',
                textStyle:
                    Theme.of(context).textTheme.headline6,
                speed: const Duration(milliseconds: 40),
              ),
            ], isRepeatingAnimation: false),
          ],
        ),
      ),
    );
  }
}
