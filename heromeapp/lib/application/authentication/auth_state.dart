abstract class AuthenticationState {}

class Authenticating extends AuthenticationState{}
class Authenticated extends AuthenticationState {}
class AuthenticationError extends AuthenticationState {
  final String errorMessage;

  AuthenticationError(this.errorMessage);
}