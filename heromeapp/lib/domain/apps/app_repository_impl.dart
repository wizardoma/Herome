import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/apps/app_repository.dart';
import 'package:hive/hive.dart';

class AppRepositoryImpl extends AppRepository {
  final String _boxName = "appsBox";
  @override
  Future<void> addAllApps(List<App> apps) async {
    var appsBox = await Hive.openBox(_boxName);
    appsBox.addAll(apps);
  }

  @override
  Future<List<App>> fetchAllApps()async {
    var appsBox = await Hive.openBox(_boxName);
    return appsBox.values.map((e) => e as App).toList();
  }
}
