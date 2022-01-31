

import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:fedis/modules/login_screen/login_screen.dart';

import 'package:flutter/material.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/Fedis-Logo.png',
      nextScreen: LoginScreen(),
      backgroundColor: Colors.white,
      duration: 2000,
      animationDuration: Duration(seconds: 2),
    );
  }
}
