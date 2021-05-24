import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/access/collaborator_state.dart';
import 'package:heromeapp/presentation/app_access/dialog_actions.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';

class RemoveCollabDialog extends StatelessWidget {
  final Function onRemoveCollab;
  final String userEmail;
  final String appName;

  const RemoveCollabDialog(
      {Key key,
      this.onRemoveCollab,
      @required this.userEmail,
      @required this.appName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollaboratorCubit, CollaboratorState>(
      listener: (c,s) {
        if (s is CollaboratorDeleteSuccessState){
          Navigator.pop(context);

        }
      },
      child: AlertDialog(
        title: Text("Remove Collaborator"),
        content:
            Text("Are you sure you want to remove $userEmail from $appName?"),
        actions: [
          actionTextButton(
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              }),
          BlocBuilder<CollaboratorCubit, CollaboratorState>(
              builder: (context, state) => state is CollaboratorDeletingState ? CircularProgress() :
                  actionTextButton(text: "Remove", onPressed: () =>  onRemoveCollab(userEmail))),
        ],
      ),
    );
  }
}
