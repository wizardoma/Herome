import 'dart:convert';

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

  @override
  Future<ResponseEntity> addCollaborator(String appId, String userId) async {
    // use silent to send an email to the user
    Map<String, dynamic> data = {"user": "$userId", "silent": "false"};
    var response =
        await collaboratorProvider.addCollaborator(appId, jsonEncode(data));
    return response;
  }

  @override
  Future<ResponseEntity> deleteCollaborator(String appId, String userId) async {
    var response = await collaboratorProvider.deleteCollaborator(appId, userId);
    return response;
  }
}
