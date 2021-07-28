abstract class AuthenticationState {}

class AuthenticatingState extends AuthenticationState{}
class NotAuthenticatedState extends AuthenticationState {}
class AuthenticatedState extends AuthenticationState {}
class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  AuthenticationErrorState(this.errorMessage);
}

class SignOutState extends NotAuthenticatedState {}

class AuthenticationUnInitializedState extends AuthenticationState {}

