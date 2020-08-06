import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/drawer_header_data.dart';

import '../base_data_model_widget.dart';

class DrawerHeaderMobilePortrait extends BaseModelWidget<DrawerHeaderData> {
  @override
  Widget build(BuildContext context, DrawerHeaderData data) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      width: queryData.orientation == Orientation.portrait ? 250 : 100,
      child: Center(
        child: Image(
          width: 150,
          image: data.logo,
        ),
      ),
    );
  }
}

class DrawerHeaderMobileLandscape extends BaseModelWidget<DrawerHeaderData> {
  @override
  Widget build(BuildContext context, DrawerHeaderData data) {
    return Container(
        height: 70,
        alignment: Alignment.center,
        child: Image(image: data.logo));
  }
}
