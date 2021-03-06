import 'package:heromeapp/domain/account/account_client.dart';
import 'package:heromeapp/domain/account/account_service.dart';
import 'package:heromeapp/domain/response.dart';

class HerokuAccountService extends AccountService {
  final AccountClient _accountProvider;

  HerokuAccountService(this._accountProvider);

  @override
  Future<ResponseEntity> fetchAccount() async {
    var response = await _accountProvider.fetchAccounts();
    return response;

  }
}
