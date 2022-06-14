import 'package:flutter/material.dart';
import 'package:machine_learning/page/pages.dart';
import 'package:machine_learning/widgets/widgets.dart';
import 'screen_arguments.dart';

class RouterSettings {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    late ScreenArguments arg;
    final Object? arguments = settings.arguments;
    if (arguments != null) {
      arg = arguments as ScreenArguments;
    }

    switch (settings.name) {
      case SplashPage.routeName:
        return SlideLeftRoute(const SplashPage());
      case HomePage.routeName:
        return SlideLeftRoute(HomePage());
      default:
        throw ('this route name does not exist');
    }
  }
}
