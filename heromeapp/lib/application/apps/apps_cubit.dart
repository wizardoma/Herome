import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/domain/apps/app_service.dart';

class AppsCubit extends Cubit<AppsState> {
  final AppService appService;

  AppsCubit(this.appService) : super(AppsNotInitialized());

  void fetchApps() async {
    emit(AppsFetchingState());
    await Future.delayed(Duration(seconds: 2));

    var response = await appService.fetchApps();
    if (!response.isError) {
      emit(AppsFetchedState(response.data));
    } else {
      print("Apps fetching not successful");
    }
  }
}
