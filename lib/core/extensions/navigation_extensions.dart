import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future pushRoute(String routeName, {Object? arguments}) async {
    await Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  void popRoute({dynamic result}) {
    Navigator.pop(this, result);
  }
}
