import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';

class AppMetricScreen extends StatelessWidget {

  final App app;
  AppMetricScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Metrics"),
    );
  }

}