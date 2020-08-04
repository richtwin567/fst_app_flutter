import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/drawer_item_data.dart';
import 'package:fst_app_flutter/widgets/drawer_option/drawer_option_mobile.dart';
import 'package:fst_app_flutter/widgets/drawer_option/drawer_option_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';
import 'package:provider/provider.dart';

class DrawerOption extends StatelessWidget {
  final String title;
  final IconData iconData;
  const DrawerOption({
    Key key,
    this.title,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: DrawerItemData(title: title, iconData: iconData),
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          landscape: (context) => DrawerOptionMobileLandscape(),
          portrait: (context) => DrawerOptionMobilePortrait(),
        ),
        tablet: OrientationLayout(
          portrait: (context) => DrawerOptionTabletPortrait(),
          landscape: (context) => DrawerOptionMobilePortrait(),
        ),
      ),
    );
  }
}
