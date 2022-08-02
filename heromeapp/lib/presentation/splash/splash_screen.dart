import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/application/settings/biometrics_sharedpref.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/presentation/app/app_screen.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';
import 'package:heromeapp/presentation/login/login_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:splashscreen/splashscreen.dart' as sp;

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var localAuth = LocalAuthentication();

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
      navigateAfterFuture: checkAuth().then((userIsAuthenticated) async {
        String destinationScreenName;

        if (userIsAuthenticated) {
          print("user is authenticated $userIsAuthenticated");

          // Check if user has biometric check before loading resources
          var isCheckBiometrics = await BiometricsSharedPref.getState();
          print("isCheckBiometrics $isCheckBiometrics");
          if (isCheckBiometrics != null && isCheckBiometrics) {
            var isBiometricsAuthenticated = await authenticateWithBiometrics();
            if (isBiometricsAuthenticated) {
              destinationScreenName = await bootStrapApp();
            }
          } else {
            destinationScreenName = await bootStrapApp();
          }
        } else {
          destinationScreenName = LoginScreen.routeName;
        }
        return destinationScreenName;
      }),
    );
  }

  Future<bool> checkAuth() async {
    var authBloc = context.read<AuthenticationBloc>();
    var isAuth = await authBloc.tryAuthentication();
    if (isAuth is AuthenticatedState) {
      return true;
    } else if (isAuth is NotAuthenticatedState) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    var authenticated = await localAuth.authenticate(
        options: AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
        localizedReason: 'Unlock');
    return authenticated ? authenticated : authenticateWithBiometrics();
  }

  Future<String> bootStrapApp() async {
    var appsCubit = context.read<AppsCubit>();
    bool appsWereStoredOnLastLogin = await appsCubit.areAppsCached();

    // if apps are already cached, navigate directly to appScreen
    if (appsWereStoredOnLastLogin) {
      return AppScreen.routeName;
    } else {
      var appList = appsCubit.getApps();
      if (appList == null) {
        appList = await appsCubit.fetchApps();
      }
      if (appList.length == 0) {
        return DashboardScreen.routeName;
      } else {
        return AppScreen.routeName;
      }
    }
  }
}
