import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthStore {
  static const String prefName = "cred";
  String _token;

  String get token  {
    return _token;
  }

  void setToken(String credentials) async {
    var pref = await SharedPreferences.getInstance();
    var token = base64.encode(utf8.encode(credentials));
    pref.setString(prefName, token);
    this._token = token;
  }

  Future<String> getToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(prefName);
  }
}
