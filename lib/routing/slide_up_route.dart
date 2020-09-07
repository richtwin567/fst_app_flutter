import 'package:flutter/material.dart';

// TODO: document @richtwin567
class SlideUpPageRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpPageRoute({@required this.page})
      : super(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (context, animation1, animation2) => page,
            transitionsBuilder: (context, animation1, animation2, child) =>
                SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                          .animate(CurvedAnimation(
                              parent: animation1, curve: Curves.easeOut)),
                  child: child,
                ));
}
