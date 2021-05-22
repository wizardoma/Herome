import 'package:flutter/material.dart';
import 'package:heromeapp/application/access/collaborator_cubit.dart';
import 'package:heromeapp/application/access/collaborator_state.dart';
import 'package:heromeapp/domain/access/collaborator.dart';
import 'package:heromeapp/domain/apps/app.dart';
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
  CollaboratorCubit _collaboratorCubit;

  void onRefresh() async {
    await _collaboratorCubit.fetchCollaborators(widget.app.id);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _collaboratorCubit = context.read<CollaboratorCubit>();
    print("init access ${_collaboratorCubit.collabs}");
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
      onRefresh: onRefresh,
      body: BlocBuilder<CollaboratorCubit, CollaboratorState>(
        // ignore: missing_return
        builder: (BuildContext context, state) {
          if (state is CollaboratorFetchingState) {
            return Center(child: CircularProgress());
          }
          if (state is CollaboratorFetchError) {
            return Center(
              child: Text(state.error == null ? "An Error Occurred. Please try again" : state.error),
            );
          }
          if (state is CollaboratorFetchedState) {
            var collabs = state.collabs;
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: onRefresh,
              enablePullDown: true,
              child: ListView.builder(
                  itemCount: collabs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: ValueKey(collabs[index].id),
                      leading: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      title: Text(collabs[index].userEmail),
                      subtitle: Text(collabs[index].role),
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
                  userEmail: collab.userEmail,
                  appName: widget.app.name,
                ));
    }
  }
}
