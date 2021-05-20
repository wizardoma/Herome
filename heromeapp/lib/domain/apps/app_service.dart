import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/response.dart';
import 'package:heromeapp/domain/service.dart';

abstract class AppService extends Service {

  Future<ResponseEntity> fetchApps();
  Future<List<App>> fetchStoredApps();
  Future<String> fetchCurrentAppId();
  void storeCurrentAppId(String id);
}