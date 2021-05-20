import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/app/app_screen.dart';
import 'package:heromeapp/presentation/dashboard/app_status_image_provider.dart';
import 'package:heromeapp/presentation/dashboard/buildpack_image_provider.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with BuildpackImageProvider, AppStatusImageProvider {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<App> apps = [];
  List<App> appSearchResults = [];
  bool isSearching = false;

  @override
  void initState() {
    apps = context.read<AppsCubit>().getApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: Icon(
            Icons.close,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        title: Text("Select a project"),
        actions: [
          PopupMenuButton(
            onSelected: (val) {
              context.read<AppsCubit>().fetchApps();
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.black87,
            ),
            padding: EdgeInsets.all(0),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Refresh"),
                height: 10,
                value: "refresh",
              )
            ],
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            filterAppSection(),
            Expanded(child: listAppsSection()),

            // ignore: missing_return
          ],
        ),
      ),
    );
  }

  Widget filterAppSection() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: kInputBorderColor, width: 0.5),
      )),
      height: 70,
      child: TextField(
        onChanged: searchApp,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: kDarkTextColor,
          ),
//          contentPadding: EdgeInsets.all(20),
          hintText: "Filter apps",
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
    );
  }

  Widget listAppsSection() {
    return BlocConsumer<AppsCubit, AppsState>(listener: (context, state) {
      if (state is AppsFetchedState) {
        setState(() {
          apps = context.read<AppsCubit>().getApps();
        });
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
        var appsList = [];
        if (isSearching) {
          appsList = appSearchResults;
        } else {

          appsList = apps;
        }
        return SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          controller: _refreshController,
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
                  physics: ScrollPhysics(),
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
                    return ListTile(
                      onTap: () => _openAppScreen(app.id),
                      leading:  Visibility(
                        visible: isSelectedApp(appsCubit.getCurrentApp(), app.id),
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
                            if (state is DynosFetchingState) {
                              return Text("Loading...");
                            }
                            if (state is DynosFetchedState) {
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
                                  Text(state.dynos[app.id][0].type),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(state.dynos[app.id][0].name),
                                ],
                              );
                            }
                          })
                        ],
                      ),
                    );
                  }),
        );
      }
    });
  }

  void _onRefresh() async {
    context.read<AppsCubit>().fetchApps();
    await Future.delayed(Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }

  void searchApp(String value) {
    if (value.isNotEmpty) {
      setState(() {
        value = value.toLowerCase();
        var searchResult = apps
            .where((element) => element.name.toLowerCase().contains(value))
            .toList();
        appSearchResults = searchResult;
        isSearching = true;
      });
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

  void _openAppScreen(String id) {
    context.read<AppsCubit>().storeCurrentAppId(id);
    Navigator.pushNamedAndRemoveUntil(context, AppScreen.routeName, (route)=> false, arguments: {
      "appId": id,
    });
  }

  bool isSelectedApp(App currentApp, String appId){
    return currentApp != null && (currentApp.id == appId);
  }
}
