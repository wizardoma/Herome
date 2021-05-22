import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/activity/build_cubit.dart';
import 'package:heromeapp/application/addon/addon_cubit.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/domain/access/collaborator_provider.dart';
import 'package:heromeapp/domain/access/collaborator_service.dart';
import 'package:heromeapp/domain/access/collaborator_service_impl.dart';
import 'package:heromeapp/domain/account/account_provider.dart';
import 'package:heromeapp/domain/account/account_service.dart';
import 'package:heromeapp/domain/account/account_service_impl.dart';
import 'package:heromeapp/domain/activity/build_provider.dart';
import 'package:heromeapp/domain/activity/build_service.dart';
import 'package:heromeapp/domain/activity/build_service_impl.dart';
import 'package:heromeapp/domain/addon/addon_provider.dart';
import 'package:heromeapp/domain/addon/addon_service.dart';
import 'package:heromeapp/domain/addon/addon_service_impl.dart';
import 'package:heromeapp/domain/api/dio_config.dart';
import 'package:heromeapp/domain/apps/app_repository.dart';
import 'package:heromeapp/domain/apps/app_repository_impl.dart';
import 'package:heromeapp/domain/apps/app_service.dart';
import 'package:heromeapp/domain/apps/app_service_impl.dart';
import 'package:heromeapp/domain/apps/apps_provider.dart';
import 'package:heromeapp/domain/auth/auth_provider.dart';
import 'package:heromeapp/domain/auth/auth_service.dart';
import 'package:heromeapp/domain/auth/auth_service_impl.dart';
import 'package:heromeapp/domain/auth/auth_store.dart';
import 'package:heromeapp/domain/dyno/dyno_provider.dart';
import 'package:heromeapp/domain/dyno/dyno_service.dart';
import 'package:heromeapp/domain/dyno/dyno_service_impl.dart';
import 'package:heromeapp/domain/service.dart';

// Custom inversion of control container
enum Cubits { Account, Apps, Dyno , Collab, Build, Addon}

enum Blocs { Authentication }

enum Services { Account, Authentication, Apps, Dyno , Collab, Build}

class IOC {
  //services
  AuthenticationService _authenticationService;
  AddonService _addonService;
  DynoService _dynoService;
  AccountService _accountService;
  BuildService _buildService;
  AppService _appService;
  CollaboratorService _collaboratorService;

  // repos

  AppRepository _appRepository;
  // providers

  CollaboratorProvider _collaboratorProvider;
  AuthProvider _authProvider;
  AddonProvider _addonProvider;
  DynoProvider _dynoProvider;
  BuildProvider _buildProvider;
  AccountProvider _accountProvider;
  AppProvider _appProvider;

  // stores
  AuthStore _authStore;

  // blocs and cubit
  AuthenticationBloc _authenticationBloc;
  AccountCubit _accountCubit;
  AddonCubit _addonCubit;
  CollaboratorCubit _collaboratorCubit;
  DynoCubit _dynoCubit;
  BuildCubit _buildCubit;
  AppsCubit _appsCubit;

  Map<Blocs, Bloc> blocMap = {};
  Map<Cubits, Cubit> cubitMap = {};

  Map<Services, Service> serviceMap = {};

  Services servicesType;
  Blocs blocsType;
  Cubits cubitsType;

  IOC() {
    // stores

    _authStore = AuthStore();
    // providers

    _authProvider = AuthProvider(dio);
    _addonProvider = AddonProvider(dio);
    _dynoProvider = DynoProvider(dio);
    _accountProvider = AccountProvider(dio);
    _buildProvider = BuildProvider(dio);
    _appProvider = AppProvider(dio);
    _collaboratorProvider = CollaboratorProvider(dio);

    // repos
    _appRepository = AppRepositoryImpl();

    // services
    _authenticationService =
        HerokuAuthenticationService(_authProvider, _authStore);
    _accountService = HerokuAccountService(_accountProvider);
    _dynoService = DynoServiceImpl(_dynoProvider);
    _appService = AppServiceImpl(_appProvider,_appRepository);
    _collaboratorService = CollaboratorServiceImpl(_collaboratorProvider);
    _buildService = BuildServiceImpl(_buildProvider);
    _addonService = AddonServiceImpl(_addonProvider);

    //blocs
    _authenticationBloc = AuthenticationBloc(_authenticationService);
    _accountCubit = AccountCubit(
        authenticationBloc: _authenticationBloc,
        accountService: _accountService);
    _appsCubit = AppsCubit(_appService);
    _dynoCubit = DynoCubit(dynoService: _dynoService, appsCubit: _appsCubit);
    _collaboratorCubit = CollaboratorCubit(_collaboratorService);
    _addonCubit = AddonCubit(_addonService);
    _buildCubit = BuildCubit(_buildService);

    blocMap.putIfAbsent(Blocs.Authentication, () => _authenticationBloc);
    cubitMap.putIfAbsent(Cubits.Account, () => _accountCubit);
    cubitMap.putIfAbsent(Cubits.Apps, () => _appsCubit);
    cubitMap.putIfAbsent(Cubits.Collab, () => _collaboratorCubit);
    cubitMap.putIfAbsent(Cubits.Dyno, () => _dynoCubit);
    cubitMap.putIfAbsent(Cubits.Build, () => _buildCubit);
    cubitMap.putIfAbsent(Cubits.Addon, () => _addonCubit);


    serviceMap.putIfAbsent(Services.Account, () => _accountService);

    serviceMap.putIfAbsent(
        Services.Authentication, () => _authenticationService);
    serviceMap.putIfAbsent(Services.Apps, () => _appService);
    serviceMap.putIfAbsent(Services.Collab, () => _collaboratorService);
    serviceMap.putIfAbsent(Services.Dyno, () => _dynoService);
  }

  Service getService(Services service) {
    var serviceInstance = serviceMap[service];
    return serviceInstance;
  }

  Bloc getBloc(Blocs bloc) {
    return blocMap[bloc];
  }

  Cubit getCubit(Cubits cubit) {
    return cubitMap[cubit];
  }
}
