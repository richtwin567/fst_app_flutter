import 'package:flutter/widgets.dart';
import 'package:fst_app_flutter/models/enums/device_screen_type.dart';

class SizingInformation {
  final Orientation orientation;
  final DeviceScreenType deviceType;
  final Size screenSize;
  final Size localWidgetSize;
  final DeviceScreenType deviceScreenType;
  SizingInformation({
    this.orientation,
    this.deviceType,
    this.screenSize,
    this.localWidgetSize,
    this.deviceScreenType,
  });

  @override
  String toString() {
    return 'Orientation:$orientation DeviceScreenType:$deviceScreenType DeviceType:$deviceType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
