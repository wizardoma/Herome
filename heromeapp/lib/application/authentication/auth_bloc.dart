import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationState initialState) : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}