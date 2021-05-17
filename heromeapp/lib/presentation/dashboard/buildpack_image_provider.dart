import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

mixin BuildpackImageProvider {
  Widget getBuildpackImage(String buildpack) {
    buildpack = buildpack.toLowerCase();
    if (buildpack.contains("java")) {
      return getImage("assets/icons/java.png");
    } else if (buildpack.contains("node")) {
      return getImage("assets/icons/node.png");
    }
    else if (buildpack.contains("php")) {
      return getImage("assets/icons/php.png");
    }
    else if (buildpack.contains("ruby")) {
      return getImage("assets/icons/ruby.png");
    }
    else if (buildpack.contains("scala")) {
      return getImage("assets/icons/scala.png");
    }
    else if (buildpack.contains("python")) {
      return getImage("assets/icons/python.png");
    }
    else if (buildpack.contains("go")) {
      return getImage("assets/icons/go.png");
    }

    else {
      return null;
    }
  }

  Widget getImage(String asset) {
    return Container(
      width: 30,
        height: 30,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(kDarkGrey, BlendMode.softLight),
            image: AssetImage(asset,) ,),

        ),

    );
  }
}
