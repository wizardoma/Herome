import 'package:flutter/material.dart';
import 'package:heromeapp/presentation/app/app_screen.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';
import 'package:heromeapp/presentation/login/login_screen.dart';
import 'package:heromeapp/presentation/settings/settings_screen.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  DashboardScreen.routeName: (_) => DashboardScreen(),
  LoginScreen.routeName: (_) => LoginScreen(),
  AppScreen.routeName: (_) => AppScreen(),
  SettingsScreen.routeName: (_) => SettingsScreen(),
  SplashScreen.routeName: (_) => SplashScreen(),
};
