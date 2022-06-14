import 'package:flutter/material.dart';

class SlideLeftRoute extends PageRouteBuilder {
  SlideLeftRoute(this.page)
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation,
                    child) =>
                SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                  child: child,
                ));
  final Widget page;
}
