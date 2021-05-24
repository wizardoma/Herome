import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/addon/addon_cubit.dart';
import 'package:heromeapp/application/addon/addon_state.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/domain/addon/addon.dart';
import 'package:heromeapp/domain/apps/app.dart';
import 'package:heromeapp/presentation/widgets/app_bottomnav_items_scaffolds.dart';
import 'package:heromeapp/presentation/widgets/circular_progress_primary.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppResourcesScreen extends StatefulWidget {
  final App app;

  AppResourcesScreen(this.app);

  @override
  _AppResourcesScreenState createState() => _AppResourcesScreenState();
}

class _AppResourcesScreenState extends State<AppResourcesScreen> {
  RefreshController _refreshController;
  AddonCubit _addonCubit;
  @override
  void initState() {
    _addonCubit = context.read<AddonCubit>();
    var hasFetched = _addonCubit.addons.length > 0;
    try {
      if (!hasFetched || _addonCubit.addons[0].appId != widget.app.id) {
        _addonCubit.fetchAppAddons(widget.app.id);
      }
    }
    catch (e) {
      _addonCubit.fetchAppAddons(widget.app.id);
    }
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppItemsScaffold(
      appBarTitle: 'Resources',
      body: Center(
        child: Container(
          // ignore: missing_return
          child: BlocBuilder<AddonCubit, AddonState>(builder: (context, state) {
            if (state is AddonFetchingState) {
              return CircularProgress();
            }

            if (state is AddonFetchErrorState) {
              return Text(state.error);
            }
            if (state is AddonFetchedStated) {
              var addons = state.addons;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: kLightGrey, width: 0.5))
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Add-ons",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: SmartRefresher(
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
                          itemCount: addons.length,
                          itemBuilder: (context, index) {
                            var addon = addons[index];
                            return ListTile(
                              key: ValueKey(addon.id),
                              leading: Icon(Icons.apps),
                              title: Text(addons[index].addonServiceName.toUpperCase()),
                              trailing: PopupMenuButton(
                                onSelected: (value) =>
                                    _selectRoleOptions(value, addons[index]),
                                icon: Icon(Icons.more_vert, color: Colors.black87),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: ListTile(title: Text("View in Market Place"), leading:  Icon(Icons.point_of_sale),),
                                    value: "role",
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(title: Text("View in Dev Center"), leading:  Icon(Icons.apps),),
                                    value: "role",
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(title: Text("Delete Addon", style: Theme.of(context).textTheme.headline2,), leading:  Icon(Icons.close, color: kerrorTextColor,),),
                                    value: "role",
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  void onRefresh() async {
    await _addonCubit.fetchAppAddons(widget.app.id);
    _refreshController.refreshCompleted();
  }

  _selectRoleOptions(value, Addon addon) {}
}
