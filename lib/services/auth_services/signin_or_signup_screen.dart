import 'package:chat_messenger/screens/signin_screen.dart';
import 'package:chat_messenger/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SignInOrSignUpScreen extends StatefulWidget {
  const SignInOrSignUpScreen({super.key});

  @override
  State<SignInOrSignUpScreen> createState() => _SignInOrSignUpScreenState();
}

class _SignInOrSignUpScreenState extends State<SignInOrSignUpScreen> {
  // initially show login screen
  bool showLoginScreen = true;

  // toggle screen method
  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return SignInScreen(
        onTap: toggleScreen,
      );
    } else {
      return SignUpScreen(onTap: toggleScreen);
    }
  }
}
