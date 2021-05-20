import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';

class AppSettingsScreen extends StatelessWidget {

  final App app;
  AppSettingsScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(body: Center(
      child: Text("Settings"),
    ), appBarTitle: 'Settings',

    );
  }


}