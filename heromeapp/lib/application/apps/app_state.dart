import 'package:heromeapp/domain/apps/app.dart';

abstract class AppsState {
}

class AppsNotInitialized extends AppsState{}

class AppsFetchingState extends AppsState {}

class  AppsFetchedState  extends AppsState{
  final List<App> apps;

  AppsFetchedState(this.apps);
}