import 'package:heromeapp/application/authentication/login_request.dart';

abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final LoginRequest loginRequest;

  LoginEvent(this.loginRequest);
}

class LogoutEvent extends AuthenticationEvent {}

class InitializeAuthEvent extends AuthenticationEvent {}