import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/addon/addon_cubit.dart';
import 'package:heromeapp/application/addon/addon_state.dart';
import 'package:heromeapp/application/dyno/dyno_cubit.dart';
import 'package:heromeapp/application/dyno/dyno_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/addon/addon.dart';
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
  AddonCubit _addonCubit;

  @override
  void initState() {
    _dynoCubit = context.read<DynoCubit>();
    _addonCubit = context.read<AddonCubit>();

    var hasFetchedDynos = _dynoCubit.appDynos.length > 0;
    if (!hasFetchedDynos || _dynoCubit.appDynos[0].appId != widget.app.id) {
      _dynoCubit.fetchAppDynos(widget.app.id);
    }
    var hasFetchedAddons = _addonCubit.addons.length > 0;
    if (!hasFetchedAddons || _addonCubit.addons[0].appId != widget.app.id) {
      _addonCubit.fetchAppAddons(widget.app.id);
    }
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
        if (state is DynosFetchingState || state is DynosUninitializedState) {
          return Center(child: CircularProgress());
        }
        if (state is DynosFetchedState) {
          var dynos = context.read<DynoCubit>().appDynos;
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
                  child: BlocBuilder<AddonCubit, AddonState>(
                      // ignore: missing_return
                      builder: (context, state) {
                        if (state is AddonFetchingState) {
                          return CircularProgress();
                        }
                        if (state is AddonFetchErrorState){
                          return Text(state.error == null ? "An error occurred, try again" : state.error);
                        }
                        if (state is AddonFetchedStated) {
                          if (!account.verified) {
                            return Text("Billing is not enabled");
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Approximate charges so far for this month"),
                                SizedBox(height: 10,),
                                Text("\$${calculateBill(state.addons)}",style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20),)
                              ],
                            );
                          }
                        }}),
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
        icon: Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        status: "${dynos.length} of ${dynos.length} dynos report normal status",
      );
    } else {
      return getDynoStatusText(
        icon: Icon(
          Icons.cancel,
          color: kerrorTextColor,
        ),
        status:
            "${listOfDownDynos.length} of ${dynos.length} dynos report down status",
      );
    }
  }

  Widget getDynoStatusText({Icon icon, String status}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(
          status,
          style: TextStyle(
              decoration: TextDecoration.underline, color: kPurpleColor),
        ),
      ],
    );
  }

  void onRefresh() async {
    await _dynoCubit.fetchAppDynos(widget.app.id);
    _refreshController.refreshCompleted();
  }

  Widget getAdditionalAction() {
    return IconButton(
        icon: Icon(
          Icons.swap_vert,
          color: Colors.black87,
        ),
        onPressed: () {});
  }

  String calculateBill(List<Addon> addons) {
    String amount = (addons.map((e) => e.billing.cents)
        .reduce((value, element) => value + element)
        .toDouble() / 100)
        .toString();
    return amount;
  }
}
