import 'package:flutter/material.dart';

import '../../sign_in/login_in_screen.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      ),
      child: Text(
        "SIGN IN",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).backgroundColor),
      ),
    );
  }
}
