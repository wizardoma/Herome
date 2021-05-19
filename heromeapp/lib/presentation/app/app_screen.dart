import 'package:flutter/material.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_appbar.dart';

class AppScreen extends StatefulWidget {
  static const routeName = "/app";

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currNavIndex,
        onTap: (index){setState(() {
          _currNavIndex = index;
        });},
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.multiline_chart), label: "Activity"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Metrics"),
            BottomNavigationBarItem(icon: Icon(Icons.security), label: "Access"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),


          ]),
      body: Text("Hello"),

    );
  }
}
