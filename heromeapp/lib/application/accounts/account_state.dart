import 'package:heromeapp/domain/account/account.dart';

abstract class AccountState {}

class AccountUnInitialized extends AccountState {}
class AccountFetched extends AccountState {
  final Account account;

  AccountFetched(this.account);
}