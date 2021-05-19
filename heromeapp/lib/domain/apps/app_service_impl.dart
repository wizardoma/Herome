import 'package:heromeapp/domain/apps/app_service.dart';
import 'package:heromeapp/domain/apps/apps_provider.dart';
import 'package:heromeapp/domain/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceImpl extends AppService {
  final String prefName = "currentAppId";

  final AppProvider appProvider;

  AppServiceImpl(this.appProvider);

  @override
  Future<ResponseEntity> fetchApps() async {
    var response = await appProvider.fetchApps();
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
}
