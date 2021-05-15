import 'package:heromeapp/domain/apps/app_service.dart';
import 'package:heromeapp/domain/apps/apps_provider.dart';
import 'package:heromeapp/domain/response.dart';

class AppServiceImpl extends AppService {

  final AppProvider appProvider;

  AppServiceImpl(this.appProvider);
  @override
  Future<ResponseEntity> fetchApps() {
    var response = appProvider.fetchApps();
    return response;
  }

}