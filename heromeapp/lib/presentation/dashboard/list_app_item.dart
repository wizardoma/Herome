import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/apps/app.dart';

class ListAppItem extends StatelessWidget {
  final App app;
  final Function(String appId) onOpenAppScreen;
  final Function isSelectedApp;
  final AppsCubit appsCubit;

  const ListAppItem({Key key, @required this.app, this.onOpenAppScreen, this.isSelectedApp, this.appsCubit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(app.id),
      onTap: () => onOpenAppScreen(app.id),
      leading: Visibility(
        visible:
        isSelectedApp(appsCubit.getCurrentApp(), app.id),
        child: Icon(
          Icons.done,
          color: kPurpleColor,
          size: 35,
        ),
      ),
      title: Text(
        app.name,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w400),
      ),
      subtitle: Row(
        children: [
          BlocBuilder<DynoCubit, DynoState>(
            // ignore: missing_return
              builder: (context, state) {
                if (state is DynosFetchingState ||
                    state is DynosUninitializedState) {
                  return Text("Loading...");
                }
                if (state is DynosFetchedState) {
                  var dynos = state.dynos;
                  if (dynos == null) {
                    return Text("Loading...");
                  }
//                              print("all app dynos $dynos");
                  return Row(
                    children: [
                      Text(app.language),
                      SizedBox(
                        width: 10,
                      ),
                      Text("-"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(dynos[app.id][0].type),
                      SizedBox(
                        width: 10,
                      ),
                      Text("-"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(dynos[app.id][0].name),
                    ],
                  );
                }
              })
        ],
      ),
    );
  }
}
