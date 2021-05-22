import 'package:heromeapp/domain/response.dart';
import 'package:heromeapp/domain/service.dart';

abstract class AddonService extends Service {
  Future<ResponseEntity> fetchAppAddons(String appId);
}