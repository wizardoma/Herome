import 'package:heromeapp/domain/apps/app.dart';

abstract class AppRepository {

  Future<List<App>> fetchAllApps();
  void addAllApps(List<App> apps);

  Future<void> deleteStoredApps();
}