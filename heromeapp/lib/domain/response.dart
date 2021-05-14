import 'package:heromeapp/domain/error_response.dart';

class ResponseEntity {
  final bool isError;
  final dynamic data;
  final ErrorResponse errors;

  ResponseEntity(this.isError, this.data, this.errors);
}