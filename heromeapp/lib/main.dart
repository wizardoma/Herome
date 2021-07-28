import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/activity/build_cubit.dart';
import 'package:heromeapp/application/addon/addon_cubit.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/settings/biometrics_cubit.dart';
import 'package:heromeapp/commons/app/routes.dart';
import 'package:heromeapp/commons/app/themes.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/ioc.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(AppAdapter());
  var pref = await SharedPreferences.getInstance();
  bool isBiometrics = pref.getBool(BiometricsCubit.sharedPrefName) ?? false;
  IOC ioc = IOC();
  runApp(MyApp(ioc,isBiometrics));
}

class MyApp extends StatelessWidget {
  final IOC ioc;
  final bool isBiometrics;

  MyApp(this.ioc, this.isBiometrics);

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
        BlocProvider.value(
            value: (ioc.getCubit(Cubits.Collab) as CollaboratorCubit)),
        BlocProvider.value(value: (ioc.getCubit(Cubits.Build) as BuildCubit)),
        BlocProvider.value(value: (ioc.getCubit(Cubits.Addon) as AddonCubit)),
        BlocProvider(create: (_) => BiometricsCubit(isBiometrics),)
      ],
      child: RefreshConfiguration(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: appRoutes,
          title: "Herome",
          home:  SplashScreen(),
          theme: kMainTheme,
        ),
      ),
    );
  }
}
