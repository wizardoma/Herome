import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

class ErrorAlertWidget extends StatelessWidget {
  final String message;

  const ErrorAlertWidget({Key key,@required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: kerrorBgColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kerrorBorderColor),
      ),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
