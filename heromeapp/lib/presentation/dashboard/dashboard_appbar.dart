import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/presentation/dashboard/dashboard_profile_overlay.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leadingWidth: 0,
      backgroundColor: kWhiteColor,
      title: Row(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/logos/logo.jpg",
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "HEROME",
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                    fontSize: 17),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 150,
            height: 35,
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(7),
                hintText: "Jump to Favorites, Apps, Pipelines...",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: kDarkGrey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: kPrimaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: kDarkGrey)),
              ),
            ),
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
      shadowColor: kPrimaryColor,
      actions: [
        DashboardProfileOverlay(),
      ],

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
