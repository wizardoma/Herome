import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/commons/app/routes.dart';
import 'package:heromeapp/commons/app/themes.dart';
import 'package:heromeapp/ioc.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  IOC ioc = IOC();
  runApp(MyApp(ioc));
}

class MyApp extends StatelessWidget {
  final IOC ioc;
  MyApp(this.ioc);

  @override
  Widget build(BuildContext context) {
    print(ioc.getBloc(Blocs.Authentication));
    print(ioc.getCubit(Cubits.Account));

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: (ioc.getBloc(Blocs.Authentication) as AuthenticationBloc)..add(InitializeAuthEvent())),
        BlocProvider.value(value: (ioc.getCubit(Cubits.Account) as AccountCubit)),
      ],
      child: MaterialApp(
        routes: appRoutes,
        title: "Herome",
        home: SplashScreen(),
        theme: kMainTheme,
      ),
    );
  }
}
