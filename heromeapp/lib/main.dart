import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/domain/auth/auth_service_impl.dart';
import 'file:///C:/Users/Wizardom/PersonalProject/Herome/heromeapp/lib/commons/style/themes.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';

void main() {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> AuthenticationBloc(new HerokuAuthenticationService()),
      child: MaterialApp(
        title: "Herome",
        home: SplashScreen(),
        theme: kMainTheme,
      ),
    );
  }
}
