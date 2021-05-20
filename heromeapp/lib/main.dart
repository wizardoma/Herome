import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/commons/app/routes.dart';
import 'package:heromeapp/commons/app/themes.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/ioc.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(AppAdapter());
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
        BlocProvider.value(value: (ioc.getCubit(Cubits.Collab) as CollaboratorCubit)),

      ],
      child: RefreshConfiguration(

        child: MaterialApp(
          routes: appRoutes,
          title: "Herome",
          home: SplashScreen(),
          theme: kMainTheme,
        ),
      ),
    );
  }
}
