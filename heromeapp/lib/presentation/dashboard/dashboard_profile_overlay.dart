import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heromeapp/application/accounts/account_cubit.dart';
import 'package:heromeapp/application/authentication/auth_bloc.dart';
import 'package:heromeapp/application/authentication/auth_event.dart';
import 'package:heromeapp/commons/app/colors.dart';
import 'package:heromeapp/commons/app/ui_helpers.dart';
import 'package:heromeapp/domain/account/account.dart';
import 'package:heromeapp/presentation/splash/splash_screen.dart';


class DashboardProfileOverlay extends StatefulWidget {
  final Function onOpenProfile;

  const DashboardProfileOverlay({Key key, this.onOpenProfile}) : super(key: key);
  @override
  _DashboardProfileOverlayState createState() =>
      _DashboardProfileOverlayState();
}

class _DashboardProfileOverlayState extends State<DashboardProfileOverlay> {
  GlobalKey _key = LabeledGlobalKey("avatar");
  OverlayEntry _overlayEntry;
  Size widgetSize;
  Offset widgetPosition;
  bool isMenuOpen = false;

  findAvatarPosition() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    widgetSize = renderBox.size;
    widgetPosition = renderBox.localToGlobal(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: widget.onOpenProfile,
          child: Container(
            key: _key,
            padding: EdgeInsets.all(defaultSpacing * 0.5),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/ninja-avatar.png",
                ),
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    Account account = context.read<AccountCubit>().getAccount();
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: widgetPosition.dy + widgetSize.height,
          left: 50,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          child: Material(
            elevation: 2.0,
            color: kWhiteColor,
            child: Container(
//              width: 300,

              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: kLightGrey)),
                    ),
                    padding: EdgeInsets.all(defaultSpacing),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(defaultSpacing * 0.5),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/ninja-avatar.png",
                                ),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultSpacing * 0.5),
                            child: Text(
                              account.name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              account.email,
                              style: TextStyle(color: kGreyTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings, color: kPurpleColor,),
                        title: Text("App Settings", style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.notifications, color: kPurpleColor),
                        title: Text("Notifications", style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,),
                      ),
                      Divider(),

                      ListTile(
                        leading: Icon(Icons.logout, color: kPurpleColor),
                        title: Text("Sign out", style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,),
                        onTap: () {
                          _overlayEntry.remove();
                          context.read<AuthenticationBloc>().add(LogoutEvent());
                          Navigator.pushNamedAndRemoveUntil(
                              context, SplashScreen.routeName, (
                              route) => false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


//    findAvatarPosition();
//    _overlayEntry = _overlayEntryBuilder();
//    Overlay.of(context).insert(_overlayEntry);
//    setState(() {
//      isMenuOpen = !isMenuOpen;
//    });


  void closeMenu() {
//    _overlayEntry.remove();
//    setState(() {
//      isMenuOpen = !isMenuOpen;
//    });
  }
}
