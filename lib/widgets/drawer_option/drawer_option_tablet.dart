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
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              data.iconData,
              size: 45,
              color: Colors.white,
            ),
            Text(data.title,
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
