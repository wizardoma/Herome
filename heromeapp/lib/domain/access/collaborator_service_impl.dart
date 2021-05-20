import 'package:heromeapp/domain/access/collaborator_provider.dart';
import 'package:heromeapp/domain/access/collaborator_service.dart';
import 'package:heromeapp/domain/response.dart';

class CollaboratorServiceImpl extends CollaboratorService {
  final CollaboratorProvider collaboratorProvider;

  CollaboratorServiceImpl(this.collaboratorProvider);

  @override
  Future<ResponseEntity> fetchCollaborators(String appId) async {
    var response = await collaboratorProvider.fetchCollaborators(appId);
    return response;
  }
}
