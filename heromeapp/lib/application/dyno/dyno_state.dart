import 'package:heromeapp/domain/dyno/dyno.dart';

abstract class DynoState {}

class DynosFetchedState extends DynoState{
  final Map<String, List<Dyno>> dynos;

  DynosFetchedState(this.dynos);
}

class DynosFetchingState extends DynoState {}

class DynosUninitializedState extends DynoState {}
class DynosFetchErrorState extends DynoState {
  final String message;

  DynosFetchErrorState(this.message);
}