import 'package:heromeapp/domain/response.dart';
import 'package:heromeapp/domain/service.dart';

abstract class DynoService extends Service {

  Future<ResponseEntity> fetchAppDyno(String id);
  Future<ResponseEntity> fetchAllAppsDynos(List<String> appIds);
}