import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/drawer_item_data.dart';
import 'package:fst_app_flutter/widgets/app_drawer/app_drawer.dart';
import 'package:fst_app_flutter/widgets/base_data_model_widget.dart';

class DrawerOptionTabletPortrait extends BaseModelWidget<DrawerItemData> {
  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      width: 152,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            data.iconData,
            size: 45,
          ),
          Text(data.title, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class AppDrawerTabletLandscape extends BaseModelWidget<DrawerItemData> {
  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: Colors.black12),
        ],
      ),
      child: Column(
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }
}
