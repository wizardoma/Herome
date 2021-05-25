import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/settings/biometrics_cubit.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isBiometrics;

  @override
  void initState() {
    isBiometrics = BlocProvider.of<BiometricsCubit>(context).state;
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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  void _onChange(bool value) {
    var biometricsCubit = context.read<BiometricsCubit>();
    biometricsCubit.setState(value);
    setState(() {
      isBiometrics = biometricsCubit.state;
    });
  }
}
