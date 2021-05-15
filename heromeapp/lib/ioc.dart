import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/domain/account/account_provider.dart';
import 'package:heromeapp/domain/account/account_service.dart';
import 'package:heromeapp/domain/account/account_service_impl.dart';
import 'package:heromeapp/domain/api/dio_config.dart';
import 'package:heromeapp/domain/auth/auth_provider.dart';
import 'package:heromeapp/domain/auth/auth_service.dart';
import 'package:heromeapp/domain/auth/auth_service_impl.dart';
import 'package:heromeapp/domain/auth/auth_store.dart';
import 'package:heromeapp/domain/service.dart';

// Custom inversion of control container
enum Cubits {
  Account
}

enum Blocs {
  Authentication
}

enum Services {
  Account, Authentication
}


class IOC {
  //services
  AuthenticationService _authenticationService;
  AccountService _accountService;

  // providers
  AuthProvider _authProvider;
  AccountProvider _accountProvider;

  // stores
  AuthStore _authStore;

  // blocs and cubit
  AuthenticationBloc _authenticationBloc;
  AccountCubit _accountCubit;

  Map<Blocs, Bloc> blocMap = {};
  Map<Cubits, Cubit> cubitMap = {};

  Map<Services, Service> serviceMap = {};

  Services servicesType;
  Blocs blocsType;
  Cubits cubitsType;


  IOC(){
    // stores

    _authStore = AuthStore();
    // providers

    _authProvider = AuthProvider(dio);
    _accountProvider = AccountProvider(dio);

    // services
    _authenticationService = HerokuAuthenticationService(_authProvider, _authStore);
    _accountService = HerokuAccountService(_accountProvider);

    //blocs
    _authenticationBloc = AuthenticationBloc(_authenticationService);
    _accountCubit = AccountCubit(authenticationBloc: _authenticationBloc,accountService: _accountService);

    blocMap.putIfAbsent(Blocs.Authentication, () => _authenticationBloc);
    cubitMap.putIfAbsent(Cubits.Account, () => _accountCubit);
    serviceMap.putIfAbsent(Services.Account, () => _accountService);
    serviceMap.putIfAbsent(Services.Authentication, () => _authenticationService);

  }

  Service getService(Services service){
   var serviceInstance = serviceMap[service];
   return serviceInstance;
  }

  Bloc getBloc(Blocs bloc){
    return blocMap[bloc];
  }

  Cubit getCubit(Cubits cubit){
    return cubitMap[cubit];
  }


}