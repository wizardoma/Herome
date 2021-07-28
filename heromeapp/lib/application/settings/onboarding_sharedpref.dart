import 'package:shared_preferences/shared_preferences.dart';

class OnboardingSharedPref {
  static const sharedPrefName = "onboarding";

  static void setState(bool value) async {
    await SharedPreferences.getInstance()
      ..setBool(sharedPrefName, value);
  }

  static void clear() async {
    await SharedPreferences.getInstance()
      ..remove(sharedPrefName);
  }

  static Future<bool> getState() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(sharedPrefName);
  }

}
