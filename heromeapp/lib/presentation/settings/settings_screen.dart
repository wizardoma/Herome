import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/settings/biometrics_sharedpref.dart';
import 'package:heromeapp/commons/app/ui_helpers.dart';
import 'package:local_auth/local_auth.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isBiometrics;
  var localAuth = LocalAuthentication();

  @override
  void initState() {
    BiometricsSharedPref.getState().then(
      (value) => isBiometrics = value?? false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListTile(
          leading: Icon(Icons.lock),
          title: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: defaultSpacing * 0.5,
            ),
            child: Text(
              "Biometrics Lock",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          subtitle: Text(
              "Require device biometrics credentials when launching the app"),
          trailing: Switch(
            value: isBiometrics,
            onChanged: _onChange,
          ),
        ),
      ),
    );
  }

  void _onChange(bool value) async {
    if (!await localAuth.canCheckBiometrics) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Your device does not support biometrics at this time"),
        ),
      );
    }
    BiometricsSharedPref.setState(value);
    var bio = await BiometricsSharedPref.getState();
    setState(() {
      isBiometrics = bio;
    });
  }
}
