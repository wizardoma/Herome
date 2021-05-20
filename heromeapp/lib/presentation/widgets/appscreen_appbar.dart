import 'package:flutter/material.dart';

class AppScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onRefresh;

  const AppScreenAppbar({@required this.title, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton(
          onSelected: (_) {
            onRefresh();
          },
          padding: EdgeInsets.all(2),
          itemBuilder: (context) => {"Refresh"}
              .map((e) => PopupMenuItem(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
          icon: Icon(Icons.more_vert, color: Colors.black87,),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
