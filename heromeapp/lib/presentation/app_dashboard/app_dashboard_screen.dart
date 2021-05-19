import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';

class AppDashboardScreen extends StatelessWidget {
  final App app;
  AppDashboardScreen(this.app);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Dashboard"),
    );
  }

}