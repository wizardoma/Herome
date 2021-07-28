import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heromeapp/application/settings/onboarding_sharedpref.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/commons/app/ui_helpers.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static String routeName = "/onboarding";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Text(
            "Herome for Heroku",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          body: "All your Heroku apps on your mobile device",
          image: Image.asset(
            "assets/logos/mobile.png",
            width: 300,
            height: 300,
          ),
        ),
        PageViewModel(
          title: "Visualize Activities",
          body: "See all your Recent Heroku App Activities",
          image: Image.asset(
            "assets/logos/monitor.png",
            width: 300,
            height: 300,
          ),
        ),
        PageViewModel(
          title: "Billings",
          body: "Manage your heroku app billings in your dashboard",
          image: Image.asset(
            "assets/logos/billing.png",
            width: 300,
            height: 300,
          ),
        ),
      ],
      done: Text(
        "Done",
        style: TextStyle(
          color: kPurpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      showSkipButton: true,
      showNextButton: true,
      showDoneButton: true,
      next: Text(
        "Next",
        style: TextStyle(
          color: kPurpleColor,
        ),
      ),
      skip: Text(
        "Skip",
        style: TextStyle(
          color: kPurpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: kPurpleColor,
        spacing: EdgeInsets.all(defaultSpacing),
      ),
      onSkip: onFinishOnboarding,
      onDone: onFinishOnboarding,
    );
  }

  void onFinishOnboarding() {
    OnboardingSharedPref.setState(true);
    pushToAuthScreen();
  }

  void pushToAuthScreen() {
    Navigator.pushNamed(context, SplashScreen.routeName);
  }
}
