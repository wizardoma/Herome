import 'package:flutter/material.dart';
import 'package:heromeapp/commons/app/colors.dart';

mixin BuildpackImageProvider {
  Image getBuildpackImage(String buildpack) {
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

  Image getImage(String asset) {
    return Image.asset(
      asset,
      height: 30,
      width: 30,
      color: kGreyTextColor,
    );
  }
}
