import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/drawer_header_data.dart';
import 'package:fst_app_flutter/widgets/drawer_header/drawer_header_mobile.dart';
import 'package:fst_app_flutter/widgets/drawer_option/drawer_option_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';
import 'package:provider/provider.dart';

class DrawerHeader extends StatelessWidget {
  final String title;
  final AssetImage logo;
  const DrawerHeader({
    Key key,
    this.title,
    this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: DrawerHeaderData(title: title, logo: logo),
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          landscape: (context) => DrawerHeaderMobileLandscape(),
          portrait: (context) => DrawerHeaderMobilePortrait(),
        ),
        tablet: OrientationLayout(
          portrait: (context) => DrawerOptionTabletPortrait(),
          landscape: (context) => DrawerHeaderMobilePortrait(),
        ),
      ),
    );
  }
}
