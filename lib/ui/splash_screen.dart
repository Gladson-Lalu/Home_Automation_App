import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_automation/config/theme.dart';
import 'package:home_automation/ui/home/home_screen.dart';
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
    Future.delayed(const Duration(seconds: 100), () {
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
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 140,
              height: 140,
            ),
            const SizedBox(height: 30),
            AnimatedTextKit(animatedTexts: [
              TyperAnimatedText(
                'Home Automation',
                textStyle: GoogleFonts.playball(
                    color: Color(0xFF08415C),
                    letterSpacing: 1.2,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
                speed: const Duration(milliseconds: 40),
              ),
            ], isRepeatingAnimation: false),
          ],
        ),
      ),
    );
  }
}
