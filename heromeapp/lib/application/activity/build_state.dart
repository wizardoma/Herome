import 'package:heromeapp/domain/activity/build.dart';

abstract class BuildState {}

class BuildNotInitializedState extends BuildState {}
class BuildFetchingState extends BuildState {}
class BuildFetchedState extends BuildState {
  final List<Build> builds;
  BuildFetchedState(this.builds);
}
class BuildFetchErrorState extends BuildState {
  final String error;

  BuildFetchErrorState(this.error);
}