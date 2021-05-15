import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/apps/app_state.dart';
import 'package:heromeapp/application/apps/apps_cubit.dart';
import 'package:heromeapp/commons/app/colors.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    var cubit = BlocProvider.of<AppsCubit>(context);
    cubit.fetchApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Herome Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child:
              BlocBuilder<AppsCubit, AppsState>(builder: (context, state) {
                if (state is AppsFetchingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  );
                }
                if (state is AppsFetchedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.apps.length,
                      itemBuilder: (context, index) {
                    return Text(state.apps[index].name);

                  });
                }
              }),
        ),
      ),
    );
  }
}
