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
import 'package:heromeapp/presentation/dashboard/app_status_image_provider.dart';
import 'package:heromeapp/presentation/dashboard/buildpack_image_provider.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_appbar.dart';
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
    var cubit = BlocProvider.of<AppsCubit>(context);
    cubit.fetchApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      body: Container(
        child: Column(
          children: [
            newAppSection(),
            filterAppSection(),
            Expanded(child: listAppsSection()),

            // ignore: missing_return
          ],
        ),
      ),
    );
  }

  Widget newAppSection() {
    return Container(
      decoration: BoxDecoration(
          color: kFooterBackgroundColor,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      height: 70,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_pin,
                  color: kPrimaryColor,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Personal",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.double_arrow,
                  color: kPrimaryColor,
                  size: 12,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kPrimaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "New",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.double_arrow,
                  color: kPrimaryColor,
                  size: 12,
                ),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget filterAppSection() {
    return Container(
      height: 70,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              onChanged: searchApp,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: kDarkTextColor,
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "Filter apps and pipelines",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: kInputBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: kPrimaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: kInputBorderColor)),
              ),
            ),
          ),
          Flexible(child: SizedBox()),
        ],
      ),
    );
  }

  Widget listAppsSection() {
    return BlocConsumer<AppsCubit, AppsState>(listener: (context, state) {
      if (state is AppsFetchedState) {
        setState(() {
          apps = state.apps;
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
        print("loaded apps ${apps.length}");
        var appsList = [];
        if (isSearching)
          appsList = appSearchResults;
        else
          appsList = apps;
        return SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          controller: _refreshController,
          child: appsList.length == 0
              ? Center(
                  child: Text(
                    "No Apps",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.only(bottom: 20),
                  physics: ScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                        color: kInputBorderColor,
                      ),
                  shrinkWrap: true,
                  itemCount: appsList.length,
                  itemBuilder: (context, index) {
                    var app = appsList[index];

                    return Container(
                      height: 60,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BlocBuilder<DynoCubit, DynoState>(
                                    // ignore: missing_return
                                    builder: (context, state) {
                                  if (state is DynosFetchingState) {
                                    return CircularProgress();
                                  }
                                  if (state is DynosFetchedState) {
                                    return getAppStatusImage(
                                        state.dynos[app.id][0].state);
                                  }
                                }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  app.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (getBuildpackImage(app.language) != null)
                                getBuildpackImage(app.language),
                              IconButton(
                                  icon: Icon(
                                    Icons.star_border,
                                    color: kGreyTextColor,
                                  ),
                                  onPressed: null),
                            ],
                          ),
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
        print(searchResult);
        appSearchResults = searchResult;
        isSearching = true;
      });
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }
}
