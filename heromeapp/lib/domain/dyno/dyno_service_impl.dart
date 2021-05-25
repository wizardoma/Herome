import 'package:heromeapp/domain/dyno/dyno_client.dart';
import 'package:heromeapp/domain/dyno/dyno_service.dart';
import 'package:heromeapp/domain/response.dart';

class DynoServiceImpl extends DynoService {
  final DynoClient dynoClient;

  DynoServiceImpl(this.dynoClient);

  @override
  Future<ResponseEntity> fetchAllAppsDynos(List<String> appIds) async {
    var response = await dynoClient.fetchAllAppsDyno(appIds);
    return response;
  }

  @override
  Future<ResponseEntity> fetchAppDyno(String id) async {
    var response = await dynoClient.fetchAppDyno(id);
    return response;
  }
}
