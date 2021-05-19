import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_profile_overlay.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_screen.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appName;

  const DashboardAppBar({Key key, this.appName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      elevation: 0,
      backgroundColor: kWhiteColor,
      automaticallyImplyLeading: false,
      title: Container(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DashboardScreen.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "App",
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(appName, style: Theme.of(context).textTheme.bodyText1.copyWith(
                    wordSpacing: 1.4
                  ),),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black87,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        DashboardProfileOverlay(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
