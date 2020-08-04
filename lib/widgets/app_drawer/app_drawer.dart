import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:fst_app_flutter/widgets/app_drawer/app_drawer_tablet.dart';
import 'package:fst_app_flutter/widgets/drawer_option/drawer_option.dart';
import 'package:fst_app_flutter/widgets/drawer_header/drawer_header.dart'
    as header;

import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);
  static List<Widget> getDrawerOptions() {
    return [
      header.DrawerHeader(title: "", logo: AssetImage("assets/FST_logo.png")),
      DrawerOption(
        title: 'Contacts',
        iconData: Icons.contacts,
      ),
      DrawerOption(
        title: 'FST Guild',
        iconData: Icons.book,
      ),
      DrawerOption(
        title: 'Freshers',
        iconData: Icons.new_releases,
      ),
      DrawerOption(
        title: 'Clubs',
        iconData: Icons.group,
      ),
      DrawerOption(
        title: 'Timetable',
        iconData: Icons.calendar_today,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const AppDrawerMobileLayout(),
      tablet: OrientationLayout(
        portrait: (context) => AppDrawerTabletPortrait(),
        landscape: (context) => AppDrawerTabletLandscape(),
      ),
    );
  }
}
