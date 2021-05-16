import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/domain/dyno/dyno_service.dart';

class DynoCubit extends Cubit<DynoState> {
  final AppsCubit appsCubit;
  final DynoService dynoService;
  StreamSubscription _streamSubscription;

  DynoCubit({this.dynoService, this.appsCubit})
      : super(DynosUninitializedState()) {
    _streamSubscription = appsCubit.stream.listen((state) {
      if (state is AppsFetchedState) {
        List<String> appIds = state.apps.map((e) => e.id).toList();
        this.fetchAppDynos(appIds);
      }
    });
  }

  Future<void> fetchAppDynos(List<String> appIds) async {
    emit(DynosFetchingState());
    var response = await dynoService.fetchAllAppsDynos(appIds);
    if (!response.isError) {
      emit(DynosFetchedState(response.data));


    }
  }

  String getAppDynoStatus(String appId) {
    if (state is DynosFetchedState) {
      String status = (state as DynosFetchedState).dynos[appId][0].state;
      return status;
    } else return null;
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
