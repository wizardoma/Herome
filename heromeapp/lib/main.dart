import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/commons/app/routes.dart';
import 'package:heromeapp/commons/app/themes.dart';
import 'package:heromeapp/domain/api/dio_config.dart';
import 'package:heromeapp/domain/auth/auth_provider.dart';
import 'package:heromeapp/domain/auth/auth_service_impl.dart';
import 'package:heromeapp/domain/auth/auth_store.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(
          new HerokuAuthenticationService(AuthProvider(dio), AuthStore()))..add(InitializeAuthEvent()),
      child: MaterialApp(
        routes: appRoutes,
        title: "Herome",
        home: SplashScreen(),
        theme: kMainTheme,
      ),
    );
  }
}
