import 'package:dio/dio.dart';
import 'package:heromeapp/domain/addon/addon.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class AddonClient {
  final Dio dio;

  AddonClient(this.dio);

  Future<ResponseEntity> fetchAppAddons(String appId) async {
    try {
      var response = await dio.get(
        "$AppsUrl/$appId/addons",
      );
      List<Addon> addons = [];
      response.data.forEach((e) {
        var addon = Addon.fromResponse(e);
        addons.add(addon);
      });

      return ResponseEntity(false, addons, null);
    } on DioError catch (e) {
      var errorResponse = e.response == null
          ? ErrorResponse()
          : ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }
}
