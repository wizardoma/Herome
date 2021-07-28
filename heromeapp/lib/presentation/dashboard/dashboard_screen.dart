import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/app/app_screen.dart';
import 'package:heromeapp/presentation/dashboard/app_status_image_provider.dart';
import 'package:heromeapp/presentation/dashboard/buildpack_image_provider.dart';
import 'package:heromeapp/presentation/dashboard/filter_apps_section.dart';
import 'package:heromeapp/presentation/dashboard/list_apps_section.dart';
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
            FilterAppSection(
              onSearchApp: searchApp,
            ),
            Expanded(
                child: ListAppsSection(
              isSearching: isSearching,
              isSelectedApp: isSelectedApp,
              onOpenAppScreen: _openAppScreen,
              refreshController: _refreshController,
              onRefresh: _onRefresh,
              appSearchResults: appSearchResults,
              apps: apps,
              setAppsState: setAppsState,
            )),

            // ignore: missing_return
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    await context.read<AppsCubit>().fetchApps();
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

  void setAppsState(List<App> newApps) {
    setState(() {
      apps = newApps;
    });
  }

  void _openAppScreen(String id) {
    context.read<AppsCubit>().storeCurrentAppId(id);
    Navigator.pushNamedAndRemoveUntil(
        context, AppScreen.routeName, (route) => false,
        arguments: {
          "appId": id,
        });
  }

  bool isSelectedApp(App currentApp, String appId) {
    return currentApp != null && (currentApp.id == appId);
  }
}
