// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:chat_messenger/services/auth_services/auth_service.dart';
import 'package:chat_messenger/widgets/custom_button.dart';
import 'package:chat_messenger/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  void Function()? onTap;
  SignInScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // text controllers needed to get details
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //  sign in method
  Future<void> signIn() async {
    //   get auth service
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );
    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //   logo
                Icon(
                  Icons.message,
                  size: 150,
                  color: Colors.grey.shade900,
                ),
                const SizedBox(height: 25),
                //   welcome message
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 25),

                //   email text field
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //   password text field
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                //   sign in button
                CustomButton(
                  btnTitle: 'Sign In',
                  onTap: signIn,
                ),
                const SizedBox(height: 50),

                //   sign up redirect text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: Colors.grey.shade900,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
