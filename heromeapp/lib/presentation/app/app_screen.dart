import 'package:flutter/material.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/app_access/app_access_screen.dart';
import 'package:heromeapp/presentation/app_activity/app_activity_screen.dart';
import 'package:heromeapp/presentation/app_dashboard/app_dashboard_screen.dart';
import 'package:heromeapp/presentation/app_monitoring/app_monitoring_screen.dart';
import 'package:heromeapp/presentation/app_resources/app_resources_screen.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AppScreen extends StatefulWidget {
  static const routeName = "/app";

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currNavIndex = 0;
  App _app;
  List<Widget> _children;

  @override
  void initState() {
    _app = context.read<AppsCubit>().getCurrentApp();
    _children = [
      AppDashboardScreen(_app),
      AppResourcesScreen(_app),
      AppMonitoringScreen(_app),
      AppActivityScreen(_app),
      AppAccessScreen(_app),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        appName: _app.name,
        openApp: _openApp,
      ),
      bottomNavigationBar: getNavBar(),
      body: _children[_currNavIndex],
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
              icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined), label: "Resources"),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined), label: "Monitoring"),
          BottomNavigationBarItem(
              icon: Icon(Icons.multiline_chart), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: "Access"),
        ]);
  }

  void _openApp() async {
    if (await canLaunch(_app.webUrl)) {
      await launch(
        _app.webUrl,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error, Could not launch app"),
        ),
      );
    }
  }
}
