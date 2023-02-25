import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/bluetooth/bluetooth_cubit.dart';

import 'widgets/sign_in_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BluetoothCubit>(context).isOn();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Hero(
              tag: "logo",
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundImage: AssetImage('assets/images/logo.gif'),
                radius: 55,
              ),
            ),
            const SizedBox(height: 30),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Home Automation',
                  textStyle: Theme.of(context).textTheme.headline6,
                  speed: const Duration(milliseconds: 40),
                ),
              ],
              isRepeatingAnimation: false,
            ),
            const SizedBox(height: 30),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 1000),
              child: const SignInButton(),
            ),
          ],
        ),
      ),
    );
  }
}
