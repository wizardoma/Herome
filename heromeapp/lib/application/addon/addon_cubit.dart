import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/addon/addon_state.dart';
import 'package:heromeapp/domain/addon/addon.dart';
import 'package:heromeapp/domain/addon/addon_service.dart';

class AddonCubit extends Cubit<AddonState> {
  final AddonService _addonService;
  List<Addon> _addons = [];
  AddonCubit(this._addonService) : super(AddonUninitializedState());

  Future<List<Addon>> fetchAppAddons(String appId) async{
    var response = await _addonService.fetchAppAddons(appId);
    if (response.isError) {
      emit(AddonFetchErrorState(response.errors.message));
      return null;
    }

    else {
      _addons = response.data;
      emit(AddonFetchedStated(_addons));
      return _addons;
    }
  }

  List<Addon> get addons => _addons;
}