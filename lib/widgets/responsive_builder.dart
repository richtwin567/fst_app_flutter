import 'package:flutter/material.dart';
import 'package:fst_app_flutter/utils/get_device_screen_type.dart';
import 'package:fst_app_flutter/utils/sizinginformation.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
  ) builder;
  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      var mediaQuery = MediaQuery.of(context);
      //print("The device type is ${getDeviceType(mediaQuery)}");
      var sizingInformation = SizingInformation(
        orientation: mediaQuery.orientation,
        deviceScreenType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize:
            Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      print(sizingInformation);
      return builder(context, sizingInformation);
    });
  }
}
