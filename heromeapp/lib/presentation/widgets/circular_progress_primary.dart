import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

class CircularProgress extends StatelessWidget {
  final Color color;

  const CircularProgress({Key key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color == null ? kPrimaryColor : color),

    );
  }
}
