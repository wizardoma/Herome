class ErrorResponse {
  final bool isError;
  final String id;
  final String message;
  final String url;

  ErrorResponse({this.isError, this.id, this.message, this.url = ""});

}