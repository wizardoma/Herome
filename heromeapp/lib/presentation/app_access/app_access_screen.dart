import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';

class AppAccessScreen extends StatelessWidget {
  final App app;
AppAccessScreen(this.app);


@override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Access"),
    );
  }
}
