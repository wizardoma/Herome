import 'package:flutter/material.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatefulWidget {
  static const routeName = "/app";

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currNavIndex = 0;
  App _app;

  @override
  void initState() {
    _app = context.read<AppsCubit>().getCurrentApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(appName: _app.name),
      bottomNavigationBar: getNavBar(),
      body: Text("Hello"),
    );
  }

  BottomNavigationBar getNavBar() {
    return BottomNavigationBar(
        currentIndex: _currNavIndex,
        onTap: (index) {
          setState(() {
            _currNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.multiline_chart), label: "Activity"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Metrics"),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: "Access"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ]);
  }
}
