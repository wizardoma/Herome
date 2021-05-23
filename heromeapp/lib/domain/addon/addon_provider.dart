import 'package:dio/dio.dart';
import 'package:heromeapp/domain/addon/addon.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AddonProvider {
  final Dio dio;

  AddonProvider(this.dio);

  Future<ResponseEntity> fetchAppAddons(String appId)async {
    try {
      var response = await dio.get("$AppsUrl/$appId/addons",);
      List<Addon> addons = [];
      response.data.forEach((e) {
        print("from response  ${e}");

        var addon = Addon.fromResponse(e);
        addons.add(addon);
      });

      return ResponseEntity(false, addons, null);
    } on DioError catch (e) {
      print("Error in addons fetching: ${e.response}");
      var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }

}