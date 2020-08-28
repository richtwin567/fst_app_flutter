import 'package:flutter/material.dart';
import 'package:fst_app_flutter/utils/get_device_screen_type.dart';
import 'package:fst_app_flutter/utils/sizing_information.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
  ) builder;
  const ResponsiveBuilder({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var sizingInformation = SizingInformation(
      orientation: mediaQuery.orientation,
      deviceScreenType: getDeviceType(mediaQuery),
      screenSize: mediaQuery.size,
    );
    return builder(context, sizingInformation);
  }
}
