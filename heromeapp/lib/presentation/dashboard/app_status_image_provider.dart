import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

mixin AppStatusImageProvider {
  Image getAppStatusImage(String appStatus){
    appStatus = appStatus.toLowerCase();
      if (appStatus == "up" )
        return getImage("assets/images/app_awake.png");

    else if (appStatus == "idle" )
      return getImage("assets/images/app_asleep.png");

    else if (appStatus == "starting" )
      return getImage("assets/images/app_loading.png");

    else if (appStatus == "down" )
      return getImage("assets/images/app_down.png");

    else if (appStatus == "crashed" )
      return getImage("assets/images/app_crashed.png");

    else return getImage("assets/images/app_awake.png");
  }

  Image getImage(String file){
    return Image.asset(file, height: 35, width: 35, color: kPrimaryColor,);
  }
}