import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricsCubit extends Cubit<bool> {
  BiometricsCubit(bool isBiometrics) : super(isBiometrics);
  static const sharedPrefName = "biometrics";

  void setState(bool state) {
    print("saving to pref $state");
    saveToPref(state);
    emit(state);
  }

  saveToPref(state) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(sharedPrefName, state);
  }
}
