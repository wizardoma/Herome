import 'package:flutter/material.dart';
import 'package:heromeapp/commons/colors.dart';
import 'package:heromeapp/presentation/login/login_screen.dart';
import 'package:splashscreen/splashscreen.dart' as sp;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return sp.SplashScreen(
      seconds: 3,
      image: Image.asset("assets/logos/logo.jpg"),
      gradientBackground: LinearGradient(
        colors: [kPrimaryColor, kDeepPurple1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,

      ),
      backgroundColor: kDeepPurple1,
      navigateAfterSeconds: LoginScreen(),
    );
  }
}
