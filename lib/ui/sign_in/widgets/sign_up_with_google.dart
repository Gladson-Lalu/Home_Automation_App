import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpWithGoogle extends StatelessWidget {
  const SignUpWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      width: size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/google.png',
            height: 24.0,
          ),
          const SizedBox(width: 10.0),
          Text(
            'Sign Up with Google',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
