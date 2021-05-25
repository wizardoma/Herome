import 'package:dio/dio.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AppClient {

  final Dio _dio;

  AppClient(this._dio);

  Future<ResponseEntity> fetchApps() async{
    try {
      var response = await _dio.get(AppsUrl);

      List<App> apps = [];
      response.data.forEach((e) {
        App app = App.fromResponse(e);
        apps.add(app);

      });

      return ResponseEntity(false, apps, null);
    } on DioError catch (e) {
      print("Error in apps fetching: ${e.response}");
      var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }
}