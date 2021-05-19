import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/presentation/app/app_screen.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';
import 'package:heromeapp/presentation/login/login_screen.dart';
import 'package:splashscreen/splashscreen.dart' as sp;
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return sp.SplashScreen(
      image: Image.asset("assets/logos/logo.jpg"),
      gradientBackground: LinearGradient(
        colors: [kPurpleColor, kDeepPurple1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      backgroundColor: kDeepPurple1,
      navigateAfterFuture: checkAuth().then((value) async {
        String screenName;
        if (value) {
          var appsCubit = context.read<AppsCubit>();
          var appList = appsCubit.getApps();
          if (appList == null) {
            appList = await appsCubit.fetchApps();
          }
          if (appList.length == 0){
          screenName = DashboardScreen.routeName; }
          else {
            screenName = AppScreen.routeName;
          }
        } else {
          screenName = LoginScreen.routeName;
        }
        return screenName;
      }),
    );
  }

  Future<bool> checkAuth() async {
    var authBloc = context.read<AuthenticationBloc>();

    if (authBloc.state is AuthenticationUnInitialized) {
      // Wait for authbloc to initialize authentication
      await Future.delayed(Duration(seconds: 2));
    }

    if (authBloc.state is Authenticated) {
      return true;
    }

    if (authBloc.state is AuthenticationError ||
        authBloc.state is NotAuthenticated) {
      return false;
    }
  }
}
