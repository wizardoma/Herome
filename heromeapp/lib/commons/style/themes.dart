import 'package:flutter/material.dart';
import 'package:heromeapp/commons/style/colors.dart';

var kMainTheme = ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kWhiteColor,
    textTheme: TextTheme(
        bodyText1: TextStyle(
          color: kDarkTextColor,
        ),
        headline1: TextStyle(
          color: kPrimaryColor,
        ),
      // error text
      headline2: TextStyle(
        color: kerrorTextColor,
        fontSize: 15
      )


    ));
