import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/access/collaborator_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/presentation/app_access/dialog_actions.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';

class AddCollaboratorDialog extends StatefulWidget {
  final Function(String) onAdd;
  final BuildContext accessContext;

  const AddCollaboratorDialog({Key key, this.onAdd, this.accessContext}) : super(key: key);

  @override
  _AddCollaboratorDialogState createState() => _AddCollaboratorDialogState();
}

class _AddCollaboratorDialogState extends State<AddCollaboratorDialog> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollaboratorCubit, CollaboratorState>(
      listener: (ctx, st){
        if (st is CollaboratorAddSuccessState) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
          title: Text("Add Collaborator"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Enter email address or ID of user",
                  style:
                      Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
                ),
              ),
              Flexible(
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: "email or id",
                    errorText: getErrorText(),
                    hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: kInputBorderColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: kPurpleColor)),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: kInputBorderColor)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            actionTextButton(
                text: "Cancel",
                onPressed: () {
                  Navigator.pop(context);
                }),
            BlocBuilder<CollaboratorCubit, CollaboratorState>(builder: (ctx, sta) {
              if (sta is CollaboratorAddingState) {
                return CircularProgress();
              } else {
                return actionTextButton(
                    text: "Add",
                    onPressed: () => _textEditingController.text.isNotEmpty
                        ? widget.onAdd(_textEditingController.text)
                        : null);
              }
            }),
          ],

      ),
    );
  }

  String getErrorText() {
    return _textEditingController.text == null
        ? "Please type an email or id"
        : null;
  }
}
