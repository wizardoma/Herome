import 'package:dio/dio.dart';
import 'package:heromeapp/domain/access/collaborator.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/error_response.dart';
import 'package:heromeapp/domain/response.dart';

class CollaboratorClient {
  final Dio _dio;

  CollaboratorClient(this._dio);

  Future<ResponseEntity> addCollaborator(String appId, dynamic data) async{
    try {
      var response  = await _dio.post("$AppsUrl/$appId/collaborators", data: data);
      return ResponseEntity(false, null, null);
    }

    on DioError catch (e) {
      var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }

  Future<ResponseEntity> deleteCollaborator(String appId, String userId) async {
    try {
      var response = await _dio.delete("$AppsUrl/$appId/collaborators/$userId");
      return ResponseEntity(false, null, null);
    }

    on DioError catch (e) {
      var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
      return ResponseEntity(true, null, errorResponse);
    }
  }

Future<ResponseEntity> fetchCollaborators(String appId) async{
  try {
    var response = await _dio.get("$AppsUrl/$appId/collaborators");
    List<Collaborator> collabs = [];
    response.data.forEach((e) {
      Collaborator collab = Collaborator.fromResponse(e);
      collabs.add(collab);

    });

    return ResponseEntity(false, collabs, null);
  } on DioError catch (e) {
    var errorResponse = e.response == null ? ErrorResponse() :ErrorResponse.fromResponse(e.response.data);
    return ResponseEntity(true, null, errorResponse);
  }
}
}