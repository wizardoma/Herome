import 'package:heromeapp/domain/account/account.dart';

abstract class AccountState {}

class AccountUnInitializedState extends AccountState {}
class AccountFetchedState extends AccountState {
  final Account account;

  AccountFetchedState(this.account);
}