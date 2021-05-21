import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/activity/build_cubit.dart';
import 'package:heromeapp/application/activity/build_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/activity/build.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppActivityScreen extends StatefulWidget {
  final App app;

  AppActivityScreen(this.app);

  @override
  _AppActivityScreenState createState() => _AppActivityScreenState();
}

class _AppActivityScreenState extends State<AppActivityScreen> {
  RefreshController _refreshController;
  BuildCubit _buildCubit;

  void onRefresh() async {
    await _buildCubit.fetchBuilds(widget.app.id);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _buildCubit = context.read<BuildCubit>();
    _refreshController = RefreshController(initialRefresh: false);
    var hasFetched = _buildCubit.builds.length > 0;
    if (!hasFetched || _buildCubit.builds[0].appId != widget.app.id) {
      _buildCubit.fetchBuilds(widget.app.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(
        appBarTitle: 'Activity',
        onRefresh: onRefresh,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            color: kFooterBackgroundColor,
            child: Text("Activity Feed"),
          ),
          Expanded(
            child: BlocBuilder<BuildCubit, BuildState>(
              // ignore: missing_return
              builder: (BuildContext context, state) {
                if (state is BuildFetchingState) {
                  return Center(child: CircularProgress());
                }
                if (state is BuildFetchErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is BuildFetchedState) {
                  var builds = state.builds;
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
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: builds.length,
                        itemBuilder: (context, index) {
                          var build = builds[index];
                          return ListTile(
                            leading: getLeadingIcon(build),
                            title: Row(
                              children: [
                                Text(
                                  "${builds[index].userEmail}:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                getBuildStatus(build),
                              ],
                            ),
                            subtitle: getBuildDate(build),
                          );
                        }),
                  );
                }
              },
            ),
          )
        ]));
  }

  Widget getLeadingIcon(Build build) {
    return build.isDeploy
        ? Icon(Icons.cloud_upload_sharp)
        : build.status == "succeeded"
            ? Icon(
                Icons.done_outline,
                color: Colors.green,
              )
            : Icon(
                Icons.error_outline,
                color: kerrorTextColor,
              );
  }

  Widget getBuildDate(Build build) {
    var date = DateTime.parse(build.date);
    var month = DateFormat("MMMM d").format(date);
    var time = DateFormat("jm").format(date);
    return RichText(
      text: TextSpan(
        text: month,
        style: Theme.of(context).textTheme.bodyText2,
        children: [
          TextSpan(text: " at ", style: Theme.of(context).textTheme.bodyText2),
          TextSpan(text: time, style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }

  Widget getBuildStatus(Build build) {
    if (build.isDeploy) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Deployed",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: kFooterBackgroundColor,
                border: Border.all(color: kLightGrey),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                build.version.substring(0, 6),
              )),
        ],
      );
    } else {
      if (build.status == "succeeded") {
        return Text(
          "build succeeded",
          style: TextStyle(color: Colors.green),
        );
      } else {
        return Text(
          "build failed",
          style: TextStyle(color: kerrorTextColor),
        );
      }
    }
  }
}
