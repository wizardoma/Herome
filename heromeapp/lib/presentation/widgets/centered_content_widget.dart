import 'package:flutter/material.dart';

class CenteredWidget extends StatelessWidget {
  final Widget child;

  const CenteredWidget({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Center(
          child: child,
        ),
      );
    });
  }
}
