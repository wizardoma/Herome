import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/app_dashboard/dashboard_info_card.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppDashboardScreen extends StatefulWidget {
  final App app;

  AppDashboardScreen(this.app);

  @override
  _AppDashboardScreenState createState() => _AppDashboardScreenState();
}

class _AppDashboardScreenState extends State<AppDashboardScreen> {
  RefreshController _refreshController;
  DynoCubit _dynoCubit;

  @override
  void initState() {
    _dynoCubit = context.read<DynoCubit>();
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(
      appBarTitle: 'Dashboard',
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: onRefresh,
          enablePullDown: true,
          child: ListView(children: [
            DashboardInfoCard(
              title: "Heroku App Status",
              child: BlocBuilder<DynoCubit, DynoState>(
                  // ignore: missing_return
                  builder: (BuildContext context, state) {
                if (state is DynosFetchingState) {
                  return Center(child: CircularProgress());
                }
                if (state is DynosFetchedState) {
                  var dynos = context.read<DynoCubit>().appDynos;
                  return Text("All dynos report normal status");
                }
              }),
            ),
            DashboardInfoCard(
              title: "Billing",
              child: Text("Billing is not enabled"),
            ),
          ]),
        ),
      ),
    );
  }

  void onRefresh() async {
    await _dynoCubit.fetchAppDynos(widget.app.id);
    _refreshController.refreshCompleted();
  }
}
