import 'package:fedis/modules/login_screen/login_screen.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          SplashScreenView(
            navigateRoute: LoginScreen(),
            imageSize: 100,
            imageSrc: "assets/images/Fedis-Logo.png",
          ),
           const Center(child: Padding(
             padding:  EdgeInsets.only(top: 200),
             child: CircularProgressIndicator(color: defaultColor,),
           )),
        ],
      );

  }
}
