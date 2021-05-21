import 'package:heromeapp/domain/response.dart';
import 'package:heromeapp/domain/service.dart';

abstract class BuildService extends Service {

  Future<ResponseEntity> fetchBuilds(String appId);
}