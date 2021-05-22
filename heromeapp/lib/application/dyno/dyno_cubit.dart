import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/domain/dyno/dyno.dart';
import 'package:heromeapp/domain/dyno/dyno_service.dart';

class DynoCubit extends Cubit<DynoState> {
  final AppsCubit appsCubit;
  final DynoService dynoService;
  StreamSubscription _streamSubscription;
  Map<String ,List<Dyno>> _allAppDynos = {};
  List<Dyno> _appDynos = [];




  DynoCubit({this.dynoService, this.appsCubit})
      : super(DynosUninitializedState()) {
    _streamSubscription = appsCubit.stream.listen((state) {
      if (state is AppsFetchedState) {
        List<String> appIds = state.apps.map((e) => e.id).toList();
        this.fetchAllAppDynos(appIds);
      }
    });
  }

  Future<Map<String, List<Dyno>>> fetchAllAppDynos(List<String> appIds) async {
    emit(DynosFetchingState());
    var response = await dynoService.fetchAllAppsDynos(appIds);
    if (!response.isError) {
      _allAppDynos = response.data;
      emit(DynosFetchedState(_allAppDynos));
      return _allAppDynos;
    }

    else {
      emit(DynosFetchErrorState(response.errors.message));
      return null;
    }
  }

  Future<List<Dyno>> fetchAppDynos(String appId) async {
    emit(DynosFetchingState());
    var response = await dynoService.fetchAppDyno(appId);
    if (!response.isError) {
      _appDynos = response.data;
      emit(DynosFetchedState(null));
      return _appDynos;
    }

    else {
      emit(DynosFetchErrorState(response.errors.message));
      return null;
    }
  }

  String getAppDynoStatus(String appId) {
    if (state is DynosFetchedState) {
      String status = (state as DynosFetchedState).dynos[appId][0].state;
      return status;
    } else return null;
  }


  Map<String, List<Dyno>> get allAppDynos => _allAppDynos;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  List<Dyno> get appDynos => _appDynos;
}
