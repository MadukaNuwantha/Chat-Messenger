// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:chat_messenger/services/auth_services/auth_service.dart';
import 'package:chat_messenger/widgets/custom_button.dart';
import 'package:chat_messenger/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  void Function()? onTap;
  SignUpScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // text controllers needed to get details
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign up method
  Future<void> signUp() async {
    //   password check
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text('Passwords doesn\'t match'),
          ),
        ),
      );
    } else {
      //   get auth service
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                e.toString(),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
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
                    'Let\'s create an account for you',
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
                  const SizedBox(height: 10),

                  //   confirm password text field
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),

                  //   sign up button
                  CustomButton(
                    btnTitle: 'Sign Up',
                    onTap: signUp,
                  ),
                  const SizedBox(height: 50),

                  //   sign in redirect text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member? ',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Sign In',
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
      ),
    );
  }
}
