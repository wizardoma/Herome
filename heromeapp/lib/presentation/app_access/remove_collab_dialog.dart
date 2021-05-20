import 'package:flutter/material.dart';
import 'package:heromeapp/presentation/app_access/dialog_actions.dart';

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
    return AlertDialog(
      title: Text("Remove Collaborator"),
      content:
          Text("Are you sure you want to remove $userEmail from $appName?"),
      actions: [
        actionTextButton(
            text: "Cancel",
            onPressed: () {
              Navigator.pop(context);
            }),
        actionTextButton(text: "Cancel", onPressed: onRemoveCollab),
      ],
    );
  }
}
