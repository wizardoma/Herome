import 'package:dio/dio.dart';

class ErrorResponse {
  final String id;
  final String message;
  final String url;

  ErrorResponse({ this.id, this.message, this.url = ""});

  factory ErrorResponse.fromResponse(dynamic data){
    return ErrorResponse(
      id: data["id"],message: data["message"],url: data["url"]
    );
  }

}