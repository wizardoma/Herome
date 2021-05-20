import 'package:heromeapp/domain/access/collaborator.dart';

abstract class CollaboratorState {}

class CollaboratorUninitialized extends CollaboratorState {}
class CollaboratorFetchingState extends CollaboratorState {}
class CollaboratorFetchedState extends CollaboratorState {
  final List<Collaborator> collabs;

  CollaboratorFetchedState(this.collabs);
}
class CollaboratorFetchError extends CollaboratorState {
  final String error;

  CollaboratorFetchError(this.error);
}