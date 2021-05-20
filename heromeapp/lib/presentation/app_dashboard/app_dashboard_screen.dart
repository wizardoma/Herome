import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';
import 'package:heromeapp/presentation/widgets/appscreen_appbar.dart';

class AppDashboardScreen extends StatelessWidget {
  final App app;

  AppDashboardScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(
      body: Center(
        child: Text("Dashboard"),
      ),
      appBarTitle: 'Dashboard',
    );
  }
}
