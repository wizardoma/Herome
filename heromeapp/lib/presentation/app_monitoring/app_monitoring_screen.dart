import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';

class AppMonitoringScreen extends StatelessWidget {

  final App app;
  AppMonitoringScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(body: Center(
      child: Text("Monitoring"),
    ), appBarTitle: 'Monitoring',

    );
  }


}