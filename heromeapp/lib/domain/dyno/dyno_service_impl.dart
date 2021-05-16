import 'package:heromeapp/domain/dyno/dyno_provider.dart';
import 'package:heromeapp/domain/dyno/dyno_service.dart';
import 'package:heromeapp/domain/response.dart';

class DynoServiceImpl extends DynoService {
  final DynoProvider dynoProvider;

  DynoServiceImpl(this.dynoProvider);

  @override
  Future<ResponseEntity> fetchAllAppsDynos(List<String> appIds) async {
    var response = await dynoProvider.fetchAllAppsDyno(appIds);
    return response;
  }

  @override
  Future<ResponseEntity> fetchAppDyno(String id) async {
    var response = await dynoProvider.fetchAppDyno(id);
    return response;
  }
}
