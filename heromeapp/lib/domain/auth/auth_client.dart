import 'package:dio/dio.dart';
import 'package:heromeapp/commons/utils/api_response_util.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AuthClient {
  final Dio _dio;

  AuthClient(this._dio);

  Future<ResponseEntity> validateCredentials() async {
    try {
      var response = await _dio.get(AccountUrl);

      return ResponseEntity(false, null, null);
    } on DioError catch (e) {
      var errorResponse = ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }
}
