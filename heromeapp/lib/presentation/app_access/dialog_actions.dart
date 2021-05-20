import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

Widget actionTextButton({@required String text, @required Function onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: kPurpleColor,
        fontSize: 18,
      ),
    ),
  );
}
