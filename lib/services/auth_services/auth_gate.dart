import 'package:chat_messenger/screens/home_screen.dart';
import 'package:chat_messenger/services/auth_services/signin_or_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //   user is logged in
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          //   user is not logged in
          else {
            return const SignInOrSignUpScreen();
          }
        },
      ),
    );
  }
}
