import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_state.dart';
import 'package:heromeapp/domain/access/collaborator.dart';
import 'package:heromeapp/domain/access/collaborator_service.dart';

class CollaboratorCubit extends Cubit<CollaboratorState> {
  final CollaboratorService collaboratorService;
  List<Collaborator> _collabs = [];

  CollaboratorCubit(this.collaboratorService)
      : super(CollaboratorUninitialized());

  Future<List<Collaborator>> fetchCollaborators(String appId) async {
    emit(CollaboratorFetchingState());
    var response = await collaboratorService.fetchCollaborators(appId);
    if (response.isError) {
      emit(CollaboratorFetchError(response.errors.message));
      return null;
    } else {
      _collabs = response.data;
      emit(CollaboratorFetchedState(_collabs));
      return _collabs;
    }
  }

  List<Collaborator> get collabs {
    return _collabs;
  }

  void addCollaborator(String appId, String userId) async {
    emit(CollaboratorAddingState());
    var response = await collaboratorService.addCollaborator(appId, userId);
    if (response.isError) {
      emit(CollaboratorAddFailureState(response.errors.message == null
          ? "An error occurred adding collaborator"
          : response.errors.message));
    } else {
      emit(CollaboratorAddSuccessState());
    }
  }

  void deleteCollaborator(String appId, String userId) async {
    emit(CollaboratorDeletingState());
    var response = await collaboratorService.deleteCollaborator(appId, userId);
    if (response.isError) {
      emit(CollaboratorDeleteFailureState(response.errors.message == null
          ? "An error occurred deleting collaborator"
          : response.errors.message));
    } else {
      emit(CollaboratorDeleteSuccessState());
    }
  }
}
