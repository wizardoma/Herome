import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';

class AppSettingsScreen extends StatelessWidget {

  final App app;
  AppSettingsScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Settings"),
    );
  }

}