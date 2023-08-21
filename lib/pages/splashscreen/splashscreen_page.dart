// ignore_for_file: unnecessary_lambdas, inference_failure_on_function_return_type, prefer_final_locals, omit_local_variable_types

import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isVisible = false, isLoading = false;

  // Future verifyUser() async {
  //   await DB().loginUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Container(
            height: 122,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/icons/splash_logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
