import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/apps/app_repository.dart';
import 'package:heromeapp/domain/apps/app_service.dart';
import 'package:heromeapp/domain/apps/apps_client.dart';
import 'package:heromeapp/domain/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceImpl extends AppService {
  final String prefName = "currentAppId";

  final AppClient appClient;
  final AppRepository appRepository;

  AppServiceImpl(this.appClient, this.appRepository);

  @override
  Future<ResponseEntity> fetchApps() async {
    var response = await appClient.fetchApps();
    if (!response.isError) {
      appRepository.addAllApps(response.data);
    }
    return response;
//    return Future.value(ResponseEntity(false, [], null));
  }

  @override
  Future<String> fetchCurrentAppId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(prefName);
  }

  @override
  void storeCurrentAppId(String id) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(prefName, id);
  }

  @override
  Future<List<App>> fetchStoredApps() async {
    var apps = await appRepository.fetchAllApps();
    return apps;
  }
}
