import 'package:heromeapp/application/authentication/login_request.dart';
import 'package:heromeapp/domain/auth/auth_client.dart';
import 'package:heromeapp/domain/auth/auth_store.dart';
import 'package:heromeapp/domain/auth/auth_service.dart';
import 'package:heromeapp/domain/response.dart';

class HerokuAuthenticationService extends AuthenticationService {
  final AuthStore _store;
  final AuthClient _authClient;

  HerokuAuthenticationService(this._authClient, this._store);
  @override
  Future<ResponseEntity> authenticate(LoginRequest request) async {
    _store.setToken("${request.email}:${request.password}");
    var response = await _authClient.validateCredentials();
    if (response.isError) {
      _store.deleteToken();
    }
    return response;
  }

  @override
  Future<bool> isAuthenticated() async {
    var token = await _store.getToken();
    var isAuthenticated = token != null && token.isNotEmpty;
    return isAuthenticated;
  }

  @override
  void logout() {
    _store.deleteToken();
  }


}