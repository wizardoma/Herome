import 'package:dio/dio.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AppProvider {

  final Dio _dio;

  AppProvider(this._dio);

  Future<ResponseEntity> fetchApps() async{
    try {
      var response = await _dio.get(AppsUrl);
      print("Success in apps fetching: ${response.data}");

      List<App> apps = [];
      response.data.forEach((e) {
        App app = App.fromResponse(e);
        apps.add(app);

      });

      return ResponseEntity(false, apps, null);
    } on DioError catch (e) {
      print("Error in apps fetching: ${e.response}");
      var errorResponse = ErrorResponse.fromResponse(e.response);
      return ResponseEntity(true, null, errorResponse);
    }
  }
}