import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/domain/dyno/dyno.dart';
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
      additionalActions: getAdditionalAction(),
      appBarTitle: 'Dashboard',
      body: BlocBuilder<DynoCubit, DynoState>(
          // ignore: missing_return
          builder: (BuildContext context, state) {
        if (state is DynosFetchingState) {
          return Center(child: CircularProgress());
        }
        if (state is DynosFetchedState) {
          var dynos = context.read<DynoCubit>().appDynos;
          print("dyno $dynos");
          var account = context.read<AccountCubit>().getAccount();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: onRefresh,
              enablePullDown: true,
              child: ListView(children: [
                DashboardInfoCard(
                  title: "Heroku App status",
                  child: getDynoStatus(dynos),
                ),
                DashboardInfoCard(
                  title: "Billing",
                  child: !account.verified
                      ? Text("Billing is not enabled")
                      : Text("Billing is enabled"),
                ),
              ]),
            ),
          );
        }
      }),
    );
  }

  Widget getDynoStatus(List<Dyno> dynos) {
    var listOfDownDynos = dynos
        .where(
            (element) => element.state == "down" || element.state == "crashed")
        .toList();
    var isAnyDynoDown = listOfDownDynos.length > 0;
    if (!isAnyDynoDown) {
      return getDynoStatusText(
        icon: Icon(Icons.check_circle, color: Colors.green,),
        status: "${dynos.length} of ${dynos.length} dynos report normal status",
      );
    }

    else {
      return getDynoStatusText(
        icon: Icon(Icons.cancel, color: kerrorTextColor,),
        status: "${listOfDownDynos.length} of ${dynos.length} dynos report down status",
      );
    }
  }

  Widget getDynoStatusText({Icon icon, String status}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(status
          ,
          style: TextStyle(decoration: TextDecoration.underline, color: kPurpleColor),
        ),
      ],
    );
  }

  void onRefresh() async {
    await _dynoCubit.fetchAppDynos(widget.app.id);
    _refreshController.refreshCompleted();
  }

  Widget getAdditionalAction() {
    return IconButton(icon: Icon(Icons.swap_vert, color: Colors.black87,), onPressed: (){});
  }
}
