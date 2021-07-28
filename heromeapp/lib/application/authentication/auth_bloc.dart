import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/application/authentication/login_request.dart';
import 'package:heromeapp/domain/auth/auth_service.dart';

import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;

  AuthenticationBloc(this.authenticationService)
      : super(AuthenticationUnInitializedState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is InitializeAuthEvent) {
      yield await tryAuthentication();
    }
    if (event is LoginEvent) {
      yield AuthenticatingState();
      yield await login(event.loginRequest);
    }

    if (event is LogoutEvent) {
      yield logout();
    }
  }

  AuthenticationState logout() {
    authenticationService.logout();
    return NotAuthenticatedState();
  }

  Future<AuthenticationState> tryAuthentication() async {
    var authenticated = await isAuthenticated();

    if (!authenticated) {
      return NotAuthenticatedState();
    } else {
      return AuthenticatedState();
    }
  }

  Future<AuthenticationState> login(LoginRequest loginRequest) async {
    var response = await authenticationService.authenticate(loginRequest);
    if (!response.isError) {
      return AuthenticatedState();
    } else {
      return AuthenticationErrorState(response.errors.message);
    }
  }

  Future<bool> isAuthenticated() async {
    var authenticated = await authenticationService.isAuthenticated();
    return authenticated;
  }
}
