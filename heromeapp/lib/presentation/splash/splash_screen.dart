import 'package:flutter/material.dart';
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
      seconds: 1,
      title: Text("My SplashScreen"),
      backgroundColor: Theme.of(context).primaryColor,
      navigateAfterSeconds: LoginScreen(),
    );
  }
}
