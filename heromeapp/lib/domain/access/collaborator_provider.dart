import 'package:dio/dio.dart';
import 'package:heromeapp/domain/access/collaborator.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class CollaboratorProvider {
  final Dio _dio;

  CollaboratorProvider(this._dio);

Future<ResponseEntity> fetchCollaborators(String appId) async{
  try {
    var response = await _dio.get("$AppsUrl/$appId/collaborators");
    print("Response from collabs ${response.data}");
    List<Collaborator> collabs = [];
    response.data.forEach((e) {
      Collaborator collab = Collaborator.fromResponse(e);
      collabs.add(collab);

    });

    return ResponseEntity(false, collabs, null);
  } on DioError catch (e) {
    print("Error in collabs fetching: ${e.response}");
    var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
    return ResponseEntity(true, null, errorResponse);
  }
}
}