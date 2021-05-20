import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

import 'colors.dart';

var kMainTheme = ThemeData(
  appBarTheme: AppBarTheme(

    color: kWhiteColor,
    titleTextStyle: TextStyle(color: Colors.black87, ),
    elevation: 0,


  ),
  iconTheme: IconThemeData(color: Colors.black87),
  scaffoldBackgroundColor: kWhiteColor,
  primaryTextTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.w400,
      color: kTextColor,
    ),
    headline3: TextStyle(
      color: kLightGrey,
    ),
    headline4: TextStyle(
      color: kPurpleColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    // error text
    headline2: TextStyle(
      color: kerrorTextColor,
      fontSize: 15,
    ),
  ),
  primaryColor: kPurpleColor,
  textTheme: TextTheme(
    headline3: TextStyle(
      color: kLightGrey,
    ),
    bodyText1: TextStyle(
        color: Colors.black87, fontSize: 15
    ),
    bodyText2: TextStyle(
      color: kGreyTextColor, fontSize: 15
    ),
    headline4: TextStyle(
      color: kPurpleColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    // error text
    headline2: TextStyle(
      color: kerrorTextColor,
      fontSize: 15,
    ),
  ),
);
