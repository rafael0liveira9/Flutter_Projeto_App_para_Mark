import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/db/user_db.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/pages/account/login/view/login_page.dart';
import 'package:Mark/pages/home/view/home_page.dart';
// import 'package:Mark/db/user_db.dart';
// import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/pages/splashscreen/splashscreen_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final userData = Get.put<UserController>(UserController());

  @override
  void initState() {
    super.initState();

    userLogin();
  }

  void userLogin() async {
    await DB().loginUser();
    print("object");
    setState(() {
      userData;
    });
    if (userData.userdata.value.token != null) {
      Timer(const Duration(seconds: 3), () {
        Get.to(const HomePage());
      });
    } else {
      Get.to(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
        fontFamily: GoogleFonts.outfit().fontFamily,
      ),
      defaultTransition: Transition.fadeIn,
      home: const SplashScreenPage(),
    );
  }
}
