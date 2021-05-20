import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_state.dart';
import 'package:heromeapp/domain/access/collaborator.dart';
import 'package:heromeapp/domain/access/collaborator_service.dart';

class CollaboratorCubit extends Cubit<CollaboratorState> {
  final CollaboratorService collaboratorService;
  List<Collaborator> _collabs = [];

  CollaboratorCubit(this.collaboratorService) : super(CollaboratorUninitialized());

  Future<List<Collaborator>> fetchCollaborators(String appId) async{
    print("fetching collabs");
    emit(CollaboratorFetchingState());
    var response = await collaboratorService.fetchCollaborators(appId);
    if (response.isError){
      emit(CollaboratorFetchError(response.errors.message));
      return null;
    }
    else {
      _collabs = response.data;
      print("fetched collabs $_collabs");
      emit(CollaboratorFetchedState(_collabs));
      return _collabs;
    }
  }

  List<Collaborator> get collabs {
    return _collabs;
  }
}