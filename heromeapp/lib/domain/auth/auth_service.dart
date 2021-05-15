import 'package:heromeapp/application/authentication/login_request.dart';
import 'package:heromeapp/domain/service.dart';

import '../response.dart';

abstract class AuthenticationService extends Service {
  Future<ResponseEntity> authenticate(LoginRequest request);
  Future<bool> isAuthenticated();




}