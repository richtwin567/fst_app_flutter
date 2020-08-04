import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/drawer_header_data.dart';
import 'package:fst_app_flutter/widgets/base_data_model_widget.dart';

class DrawerOptionTabletPortrait extends BaseModelWidget<DrawerHeaderData> {
  @override
  Widget build(BuildContext context, DrawerHeaderData data) {
    return Container(
      width: 152,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(
            image: data.logo,
          ),
          Text(data.title, style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
