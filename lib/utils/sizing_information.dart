import 'package:flutter/widgets.dart';
import 'package:fst_app_flutter/models/enums/device_screen_type.dart';

class SizingInformation {
  final Orientation orientation;
  final Size screenSize;
  final DeviceScreenType deviceScreenType;
  SizingInformation({
    this.orientation,
    this.screenSize,
    this.deviceScreenType,
  });

  @override
  String toString() {
    return 'Orientation:$orientation DeviceScreenType:$deviceScreenType ScreenSize:$screenSize';
  }
}
