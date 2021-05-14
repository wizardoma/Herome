import 'package:dio/dio.dart';

class ErrorResponse {
  final String id;
  final String message;
  final String url;

  ErrorResponse({ this.id, this.message, this.url = ""});

  factory ErrorResponse.fromResponse(Response response){
    return ErrorResponse(
      id: response.data["id"],message: response.data["message"],url: response.data["url"]
    );
  }

}