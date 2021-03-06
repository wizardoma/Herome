import 'package:flutter/material.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/access/collaborator_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/access/collaborator.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/app_access/add_collaborator_dialog.dart';
import 'package:heromeapp/presentation/app_access/change_role_dialog.dart';
import 'package:heromeapp/presentation/app_access/remove_collab_dialog.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAccessScreen extends StatefulWidget {
  final App app;

  AppAccessScreen(this.app);

  @override
  _AppAccessScreenState createState() => _AppAccessScreenState();
}

class _AppAccessScreenState extends State<AppAccessScreen> {
  RefreshController _refreshController;
  bool hasFetchedCollabs;
  CollaboratorCubit _collaboratorCubit;

  void onRefresh() async {
    await _collaboratorCubit.fetchCollaborators(widget.app.id);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    hasFetchedCollabs = false;
    _collaboratorCubit = context.read<CollaboratorCubit>();
    var hasFetched = _collaboratorCubit.collabs.length > 0;
    _refreshController = RefreshController(initialRefresh: false);

    if (!hasFetched || _collaboratorCubit.collabs[0].appId != widget.app.id) {
      _collaboratorCubit.fetchCollaborators(widget.app.id);
    }

    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(
      additionalActions: _getAdditionalAction(),
      onRefresh: onRefresh,
      body: BlocConsumer<CollaboratorCubit, CollaboratorState>(
        listener: (context, state) {
          if (state is CollaboratorAddFailureState) {
            _showErrorSnackbar(state.error);
          }

          if (state is CollaboratorDeleteFailureState) {
            _showErrorSnackbar(state.error);
          }

          if (state is CollaboratorAddSuccessState) {
            _showSuccessSnackbar(
                "Your collaborator invitation was sent to the user");
          }
          if (state is CollaboratorDeleteSuccessState) {
            _showSuccessSnackbar("The user was successfully removed");
          }
        },
        // ignore: missing_return
        builder: (BuildContext context, state) {
          if (state is CollaboratorFetchingState) {
            return Center(child: CircularProgress());
          } else if (state is CollaboratorFetchError) {
            return Center(
              child: Text(state.error == null
                  ? "An Error Occurred. Please try again"
                  : state.error),
            );
          } else {
            var collabs = context.read<CollaboratorCubit>().collabs;

            return SmartRefresher(
              controller: _refreshController,
              onRefresh: onRefresh,
              enablePullDown: true,
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: kLightGrey,
                        height: 0.5,
                        thickness: 0.5,
                      ),
                  itemCount: collabs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: ValueKey(collabs[index].id),
                      leading: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      title: Text(collabs[index].userEmail),
                      subtitle: Text(collabs[index].role ?? "collaborator"),
                      trailing: PopupMenuButton(
                        onSelected: (value) =>
                            _selectRoleOptions(value, collabs[index]),
                        icon: Icon(Icons.more_vert, color: Colors.black87),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Change Role"),
                            value: "role",
                          ),
                          PopupMenuItem(
                            child: Text("Remove"),
                            value: "remove",
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
        },
      ),
      appBarTitle: 'Collaborators',
    );
  }

  void _selectRoleOptions(dynamic value, Collaborator collab) {
    switch (value) {
      case "role":
        showDialog(
            context: context,
            builder: (context) {
              return ChangeRoleDialog();
            });
        break;

      case "remove":
        showDialog(
            context: context,
            builder: (context) => RemoveCollabDialog(
                  onRemoveCollab: _onRemoveCollaborator,
                  userEmail: collab.userEmail,
                  appName: widget.app.name,
                ));
    }
  }

  Widget _getAdditionalAction() {
    return TextButton(
        onPressed: _addCollaborator,
        child: Text(
          "Add",
          style: Theme.of(context).textTheme.headline4,
        ));
  }

  void _addCollaborator() {
    showDialog(
        context: context,
        builder: (cont) => AddCollaboratorDialog(
              accessContext: context,
              onAdd: _onAddCollaborator,
            ));
  }

  void _onAddCollaborator(String userId) {
    context.read<CollaboratorCubit>().addCollaborator(widget.app.id, userId);
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(_snackBar(message));
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(_snackBar(message));
  }

  SnackBar _snackBar(String message) {
    return SnackBar(content: Text(message));
  }

  void _onRemoveCollaborator(String userId) {
    context.read<CollaboratorCubit>().deleteCollaborator(widget.app.id, userId);
  }
}
