import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_app_item.dart';

class ListAppsSection extends StatelessWidget {
  final bool isSearching;
  final List appSearchResults;
  final Function(String appId) onOpenAppScreen;
  final Function isSelectedApp;
  final AppsCubit appsCubit;
  final List<App> apps;
  final RefreshController refreshController;
  final Function onRefresh;
  final Function setAppsState;



  const ListAppsSection({Key key, this.isSearching, this.appSearchResults, this.onOpenAppScreen, this.isSelectedApp, this.appsCubit, this.refreshController, this.onRefresh, this.setAppsState, this.apps}) : super(key: key);@override
  Widget build(BuildContext context) {
 return BlocConsumer<AppsCubit, AppsState>(listener: (context, state) {
      if (state is AppsFetchedState) {
        setAppsState(context.read<AppsCubit>().getApps());

      }
    },
        // ignore: missing_return
        builder: (context, state) {
          if (state is AppsFetchingState) {
            return Center(
              child: CircularProgress(),
            );
          }
          if (state is AppsFetchedState) {
            print("fetched apps ${state.apps}");
            var appsList = [];
            if (isSearching) {
              appsList = appSearchResults;
            } else {
              appsList = apps;
            }
            return SmartRefresher(
              enablePullDown: true,
              onRefresh: onRefresh,
              controller: refreshController,
              child: appsList.length == 0
                  ? Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "You have no apps",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
                  : ListView.separated(
                  padding: EdgeInsets.only(bottom: 20),
                  separatorBuilder: (context, index) => Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: kInputBorderColor,
                  ),
                  shrinkWrap: true,
                  itemCount: appsList.length,
                  itemBuilder: (context, index) {
                    App app = appsList[index];
                    var appsCubit = context.read<AppsCubit>();
                    return ListAppItem(
                      app: app,
                      onOpenAppScreen: onOpenAppScreen,
                      isSelectedApp: isSelectedApp,
                      appsCubit: appsCubit,
                    );
                  }),
            );
          }
        });

  }
}
