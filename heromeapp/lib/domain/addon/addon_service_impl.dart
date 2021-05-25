import 'package:heromeapp/domain/addon/addon_client.dart';
import 'package:heromeapp/domain/addon/addon_service.dart';
import 'package:heromeapp/domain/response.dart';

class AddonServiceImpl extends AddonService {
  final AddonClient _addonClient;

  AddonServiceImpl(this._addonClient);
  @override
  Future<ResponseEntity> fetchAppAddons(String appId) async{
    var response = await _addonClient.fetchAppAddons(appId);
    return response;
  }

}