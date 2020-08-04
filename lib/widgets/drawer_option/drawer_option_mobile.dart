import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/drawer_item_data.dart';

import '../base_data_model_widget.dart';

class DrawerOptionMobilePortrait extends BaseModelWidget<DrawerItemData> {
  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      height: 80,
      child: Material(
        color: Color.fromRGBO(18, 29, 72, 1),
        child: InkWell(
          splashColor: Colors.blue[900],
          onTap: () {},
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 25,
              ),
              Icon(
                data.iconData,
                size: 25,
                color: Colors.white,
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerOptionMobileLandscape extends BaseModelWidget<DrawerItemData> {
  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: StatefulBuilder(builder: (context, updateState) {
        bool isPressed = false;
        return IconButton(
          onPressed: () {
            updateState(() {
              isPressed = !isPressed;
            });
          },
          icon: Icon(
            data.iconData,
            color: isPressed ? Colors.blue[900] : Colors.white,
          ),
        );
      }),
    );
  }
}
