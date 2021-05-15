import 'package:dio/dio.dart';
import 'package:heromeapp/domain/account/account.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AccountProvider {
  final Dio _dio;

  AccountProvider(this._dio);

  Future<ResponseEntity> fetchAccounts() async{
    try {
      var response = await _dio.get(AccountUrl);

      return ResponseEntity(false, Account.fromResponse(response.data), null);
    } on DioError catch (e) {
      var errorResponse = ErrorResponse.fromResponse(e.response);
      return ResponseEntity(true, null, errorResponse);
    }
  }
}