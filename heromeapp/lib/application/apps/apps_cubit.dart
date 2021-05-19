import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/apps/app_service.dart';

class AppsCubit extends Cubit<AppsState> {
  final AppService appService;
  List<App> _apps;
  App _currentApp;

  AppsCubit(this.appService) : super(AppsNotInitialized());

  Future<List<App>> fetchApps() async {
    print("fetching apps");
    emit(AppsFetchingState());

    var response = await appService.fetchApps();
    if (!response.isError) {
      var data = response.data as List;
      if (data.isEmpty) {
        _apps = [];
        emit(AppsFetchedState([]));
      } else {
        _apps = response.data;
        fetchCurrentAppId();
        emit(AppsFetchedState(data));
      }

      return _apps;
    } else {
      print("Apps fetching not successful");
    }
  }

  void storeCurrentAppId(String id) {
    appService.storeCurrentAppId(id);
    _currentApp = _apps.firstWhere((element) => element.id == id);
  }

  Future<App> fetchCurrentAppId() async {
    if (_currentApp == null) {
      var appId = await _getAppId();
      if (appId == null) {
        appId = _apps[0].id;
      }
      var app = _apps.firstWhere((element) => element.id == appId);
      _currentApp = app;
      storeCurrentAppId(app.id);
      return app;
    } else {
      return _currentApp;
    }
  }

  App getCurrentApp() {
    return _currentApp;
  }

  List<App> getApps(){
    return _apps;
  }

  Future<String> _getAppId() async {
    var appId = await appService.fetchCurrentAppId();
    return appId;
  }
}
