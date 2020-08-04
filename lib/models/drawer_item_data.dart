import 'package:flutter/material.dart';

class DrawerItemData {
  final String title;
  final IconData iconData;
  final String route;
  DrawerItemData({
    @required this.title,
    @required this.iconData,
    this.route,
  });
}
