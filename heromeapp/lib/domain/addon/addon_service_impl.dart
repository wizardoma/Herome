import 'package:heromeapp/domain/addon/addon_provider.dart';
import 'package:heromeapp/domain/addon/addon_service.dart';
import 'package:heromeapp/domain/response.dart';

class AddonServiceImpl extends AddonService {
  final AddonProvider _addonProvider;

  AddonServiceImpl(this._addonProvider);
  @override
  Future<ResponseEntity> fetchAppAddons(String appId) async{
    var response = await _addonProvider.fetchAppAddons(appId);
    return response;
  }

}