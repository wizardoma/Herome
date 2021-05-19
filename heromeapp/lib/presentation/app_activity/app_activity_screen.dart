import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';

class AppActivityScreen extends StatelessWidget {

  final App app;
  AppActivityScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Activity"),
    );
  }

}