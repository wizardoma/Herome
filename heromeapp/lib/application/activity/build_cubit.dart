import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/activity/build_state.dart';
import 'package:heromeapp/domain/activity/build.dart';
import 'package:heromeapp/domain/activity/build_service.dart';


class BuildCubit extends Cubit<BuildState> {
  final BuildService buildService;
  BuildCubit(this.buildService) : super(BuildNotInitializedState());
  List<Build> builds = [];

  Future<List<Build>> fetchBuilds(String appId) async{
    emit(BuildFetchingState());
    var response = await buildService.fetchBuilds(appId);
    if (response.isError){
      emit(BuildFetchErrorState(response.errors.message));
      return null;
    }

    builds = response.data;
    emit(BuildFetchedState(builds));
    return builds;

  }



}