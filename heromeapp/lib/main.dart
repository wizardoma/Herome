import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/activity/build_cubit.dart';
import 'package:heromeapp/application/addon/addon_cubit.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/settings/onboarding_sharedpref.dart';
import 'package:heromeapp/commons/app/routes.dart';
import 'package:heromeapp/commons/app/themes.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/ioc.dart';
import 'package:heromeapp/presentation/onboarding/onboarding_screen.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(AppAdapter());
  IOC ioc = IOC();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  var isOnboarded = await OnboardingSharedPref.getState() ?? false;
  runApp(MyApp(ioc: ioc, isOnboarded: isOnboarded,));
}

class MyApp extends StatefulWidget {
  final bool isOnboarded;

  final IOC ioc;

  MyApp({this.ioc, this.isOnboarded});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value:
            (widget.ioc.getBloc(Blocs.Authentication) as AuthenticationBloc)
              ..add(InitializeAuthEvent())),
        BlocProvider.value(
            value: (widget.ioc.getCubit(Cubits.Account) as AccountCubit)),
        BlocProvider.value(
            value: (widget.ioc.getCubit(Cubits.Apps) as AppsCubit)),
        BlocProvider.value(
            value: (widget.ioc.getCubit(Cubits.Dyno) as DynoCubit)),
        BlocProvider.value(
            value: (widget.ioc.getCubit(Cubits.Collab) as CollaboratorCubit)),
        BlocProvider.value(
            value: (widget.ioc.getCubit(Cubits.Build) as BuildCubit)),
        BlocProvider.value(
            value: (widget.ioc.getCubit(Cubits.Addon) as AddonCubit)),
      ],
      child: RefreshConfiguration(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: appRoutes,
          title: "Herome",
          home: (widget.isOnboarded == null || !widget.isOnboarded)
              ? OnboardingScreen()
              : SplashScreen(),
          theme: kMainTheme,
        ),
      ),
    );
  }
}
