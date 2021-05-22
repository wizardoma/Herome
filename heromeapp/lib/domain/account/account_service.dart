import 'package:heromeapp/domain/response.dart';
import 'package:heromeapp/domain/service.dart';

abstract class AccountService extends Service{
  Future<ResponseEntity> fetchAccount();

}