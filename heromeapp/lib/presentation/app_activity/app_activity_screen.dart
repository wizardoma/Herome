import 'package:flutter/material.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';

class AppActivityScreen extends StatelessWidget {

  final App app;
  AppActivityScreen(this.app);

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(body: Center(
      child: Text("Activity"),
    ), appBarTitle: 'Activity',

    );
  }


}