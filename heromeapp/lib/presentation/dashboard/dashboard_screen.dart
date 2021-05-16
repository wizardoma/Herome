import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/presentation/dashboard/buildpack_image_provider.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_appbar.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with BuildpackImageProvider{

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              newAppSection(),
              filterAppSection(),
              listAppsSection(),

              // ignore: missing_return
            ],
          ),
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
    // ignore: missing_return
    return BlocBuilder<AppsCubit, AppsState>(builder: (context, state) {
      if (state is AppsFetchingState) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
        );
      }
      if (state is AppsFetchedState) {
        return ListView.separated(
          padding: EdgeInsets.only(bottom: 20),

          physics: ScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
                  color: kInputBorderColor,
                ),
            shrinkWrap: true,
            itemCount: state.apps.length,
            itemBuilder: (context, index) {
              var app = state.apps[index];
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
                          Icon(
                            Icons.grid_on,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            app.name,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (getBuildpackImage(app.language) != null) getBuildpackImage(app.language),
                        IconButton(icon: Icon(Icons.star_border, color: kDarkTextColor,), onPressed: null),
                      ],
                    ),
                  ],
                ),
              );
            });
      }
    });
  }
}
