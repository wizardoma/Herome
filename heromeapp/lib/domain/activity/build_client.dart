import 'package:dio/dio.dart';
import 'package:heromeapp/domain/activity/build.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class BuildClient {
  final Dio dio;

  BuildClient(this.dio);

  Future<ResponseEntity> fetchBuilds(String appId) async {
    try {
      var response = await dio.get("$AppsUrl/$appId/builds", options: Options(
        headers: {"Range": "created_at; order=desc, max = 10"}
      ));
      // filter only builds with valid release id to remove unnecessary data
      List<dynamic> filteredData = response.data.where((e) => e["release"] !=null
      ).toList();
      return ResponseEntity(false, filteredData, null);
    } on DioError catch (e) {
      var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }

}