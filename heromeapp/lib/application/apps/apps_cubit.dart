import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/apps/app_service.dart';

class AppsCubit extends Cubit<AppsState> {
  final AppService appService;
  List<App> _apps;
  App _currentApp;

  AppsCubit(this.appService) : super(AppsNotInitialized());

  Future<bool> areAppsCached() async {
    var apps = await appService.fetchStoredApps();
    if (apps != null && apps.length > 0) {
      _apps = apps;
      emit(AppsFetchedState(_apps));
      var id = await _getCurrentAppId();
      _currentApp = apps.firstWhere((element) => element.id == id);
      return true;
    }

    return false;
  }

  Future<List<App>> fetchApps() async {
    emit(AppsFetchingState());

    var response = await appService.fetchApps();
    if (!response.isError) {
      var data = response.data as List;
      if (data.isEmpty) {
        _apps = [];
        emit(AppsFetchedState([]));
      } else {
        _apps = response.data;
        fetchCurrentApp();
        emit(AppsFetchedState(data));
      }

      return _apps;
    } else {
    }
  }

  void storeCurrentAppId(String id) {
    appService.storeCurrentAppId(id);
    _currentApp = _apps.firstWhere((element) => element.id == id);
  }

  Future<App> fetchCurrentApp() async {
    if (_currentApp == null) {
      var appId = await _getCurrentAppId();
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

  List<App> getApps() {
    return _apps;
  }

  Future<String> _getCurrentAppId() async {
    var appId = await appService.fetchCurrentAppId();
    return appId;
  }
}
