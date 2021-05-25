import 'package:dio/dio.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/dyno/dyno.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class DynoClient {
  final Dio dio;

  DynoClient(this.dio);

  Future<ResponseEntity> fetchAppDyno(String id) async {
    try {
      var response = await dio.get("$AppsUrl/$id/dynos");

      List<Dyno> dynos = [];
      response.data.forEach((e) {
        Dyno dyno = Dyno.fromResponse(e);
        dynos.add(dyno);
      });

      return ResponseEntity(false, dynos, null);
    } on DioError catch (e) {
      print("Error in dynos fetching: ${e.response}");
      var errorResponse = ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }

  Future<ResponseEntity> fetchAllAppsDyno(List<String> appIds) async {
    Map<String, List<Dyno>> dynos = {};
    // increment counter for every dyno retrieval and only return response when all dynos are retrieved
    int counter = 0;
    appIds.forEach((appID) async {
      try {
        var response = await dio.get("$AppsUrl/$appID/dynos");
        List<Dyno> dynoList = [];

        response.data.forEach((e) {
          var dyno = Dyno.fromResponse(e);
          dynoList.add(dyno);
          ++counter;
        });
        dynos.putIfAbsent(appID, () => dynoList);
      } on DioError catch (e) {
        print("Error in dyno fetching: ${e.response}");
      }
    });

    // wait until all dynos are fetched
    while (counter != appIds.length){
      await Future.delayed(Duration(milliseconds: 500));
    }

    return ResponseEntity(false, dynos, null);

  }
}
