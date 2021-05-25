import 'package:flutter/material.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/app_access/app_access_screen.dart';
import 'package:heromeapp/presentation/app_activity/app_activity_screen.dart';
import 'package:heromeapp/presentation/app_dashboard/app_dashboard_screen.dart';
import 'package:heromeapp/presentation/app_monitoring/app_monitoring_screen.dart';
import 'package:heromeapp/presentation/app_resources/app_resources_screen.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';
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
        onOpenProfile: openMenu,
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
        selectedFontSize: 11,
        unselectedFontSize: 11,
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

  void openMenu() {
    var account = context.read<AccountCubit>().getAccount();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
//              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.black87,
                                    ),
                                    onPressed: () => Navigator.pop(context))),
                            Flexible(
                                child: Text(
                              "Herome",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 20),
                            )),
                            Flexible(
                                child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/ninja-avatar.png",
                                ),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          title: Text(
                            account.name,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(account.email),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: kInputBorderColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.settings_outlined,
                            color: kDarkTextColor,
                          ),
                          title: Text("App Settings"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.feedback_outlined,
                            color: kDarkTextColor,
                          ),
                          title: Text("Feedback"),
                        ),
                        ListTile(
                          onTap: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(LogoutEvent());
                            Navigator.pushNamedAndRemoveUntil(context,
                                SplashScreen.routeName, (route) => false);
                          },
                          leading: Icon(
                            Icons.logout,
                            color: kDarkTextColor,
                          ),
                          title: Text("Sign out"),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: kInputBorderColor,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: _buyMeACoffee,
                            child: Text(
                              "Buy me a coffee",
                              style: TextStyle(color: kDarkTextColor),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 18),
                          ),
                          TextButton(
                              onPressed: _openAbout,
                              child: Text("About Herome",
                                  style: TextStyle(color: kDarkTextColor))),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _buyMeACoffee() {}

  void _openAbout() {
    showAboutDialog(
      context: context,
      applicationName: "Herome for Heroku",
      applicationVersion: "0.0.1",
    );
  }
}
