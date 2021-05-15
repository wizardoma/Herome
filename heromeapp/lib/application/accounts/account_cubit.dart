
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_state.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_state.dart';
import 'package:heromeapp/domain/account/account.dart';
import 'package:heromeapp/domain/account/account_service.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountService accountService;
  StreamSubscription _streamSubscription;

  AccountCubit({AuthenticationBloc authenticationBloc, this.accountService})
      : super(AccountUnInitializedState()) {
    _streamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Authenticated) {
        this.fetchAccount();
      }
    });
  }

  void fetchAccount() async {
    var response = await accountService.fetchAccount();
    if (!response.isError) {
      Account account = response.data;
      emit(AccountFetchedState(account));
    }
    else {
      print("An error occurred fetching accounts");
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
