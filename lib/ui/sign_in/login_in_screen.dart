import 'package:flutter/material.dart';
import 'package:home_automation/ui/sign_in/widgets/divider.dart';

import '../../config/typography.dart';
import 'sign_up_screen.dart';
import 'widgets/already_have_an_account_check.dart';
import 'widgets/rounded_button.dart';
import 'widgets/rounded_input_field.dart';
import 'widgets/rounded_password_input_field.dart';
import 'widgets/sign_in_with_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isForgot = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.03),
                isForgot
                    ? Text(
                        "FORGOT PASSWORD",
                        style: textStyle.copyWith(color: Colors.black54),
                      )
                    : Text(
                        "LOGIN",
                        style: textStyle.copyWith(color: Colors.black54),
                      ),
                SizedBox(height: size.height * 0.03),
                const Hero(
                  transitionOnUserGestures: true,
                  tag: "logo",
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundImage: AssetImage('assets/images/logo.gif'),
                    radius: 55,
                  ),
                ),
                buildLoginForgotForm(size),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isForgot = !isForgot;
                    });
                  },
                  child: isForgot
                      ? Text(
                          "Login Now!",
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.w600),
                        )
                      : Text(
                          "Forgot Password",
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.w600),
                        ),
                ),
                SizedBox(height: size.height * 0.02),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
                const OrVerticalDivider(),
                const SignInWithGoogle(),
              ],
            ),
          ),
        ));
  }

  Widget buildLoginForgotForm(Size size) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 100),
      firstChild:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          onChanged: (value) {},
        ),
        RoundedPasswordField(
          onChanged: (value) {},
        ),
        RoundedButton(
          text: "LOGIN",
          press: () {},
        ),
      ]),
      secondChild:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          onChanged: (value) {},
        ),
        RoundedButton(
          text: "CONTINUE",
          press: () {},
        ),
      ]),
      crossFadeState:
          isForgot ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
