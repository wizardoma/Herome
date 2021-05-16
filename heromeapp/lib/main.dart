import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
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

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: (ioc.getBloc(Blocs.Authentication) as AuthenticationBloc)
              ..add(InitializeAuthEvent())),
        BlocProvider.value(
            value: (ioc.getCubit(Cubits.Account) as AccountCubit)),
        BlocProvider.value(value: (ioc.getCubit(Cubits.Apps) as AppsCubit)),
        BlocProvider.value(value: (ioc.getCubit(Cubits.Dyno) as DynoCubit)),
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
