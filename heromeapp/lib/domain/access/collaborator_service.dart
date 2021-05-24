import 'package:heromeapp/domain/response.dart';
import 'package:heromeapp/domain/service.dart';

abstract class CollaboratorService extends Service {

  Future<ResponseEntity> fetchCollaborators(String appId);
  Future<ResponseEntity> deleteCollaborator(String appId, String userId);
  Future<ResponseEntity> addCollaborator(String appId, String userId);
}