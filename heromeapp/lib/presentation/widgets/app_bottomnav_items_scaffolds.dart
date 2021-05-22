import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heromeapp/presentation/widgets/appscreen_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppItemsScaffold extends StatelessWidget {
  final String appBarTitle;
  final Function onRefresh;
  final Widget body;
  final Widget additionalActions;

  const AppItemsScaffold({
    @required this.appBarTitle,
    this.onRefresh,
    @required this.body,
    this.additionalActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppScreenAppbar(
          title: appBarTitle,
          onRefresh: onRefresh,
          additionalActions: additionalActions,
        ),
        body: body);
  }
}
