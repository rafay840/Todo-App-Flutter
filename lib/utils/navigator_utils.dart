import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtils {
  static Future push(
    BuildContext context, {
    required Widget page,
  }) {
    return Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static Future present(
    BuildContext context, {
    required Widget page,
  }) {
    return Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => page,
      ),
    );
  }
}
