import 'package:heromeapp/application/authentication/login_request.dart';

import '../response.dart';

abstract class AuthenticationService {
  Future<Response> authenticate(LoginRequest request);

}