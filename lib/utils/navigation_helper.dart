import 'package:flutter/material.dart';

mixin NavigationHelper {
  static Future<void> navigateTo(BuildContext context, String routeName,
      {Object? arguments}) async {
    if (Navigator.canPop(context)) {
      Navigator.popAndPushNamed(context, routeName, arguments: arguments);
    } else {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    }
  }

  static void pop(BuildContext context, {Object? result}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
    }
  }

  static Future<void> replaceWith(BuildContext context, String routeName,
      {Object? arguments}) async {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static Future<void> clearAndNavigateTo(BuildContext context, String routeName,
      {Object? arguments}) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
