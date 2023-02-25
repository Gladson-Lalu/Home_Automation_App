import 'package:flutter/material.dart';
import 'package:home_automation/ui/sign_in/widgets/sign_in_with_google.dart';

import 'login_in_screen.dart';
import 'widgets/already_have_an_account_check.dart';
import 'widgets/divider.dart';
import 'widgets/rounded_button.dart';
import 'widgets/rounded_input_field.dart';
import 'widgets/rounded_password_input_field.dart';
import 'widgets/sign_up_with_google.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Name",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  hintText: "Confirm Password",
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {},
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                const OrVerticalDivider(),
                const SignUpWithGoogle(),
              ],
            ),
          ),
        ));
  }
}
