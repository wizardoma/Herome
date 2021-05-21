import 'package:flutter/material.dart';
import 'package:heromeapp/domain/access/collaborator_types.dart';
import 'package:heromeapp/presentation/app_access/dialog_actions.dart';

class ChangeRoleDialog extends StatelessWidget {
  final Function onChangeRole;

  const ChangeRoleDialog({Key key, this.onChangeRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollaboratorType type;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        actions: [
          actionTextButton(
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              }),
          actionTextButton(
            text: "OK",
            onPressed: onChangeRole,
          ),
        ],
        title: Text("Change Role"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: CollaboratorType.values.map((e) {
            return ListTile(
              leading: Radio(
                  value: e,
                  groupValue: type,
                  onChanged: (val) {
                    setState(() {
                      type = val;
                    });
                  }),
              title: Text(e.toString().split(".")[1]),
            );
          }).toList(),
        ),
      );
    });
  }
}
