import 'dart:convert';

import 'package:heromeapp/domain/access/collaborator_client.dart';
import 'package:heromeapp/domain/access/collaborator_service.dart';
import 'package:heromeapp/domain/response.dart';

class CollaboratorServiceImpl extends CollaboratorService {
  final CollaboratorClient collaboratorClient;

  CollaboratorServiceImpl(this.collaboratorClient);

  @override
  Future<ResponseEntity> fetchCollaborators(String appId) async {
    var response = await collaboratorClient.fetchCollaborators(appId);
    return response;
  }

  @override
  Future<ResponseEntity> addCollaborator(String appId, String userId) async {
    // use silent to send an email to the user
    Map<String, dynamic> data = {"user": "$userId", "silent": "false"};
    var response =
        await collaboratorClient.addCollaborator(appId, jsonEncode(data));
    return response;
  }

  @override
  Future<ResponseEntity> deleteCollaborator(String appId, String userId) async {
    var response = await collaboratorClient.deleteCollaborator(appId, userId);
    return response;
  }
}
