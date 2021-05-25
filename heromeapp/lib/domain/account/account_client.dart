import 'package:dio/dio.dart';
import 'package:heromeapp/domain/account/account.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

import '../error_response.dart';

class AccountClient {
  final Dio _dio;

  AccountClient(this._dio);

  Future<ResponseEntity> fetchAccounts() async{
    try {
      var response = await _dio.get(AccountUrl);

      return ResponseEntity(false, Account.fromResponse(response.data), null);
    } on DioError catch (e) {
      var errorResponse = e.response != null ? ErrorResponse.fromResponse(e.response.data): ErrorResponse(id: "", message: "");
      return ResponseEntity(true, null, errorResponse);
    }
  }
}