import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/application/authentication/login_request.dart';
import 'package:heromeapp/domain/auth/auth_service.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  AuthenticationBloc(this.authenticationService) : super(AuthenticationError(""));

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if (event is LoginEvent) {
      yield Authenticating();
      yield await Future.delayed(Duration(seconds: 2));
      yield await login(event.loginRequest);
    }
  }

  Future<AuthenticationState> login(LoginRequest loginRequest)async {
    var response =await authenticationService.authenticate(loginRequest);
    if (!response.isError){
      return Authenticated();
    }

    else {
      return AuthenticationError(response.errors.message);

    }

  }
}