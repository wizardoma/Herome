import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

var kMainTheme = ThemeData.light().copyWith(
  iconTheme: IconThemeData(
    color: Colors.black87
  ),
  scaffoldBackgroundColor: kWhiteColor,
  primaryTextTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.w400,
      color: kTextColor,
    ),
  ),
  primaryColor: kWhiteColor,
  accentColor: kPurpleColor,
  textTheme: TextTheme(
          headline3: TextStyle(
            color: kLightGrey,
          ),
          headline1: TextStyle(
              color: kPurpleColor, fontSize: 16, fontWeight: FontWeight.w500),
          // error text
          headline2: TextStyle(color: kerrorTextColor, fontSize: 15))
      .apply(bodyColor: kTextColor, displayColor: kDarkTextColor),
);
