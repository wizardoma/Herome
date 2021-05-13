import 'package:heromeapp/domain/error_response.dart';

class Response {
  final bool isError;
  final dynamic data;
  final ErrorResponse errors;

  Response(this.isError, this.data, this.errors);
}